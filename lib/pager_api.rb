module PagerApi
  extend ActiveSupport::Autoload

  autoload :Kaminari

  # pagination handler
  mattr_accessor :pagination_handler
  @@pagination_handler = :kaminari

  # Meta tag information for pagination
  mattr_accessor :include_pagination_on_meta
  @@include_pagination_on_meta = true

  def self.include_pagination_on_meta?
    @@include_pagination_on_meta
  end

  #Method to configure pager api
  def self.setup
    yield self
  end

end

require "pager_api/version"
require "pager_api/hooks"
