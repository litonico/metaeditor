Serious edits to follow

Emacs is a simple and profound idea: 

Emacs consists of three parts: a abstraction of terminal drawing (in C), a 
Lisp interprerer (also in C), and the editor itself (in Emacs Lisp).

Terminal libraries are tricky to write and full of complexity to account for the 
full range of terminals out there. Fortunately, most Unix distributions come
with a great teriminal drawing library: Ncurses!

A neat thing about emacs is how universal it is: it can be implemented with
ANY interpreted language that can be embedded in a C application. Though we'll
use a Lisp for this implemetation, a future Let's Write will cover an Emacs in
Ruby!

Instead of Emacs Lisp, we're going to embed a language that's hopefully a
simple and familiar one: Ruby. There's an implementation of Ruby just for 
projects like this– MiniRuby, also called mruby.




Implementation
--------------

Next is the command loop, which reads one key at a time into read_key_sequence
until a valid command is found.
