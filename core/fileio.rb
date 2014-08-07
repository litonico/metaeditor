def load_file(filename)

end

def write_buffer

end 


class FileObject
    # @lines (an array of LineObjects)
    # @size
    # @num_lines

    def initialize(filename)
        @size = File.size?(filename)
        if size.nil?
            # TODO: File doesn't exist- not sure of best behavior...
        elsif (size / 1000*1000) > 2  # Bigger than 2mb?
            init_big(filename)
        else
            init_small(filename)
        end
    end

    def init_small(filename)
        File.open(filename).each_line do |line|
            @lines << LineObject.new(line)
        end
    end

    def init_big(filename)
        raise NoMethodError #TODO
    end
end

class LineObject
    # Holds a line of text. If the line is long (more than 180 chars)
    # the line is held in a linked list of LineObjects.
    #
    # The object_id of each line is used to associate it with layer styling.
    # The linenum is the actual line number of the line.
    def initialize(long_line)
        @contents = ""
        @nextchunk = nil
        if long_line.length > 180 # 1440 px' worth of characters
            @contents = long_line[0..180]
            @nextchunk = LineObject.new(long_line[180..-1])
        end
    end
end
