# Open Source Acknowledgments & Third-Party Credits

The UltraMPV configuration ecosystem contains third-party open-source components alongside original configuration code. While original files (such as `mpv.conf`, `ultrampv-updater.ps1/.bat`, `clip.lua`, and architectural documentation) are distributed under the repository's main MIT License, external shaders and pre-compiled system binaries are subject to their own respective upstream community licenses.

### Third-Party Shaders & Render Models

* **SSimSuperRes Shader (`SSimSuperRes.glsl`):** Developed by the open-source community (Shiandow / sharper) and governed under the GNU Lesser General Public License v3.0 (LGPLv3) for structural-similarity upscaling feedback.
* **CfL_Prediction Shader (`CfL_Prediction.glsl`):** A high-accuracy luma-guided chroma prediction and reconstruction algorithm developed by the open-source community (thep00oon / Artoriuz) and distributed under the MIT License.
* **Adaptive-Sharpen Shader (`adaptive-sharpen.glsl`):** A high-precision spatial edge-sharpening model developed by the open-source community (Bacondither) and distributed under the MIT License for adaptive image frequency enhancement.
* **SSimDownscaler Shader (`SSimDownscaler.glsl`):** Developed by the open-source community (igv) and governed under the GNU Lesser General Public License v3.0 (LGPLv3) for structural-similarity perceptual downscaling.

### Core Player & External Binary Utilities

* **MPV Player Core & Binaries:** Governed by the GNU General Public License (GPLv3+) as outlined by the official MPV Player project contributors.
* **FFmpeg Audio/Video Converter Toolkit (`ffmpeg.exe`):** A comprehensive cross-platform recording, converting, and stream-muxing command-line utility compiled under the GNU General Public License (GPLv3+) via upstream master build repositories.
* **YT-DLP Advanced Stream Scraper (`yt-dlp.exe`):** A high-fidelity command-line media stream downloader and site extractor used natively to process web streaming links. Governed entirely under the public domain via the Unlicense model.
* **Windows Bootstrapping Framework Base:** Core updater network structures are adapted from shinchiro's open-source build-system packaging scripts, maintained under the community licensing guidelines of the upstream mpv-winbuild-cmake project workspace.

### User Modification & Distribution Rights

Users are fully authorized to modify, adapt, and redistribute these specific standalone third-party files in accordance with their original upstream open-source license structures. When distributing custom forks or repackaged installers of UltraMPV, you must preserve the original license files and attribution strings belonging to these respective authors.