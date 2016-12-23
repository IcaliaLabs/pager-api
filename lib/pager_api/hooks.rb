# Dynamic pagination handler call
require "pager_api/pagination/#{PagerApi.pagination_handler}"

begin; require 'kaminari';           rescue LoadError; end
begin; require 'will_paginate';      rescue LoadError; end

if defined?(ActionController::API)
  ActionController::API.send(:include, "PagerApi::Pagination::#{PagerApi.pagination_handler.to_s.classify}".constantize)
else
  ActionController::Base.send(:include, "PagerApi::Pagination::#{PagerApi.pagination_handler.to_s.classify}".constantize)
end

unless defined?(Kaminari) or defined?(WillPaginate)
  Kernel.warn <<-WARNING.gsub(/^\s{4}/, '')
    Warning: pager-api needs Kaminari or Will Paginate as a dependency.
    You need to add it to your Gemfile

    gem 'kaminari' or gem 'will_paginate'
  WARNING
end
