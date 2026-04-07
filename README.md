# Sentinel OS (Live ISO build)

This repository contains the **Sentinel OS** live-build configuration: a **CLI-first** operating system focused on **web application penetration testing**, with an **on-demand minimal GUI** only when you launch specific GUI apps (e.g. Burp Suite, browser).

## Build (recommended entrypoint)

Run the Sentinel wrapper script (keeps the upstream layout intact for reliability):

```bash
./sentinel-build.sh
```

Artifacts are written under `kali-live-main/kali-live-main/images/` and are named `sentinel-os-...`.

## Upstream layout (kept intentionally)

Internally, the build system still uses the upstream directory names like `kali-config/` and `kali-live-main/` because many scripts and live-build conventions assume them. We changed **branding, ISO labels, boot menus, and output filenames** to Sentinel OS, while keeping the underlying structure stable so ISO builds don’t break.
