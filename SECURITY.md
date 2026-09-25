# Security Policy

## Image Signing

All `itsphenom/open77` images published from this repository's official
GitHub Actions pipeline are cryptographically signed using
[Sigstore Cosign](https://github.com/sigstore/cosign). This lets you verify
that an image was genuinely built and published by this project's CI -
not tampered with, and not distributed by an unrelated third party under
the same name.

### Public Key

The public key used to verify signatures is committed in this repository
at [`cosign.pub`](./cosign.pub).

### Verifying an Image

1. Install Cosign: https://docs.sigstore.dev/cosign/system_config/installation/
2. Download `cosign.pub` from this repository.
3. Run:

```bash
   cosign verify --key cosign.pub itsphenom/open77:latest
```

   Replace `:latest` with any published tag (`:stable`, `:unstable`, or a
   specific version such as `:2.31.13-op77.87`).

A successful verification prints a JSON payload and confirms the
signature was validated against the key above. If verification fails,
**do not run the image** - it may not have come from this project's
official build pipeline.

### What Signing Does and Doesn't Guarantee

Signing confirms the image was built and published by this repository's
CI pipeline and hasn't been modified since. It does **not** guarantee the
image is free of vulnerabilities, nor does it vouch for the upstream
OPEN//77 server software itself - only for the integrity of this specific
Docker distribution of it.

## Reporting a Vulnerability

If you discover a security vulnerability in this Docker image, its build
pipeline, or configuration, please report it privately rather than
opening a public issue.

- **Preferred:** open a
  [GitHub Security Advisory](../../security/advisories/new) for this
  repository.
- **Alternative:** DM phenom on Discord

Please include as much detail as possible (affected version/tag, steps to
reproduce, potential impact) so the issue can be triaged quickly.

This project is an unofficial, independent fan project and is not
affiliated with, endorsed by, or sponsored by CD PROJEKT S.A. Security
issues in the OPEN//77 server software itself (as opposed to this Docker
packaging) should be reported to the
[OPEN//77 project](https://open2077.net) directly.