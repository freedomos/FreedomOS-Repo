#!/usr/bin/env bash
#
# Script name: build-db.sh


echo "###########################"
echo "Building the repo database."
echo "###########################"

## Arch: x86_64

rm -f FreedomOS-Core/x86_64/FreedomOS-Core*
rm -f FreedomOS-Extra/x86_64/FreedomOS-Extra*
rm -f FreedomOS-Testing/x86_64/FreedomOS-Testing*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in database
## -R: remove old package files when updating their entry
repo-add -n -R FreedomOS-Core/x86_64/FreedomOS-Core.db.tar.gz FreedomOS-Core/x86_64/*.pkg.tar.zst
repo-add -n -R FreedomOS-Extra/x86_64/FreedomOS-Extra.db.tar.gz FreedomOS-Extra/x86_64/*.pkg.tar.zst
repo-add -n -R FreedomOS-Testing/x86_64/FreedomOS-Testing.db.tar.gz FreedomOS-Testing/x86_64/*.pkg.tar.zst

# Removing the symlinks because GitLab can't handle them.
rm -f FreedomOS-Core/x86_64/FreedomOS-Core.db
rm -f FreedomOS-Extra/x86_64/FreedomOS-Extra.db
rm -f FreedomOS-Testing/x86_64/FreedomOS-Testing.db
#rm FreedomOS-Core-Repo.db.sig
rm -f FreedomOS-Core/x86_64/FreedomOS-Core.files
rm -f FreedomOS-Extra/x86_64/FreedomOS-Extra.files
rm -f FreedomOS-Testing/x86_64/FreedomOS-Testing.files
#rm FreedomOS-Core-Repo.files.sig

# Renaming the tar.gz files without the extension.
mv FreedomOS-Core/x86_64/FreedomOS-Core.db.tar.gz FreedomOS-Core/x86_64/FreedomOS-Core.db
mv FreedomOS-Extra/x86_64/FreedomOS-Extra.db.tar.gz FreedomOS-Extra/x86_64/FreedomOS-Extra.db
mv FreedomOS-Testing/x86_64/FreedomOS-Testing.db.tar.gz FreedomOS-Testing/x86_64/FreedomOS-Testing.db
#mv FreedomOS-Core-Repo.db.tar.gz.sig FreedomOS-Core-Repo-db.sig
mv FreedomOS-Core/x86_64/FreedomOS-Core.files.tar.gz FreedomOS-Core/x86_64/FreedomOS-Core.files
mv FreedomOS-Extra/x86_64/FreedomOS-Extra.files.tar.gz FreedomOS-Extra/x86_64/FreedomOS-Extra.files
mv FreedomOS-Testing/x86_64/FreedomOS-Testing.files.tar.gz FreedomOS-Testing/x86_64/FreedomOS-Testing.files
#mv FreedomOS-Core-Repo.files.tar.gz.sig FreedomOS-Core-Repo.files.sig

echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"
 
git pull

# Below command will backup everything inside the project folder
git add --all .

# Give a comment to the commit if you want
echo "####################################"
echo "Write your commit comment!"
echo "####################################"

read input

# Committing to the local repository with a message containing the time details and commit text

git commit -m "$input"

# Push the local files to github

git push -u origin master


echo "################################################################"
echo "###################    Git Push Done      ######################"
echo "################################################################"
