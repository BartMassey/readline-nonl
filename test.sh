#!/bin/sh
make -s
cat <<'EOF' |
./r-c
./r-cc
java r_java
./r-rs
runghc r.hs
perl r.pl
sh r.sh
python3 r3.py
python2 r2.py
smjs r.js
nickle r.5c
go run r.go
d8 r.js
EOF
while read CMD
do
    echo -n "$CMD: "
    $CMD <nonl.txt
done
make -s clean
