# Sentinel OS (Live ISO build)

This repository contains the **Sentinel OS** live-build configuration: a **CLI-first** operating system focused on **web application penetration testing**, with an **on-demand minimal GUI** only when you launch specific GUI apps (e.g. Burp Suite, browser).

## Build (recommended entrypoint)

Run the Sentinel wrapper script:

```bash
./sentinel-build.sh
```

Artifacts are written under `sentinel-live-main/sentinel-live-main/images/` and are named `sentinel-os-...`.

## Layout notes

The project is derived from upstream Kali live-build scripts, but directory names in this repo are now Sentinel OS themed.
