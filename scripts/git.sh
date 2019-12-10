#!/usr/bin/env bash

function fetch() {
    git fetch --all
    git fetch -p
}

function showAll() {
    git branch -a | grep -v HEAD
}

function changeBranch() {
    git reset --hard
    git checkout -B $1 --track $2
    exit 0
}

function generatorData() {
    git pull
    cd tools/gen_const_sheet
    ./gen_const_sheet.sh
    cd -
}

function commit() {
    git status
    git commit -a -m "gen plist data by go-gpt"
}

function push() {
    git pull
    git push --all
}

function update() {
    ./deploy_dev.sh
    exit 0
}


function error() {
    echo "Usage: git.sh {git-path} {fetch|all|checkout|generator|commit|push|update} {name}"
    exit
}

if [[ -z "$1" ]] || [[ -z "$2" ]]; then
	error
fi
cd "$1"
case "$2" in
    "fetch")
        fetch
        ;;
    "all")
        showAll
        ;;
    "checkout")
        if [[ -z "$3" ]] || [[ -z "$4" ]]; then
            error
        fi
        changeBranch $3 $4
        ;;
    "generator")
        generatorData
        ;;
    "commit")
        commit
        ;;
    "push")
        push
        ;;
    "update")
        update
        ;;
    *)
        error
        ;;
esac



