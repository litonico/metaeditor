class Buffer

    def initialize(name)
        @name = name
        @id = self.object_id
        @path = nil
        @layers = [UnicodeLayer.new] # A stack of layers, starting with unicode
        @contents = nil
    end

    def from_file(filename)
        return self.new(filename)

    def self.refresh
        output = buffer.contents

        buffer.layers.each do |layer|
            output = layer.apply(output)
        end

        output
    end

end
