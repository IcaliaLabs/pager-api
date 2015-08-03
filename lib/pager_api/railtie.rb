module PagerApi
  class Railtie < Rails::Railtie

    initializer "pager_api.action_dispatch" do |app|
      ActiveSupport.on_load :action_controller do
        require "pager_api/hooks"
      end
    end

  end
end
