Lines are stored as (some kind of) data structure, each with a unique ID, which
does not correspond to line number. This allows each line to keep its styling 
as its moved around the document.  Also, linewise editing is possible in 
'locked' layer modes, such as type inference.




Keymap ideas:

    def remap (mode, remapped_key, key_or_command):

    def iremap x y: 
        remap (insert_mode, x, y)

    # 'recursive remapping' makes no sense given that commands are singletons
    inoremap = remap 
