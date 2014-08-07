# TODO ISSUE: how to handle multiple keystrokes that start the same way?
# logic should be contained ONLY in the commands


# C => command (action without motion). call as C(state)
# A => action. call as A(motion, state)
# M => motion. call as M(state)
# U => utility. Do we even need this?

class NormalMode < Mode
    @bindings = {
        motions: { },
        actions: {},
        'a' => append, # or action_append? motion_back_word? action_a?
        'A' => append_LINE,
        'b' => back_word_A,
        'B' => back_WORD_A,
        'c' => change_A,
        'C' => change_LINE, #PROBLEM in RIVER CITY
        'd' => delete_A,
        'dd' => delete_A(line_full), #TODO: orrrr shoudn't this be a motion or something? Curried?
                              # Or just use delete_LINE, which is def as delete(line_full, state)
        'D' => delete_LINE_A, # 
        'e' => end_of_word_M,
        'f' => from_M,
        'F' => from_BACK_M,
        # 'g': wait_for_more, # shouldn't actually be a command
        # the whole frikkin' g-family
        'G' => go_to_M, # gah, motion or action? 12G vs G12
        'h' => left_M
    }
end


# primitive objects? like word or paragraph or sth
class Word < TextObject
end

# Questions:
# Explicity include state? that makes calling from cmdline hard
# could do something like state=$STATE
def enter_insert_mode

end

def insert_C(state=$STATE)
    enter_insert_mode_C(state)
end

def append_C(state)
    move_right_M(state)
    insert(state)
end

def change_A(range, state)

end

def end_of_word_M(range, state=$STATE)
    state.selection_end = blah# lots of cursor logic here
end

def around_object_M(motion, state)
    state.blah
end

# "Whatever features your IDE gives you is a design flaw in your programming 
# language" -- Reg Braithwhite

# IDE functions are still an option, but they're part of the language, not part
# of the editor.
 
# So, let's seek to provide meta-linguistic information.
# What kind of data is valuable across languages?
# ,diff (leader diff)
# ,perf
# ,err
# ,type
# quick navigation (vim) is EXTREMELY valuable (and feels nice)
# gotta look nice (this is HARD in a terminal app. Sucks.)
