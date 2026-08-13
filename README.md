# UltraMPV v1.0.32
<br />

## The BEST realistic 4K video playback experience in the world!
###### Carefully follow all steps in this guide to completely transform your MPV Player so it can rival the highest quality video players in existence. (Optimized for Nvidia)

### 1. Download and install MPV Player using their [OFFICIAL GitHub repository][MPVrepo] or [SourceForge page][SourceForge]. For your convenience, there's a copy of the Windows MPV Player Bootstrapper (Updated 13/08/2026) in the UltraMPV repository's `\Archive` folder. You can use this [Direct Link][Bootstrapper] to download a new copy of the MPV Player Bootstrapper that's found in the UltraMPV repository's `\Archive` folder.
<br />

### 2. After downloading the Windows MPV Player installer from SourceForge, search your downloads for a file called `bootstrapper.zip` and extract its contents into the folder you want MPV Player program files to be stored.
<br />

### 3. Open the extracted `bootstrapper` folder, `right-click` the `updater.bat` file and run as administrator.
<br />

### 4. In the terminal that opens, enter `Y` to proceed with the installation, enter `1` to check for updates weekly, enter `2` to download the `x86_64-v3` version of MPV Player. This "v3" build is optimized for modern CPUs (typically those released after 2015) and offers better performance by utilizing newer instruction sets like AVX2. Then enter `Y` to delete archives after extract.
<br />

### 5. This step is completely optional, it allows you to drag links for web hosted videos or live streams directly onto your opened MPV player (or use the command line `mpv "https://youtube.com/YourVideoLink"`, for example) to play your web hosted videos or live streams (YouTube, Kick, Twitch, etc...) streamed directly through MPV players so that the high quality premium shaders are applied to your web hosted videos in real time. To enable the functionality to play web hosted videos or live streams through MPV Player, enter `Y` to proceed with downloading `ytdlp` and then enter `1` to make sure it downloads `ytdlp` and do not download the obsolete `youtube-dl`.
<br />

### 6. Open the `installer` folder that `updater.bat` downloaded into your extracted `bootstrapper` folder. Inside the `installer` folder, `right-click` the `mpv-install.bat` file and run as administrator to install MPV Player on your system. 

###### NOTE: You will have to re-run this `mpv-install.bat` file whenever you move or rename your extracted `bootstrapper` folder. MPV Player is a "portable" application, so Windows does not automatically track its location like it would for a standard program with a traditional installer.
<br />

### 7. Double-click `mpv.exe` to open the MPV player. The player should open and stay open with a black screen. This indicates you have installed the proper build of MPV Player for your system.
<br />

### 8. Access the following filepath then place the UltraMPV `mpv.conf` file inside the `mpv` folder on your system to overwrite your current `mpv.conf` file, if one exists:
<br />

```Bash
%APPDATA%\mpv\
```

### 9. Access the following filepath then place the UltraMPV `shaders` folder inside the `mpv` folder on your system to replace your current `shaders` folder, if one exists:
<br />

```Bash
%APPDATA%\mpv\
```

### 10. Open a video file with MPV Player and press the backtick key (`` ` ``) to open the terminal then make sure there are no errors loading the UltraMPV configuration.
<br />
<br />

## DONE!
<br />
<br />

# UltraMPV Configuration Summary

### In the Windows/Nvidia environment, this is effectively the WORLD'S BEST configuration for a fixed 60Hz 4K monitor. It leverages a sophisticated balance of high-performance internal settings and industry-standard external shaders. This configuration is essentially the gold standard for "realistic" 4K playback in 2026.
<br />

### It's superior to standard high-quality templates because it intelligently handles Chroma reconstruction (using `KrigBilateral`) and uses Dynamic Profile Logic to ensure the GPU doesn't waste resources on unnecessary shaders when playing native 4K content.
<br />

## Features:

### - The "Heavy Lifters" (Shaders): By using `FSRCNNX` (Luma upscaling), `KrigBilateral` (Chroma scaling), and `SSimDownscaler` (Perceptual downscaling), this configuration is using some of the most accurate algorithms available for realistic video.
<br />

