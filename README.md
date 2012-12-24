# Virb

Virb is an interactive Vim mode for IRB, Rails console, and Pry.

![screen1](https://raw.github.com/danchoi/virb/master/images/virb1-sm.png)
![screen2](https://raw.github.com/danchoi/virb/master/images/virb2-sm.png)

## Motivation

IRB is Ruby's interactive REPL. IRB is a very handy tool, but its text-editing
capabilities are limited. Virb wraps an IRB session in a Vim session and gives
you convenient ways to evaluate Ruby code from Vim.

Virb inverts the approach taken by
the [interactive_editor](https://github.com/jberkel/interactive_editor) gem and
similar solutions which let you pop out into Vim from IRB and come back to IRB
to see the results.  Virb keeps you in Vim at all times, calling IRB behind the
scenes and fetching IBR's output to display inside Vim.

## Install

    gem install virb

Virb requires Ruby 1.9 and Vim 7.2 or above. Virb has been tested only on OS X
10.8 and Ubuntu Linux.


## Using Virb 

Start up Virb with the command

    virb [file]

The optional `file` is a text file that contains Ruby code that you
would like to run interactively.

Virb opens 2 Vim buffers. The bottom buffer is the interactive buffer, 
where you can edit Ruby code and then send it to the underlying interactive
Ruby session for evaluation. The top buffer is the output buffer, where you 
can see the IRB session you are controlling from the interactive buffer.

To evaluate code in the interactive buffer:

To evaluate a line of code, put the cursor on it, and press ENTER in normal mode.

To evaluate several lines of code, you can either

1. select the lines in Vim's visual mode, and press ENTER to evaluate them;
2. use an ed-style range command: `:[range]Virb`

If IRB takes too long (more than about half a second) to evaluate your code,
you may need to manually force the session buffer to update itself. You can
force an update by pressing SPACE in normal mode.


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

and start Rails console as you do normally, with `rails c`. You should see the
Virb interface open, where you can interact with the Ralis console through a
Vim buffer and see its output in the other Vim buffer.

If you want to open a worksheet in Virb + Rails console, don't specify it on
the command line. Open it from within Vim using `:e [file]` after the Virb
session has started.

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


## Issues

Please report issues [on the GitHub issue tracker](https://github.com/danchoi/virb/issues).

## Author

Virb was written by [Daniel Choi](http://danielchoi.com/software), an independent software developer based in Cambridge, Massachusetts.

* [GitHub](http://github.com/danchoi)
* [Twitter](http://twitter.com/danchoi)
* I am available for short to medium-term consulting projects: [Email](mailto:dhchoi@gmail.com)
