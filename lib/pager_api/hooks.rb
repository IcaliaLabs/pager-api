require 'rails'
require 'pager_api/pagination/kaminari'

ActionController::Base.send(:include, PagerApi::Pagination::Kaminari)

begin; require 'kaminari';      rescue LoadError; end

unless defined?(Kaminari)
  Kernel.warn <<-WARNING.gsub(/^\s{4}/, '')
    Warning: pager-api needs Kaminari as a dependency.
    You need to add it to your Gemfile

    gem 'kaminari'
  WARNING
end
