# UltraMPV v1.6.41
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

### 9. Go to the following filepath then place the UltraMPV `input.conf` file inside the `mpv` folder on your system to overwrite your current `input.conf` file, if one exists:

```Bash
%APPDATA%\mpv\
```
<br />

### 10. Browse to the following filepath then place the UltraMPV `shaders` folder inside the `mpv` folder on your system to replace your current `shaders` folder, if one exists:

```Bash
%APPDATA%\mpv\
```
> ⚠️ **NOTE:** The `shaders` folder should contain `SSimSuperRes.glsl`, `CfL_Prediction.glsl`, `adaptive-sharpen.glsl`, and `SSimDownscaler.glsl`.
<br />

### 11. Open a video file with MPV Player and press the backtick key (`` ` ``) to open the terminal then make sure there are no errors loading the UltraMPV configuration.
<br />
<br />

## DONE!
<br />
<br />

# UltraMPV Configuration Summary

### In the Windows/Nvidia environment, this is effectively the WORLD'S BEST configuration for a fixed 60Hz 4K monitor. It leverages a sophisticated balance of high-performance internal settings and industry-standard external shaders. This configuration is essentially the gold standard for "realistic" 4K playback in 2026.
<br />

### It's superior to standard high-quality templates because it intelligently handles Chroma reconstruction (using `CfL_Prediction`) and uses Dynamic Profile Logic to ensure the GPU doesn't waste resources on unnecessary shaders when playing native 4K content.
<br />

## Features

* ### <ins>Cascade Processing Architecture:</ins> 
  Utilizes an efficient, pre-appended cascade design (`glsl-shaders`) that initializes core shader blocks on startup rather than forcing resource-heavy compilation steps mid-stream. Lower-resolution pipelines step down seamlessly via explicit cache resets (`glsl-shaders-clr`) only when entering 4K spaces, completely neutralizing thread stalls and window freezing when transitioning between video sizes.

* ### <ins>Ghosting-Free Motion Cadence:</ins> 
  The synchronized pairing of `video-sync=display-resample` and `tscale=oversample` provides precise frame-step matching. By matching frame delivery to display timings without using artificial frame-blending or temporal interpolation filters, this pipeline preserves 100% texture and skin-pore sharpness during fast panning shots while completely eliminating 24p judder on fixed 60Hz panels.

* ### <ins>`SSimSuperRes` Structural Super-Resolution:</ins> 
  Bypasses artwork-trained, edge-doubling neural models (like FSRCNNX or NNEDI3) which cause an artificial "oil painting" or plastic look on human subjects. Instead, `SSimSuperRes.glsl` works via downscaling feedback loops, continually comparing the scaled frame against the source data to preserve authentic textural realism, skin pores, fine wrinkles, and background film grain on sub-4K masters.

* ### <ins>Codec-Aware Bitrate Debanding:</ins> 
  A reactive anti-banding system segments files by inspecting raw bit-budgets per compression standard (H264 >= 15M, HEVC >= 8M, AV1 >= 6M, VP9 >= 8M). It forces a non-destructive reference pass (`iterations=1`) on high-fidelity files to protect original grain maps, but automatically engages an aggressive pass (`iterations=3`, `threshold=45`) when compressed, low-bitrate streams are detected.

* ### <ins>Spatial Error-Diffusion Dithering:</ins> 
  Replaces basic, patterned ordered dithering arrays with advanced spatial distribution algorithms (`dither=error-diffusion`). This math engine pushes rounding errors to neighboring pixels in a fluid, non-repeating pattern, completely eliminating macro-gradients and color banding across uniform areas like smooth skin tones and uniform backgrounds.

* ### <ins>Unified Vulkan Zero-Copy Rendering:</ins> 
  Migrates the playback pipeline natively to high-performance Vulkan (`gpu-api=vulkan` and `gpu-context=winvk`). This anchors rendering directly inside the Windows graphics swapchain, providing low-overhead decoding, stable frame rendering, and clean presentation timing on massive 4K UHD masters.

