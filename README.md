# 1mb-dev/homebrew-tap

[![test](https://github.com/1mb-dev/homebrew-tap/actions/workflows/test.yml/badge.svg)](https://github.com/1mb-dev/homebrew-tap/actions/workflows/test.yml)

Homebrew tap for [1mb-dev](https://github.com/1mb-dev) tools.

## Install

```sh
brew tap 1mb-dev/tap
brew install <formula>
```

Available formulas in the table below.

## Formulas

| Name | Description | Source |
|------|-------------|--------|
| [natcheck](Formula/natcheck.rb) | NAT type diagnosis CLI for WebRTC / P2P / VPN | [1mb-dev/natcheck](https://github.com/1mb-dev/natcheck) |
| [gowsay](Formula/gowsay.rb) | Modern cowsay in Go - CLI, REST API, and web UI in one binary | [1mb-dev/gowsay](https://github.com/1mb-dev/gowsay) |
| [lobster](Formula/lobster.rb) | Intelligent web stress testing CLI with auto URL discovery | [1mb-dev/lobster](https://github.com/1mb-dev/lobster) |
| [shim](Formula/shim.rb) | Anthropic Messages API proxy with built-in request measurement | [1mb-dev/shim](https://github.com/1mb-dev/shim) |

`shim` is daemon-capable: run it directly, or opt into a managed background service with `brew services start shim`.

## Updating a formula

When the upstream project tags a new release, bump the formula. Replace `<formula>`, `<owner>`, `<repo>`, and `<version>`:

```sh
# 1. Capture the new SHA256
SHA=$(curl -sL "https://github.com/<owner>/<repo>/archive/refs/tags/v<version>.tar.gz" \
  | shasum -a 256 | cut -d' ' -f1)
echo "SHA: $SHA"

# 2. Edit Formula/<formula>.rb — bump url to .../v<version>.tar.gz and sha256 to $SHA

# 3. Validate locally (one-time setup: symlink this repo into Homebrew Taps;
#    see .github/workflows/test.yml for the exact pattern)
brew audit --strict --online --new 1mb-dev/tap/<formula>
brew install --build-from-source 1mb-dev/tap/<formula>
brew test 1mb-dev/tap/<formula>
brew uninstall <formula>

# 4. Open a PR — CI re-runs the same checks. Merge on green.
```

## Troubleshooting

**SHA mismatch on `brew install` after the formula was working.** We never retag releases. If a version ships broken, we cut a new patch (e.g., v0.1.1 → v0.1.2) rather than rewriting the tag. A mid-life SHA mismatch always indicates upstream changed something, not a tap bug — file an issue against the upstream repo, not this one.

**Rolling back a bad formula bump.** Revert the formula commit on `main`. Users get the previous formula on their next `brew update`. Already-installed binaries are unaffected.

```sh
git revert <bad-commit-sha>
git push origin main
```

## Contributing a new formula

One PR per formula. Each formula must:

- Live at `Formula/<name>.rb` (one file per project).
- Pin a specific tag's source tarball with SHA256 (no `:branch`, no `HEAD`-only).
- Include a `test do` block. The `--version` assertion is the documented ceiling for `test do` here — richer tests need network access, which Homebrew's sandbox restricts.
- Pass `brew audit --strict --online --new 1mb-dev/tap/<formula>` cleanly. CI must be green before merge.

## License

MIT — see [LICENSE](LICENSE).
