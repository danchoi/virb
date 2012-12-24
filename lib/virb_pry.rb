`rm -rf .virb`
`mkdir -p .virb`
unless File.exist?('.virb/fifo')
  `mkfifo .virb/fifo`
end
`touch .virb/session`

#`mkfifo fifo`
class Fifo
  def initialize
    reinit_fifo
  end
  def reinit_fifo
    fd = IO.sysopen(".virb/fifo")
    @io = IO.new(fd, 'r')
  end
  def readline(current_prompt)
    $stdout.print current_prompt
    if @io.eof?
      reinit_fifo
    end
    @io.gets
  end
  def rewind
  end
end

# fakes a tty stdout
class Output
  def initialize
    @out = File.open(".virb/session", "w")
    @out.sync = true
  end
  def print s
    @out.print s
  end
  def puts s
    @out.puts s
  end
  def write s
    puts s
  end
  def flush
    @out.flush
  end
  def tty?
    true
  end
end
fork do
  ENV['TERM'] = 'dumb'
  require 'pry'
  # This is incomplete
  # require 'virb/pry'

  Pry.cli = true
  Pry.color = false
  Pry.config.pager = false
  Pry.config.print = Pry::SIMPLE_PRINT
  Pry.config.auto_indent = false # turns off ansi control escape sequences
  input = Fifo.new
  Pry.input = input
  out = Output.new
  Pry.config.output = out
  $stdout = out
  $stderr = out

  Pry.start(TOPLEVEL_BINDING.eval('self'))
end
args = ARGV.dup
vimscript = File.join(File.dirname(__FILE__), 'virb.vim')
exec("vim -S #{vimscript} #{args.join(' ')}")

