# encoding: utf-8

module Virb
  class Railtie < Rails::Railtie
    if ENV['VIRB'] == 'pry'
      require 'virb/pry'
      console do
        if Rails::VERSION::MAJOR == 3
          Rails::Console::IRB = Virb::Pry
        end  
        if Rails::VERSION::MAJOR == 4
          Rails.application.config.console = Virb::Pry
        end  

        if (Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR >= 2) || Rails::VERSION::MAJOR == 4
          require 'rails/console/app'
          require 'rails/console/helpers'
          TOPLEVEL_BINDING.eval('self').extend ::Rails::ConsoleMethods
        end
      end
    else
      require 'virb/default'
      console do
        if Rails::VERSION::MAJOR == 3
          Rails::Console::IRB = IRB
        end  
        if Rails::VERSION::MAJOR == 4
          Rails.application.config.console = IRB
        end  

        if (Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR >= 2) || Rails::VERSION::MAJOR == 4
          require 'rails/console/app'
          require 'rails/console/helpers'
          TOPLEVEL_BINDING.eval('self').extend ::Rails::ConsoleMethods
        end
      end
    end
  end
end
