module PagerApi

  # pagination handler
  mattr_accessor :pagination_handler
  @@pagination_handler = :kaminari

  # Meta tag information for pagination
  mattr_accessor :include_pagination_on_meta
  @@include_pagination_on_meta = true

  # Links headeras with pagination information
  mattr_accessor :include_pagination_headers
  @@include_pagination_headers = true

  # Total Pages Header name
  mattr_accessor :total_pages_header
  @@total_pages_header = "X-Total-Pages"

  # Total Count Header name
  mattr_accessor :total_count_header
  @@total_count_header = "X-Total-Count"

  def self.include_pagination_on_meta?
    @@include_pagination_on_meta
  end

  def self.include_pagination_headers?
    @@include_pagination_headers
  end

  #Method to configure pager api
  def self.setup
    yield self
  end

end

require "pager_api/version"
require "pager_api/railtie"
