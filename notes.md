# GIT Notes

## What is GIT?
- version control system

## Common GIT Commands
`git init` initializes the git repo in the folder
git commands only work inside a directory that has git initialized
`git status` checks the status of working directory and staging area
`git add <filename> <filename2>` adds changes to files files to the staging area to get ready for commits. If you delete a file that is being tracked, and you want to commit that deletion, you need to 'add' the deletion of the file because it is a modification
`git diff` looks at difference between modified files to the staging area and working dir
`git commit -m '<message>'` commits the files in the staging area to the git directory
commit messages should start with a  present tense imperative verb
`git log` shows all the commit versions
`git log --oneline` shows just commit messages, not the author or date information
changing the local author will allow remote repositories to read your commit authors and give you credit for your work
`git config --local user.email <email>` sets the local author's email
`git config --local user.name <name>` sets the local author's name
`git config --local user.username <username>` sets the local author's username
`git config user.name` shows the current author's name


## Branches
- master branch is a branch automatically created at git initialization
- if you want to work on other features but still keep a working version, then we can create branches that will have its own commit logs starting at whatever commit the last commit it branched out of
- we can merge a branch (1) into another branch (2) once we are satisfied with the branch (1)
- we can switch between branches easily
- master branch should only have clean and working code

`git branch` shows all the branches
`git branch <branch name>` will create a new branch
`git checkout <branch name>` will checkout a branch
`git checkout -b <branch name>` will create and checkout the new branch at the same time
if we try to checkout a branch that has a different commit log than the one we are currently on, and we have some files in our working directory, we either need to commit those files or stash the files
`git stash` will stash the files in our branch before we checkout to a different change
`git stash apply` will get the last stash changes and put them into our working directory again
`git stash list` will show all our stashes
