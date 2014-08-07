# The search function. This is used in all motion calls to
# find the TextObjects that are operated on.

class Selection
    def initialize(start, fin)
        self.start = start
        self.fin = fin
    end
end

def search(position, direction)
    #search starts AFTER the (fat) cursor
end


def distance(p1, p2)
    abs (p1-p2)
end

# TODO: perf- try 1000c10000w or things like that- something that forces
# get_obj_at to make tons of search calls

def get_obj_at(text_object, location)
    # Finds the nearest TextObject to the location.
    # If the location is inside the TextObject, say in the 
    # middle of a paragraph, it will return that object.
    # Otherwise, it'll return the next occurance.

    # Cases: (# is the cursor)
    #
    # In the object: 
    # blagh oth#rwise blah
    #
    # After a valid object:
    # def blah
    #   lala
    # end
    #
    # #
    #
    # def ... <- Found TextObject should start here

    #TODO: find out the rubyists's way of reverse=true
    back_start = search(text_object.startpattern, reverse=true) 
    back_fin = search(text_object.endpattern, reverse=true)
    forward_fin = search(text_object.endpattern)
    forward_start = search(text_object.startpattern)

    # If the back_start is closer than back_fin, we're inside the obj
    # Also, if there's not back_start or back_fin, there's no chance 
    # that there's a
    if (distance(location, back_start) < distance(location, back_fin)) && 
        (!back_fin.nil? || !back_start.nil?)

        return Selection(back_start, forward_fin)

    elsif forward_start.nil? # No next object found
        return nil

    elsif forward_fin.nil? # Object starts, but doesn't terminate
        raise # some kind of error; the TextObject's endpattern is wrong

    else # Return the next TextObject
        return Selection(forward_start, forward_fin)

    end
end
