#!/bin/sh
make -s
cat <<'EOF' |
d8 r.js
./r-c
./r-cc
java r_java
./r-rs
go run r.go
runghc r.hs
perl r.pl
sh r.sh
python3 r3.py
python2 r2.py
EOF
while read CMD
do
    echo -n "$CMD: "
    $CMD <nonl.txt
done
make -s clean
