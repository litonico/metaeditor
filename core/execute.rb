def execute (key_seq, state=$STATE)
    range = ""

    key = key_seq.last

    # Refactor into a method?
    # all commands where the first letter matches the key.
    possible_cmds = state.mode.keymap.select {|k, v| k[0] == key}

    # A command is bound to the key sequence
     cmd = possible_cmds[key]

    if nil? cmd
    
    
    # returnsa method?

        return FINISHED

    elsif cmd.type == 'incomplete_range' # Say, a single digit of a range
        range << cmd
        return NOT_FINISHED

    elsif cmd.type == 'range'


    elsif cmd.type == 'action'

    end
end


# c2e
# c22w
# 22cw
# 3i (a)
# daw
# di[ (or di]). Text objects.
# vi[, etc.
#
# waiting for key input (wait 2 seconds after pressing s, unless another key is pushed)
