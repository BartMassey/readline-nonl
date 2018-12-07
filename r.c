/*
 * Copyright © 2018 Bart Massey
 * [This program is licensed under the "MIT License"]
 * Please see the file LICENSE in the source
 * distribution of this software for license terms.
 */

#include <stdio.h>

int main() {
    char buf[1024];
    if (!fgets(buf, sizeof buf, stdin)) {
        perror("fgets");
        return 1;
    }
    printf("%s\n", buf);
    return 0;
}
