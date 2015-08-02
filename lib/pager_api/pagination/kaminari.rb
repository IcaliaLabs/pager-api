module PagerApi
  module Pagination
    module Kaminari

      def paginate(*args)
        options = args.extract_options!
        collection = args.first

        paginated_collection = paginate_collection(collection, options)

        options[:json] = paginated_collection

        options[:meta] = meta(paginated_collection, options) if PagerApi.include_pagination_on_meta?

        render options
      end

      private

        def pagination_links(collection, options)
            current_uri = request.env['PATH_INFO']
            {
              first: "#{current_uri}?page=1",
              last: "#{current_uri}?page=#{collection.total_pages}",
              prev: "#{current_uri}?page=#{collection.current_page - 1}",
              next: "#{current_uri}?page=#{collection.current_page + 1}"
            }
        end

        def paginate_collection(collection, options = {})
          options[:page] = params[:page] || 1
          options[:per_page] = options.delete(:per_page) || params[:per_page]

          collection.page(options[:page]).per(options[:per_page])
        end

        def meta(collection, options = {})
          {
            pagination:
            {
              per_page: options[:per_page] || params[:per_page],
              total_pages: collection.total_pages,
              total_objects: collection.total_count,
              links: pagination_links(collection, options)
            }
          }
        end

    end
  end
end