### - Realistic Motion: The combination of `video-sync=display-resample` and `interpolation=yes` with `tscale=oversample` provides the most natural motion possible on standard 60Hz displays by eliminating "judder" without creating the "soap opera effect" of cheaper video players.
<br />

### - `FSRCNNX`: Widely considered one of the best for non-animated, realistic content because it uses neural networks to reconstruct detail without the "artificial" look of basic sharpeners.
<br />

### - `KrigBilateral`: Uses luma (brightness) information to intelligently upscale chroma (colour), significantly reducing "colour bleeding" on sharp edges.
<br />

### - Hardware Efficiency: Switching to `d3d11va` ensures a direct path to your GPU, which is critical for maintaining `0` dropped frames in high-bitrate 4K.
<br />

### - Context-Aware Processing: Auto-profiles intelligently switch between upscaling (`FSRCNNX`), downscaling (`SSimDownscaler`), and native 4K modes. This prevents your GPU from wasting cycles on shaders that would actually degrade a native 4K signal.
<br />

### - Banding Prevention: The combination of `deband-grain=5` and `dither=fruit` ensures that even the most difficult dark scenes (like space or underwater shots) look smooth and natural.
<br />
<br />

## PEASE NOTE!

### Hardware Demand: This config is extremely demanding. `FSRCNNX_x2_16-0-4-1` and `KrigBilateral` run heavily on the GPU. If you experience dropped frames you may need to downscale `FSRCNNX` to the `8-0-4-1` version. Find out if there are dropped frames by pressing `Shift + i` then `2`, and check "Frame Timings". If the "Estimated" and "Measured" times are consistent and below your refresh rate interval (e.g., <16.6ms for 60Hz), you're golden.
<br />

### Dither Check: This config is setup with `dither-depth=auto` so that it automatically decides between 8-bit and 10-bit colour depending on your display. You may also hardcode this to either `dither-depth=10` to force 10-bit colour or `dither-depth=8` to force 8-bit colour. If you decide to hardcode this value to `dither-depth=10` to force 10-bit colour, then ensure your Windows/GPU display settings are correctly set to 10-bit colour, otherwise, this can cause issues on 8-bit monitors.
<br />

### Dynamic Range: Check your NVIDIA Control Panel. Ensure "Output Dynamic Range" is set to Full (0-255), not Limited. If it's on Limited, even the best MPV config will look washed out.
<br />

### Display Capabilities: Are you watching this on a true HDR monitor/TV, or are you tone-mapping HDR content down to an SDR display? This changes which target-peak value you should use. Within `mpv.conf`, locate `# target-peak=300` then uncomment it by removing the `#` so that it just reads `target-peak=300` and set the numeric value to your monitor's actual nits if SDR.
<br />
<br />

# You're all set!
<br />
<br />

## License

### This project is licensed under the [MIT License](LICENSE). Third-party shaders and bundled binaries are subject to their own respective upstream licenses, detailed in the [THIRD-PARTY-LICENSES](THIRD-PARTY-LICENSES.md) file.
<br />

## Third-Party Shaders & Utilities Download Links

*   **FSRCNNX Shaders:** https://github.com/igv/FSRCNN-TensorFlow/releases/download/1.1/FSRCNNX_x2_16-0-4-1.glsl
*   **KrigBilateral Shaders:** https://gist.github.com/igv/a015fc885d5c22e6891820ad89555637
*   **SSimDownscaler Shaders:** https://gist.github.com/igv/36508af3ffc84410fe39761d6969be10
*   **MPV Player:** https://sourceforge.net/projects/mpv-player-windows/files/bootstrapper.zip/download


[MPVrepo]: https://github.com/mpv-player/mpv
[SourceForge]: https://sourceforge.net/projects/mpv-player-windows/
[Bootstrapper]: https://sourceforge.net/projects/mpv-player-windows/files/bootstrapper.zip/download