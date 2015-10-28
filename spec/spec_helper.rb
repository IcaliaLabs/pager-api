$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rails/all'
require 'rspec/rails'
require 'pager_api'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end
