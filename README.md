# extusbinst
[alpm hook](https://www.archlinux.org/pacman/alpm-hooks.5.html) to automatically copy kernel image and initial RAM disk(s) to external USB drive.

This software is [Arch Linux](https://www.archlinux.org/) specific (but you may try to adapt it to other Linux distributions). Its main goal is to copy kernel image and accompanying files to external USB drive(s) (including SD cards) whenever those files have changed during system upgrade/downgrade.

## Installation

Download source code from git repository:

    $ git clone https://github.com/mmarzantowicz/extusbinst.git

Run `make` and `make install` (second command may require root privileges):

    $ make
    ...
    $ sudo make install

By default `make` and `make install` does not require any arguments and in such case it builds `linux.hook` for kernel package called `linux`. If you have other kernel packages installed (e.g. `linux-lts`) and would like their files to be copied to external drive as well, you can specify `HOOKS` argument:

    $ make HOOKS="linux.hook linux-lts.hook"

In order to install your files in different directory than `/etc`, you can do:

    $ sudo make install DESTDIR=/path/to/somewhere

Please not that it may be required to adjust value of `HookDir` in `/etc/pacman.conf` when installing hooks in non standard directory (default is `/etc/pacman.d/hooks/`).


## Configuration

A configuration file called `extusbinst` is created in `/etc/conf.d/`. Before using this hooks, you must change its content according to your needs.

Below is a simple configuration with two external USB drives mounted at `/mnt/usb-boot-1` and `/mnt/usb-boot-2`:

    BOOTABLE_DEVICES=(
        '/mnt/usb-boot-1'
        '/mnt/usb-boot-2'
    )

> **NOTE**: Before upgrading kernel package (or any other packages that will trigger rebuild of initial RAM disk), you must mount your USB drives under specified directories. Otherwise you will see complains from alpm hook.

> **NOTE**: Please note that your USB drive must be bootable ([see here](https://wiki.archlinux.org/index.php/GRUB/Tips_and_tricks#Install_to_external_USB_stick)) in order to load kernel image and initial RAM disk from given USB drive.

## Bugs

### Reporting bugs

Please open a Github [issue](https://github.com/mmarzantowicz/extusbinst/issues) with as much information as possible.

### Known issues

- Only one initial RAM disk `/boot/initramfs-<package>.img` is copied to USB drive (fallback initramfs is not supported yet).
- Colored output does not always work
