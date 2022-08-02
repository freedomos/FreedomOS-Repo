#!/usr/bin/env bash
#
# Script name: build-db.sh
# Description: Script for rebuilding the database for FreedomOS-Extra-Repo.
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
rm -f FreedomOS-Extra*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in database
## -R: remove old package files when updating their entry
repo-add -n -R FreedomOS-Extra.db.tar.gz *.pkg.tar.zst

# Removing the symlinks because GitLab can't handle them.
rm FreedomOS-Extra.db
#rm FreedomOS-Extra-Repo.db.sig
rm FreedomOS-Extra.files
#rm FreedomOS-Extra-Repo.files.sig

# Renaming the tar.gz files without the extension.
mv FreedomOS-Extra.db.tar.gz FreedomOS-Extra.db
#mv FreedomOS-Extra-Repo.db.tar.gz.sig FreedomOS-Extra-Repo-db.sig
mv FreedomOS-Extra.files.tar.gz FreedomOS-Extra.files
#mv FreedomOS-Extra-Repo.files.tar.gz.sig FreedomOS-Extra-Repo.files.sig

echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"
