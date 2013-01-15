# encoding: utf-8

module Virb
  class Railtie < Rails::Railtie
    if ENV['VIRB'] == 'pry'
      console do
        require 'pry'
        require 'virb/pry'
        if Rails::VERSION::MAJOR == 3
          Rails::Console::IRB = Virb::Pry
          unless defined? Virb::Pry::ExtendCommandBundle
            Virb::Pry::ExtendCommandBundle = Module.new
          end
        end  
        if Rails::VERSION::MAJOR == 4
          Rails.application.config.console = Virb::Pry
        end  

        if (Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR >= 2) || Rails::VERSION::MAJOR == 4
          require 'rails/console/app'
          require 'rails/console/helpers'
          TOPLEVEL_BINDING.eval('self').extend ::Rails::ConsoleMethods
        end
        # do this to prevent the sql output from going to vim interactive buffer
        STDERR.reopen("/dev/null")
        require "virb/pry_commands"
        ::Pry.commands.import PryRails::Commands
      end
    else
      console do
        require 'virb/default'
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
