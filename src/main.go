package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context) (*string, error) {	
	output := "Hello v1"
	fmt.Print(output)

	return &output, nil
}

func main() {
	lambda.Start(handler)
}
