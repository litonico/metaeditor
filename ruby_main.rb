#!usr/bin/env ruby

# This module contains the editor loop, application state, and loading 
# protocol. 

def start_ariel
    load './loading.rb'
    load_core
    load_langs
    load_plugins
    load_userdata

    ariel_STATE = State.new

    # Enter the main loop!
    catch_errors(
        main_loop (ariel_STATE)
    )
end


NOT_FINISHED = false
FINISHED = true

def main_loop (state)
    loop do 
        # Start a new command
        key_seq = ""
        key_seq << get_ch()

        # execute performs editing by modifying state,
        # and returns NOT_FINISHED if it needs more chars, 
        # or FINISHED if it's done.
        result = execute(key_seq)

        # If the command isn't complete, keep waiting for keys
        while result == NOT_FINISHED
            key_seq << get_ch()
            result = execute(key_seq) 
        end
        # We're done here (result == FINISHED)
        # Refresh buffer, and display the result
        display! state.current_buffer.refresh
    end
end


def catch_errors (editor_loop, editor_state)
    # Handles any error that editor_loop (usually main_loop) might throw, 
    # so that mruby itself never has to deal with these. If mruby sees 
    # an exception, it'll destroy the mrb pointer, which is NOT what we want.
    begin
        editor_loop

    rescue SystemExit => exit_code
        editor_state.logger.warn('Exiting')
        raise exit_code # TODO: might need more memory cleanup for mrb*

    rescue Exception => e # Catch ALL Exceptions
        editor_state.logger.warn("Uncaught exception #{e}")
        editor_state.logger.warn("\n\t#{e.backtrace.join("\nfrom:")}")
    end
end


class State
    # @hooks ?
    @current_buffer = nil

end

start_ariel
