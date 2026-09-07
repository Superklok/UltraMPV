# UltraMPV v1.0.93
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

> ⚠️ **NOTE:** You will have to re-run this `mpv-install.bat` file whenever you move or rename your extracted `bootstrapper` folder. MPV Player is a "portable" application, so Windows does not automatically track its location like it would for a standard program with a traditional installer.
<br />

### 7. Double-click `mpv.exe` to open the MPV player. The player should open and stay open with a black screen. This indicates you have installed the proper build of MPV Player for your system.
<br />

### 8. Access the following filepath then place the UltraMPV `mpv.conf` file inside the `mpv` folder on your system to overwrite your current `mpv.conf` file, if one exists:

```Bash
%APPDATA%\mpv\
```
<br />

### 9. Access the following filepath then place the UltraMPV `shaders` folder inside the `mpv` folder on your system to replace your current `shaders` folder, if one exists:

```Bash
%APPDATA%\mpv\
```
> ⚠️ **NOTE:** The `shaders` folder should contain `FSRCNNX_x2_16-0-4-1.glsl`, `KrigBilateral.glsl`, and `SSimDownscaler.glsl`.
<br />

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

## Features

* ### <ins>Context-Aware Processing Architecture:</ins> 
  Auto-profiles evaluate media resolution against active monitor geometry in real time. They instantly isolate or strip away heavy shader passes using automated pipeline flushes (`glsl-shaders-clr`), ensuring your GPU never leaves previous shaders jammed in memory or wastes performance cycles on native 4K signals.

* ### <ins>Ghosting-Free Motion Cadence:</ins> 
  The synchronized combination of `video-sync=display-resample` and `tscale=oversample` provides pixel-perfect frame-step matching. Unlike cubic blending filters (like Mitchell) which cause temporal blur and ghosting during camera pans, this pipeline preserves 100% texture and skin-pore sharpness during fast motion while completely eliminating 24p judder on fixed 60Hz panels.

* ### <ins>`FSRCNNX_x2_16-0-4-1` Neural Super-Resolution Upscaling:</ins> 
  Deploys a heavy, 16-filter convolutional neural network natively inside the Vulkan pipeline. Unlike artwork-trained models that create an artificial "oil painting" look, FSRCNNX uses advanced statistical super-resolution to accurately reconstruct high-frequency data. It preserves natural human features—including skin pore structures, fine wrinkles, clothing textures, and organic film grain—delivering lifelike clarity to sub-4K content without introducing edge halos, ringing, or plastic smoothing artifacts.

* ### <ins>Dynamic Dual-State Debanding:</ins> 
  A reactive anti-banding system protects your media. It defaults to a non-destructive, ultra-light pass (`iterations=1`) to keep native 4K film grain untouched, but automatically scales up to an aggressive cleanup pass (`iterations=4`, `threshold=48`) exclusively when low-bitrate, heavily compressed sub-4K streaming sources are detected.

* ### <ins>Spatial Error-Diffusion Dithering:</ins> 
  Replaces standard ordered dithering matrices with advanced spatial distribution algorithms (`dither=error-diffusion` via Atkinson). This math engine eliminates macro-gradients and color banding in difficult, shadow-heavy scenes, ensuring smooth, filmic transitions across both 8-bit and 10-bit panels.

* ### <ins>Vulkan Zero-Copy Hardware Decoding:</ins> 
  Migrates the entire playback stack to modern Vulkan (`gpu-api=vulkan` and `gpu-context=winvk`). This creates a direct, low-overhead hardware decoding handshake with your GPU, ensuring flawless stability and frame-perfect presentation timing on massive 4K UHD Blu-ray remux files.

* ### <ins>`KrigBilateral` Chroma Reconstruction:</ins> 
  Contains a high-accuracy, luma-guided bilateral upscaling algorithm that uses the video's high-resolution brightness channel to perfectly reconstruct missing color data. By mapping chroma boundaries directly to localized luminance detail, it completely eliminates color bleeding, tightens color accuracy, and provides razor-sharp, hyper-realistic color boundaries around human figures, skin tones, and complex real-world environments.

* ### <ins>`SSimDownscaler` Perceptual Reduction:</ins> 
  Utilizes structure-similarity models to downscale 4K assets onto lower-resolution displays (like 1440p or 1080p monitors) when necessary. The algorithm focuses on preserving localized contrast and fine specular highlights, rendering a sharp downscaled image that holds true to the master file.

* ### <ins>Native 60fps Frame Bypass:</ins> 
  Tracks incoming media framerates dynamically. It instantly untethers the interpolation engine (`interpolation=no`) when native 60fps media is opened, preventing processing artifacts and keeping system overhead low on sports, gameplay, or high-framerate action content.
<br />
<br />

## PLEASE NOTE!

### Hardware Demand & Performance Fallback:
This configuration is exceptionally demanding. Combining `FSRCNNX_x2_16-0-4-1` and `KrigBilateral` via the Vulkan compute pipeline places a heavy load on your graphics card. If your system encounters dropped frames, you can drop your upscaler down to `FSRCNNX_x2_8-0-4-1.glsl` to reclaim massive GPU performance overhead. 

To audit your real-time performance, press `Shift + i` during playback, then hit `2` to view **Frame Timings**. If your "Estimated" and "Measured" compute times are stable and remain safely below your display's refresh interval (for example, `< 16.6ms` for a 60Hz monitor or `< 6.9ms` for a 144Hz panel), your hardware is performing flawlessly.
<br />

### Advanced Error-Diffusion Dithering:
This setup relies on advanced spatial distribution mapping (`dither=error-diffusion` via Atkinson). By default, `dither-depth=auto` allows mpv to automatically negotiate the optimal 8-bit or 10-bit deep-color state directly with your monitor's display driver. 

If you choose to hardcode this setting by changing it to `dither-depth=10`, you **must** verify that your Windows Display Settings or Nvidia Control Panel is actively transmitting a true 10-bit color signal. Forcing a 10-bit dithering pattern onto an active 8-bit output path will create visual artifacts and micro-gradients.
<br />

### NVIDIA Dynamic Range Handshake:
Open your **NVIDIA Control Panel** and navigate to *Change Resolution*. Scroll down and guarantee that your **Output Dynamic Range** is explicitly toggled to **Full (0-255)** rather than *Limited (16-235)*. Leaving this setting on Limited forces the GPU to crush black levels and clip highlights, making even the most advanced configuration look flat and washed out.
<br />

### Display Capabilities & SDR Tone-Mapping:
This profile is optimized out of the box to pass high-dynamic-range metadata directly to the modern Windows DXGI HDR swapchain using `target-colorspace-hint=yes`. 

However, if you are viewing HDR content on a standard, non-HDR display (SDR monitor), you should manually uncomment the target peak variable in your main configuration block by removing the leading hash mark so that it reads `target-peak=300`. For peak realism, adjust that numerical value to match the exact, measured peak luminance nits specification of your specific panel.
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