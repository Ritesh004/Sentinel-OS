#!/bin/sh
# Pack a directory that already contains a full ISO/live filesystem (bootloaders
# included). Typical input is a live-build working tree: .../sentinel-live-main/sentinel-live-main/binary
#
# A plain clone of this repo does NOT contain boot/isolinux or boot/grub/efi.img.
# To produce a bootable image from source, run ./sentinel-build.sh (Debian/Ubuntu, live-build).

set -eu

usage() {
  echo "Usage: $0 <iso-root-directory> [output.iso]" >&2
  echo "  iso-root must contain boot/isolinux/isolinux.bin, boot/isolinux/boot.cat," >&2
  echo "  and boot/grub/efi.img (as produced by live-build, not a Git checkout)." >&2
  exit 2
}

[ "${1:-}" ] || usage
ISO_ROOT=$(CDPATH= cd -- "$1" && pwd)
OUT=${2:-sentinel.iso}

need() {
  test -e "$1" || {
    echo "ERROR: missing: $1" >&2
    return 1
  }
}

need "$ISO_ROOT/boot/isolinux/isolinux.bin" || missing=1
need "$ISO_ROOT/boot/isolinux/boot.cat" || missing=1
need "$ISO_ROOT/boot/grub/efi.img" || missing=1
if [ "${missing:-0}" = 1 ]; then
  echo >&2
  echo "This directory is not a bootable ISO staging tree (often it is only source code)." >&2
  echo "You cannot xorriso a Git checkout into a hybrid ISO — bootloaders are added by live-build." >&2
  echo "From this repo on Debian/Ubuntu, build the real image with:" >&2
  echo "  ./sentinel-build.sh" >&2
  echo "Output appears under sentinel-live-main/sentinel-live-main/images/" >&2
  exit 1
fi

ISOHDPFX=""
for p in \
  /usr/lib/ISOLINUX/isohdpfx.bin \
  /usr/lib/syslinux/mbr/isohdpfx.bin \
  /usr/share/syslinux/isohdpfx.bin
do
  if [ -f "$p" ]; then
    ISOHDPFX=$p
    break
  fi
done

if [ -z "$ISOHDPFX" ] && command -v dpkg >/dev/null 2>&1; then
  ISOHDPFX=$(dpkg -L isolinux 2>/dev/null | grep -F 'isohdpfx.bin' | head -n1 || true)
fi

if [ -z "$ISOHDPFX" ] || [ ! -f "$ISOHDPFX" ]; then
  echo "ERROR: isohdpfx.bin not found. On Debian/Ubuntu install: sudo apt install isolinux" >&2
  exit 1
fi

exec xorriso -as mkisofs \
  -o "$OUT" \
  -isohybrid-mbr "$ISOHDPFX" \
  -b boot/isolinux/isolinux.bin \
  -c boot/isolinux/boot.cat \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  -eltorito-alt-boot \
  -e boot/grub/efi.img \
  -no-emul-boot \
  -isohybrid-gpt-basdat \
  -J -R \
  "$ISO_ROOT"
