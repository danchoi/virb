# Virb

A Vim shell for irb, rails console, and pry.




## How to wrap Rails console with Virb 

If you want to use Virb with the standard Rails console:

Put this in your Gemfile:

    group :development do
      gem 'pry'
    end

and start Rails console as you do normally. You should see the Virb interface
open, where you can interactive with the Ralis console through a Vim buffer and
see its output in another Vim buffer.

If you want to use Virb with Pry and Rails console:

Put this in your Gemfile:

  group :development do
    gem 'pry'
    gem 'virb'
  end

and start Rails console like this:

  VIRB=pry rails c




