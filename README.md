# readline-nonl: Read and print an unterminated line from stdin
Copyright (c) 2018 Bart Massey

This repository contains implementations in more than 11
languages of a program that reads and prints a line from
standard input, together with a test script which runs each
of these implementations against a test file.

## Motivation

One of the things you might do in a programming language is
to read a line from standard input. By convention, lines are
terminated with a newline character. It is sometimes the
case that the last or only line in a file might be unterminated,
either accidentally or by design.

If a file with an unterminated line is fed to a program as
standard input, the programming language routine for reading
a line has to decide what to do with this odd line. Obvious
possibilities: pretend the line has a newline at the end,
throw some kind of exception. Programming languages pretty
uniformly do the former. Go's line reader is peculiar in
that it returns *both* the line contents and an error
indication.

A less obvious possibility for reading an unterminated line
from standard input was chosen by Google in their
[d8](https://v8.dev/docs/d8) Javascript implementation,
which silently returns `undefined` in this case.  In
Javascript printing `undefined` is of course a legitimate
activity, so it is turned into the string `undefined` and
printed on standard output. Mozilla's `smjs` Javascript
implementation does not exhibit this behavior, returning the
line as expected.

## Demonstration

The file `nonl.txt` contains the string "hello" without a
terminating newline. This file is used by default in the
test script.
Running `sh test.sh` on my system yields this:

```
./r-c: hello
./r-cc: hello
java r_java: hello
./r-rs: hello
runghc r.hs: hello
perl r.pl: hello
sh r.sh: hello
python3 r3.py: hello
python2 r2.py: hello
smjs r.js: hello
nickle r.5c: hello
go run r.go: hello
read error: EOF
exit status 1
d8 r.js: undefined
```

Note that the Go program writes the error and exit status
indication to standard error, which was captured here.

The file `nl.txt` contains the string "hello" *with* a
terminating newline. Running `sh test.sh nl.txt` on my
system yields this:

```
./r-c: hello

./r-cc: hello
java r_java: hello
./r-rs: hello

runghc r.hs: hello
perl r.pl: hello

sh r.sh: hello
python3 r3.py: hello

python2 r2.py: hello

smjs r.js: hello
nickle r.5c: hello
go run r.go: hello

d8 r.js: hello
```

It is easy to see from this output which languages strip the
terminating newline on read and which do not.

## Comparison of Languages

While I didn't intend this project as a comparative study of
the ergonomics of reading a line in various languages, there
is some stuff here that I found interesting.

* The documentation of how to read a line from standard
  input in various languages ranges from modest to
  nonexistent. I am familiar with all of these languages (a
  big part of why I chose them), so I was surprised by how
  much time I spent on Stack Overflow reminding myself how
  to perform this simple task.

* C infamously provides no way for its line reader to
  allocate a string sufficiently long to read the line.  I
  used the usual "pick a size and die if it fails"
  strategy. Even after 35 years of C programming, I forgot
  to check the error return from `fgets()` and had to go
  back and add it.

* I chose to include [Nickle](http://nickle.org) because I
  am a co-creator of the language (although almost all of
  the actual implementation is by co-author Keith Packard).
  I am relieved, though not surprised, by our language's
  behavior in this common case.

* The command-line Javascript implementation uses primitives
  provided by both `d8` and `smjs`, but which as far as I
  know are not part of the Javascript specification and are
  not (for obvious reasons) available in a web browser
  implementation of the language. The `rhino` command-line
  Javascript implementation throws an error that I don't
  understand on this program (with a tremendously huge stack
  trace) even for the newline-terminated file, so I chose
  not to include it.

* Languages with way more ceremony than I find conscionable
  for this simple task: Rust, Go, Java. I am working on an
  RFC for Rust to improve the situation there. There is
  probably no reasonable plan for Java at this point: I
  don't know why `System.in` isn't a `BufferedReader` to
  begin with.

* Java's habit of building the class name into the class
  file is annoying. One would *think* that one could call
  the class `r`, compile with `javac r.java`, and just
  rename `r.class` to `r-java.class`. Nope: the bytecode
  interpreter refuses to run it.

## Build and Run

You will need installations of all of the above-indicated
language implementations on your machine. They are all
available as Debian Linux packages with quite guessable
names. It is presumably clear how to run `test.sh` from the
comments in the previous section.

## Future Work

* I guess it would be worthwhile to add more languages? I
  ran out of steam at 12.

* I probably should file a bug against `d8`. Just saying.

## License

This program is licensed under the "MIT License".  Please
see the file `LICENSE` in the source distribution of this
software for license terms.
