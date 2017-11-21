module PagerApi
  class Railtie < Rails::Railtie
    initializer "pager_api.configure_pagination_helpers" do
      require 'pager_api/hooks'
    end
  end
end
