
require 'pry'
#`mkfifo fifo`
class Fifo
  def initialize
    reinit_fifo
  end
  def reinit_fifo
    fd = IO.sysopen("fifo")
    @io = IO.new(fd, 'r')
  end
  def readline(*)
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
    @out = File.open("pryout", "w")
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
  end
  def tty?
    true
  end
end

Pry.cli = true
Pry.color = false
Pry.config.pager = false
input = Fifo.new
#input = StringIO.new("puts 1")
Pry.input = input
#out = File.open("pryout", "w")
out = Output.new
Pry.config.output = out
$stdout = out
$stderr = out
Pry.start(TOPLEVEL_BINDING.eval('self'))

