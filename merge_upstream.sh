#!/bin/sh
#
# This script helps to automatically synchronise a GitHub fork to the upstream repository

# Fetch upstream changes
git remote add upstream https://github.com/tissazak/meteor-dapp-wallet
git fetch upstream

# Prune deleted branches
git fetch -p

# Swap to master branch
git checkout develop

# Merge in the changes from upstream/master
git merge upstream/develop

# Check if any branches need pruning
git branch --merged develop | grep -v 'develop$'

if [ $? -eq 1 ]; then
        echo "No local branches need deleting"
else
        echo "Local branches need deleting"
        git branch --merged develop | grep -v 'develop$' | xargs git branch -d
fi

echo "Finished!"
