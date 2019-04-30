module PagerApi
  module Pagination
    module Pagy
      include ::Pagy::Backend

      def paginate(*args)
        options = args.extract_options!
        collection = args.first

        pagy, paginated_collection = paginate_collection(collection, options)

        options[:json] = paginated_collection

        options[:meta] = meta(pagy, options) if PagerApi.include_pagination_on_meta?

        pagination_headers(pagy) if PagerApi.include_pagination_headers?

        render options
      end

      private

      # Link: <http://example.com/api/v1/users?page="2">; rel="next",
      # <http://example.com/api/v1//users?page="5">; rel="last",
      # <http://example.com/api/v1//users?page="1">; rel="first",
      # <http://example.com/api/v1/users?page="1">; rel="prev",
      def pagination_headers(pagy)
        links = (headers["Link"] || "").split(",").map(&:strip)
        clean_url = request.original_url.sub(/\?.*$/, "")

        paging_info = pages(pagy)

        paging_info.each do |key, value|
          query_params = request.query_parameters.merge(page: value)
          links << %Q{ <#{clean_url}?#{query_params.to_param}>; rel="#{key}" }
        end

        headers["Link"] = links.join(", ") unless links.empty?
        headers[PagerApi.total_pages_header] = pagy.pages
        headers[PagerApi.total_count_header] = pagy.count

        return nil
      end

      def pagination_links(pagy)
        current_uri = request.env["PATH_INFO"]
        meta_links = {}

        pages(pagy).each do |key, value|
          query_params = request.query_parameters.merge(page: value)
          meta_links[key] = "#{current_uri}?#{query_params.to_param}"
        end

        meta_links
      end

      def pages(pagy)
        {}.tap do |paging|
          paging[:first] = 1
          paging[:last] = pagy.pages

          paging[:prev] = pagy.prev unless pagy.prev.nil?
          paging[:next] = pagy.next unless pagy.next.nil?
        end
      end

      def paginate_collection(collection, options = {})
        options[:page] = params[:page] || 1
        options[:items] = options.delete(:per_page) || params[:per_page] || ::Pagy::VARS[:items]

        meta, collection = pagy(collection, options)
        [meta, collection]
      end

      def meta(pagy, options = {})
        {
          pagination: {
            per_page: pagy.items,
            total_pages: pagy.pages,
            total_objects: pagy.count,
            links: pagination_links(pagy),
          },
        }
      end
    end
  end
end
