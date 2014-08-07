INSTALL_DIR = File.dirname(__FILE__)

def editor_load (dir, specific_files=[])

    # TODO: should they be included without ext?
    if specific_files.empty? # All files in a directory
        Dir["#{dir}/*.rb"].each do |ruby_file| 
            load ruby_file
        end

    else # Specific files
        Dir.chdir(dir) do 
            specific_files.each do |file|
                # If the file doesn't exist, don't do anything
                if File.exists?(file)
                    load file
                end
            end
        end
    end
end


def load_core
    editor_load("#{INSTALL_DIR}/core") 
end


def load_langs
    editor_load(".ariel/langs") 
end


def load_plugins
    editor_load(".ariel/plugins") 
end


def load_userdata # only load '.arielrc' 
    editor_load("~", ['.arielrc']) 
rescue # .arielrc doesn't exist
    #TODO: create it?
end


def local_load (dir) # Find .ariel files in a directory
    editor_load(dir, ['.ariel'])
end


# source = editor_load # For Vim compatability
