pagination_handler_name = PagerApi.pagination_handler.to_s

begin
  require pagination_handler_name
rescue LoadError
  Kernel.warn <<-WARNING.gsub(/^\s{4}/, "")
    Warning: pager-api needs #{pagination_handler_name} as a dependency.
    You need to add it to your Gemfile

    gem '#{pagination_handler_name}'

    Also you can change pagination_handler in pager_api initializer
  WARNING
end

# Dynamic pagination handler call
require "pager_api/pagination/#{pagination_handler_name}"

if defined?(ActionController::Base)
  ActionController::Base.send(:include, "PagerApi::Pagination::#{pagination_handler_name.classify}".constantize)
else
  ActionController::API.send(:include, "PagerApi::Pagination::#{pagination_handler_name.classify}".constantize)
end
