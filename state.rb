# The current state of the editor

class State
    def initialize
        @buffers = [Buffer.new("No Name")] # add a scratch buffer
        @current_buffer = 
        @logger = Logger.new
    end
end
