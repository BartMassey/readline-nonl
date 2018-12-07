/*
 * Copyright © 2018 Bart Massey
 * [This program is licensed under the "MIT License"]
 * Please see the file LICENSE in the source
 * distribution of this software for license terms.
 */

#include <stdio.h>

int main() {
    char buf[32];
    printf("%s\n", fgets(buf, sizeof buf, stdin));
}
