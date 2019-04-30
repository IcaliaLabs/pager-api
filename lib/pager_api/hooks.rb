begin; require "kaminari"; rescue LoadError; end
begin; require "will_paginate"; rescue LoadError; end
begin; require "pagy"; rescue LoadError; end

# Dynamic pagination handler call
require "pager_api/pagination/#{PagerApi.pagination_handler}"

if defined?(ActionController::Base)
  ActionController::Base.send(:include, "PagerApi::Pagination::#{PagerApi.pagination_handler.to_s.classify}".constantize)
else
  ActionController::API.send(:include, "PagerApi::Pagination::#{PagerApi.pagination_handler.to_s.classify}".constantize)
end

unless defined?(Kaminari) or defined?(WillPaginate) or defined?(Pagy)
  Kernel.warn <<-WARNING.gsub(/^\s{4}/, "")
    Warning: pager-api needs Kaminari, Will Paginate or Pagy as a dependency.
    You need to add it to your Gemfile

    gem 'kaminari', gem 'will_paginate' or gem 'pagy'
  WARNING
end