* ### <ins>`CfL_Prediction` Chroma Reconstruction:</ins> 
  Deploys a high-accuracy, luma-guided prediction model (`CfL_Prediction.glsl`) that uses the video's high-resolution brightness channel to reconstruct missing color information. Mapping color boundaries directly to luminance detail eliminates color bleeding and tightens color accuracy around eyes, lips, and fast-moving human silhouettes.

* ### <ins>`SSimDownscaler` Perceptual Reduction:</ins> 
  Employs structure-similarity models (`SSimDownscaler.glsl`) to downscale 4K assets onto lower-resolution displays (like 1440p or 1080p monitors). The algorithm preserves localized contrast and fine specular highlights, rendering a downscaled image that holds true to the master file.

* ### <ins>Purist Adaptive Edge Sharpening:</ins> 
  Integrates a high-precision `adaptive-sharpen.glsl` pass inside the native 4K and downscaling loops to counteract physical display anti-aliasing and lens softening. By analyzing localized spatial contrast, it sharpens fine details—like hair strands and pores—without introducing edge halos or boosting image noise.

* ### <ins>Native 60fps Performance Bypass:</ins> 
  Tracks incoming media framerates dynamically. It instantly shuts down the oversample engine (`interpolation=no`) when native 60fps media is opened, preventing processing artifacts and keeping system overhead low on sports, gameplay, or high-framerate action content.

* ### <ins>Silicon-Level H.264 Driver Failsafe:</ins> 
  Dynamically intercepts H.264 video streams on initialization and routes them away from broken NVIDIA Vulkan driver pathways, safely executing them via native hardware CUDA channels (`hwdec=nvdec`). This completely prevents unwatchable macroblock corruption while maintaining hardware processing stability.
<br />
<br />

## Custom Controls & Navigation

UltraMPV features an optimized, high-precision keyboard binding matrix (`input.conf`) specifically designed for frame-accurate tracking and analysis of high-motion 4K 60fps real human video footage and live streams.

### ⏱️ Micro-Seeking (Precision Navigation)
Standard media players rely on "fuzzy" 5-to-10 second seeking loops that drop you onto variable keyframes. UltraMPV enforces hardware-level exact millisecond alignment.
* **`→` (Right Arrow):** Advances the video by exactly **1 second**.
* **`←` (Left Arrow):** Reverses the video by exactly **1 second**.

### ⏩ Standard Seeking Fallbacks
When you need to cross larger timeline distances quickly without losing precision, use the modifier layer.
* **`Shift + →`:** Advances the video by exactly **5 seconds**.
* **`Shift + ←`:** Reverses the video by exactly **5 seconds**.

### 🎞️ Frame-Perfect Analysis
For deep analysis of movement, capturing microexpressions, selecting the perfect video thumbnail, or observing fast-action changes, step through individual video frames with zero performance stutter.
* **`↑` (Up Arrow):** Advances the pipeline forward by exactly **1 frame**.
* **`↓` (Down Arrow):** Steps the pipeline backward by exactly **1 frame**.
<br />
<br />

## PLEASE NOTE!

### Hardware Optimization & Performance Metrics:
This configuration is specifically engineered for high-performance setups utilizing desktop NVIDIA graphics hardware (such as the RTX 5070 Ti). Combining `SSimSuperRes.glsl` and `CfL_Prediction.glsl` via a continuous Vulkan cascade pipeline, alongside `adaptive-sharpen.glsl` in 4K spaces, places a heavy workload on the GPU compute planes. 

To audit your real-time performance, press `Shift + I` during playback, then hit `2` to view your **Frame Timings**. To ensure smooth, stutter-free playback, your "Estimated" and "Measured" compute times must remain safely below your monitor's physical refresh interval (for example, `< 16.6ms` for a 60Hz panel or `< 6.9ms` for a 144Hz panel). If you experience dropped frames, ensure your graphics card is not entering into a power-saving throttling mode.

