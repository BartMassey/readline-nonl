# Copyright © 2018 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

TARGETS = r-c r-cc r-rs r_java.class

all: $(TARGETS)

r-c: r.c
	$(CC) $(CFLAGS) -Wall -o r-c r.c

r-cc: r.cc
	$(CXX) $(CXXFLAGS) -Wall -o r-cc r.cc

r-rs: r.rs
	rustc -o r-rs r.rs

r_java.class: r_java.java
	javac r_java.java

clean:
	-rm -f $(TARGETS)
