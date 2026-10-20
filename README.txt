Fix for Windows MinGW-w64 cross-compilation linker errors:
  undefined reference to kpse_var_value

The standalone workflow was compiling with -DTEX_LIVE, which enables calls
into the Kpathsea library. The workflow does not link against Kpathsea, so
both x86 and x64 builds fail at link time.

The replacement workflow uses -DWIN32 without -DTEX_LIVE for both targets.
No source-code change is needed. The Windows x64 release remains -O3 -flto.

Copy .github/workflows/windows-cross.yml into your repository and rerun
GitHub Actions > Windows cross-build (MinGW-w64) > Run workflow.

Notes: The x86 probe is allowed to fail for unrelated reasons. On Windows,
run chktex.exe in the directory containing chktexrc, or configure CHKTEXRC
appropriately. The cross-built executable has not been tested under Windows.
