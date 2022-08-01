#!/usr/bin/env bash
#
# Script name: build-db.sh
# Description: Script for rebuilding the database for FreedomOS-Testing-Repo.
# GitLab: https://www.gitlab.com/dwt1/FreedomOS-Testing-Repo
# Contributors: Derek Taylor

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

#x86_pkgbuild=$(find ../FreedomOS-pkgbuild/x86_64 -type f -name "*.pkg.tar.zst*")

#for x in ${x86_pkgbuild}
#do
#    mv "${x}" x86_64/
#    echo "Moving ${x}"
#done

echo "###########################"
echo "Building the repo database."
echo "###########################"

## Arch: x86_64
cd x86_64
rm -f FreedomOS-Testing*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in database
## -R: remove old package files when updating their entry
repo-add -n -R FreedomOS-Testing.db.tar.gz *.pkg.tar.zst

# Removing the symlinks because GitLab can't handle them.
rm FreedomOS-Testing.db
#rm FreedomOS-Testing-Repo.db.sig
rm FreedomOS-Testing.files
#rm FreedomOS-Testing-Repo.files.sig

# Renaming the tar.gz files without the extension.
mv FreedomOS-Testing.db.tar.gz FreedomOS-Testing.db
#mv FreedomOS-Testing-Repo.db.tar.gz.sig FreedomOS-Testing-Repo-db.sig
mv FreedomOS-Testing.files.tar.gz FreedomOS-Testing.files
#mv FreedomOS-Testing-Repo.files.tar.gz.sig FreedomOS-Testing-Repo.files.sig

echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"
