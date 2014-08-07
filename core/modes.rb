class Mode
    @name = ""
    @layers = [] # Layers attached to this mode
    @keymap = Keymap.new # Keybindings (a hash)
end

class Keymap < Hash
    # override the error messages to make them more clear
    # (e.g. "no binding for 'a' found")
    # TODO: OR maybe it would be better to just silence warnings
end
