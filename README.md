# UltraMPV v1.0.5
<br />

## The BEST realistic 4K video playback experience in the world!
###### Carefully follow all steps in this guide to completely transform your MPV Player so it can rival the highest quality video players in existence. (Optimized for Nvidia)
<br />

### 1. Download and install MPV Player using their [OFFICIAL GitHub repository][MPVrepo] or [SourceForge page][SourceForge].
<br />

###### Use the following instructions to download MPV Player from [SourceForge][SourceForge] and install onto Windows 11. Alternatively, there's a copy of the Windows MPV Player Bootstrapper (Updated 22/03/2026) in the UltraMPV repository's `/Archive` folder.

### 2. After downloading the Windows MPV Player installer from SourceForge, search your downloads for a file called `bootstrapper.zip` and extract its contents into the folder you want MPV Player program files to be stored.
<br />

### 3. Open the extracted `bootstrapper` folder, `right-click` the `updater.bat` file and run as administrator.
<br />

### 4. In the terminal that opens, enter `Y` to proceed with the installation, enter `1` to check for updates weekly, enter `2` to download the `x86_64-v3` version of MPV Player, and let the rest of the installation run with the default options selected. This "v3" build is optimized for modern CPUs (typically those released after 2015) and offers better performance by utilizing newer instruction sets like AVX2.
<br />

### 5. Open the `installer` folder that `updater.bat` downloaded into your extracted `bootstrapper` folder. Inside the `installer` folder, `right-click` the `mpv-install.bat` file to install MPV Player on your system. 

###### NOTE: You will have to re-run this `mpv-install.bat` file whenever you move or rename your extracted `bootstrapper` folder. MPV Player is a "portable" application, so Windows does not automatically track its location like it would for a standard program with a traditional installer.
<br />

### 5. Double-click `mpv.exe` to open the MPV player. The player should open and stay open with a black screen. This indicates you have installed the proper build of MPV Player for your system.
<br />

### 6. Access the following filepath then place the UltraMPV `mpv.conf` file inside the `mpv` folder on your system to overwrite your current `mpv.conf` file, if one exists:
<br />

```Bash
%APPDATA%\mpv\
```

<br />
<br />

[MPVrepo]: https://github.com/mpv-player/mpv
[SourceForge]: https://sourceforge.net/projects/mpv-player-windows/