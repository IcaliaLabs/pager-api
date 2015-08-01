module PagerApi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__) 

      desc "Creates a PagerApi initializer in your application"

       def copy_initializer
        template "pager_api.rb", "config/initializers/pager_api.rb"
       end
    end
  end
end
