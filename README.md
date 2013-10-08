CONVENIENCE SCRIPTS FOR OME DEVELOPMENT
=======================================

Building development/execution chroots
--------------------------------------

Currently the chroot builder scripts support the following distributions
automatically:

* Debian (and Debian derived such as Ubuntu)
* Arch Linux



To build a working dev/build chroot for the OMERO project, run:

       ./make_dev_chroot.sh <CHROOT_PATH>

After the chroot is made, you'll likely want to use something like:

* https://bitbucket.org/criswell/chroot-wrap

to manage the chroot itself.

Using the scripts in non-chroots
--------------------------------

The setup_env.sh scripts are suitable to run in non-chroot (e.g., host)
environments, if you don't like building/developing in a chroot.

        ./deb_setup_env.sh

TODO and notes for future work
------------------------------

* At some point, it would be nice to add support for other distros.
* Might also be nice to add LXC support.
