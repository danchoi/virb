# encoding: utf-8

module Virb
  class Railtie < Rails::Railtie
    if ENV['VIRB'] == 'pry'
      require 'pry'
      require 'virb/pry'
      console do
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
      end
      require "virb/pry_commands"
      ::Pry.commands.import PryRails::Commands

      # do this to prevent the sql output from going to vim interactive buffer
      STDERR.reopen("/dev/null")

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
