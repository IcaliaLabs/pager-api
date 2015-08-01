module PagerApi
  extend ActiveSupport::Autoload

  # pagination handler
  mattr_accessor :pagination_handler
  @@pagination_handler = :kaminari

  #Method to configure pager api
  def self.setup
    yield self
  end

end

require "pager_api/version"
