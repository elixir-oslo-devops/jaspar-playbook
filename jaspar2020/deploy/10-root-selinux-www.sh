#!/bin/sh

# SPDX-FileCopyrightText: 2020-2021 University of Oslo
# SPDX-FileContributor: Morten Johansen <morj@uio.no>
# SPDX-License-Identifier: GPL-3.0-or-later

THISDIR=`dirname "$0"`
BASEDIR=`realpath "$THISDIR/.."`

. "$BASEDIR/deploy/tools/system.sh"

if ! have semanage ; then
    exit 0
fi

# Add labels for www/httpd read-only files and directories.

for DIRNAME in jaspar downloads jaspar portal profile-inference restapi static templates utils ; do
    DIRPATH="$BASEDIR/$DIRNAME"

    # Set a label for SELinux.

    semanage fcontext -a -t httpd_sys_content_t "$DIRPATH(/.*)?"
done

semanage fcontext -a -t httpd_sys_content_t "$DIRPATH/secret.txt"

# Apply all labels
restorecon -R "$DIRPATH"


# vim: tabstop=4 expandtab shiftwidth=4
