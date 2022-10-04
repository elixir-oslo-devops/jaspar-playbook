#!/bin/sh

# SPDX-FileCopyrightText: 2020-2021 University of Oslo
# SPDX-FileContributor: Morten Johansen <morj@uio.no>
# SPDX-License-Identifier: GPL-3.0-or-later

THISDIR=`dirname "$0"`
BASEDIR=`realpath "$THISDIR/.."`
TOOLS=`realpath "$BASEDIR/../jaspar_tools"`

. "$BASEDIR/deploy/tools/system.sh"

if ! have semanage ; then
    exit 0
fi

# Add labels for www/httpd read-only files and directories.

for DIRNAME in downloads jaspar portal profile-inference restapi static templates utils ; do
    DIRPATH="$BASEDIR/$DIRNAME"

    # Set a label for SELinux.

    semanage fcontext -a -t httpd_sys_content_t "$DIRPATH(/.*)?"
done

semanage fcontext -a -t httpd_sys_content_t "$DIRPATH/secret.txt"

# Need httpd read accessible file context for tool data in git repos
semanage fcontext -a -t git_content_t "$TOOLS/CSC(/.*)?"
semanage fcontext -a -t git_content_t "$TOOLS/stamp(/.*)?"

# Apply all labels
restorecon -R "$DIRPATH"
restorecon -R "$TOOLS"


# vim: tabstop=4 expandtab shiftwidth=4
