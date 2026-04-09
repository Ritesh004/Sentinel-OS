# Sentinel OS Live Build-Scripts

_`live-build` configuration for Sentinel OS ISO images._

Note: This workspace has been adapted as the Sentinel OS build configuration — a CLI-only, security-focused distribution derived from these live-build scripts. The default variant has been switched to `variant-minimal` so builds produce a terminal-first image without graphical desktops or X11.

To build the Sentinel CLI-only ISO (default):

```console
$ ./build.sh
```

If you need a GUI variant for testing, you can still build other variants by explicitly passing `--variant <name>` (but GUI meta-packages are commented out in this fork).

These build scripts are derived from the upstream Kali build-scripts, adapted and branded as **Sentinel OS**.

_Build your Sentinel OS image today!_

- - -

These images can be used to live boot into Sentinel OS, from such a USB/CD/DVD/sdCard, and also offer a basic installation. For more customization during setup, see [kali-installer](https://gitlab.com/kalilinux/build-scripts/kali-installer).

- [kali-installer](https://gitlab.com/kalilinux/build-scripts/kali-installer) uses [Simple-CDD](https://wiki.debian.org/Simple-CDD) _(which is a wrapper for [debian-cd](https://wiki.debian.org/debian-cd))_
- [kali-live](https://gitlab.com/kalilinux/build-scripts/kali-live) uses [live-build](https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html)

- - -

Have a look at [Live Build a Custom Kali ISO](https://www.kali.org/docs/development/live-build-a-custom-kali-iso/) for explanations on how to use this repository.

There are also other [code examples of live-build](https://gitlab.com/kalilinux/recipes/live-build-config-examples), as well as [code examples for pre-seed to automate/unattended installation](https://gitlab.com/kalilinux/recipes/kali-preseed-examples).

- - -

## Help

```console
$ ./build.sh --help
Usage: ./build.sh [<option>...]

  --distribution <arg>
  --proposed-updates
  --arch <arg>
  --verbose
  --debug
  --variant <arg>
  --version <arg>
  --subdir <arg>
  --get-image-path
  --no-clean
  --clean
  --help

More information: https://www.kali.org/docs/development/live-build-a-custom-kali-iso/
$
```

## Usage Examples

Both images types, using the latest packages:

```console
$ ./build.sh
[...]
```

- - -

Manually define which Kali mirror to pull from, as well as be more detailed in output:

```console
$ echo "http://kali.download/kali" > .mirror
$
$ ./build.sh --verbose
[...]
```

- - -

Build a different Live image version (GNOME and KDE Plasma):

```console
$ ./build.sh \
  --debug \
  --variant gnome
[...]
$
$ ./build.sh \
  --debug \
  --variant kde
[...]
$
```
