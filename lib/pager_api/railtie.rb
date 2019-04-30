module PagerApi
  class Railtie < Rails::Railtie
    config.after_initialize do
      require 'pager_api/hooks'
    end
  end
end
