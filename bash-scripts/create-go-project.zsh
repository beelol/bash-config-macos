create-go-project() {
    if [ -z "$1" ]; then
        echo "Usage: create-go-project <project-name>"
        return 1
    fi

    local PROJECT_NAME=$1

    # Create the project directory and navigate into it
    mkdir -p $PROJECT_NAME
    cd $PROJECT_NAME

    # Initialize a new Go module
    go mod init $PROJECT_NAME

    # Create the main.go file with a basic template
    cat <<EOF > main.go
package main

import "fmt"

func main() {
    fmt.Println("Hello, Go!")
}
EOF

    # Run the new Go application
    go run main.go

    echo "Go project '$PROJECT_NAME' created and ran successfully!"
}