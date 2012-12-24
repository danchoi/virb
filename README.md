# Virb

Virb is a Vim shell for IRB, Rails console, and Pry.


## Using Virb 

Start up Virb with the command

    virb [file]

The optional `file` is a text file that contains Ruby code that you
would like to run interactively.

## Using Virb with Pry

Make sure you have the `pry` gem installed. Then you can run this:

    virb-pry [file]

When virb opens, you should be able to send your code for evaluation to Pry and
get Pry output in the virb session buffer.

## How to wrap Rails console with Virb 

If you want to use Virb with the standard Rails console:

Put this in your Gemfile:

    group :development do
      gem 'virb'
    end

and start Rails console as you do normally. You should see the Virb interface
open, where you can interact with the Ralis console through a Vim buffer and
see its output in the other Vim buffer.

If you want to use Virb with Pry and Rails console:

Put this in your Gemfile:

    group :development do
      gem 'pry'
      gem 'virb'
    end

and start Rails console like this:

    VIRB=pry rails c


## Caveats

The normal command line options for `irb` and `pry` do not work with `virb`.


## Author

Virb was written by [Daniel Choi](http://danielchoi.com/software), an independent software developer based in Cambridge, Massachusetts.

* [GitHub](http://github.com/danchoi)
* [Twitter](http://twitter.com/danchoi)
* I am available for short to medium-term consulting projects: [Email](mailto:dhchoi@gmail.com)
