
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

Pry.cli = true
Pry.color = false
input = Fifo.new
#input = StringIO.new("puts 1")
Pry.input = input
Pry.start(TOPLEVEL_BINDING.eval('self'))