### Automated Spatial Dithering Handshake:
This setup relies on reference-grade spatial distribution mapping (`dither=error-diffusion`). By default, the configuration uses `dither-depth=auto`, which instructs `mpv` to dynamically query the active Windows DXGI graphics swapchain on the fly. The engine will automatically deploy a 10-bit or 8-bit error-diffusion shader pattern to match the physical capabilities of your active monitor. 

If you choose to hardcode this setting (e.g., `dither-depth=10`), you **must** verify that your Windows Display Settings or NVIDIA Control Panel is actively transmitting a true 10-bit color container signal to that monitor. Forcing a 10-bit rendering pipeline into a monitor running an active 8-bit connection will create color banding and micro-gradients across uniform human skin tones.

### NVIDIA Full Dynamic Range Configuration:
Open your **NVIDIA Control Panel** and navigate to *Change Resolution*. Scroll down and guarantee that your **Output Dynamic Range** is explicitly toggled to **Full (0-255)** rather than *Limited (16-235)*. Leaving this driver setting on Limited forces the GPU to compress video data packets, crushing deep shadow detail and clipping specular highlights, which will make your advanced configuration look flat and washed out.

### Display Context Toggling & SDR Tone-Mapping:
This profile is highly optimized out of the box to pass raw high-dynamic-range metadata directly to the modern Windows DXGI HDR swapchain using `target-colorspace-hint=yes`. 

However, if you are viewing HDR content on a standard dynamic range display (SDR monitor), you should open `mpv.conf` and manually uncomment the target peak variable in your main configuration block by removing the leading hash mark so that it reads `target-peak=300`. For absolute reference accuracy, adjust that numerical value to match the exact, measured peak luminance nits specification of your specific panel model.

### Required Shaders Folder Layout:
For this build to initialize without fatal errors, you must download the necessary assets and place them directly in the root of your local configuration directory. Do not use nested subfolders. Ensure your directory structure is organized precisely as follows:

```text
📁 %APPDATA%\mpv\
  ├── 📄 mpv.conf
  ├── 📄 input.conf
  └── 📁 shaders
        ├── 📄 CfL_Prediction.glsl
        ├── 📄 SSimSuperRes.glsl
        ├── 📄 SSimDownscaler.glsl
        └── 📄 adaptive-sharpen.glsl
```

<br />
<br />

# You're all set!
<br />
<br />

## License

### This project is licensed under the [MIT License](LICENSE). Third-party shaders and bundled binaries are subject to their own respective upstream licenses, detailed in the [THIRD-PARTY-LICENSES](THIRD-PARTY-LICENSES.md) file.
<br />

## Third-Party Shaders & Utilities Download Links

*   **SSimSuperRes Shaders:** https://gist.github.com/igv/2364ffa6e81540f29cb7ab4c9bc05b6b
*   **CfL_Prediction Shaders:** https://github.com/Artoriuz/glsl-chroma-from-luma-prediction/blob/main/CfL_Prediction.glsl
*   **adaptive-sharpen Shaders:** https://github.com/libretro/glsl-shaders/blob/master/sharpen/shaders/adaptive-sharpen.glsl
*   **SSimDownscaler Shaders:** https://gist.github.com/igv/36508af3ffc84410fe39761d6969be10
*   **MPV Player:** https://sourceforge.net/projects/mpv-player-windows/files/bootstrapper.zip/download
<br />

---

💡 *If you find this project useful, reach out via [Upwork](https://www.upwork.com/freelancers/~01a2b86360ffeb733e)/[Contra](https://contra.com/Superklok) to hire Superklok Labs today!*

[MPVrepo]: https://github.com/mpv-player/mpv
[SourceForge]: https://sourceforge.net/projects/mpv-player-windows/
[Bootstrapper]: https://sourceforge.net/projects/mpv-player-windows/files/bootstrapper.zip/download