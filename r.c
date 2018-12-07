/*
 * Copyright © 2018 Bart Massey
 * [This program is licensed under the "MIT License"]
 * Please see the file LICENSE in the source
 * distribution of this software for license terms.
 */

#include <assert.h>
#include <stdio.h>

int main() {
    char buf[1024];
    assert(fgets(buf, sizeof buf, stdin));
    printf("%s\n", buf);
}
