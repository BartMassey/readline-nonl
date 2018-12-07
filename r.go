package main

import (
	"bufio"
	"os"
	"fmt"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	buf, err := reader.ReadString('\n')
	fmt.Println(buf)
	if err != nil {
		fmt.Fprintf(os.Stderr, "read error: %s\n", err)
		os.Exit(1)
	}
}
