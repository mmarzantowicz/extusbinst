# extusbinst
[alpm hook](https://www.archlinux.org/pacman/alpm-hooks.5.html) to automatically copy kernel image and initial RAM disk(s) to external USB drive.

## Installation

- Download source code from git repository:

    ```
    $ git clone https://github.com/mmarzantowicz/extusbinst.git
    ```

- Run `make` and `make install` (second command may require root privileges):

    ```
    $ make HOOKS=linux.hook
    ...
    $ sudo make install
    ```
