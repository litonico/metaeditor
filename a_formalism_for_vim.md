A Formalism for Vim
===================

I set out to write an easily-customizable version of Vim, and ended up with
something that looks a lot like Emacs. _Shit_. (I kid, I kid, I love 
emacs, though I'm certainly not a power-user. I'll write about how breathtaking
and elegant emacs is some other time.)

In Vim, all of the commands are hardcoded into their key, which leads to some 
confusion in the form of things like recursive remapping. 

If you bind a key– say, 'a' to 'b', and 'b' is already remapped to 'z', what's
the new value of 'a'? Vim solves this by having nonrecursive remap (`nnoremap`
for normal mode) and recursive remap (`nremap`). With recursive remapping, 
'a' becomes 'z', whereas with nonrecursive, 'a' becomes 'b'.

We can avoid this by having *invariant* functions that we bind keys to. Here's
the 'delete' function:

    def delete(motion, state)
        [...]

Notice that it takes a motion as an argument; this means `delete` covers
everything from `'d}'` (delete to end of paragraph) to `'daw'` (delte
around word) just by passing in those motions.

    def delete_word(state)
        delete(word, state)
    end

Also, _every_ method here takes `state` as an argument; this is the editor's
state and contains the cursor position, number of buffers, et cetera.

So what is `word`? It's the NEXT word object, not the current one.

We're going to tweak Vim's use of these terms.

The atomic unit is (to borrow Vim's terminology) the TextObject– a word, a 
paragraph, or a line, for instance. 

Each TextObject has a starting position
and an ending position, `TextObject.startpattern` and `TextObject.endpattern`. 
These correspond to the beginning and end of the selection that the editor modifies.

We can define our own TextObejcts:
    

A 'mode' (normal mode, for instance) is just a collection of keybindings.

A motion is a function that takes a TextObject as an argument and returns
a selection. Vim's 'b' motion
looks something like this:

    # the cursor is always at the selection's end
    # the state's variable cursor_pos

    def back_motion (text_object, location)
        obj = get_obj_at(text_object, location)
        return Selection(location,)
    end


    abstract according to this pattern?

    def next_motion (text_object, state) # as in 'w'
        obj = get_obj_at(text_object, state.cursor_pos) # NEXT text object
        state.selection.start = obj.start
        state.selection.end = obj.end


    motion . motion = motion; i.e, iw = i(w) = w(i). Does that work?

    def inner_motion

This means that motions can be composed: 'ww' is just w(w(cursorpos))

What Vim calls TextObjects- 'i' and 'a' ('in' and 'around', e.g. ciw, daw- 
change in word, delete around word) can be implemented as motions.


    def around_motion (text_object, location)
        obj = get_obj_at(text_object, state.cursor_pos)
        state.selection.start = obj.start - 1
        state.selection.end = obj.end + 1

    def inside_motion (text_object, state)
        obj = get_obj_at(text_object, state.cursor_pos)
        state.selection.start = obj.start
        state.selection.end = obj.end


In Vim, motions like 'w' go from the current cursor position to the start of
the next TextObject, so I've kept that behavior here.

With a kind of hardcoded partial-application, we can easily define:

    def back_word (state) # The specific case of back_motion that uses 'word'
        back_motion('word', state)
    end

 TODO

    # Where bind key is
    # bind_key (mode, key, command)
    #   [...]

    # bind_key :: Mode -> Key -> Command -> Keybinding

For the pure-vim enthusiasts, here's nnoremap:

    def bind_key 


    bind_key "normal", 'b', back_word

    def nnoremap(key, command)
        "nnoremap is not recommended– next time, use bind_key(mode, key, value)"
        bind_key('normal', key, command)
    end

and then

    def back_paragraph
        back_motion(paragraph, state)

    bind_key "normal" '{' back_paragraph
