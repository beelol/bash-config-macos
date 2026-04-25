# Compare working tree + commits against a target branch's merge-base
# Usage: brdiff [branch_name]
function brdiff() {
    # Set target branch to the first argument, or default to 'dev'
    local target_branch="${1:-dev}"

    # Verify we are actually in a git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "❌ Error: Not a git repository."
        return 1
    fi

    # Find the merge base
    local merge_base
    merge_base=$(git merge-base "$target_branch" HEAD 2>/dev/null)

    # Check if a merge base was actually found
    if [[ -z "$merge_base" ]]; then
        echo "❌ Error: Could not find a common ancestor between '$target_branch' and HEAD."
        echo "Make sure the branch '$target_branch' exists locally and shares history with your current branch."
        return 1
    fi

    echo "🔍 Showing all changes since diverging from '$target_branch' ($merge_base)..."
    
    # Run the diff
    git diff "$merge_base"
}