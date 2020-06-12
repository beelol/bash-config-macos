function ghcu {
    user=$1
    repo=$2

    git clone git@github.com:${user}/${repo}.git
}
