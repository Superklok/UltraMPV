# UltraMPV v1.0.67
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

### 5. This step is completely optional, it allows you to drag links for web hosted videos or live streams directly onto your opened MPV player (or use the command line `mpv "https://youtube.com/YourVideoLink"`, for example) to play your web hosted videos or live streams (YouTube, Kick, Twitch, etc...) streamed directly through MPV player so that the high quality premium shaders are applied to your web hosted videos in real time. To enable the functionality to play web hosted videos or live streams through MPV Player, enter `Y` to proceed with downloading `ytdlp` and then enter `1` to make sure it downloads `ytdlp` and do not download the obsolete `youtube-dl`.
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

* ### <ins>Context-Aware Processing:</ins> Auto-profiles evaluate media resolution against active monitor geometry in real time. They instantly isolate heavy shader passes so your GPU never wastes performance cycles on native 4K signals.
* ### <ins>Reference-Grade Motion Scaling:</ins> The unified combination of `video-sync=display-resample`, `interpolation=yes`, and `tscale=mitchell` delivers mathematically perfect frame blending. It completely eliminates 24fps "judder" on fixed 60Hz panels without causing artificial soap-opera artifacts.
* ### <ins>Fidelity-First Debanding:</ins> A dynamic dual-state deband pipeline protects native 4K film grain and micro-textures. It reserves aggressive artifact filtering exclusively for sub-4K compression and streaming web sources.
* ### <ins>`FSRCNNX` Neural Upscaling:</ins> Employs deep-learning-trained neural networks to reconstruct fine edge details and textures on sub-4K content without introducing the artificial halo or ringing artifacts of generic video sharpeners.
* ### <ins>`KrigBilateral` Chroma Reconstruction:</ins> Uses localized luma (brightness) contrast information to intelligently calculate and reconstruct color channels. This significantly minimizes edge color bleeding and enhances realistic color separation.
* ### <ins>`SSimDownscaler` Perceptual Reduction:</ins> Uses structure-similarity algorithms to map native 4K assets down onto lower-resolution displays (like 1080p or 1440p monitors) while preserving fine specular highlights and image sharpness.
* ### <ins>Zero-Copy Hardware Decoding:</ins> Utilizing `d3d11va` creates a direct, zero-overhead pipeline straight to your GPU's specialized video decode block. This ensures absolute stability and zero dropped frames on massive 4K UHD Blu-ray remuxes.
* ### <ins>Temporal Dithering Precision:</ins> Employs high-quality `fruit` dithering matrices. This prevents gradient blocking and banding artifacts in difficult, shadow-heavy scenes while maintaining accurate 8-bit or 10-bit visual depth.
* ### <ins>Native 60fps Frame Bypass:</ins> Automatically detects and bypasses the motion interpolation engine when native 60fps media is opened. This reduces system overhead and eliminates redundant processing artifacts on high-framerate sports or action content.
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
<br />

---

💡 *If you find this project useful, reach out via [Upwork](https://www.upwork.com/freelancers/~01a2b86360ffeb733e)/[Contra](https://contra.com/Superklok) to hire Superklok Labs today!*

[MPVrepo]: https://github.com/mpv-player/mpv
[SourceForge]: https://sourceforge.net/projects/mpv-player-windows/
[Bootstrapper]: https://sourceforge.net/projects/mpv-player-windows/files/bootstrapper.zip/download