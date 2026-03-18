# Add to your .bashrc or .zshrc:

fileize_ai_output() {
    local input_file="$1"
    local base_path="${2:-$(pwd)}"
    
    if [ -z "$input_file" ]; then
        echo "Usage: fileize_ai_output input_file [base_path]" >&2
        return 1
    fi
    
    if [ ! -r "$input_file" ]; then
        echo "Error: Cannot read input file '$input_file'" >&2
        return 1
    fi
    
    if [ ! -d "$base_path" ] && ! mkdir -p "$base_path" 2>/dev/null; then
        echo "Error: Cannot create or access base directory '$base_path'" >&2
        return 1
    fi
    
    base_path=$(cd "$base_path" && pwd) || return 1
    
    local current_file=""
    local buffer=""
    
    while IFS= read -r line || [ -n "$line" ]; do
        if [[ $line =~ ^(#|\/\/)[[:space:]]*([[:alnum:]/._-]+\.(py|go)) ]]; then
            if [ -n "$current_file" ] && [ -n "$buffer" ]; then
                local target_dir="$base_path/$(dirname "$current_file")"
                local target_file="$base_path/$current_file"
                
                [[ "$target_file" != "$base_path"/* ]] && {
                    echo "Error: Invalid path '$current_file'" >&2
                    return 1
                }
                
                mkdir -p "$target_dir" 2>/dev/null || {
                    echo "Error: Failed to create directory '$target_dir'" >&2
                    return 1
                }
                
                echo "$buffer" > "$target_file" 2>/dev/null || {
                    echo "Error: Failed to write file '$target_file'" >&2
                    return 1
                }
                
                echo "Created: $target_file"
            fi
            
            current_file="${BASH_REMATCH[2]}"
            buffer=""
        else
            buffer+="$line"$'\n'
        fi
    done < <(LC_ALL=C cat "$input_file")
    
    if [ -n "$current_file" ] && [ -n "$buffer" ]; then
        local target_dir="$base_path/$(dirname "$current_file")"
        local target_file="$base_path/$current_file"
        
        [[ "$target_file" != "$base_PATH"/* ]] && {
            echo "Error: Invalid path '$current_file'" >&2
            return 1
        }
        
        mkdir -p "$target_dir" 2>/dev/null || {
            echo "Error: Failed to create directory '$target_dir'" >&2
            return 1
        }
        
        echo "$buffer" > "$target_file" 2>/dev/null || {
            echo "Error: Failed to write file '$target_file'" >&2
            return 1
        }
        
        echo "Created: $target_file"
    fi
}
