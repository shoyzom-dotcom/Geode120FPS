# 120 FPS Unlock — iOS Geode Mod

This project targets Geode **v5.9.0** and Geometry Dash **2.2081** for iOS.

## What it does

- Requests up to 120 FPS on iOS displays that support it.
- Sets the Cocos2d animation interval to the selected 120-FPS rate.
- Sets `GLKViewController`'s preferred frame rate when Geometry Dash exposes that controller.
- Automatically falls back to the device's maximum refresh rate, so a 60 Hz device is not forced above 60 Hz.

## GitHub Actions

Push the repository to GitHub and open:

**Actions → Build Geode Mod → Run workflow**

The finished `.geode` file is uploaded as the **120-FPS-Unlock-iOS** artifact.

## Important

A 120 FPS request cannot make a 60 Hz display physically refresh at 120 Hz. iOS can also reduce the available refresh rate because of system policy, Low Power Mode, thermal conditions, or device limitations.

The mod is intentionally iOS-only.

## Project layout

- `mod.json` — Geode v5.9.0 metadata
- `CMakeLists.txt` — Geode CMake project with the iOS arm64 configuration
- `src/main.mm` — iOS 120-FPS implementation
- `.github/workflows/build.yml` — macOS GitHub Actions build


## Geode 5.9.0

This project is pinned to Geode SDK **5.9.0**. The GitHub Actions workflow builds an iOS `.geode` package using the Geode 5.9.0 SDK and uploads the resulting package as an Actions artifact.

### Getting the `.geode`
1. Push the repository to GitHub.
2. Open **Actions → Build Geode Mod → Run workflow**.
3. Wait for the macOS iOS build to finish.
4. Open the completed workflow run and download the **120-FPS-Unlock-iOS** artifact.
5. The downloaded artifact contains the `.geode` file.
