class TextObject
end

word = new TextObject(/\s.*|\w\W|\W\w/, //)
#word start- /\s.* | \w\W/ whitespace and then anything, or the boundary between a word and any symbol
#word end - /.*\s | \w\W/
