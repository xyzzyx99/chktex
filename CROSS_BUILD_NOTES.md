# Windows cross-build

The workflow `.github/workflows/windows-cross.yml` runs **manually only**.

* Runs on Ubuntu using MinGW-w64.
* Attempts a Windows x86 (32-bit) cross-compile first as a non-blocking compatibility probe.
* Builds a Windows x64 (64-bit) package with `-O3 -flto` and `-DNDEBUG`.
* Uploads `chktex-windows-x64.zip` from GitHub Actions -> workflow run -> Artifacts.
* Bundles `chktex.exe` and `chktexrc` together. Tests requiring execution of Windows binaries are **not** performed on the Linux runner.

Source compatibility changes:

* `chktex/configure.ac`: allow builds where no termcap library exists (fallback terminal behavior already in `OpSys.c`).
* `chktex/Makefile.in`: do not force `__unix__` on Windows cross-compilation. The compiler supplies `__unix__` automatically on Unix. The Windows build explicitly defines `WIN32` and `TEX_LIVE` to use Windows paths.

If using the existing GitHub repository, place these files at the repository root, with the sources in `chktex/`.

Note: This has been validated with a native Linux x86-64 build, not with a real MinGW cross-build or Windows runtime test.
