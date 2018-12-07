package main

import (
	"bufio"
	"os"
	"fmt"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	buf, _ := reader.ReadString('\n')
	fmt.Println(buf)
}
