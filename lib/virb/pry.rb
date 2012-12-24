# Patches the retrieve_line method so that it echoes prompt and input
#
class Pry
  # Read and process a line of input -- check for ^D, determine which prompt to
  # use, rewrite the indentation if `Pry.config.auto_indent` is enabled, and,
  # if the line is a command, process it and alter the eval_string accordingly.
  # This method should not need to be invoked directly.
  #
  # @param [String] eval_string The cumulative lines of input.
  # @param [Binding] target The target of the session.
  # @return [String] The line received.
  def retrieve_line(eval_string, target)
    @indent.reset if eval_string.empty?
    current_prompt = select_prompt(eval_string, target)
    completion_proc = Pry::InputCompleter.build_completion_proc(target,
                                                        instance_eval(&custom_completions))

    indentation = Pry.config.auto_indent ? @indent.current_prefix : ''
    begin
      val = readline("#{current_prompt}#{indentation}", completion_proc)

    # Handle <Ctrl+C> like Bash, empty the current input buffer but do not quit.
    # This is only for ruby-1.9; other versions of ruby do not let you send Interrupt
    # from within Readline.
    rescue Interrupt
      output.puts ""
      eval_string.replace("")
      return
    end

    # invoke handler if we receive EOF character (^D)
    if !val
      output.puts ""
      Pry.config.control_d_handler.call(eval_string, self)
      return
    end

    # Change the eval_string into the input encoding (Issue 284)
    # TODO: This wouldn't be necessary if the eval_string was constructed from
    # input strings only.
    if should_force_encoding?(eval_string, val)
      eval_string.force_encoding(val.encoding)
    end

    original_val = "#{indentation}#{val}"
    indented_val = @indent.indent(val)
    output.print "prompt> #{val}"

    if !process_command(val, eval_string, target)
      eval_string << "#{indented_val.rstrip}\n" unless val.empty?
    end
  end
end
