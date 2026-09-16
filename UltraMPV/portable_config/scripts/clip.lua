-- ========================================================
-- UltraMPV Clipping Script v2.0.0 - BEST Real Human 4K/60
-- Author: Trevor Morin | Superklok Labs ➔ superklok.com
-- ========================================================

local recording = false
local start_time = 0

function toggle_record()
    local path = mp.get_property("path")
    if not path then
        mp.osd_message("❌ No media playing")
        return
    end

    -- Strictly blocks web streams from using this script, local file clipping ONLY
    if path:find("^http://") or path:find("^https://") or path:find("^rtmp://") then
        mp.osd_message("❌ Local file clipping ONLY!")
        return
    end

    if not recording then
        -- =========================================================================
        -- Start local file cutting checkpoint
        -- =========================================================================
        recording = true
        start_time = mp.get_property_number("time-pos", 0)
        mp.osd_message("⏺️ Local Recording Started", 2)
    else
        -- =========================================================================
        -- Calculate length and spin up background FFmpeg sub-thread
        -- =========================================================================
        recording = false
        
        local end_time = mp.get_property_number("time-pos", 0)
        local duration = end_time - start_time
        
        if duration <= 0 then
            mp.osd_message("❌ Error: Invalid clip duration", 2)
            return
        end
        
        -- '~~/' resolves directly to portable_config, use native expand-path to fix windows slashes
        local config_dir = mp.command_native({"expand-path", "~~/"})
        local output_dir = config_dir .. "/clips"
        
        -- Safe cross-platform folder creation
        os.execute('mkdir "' .. output_dir .. '" 2>nul')
        
        -- Calculate the parent directory tree correctly without breaking paths
        local root_dir = config_dir:match("(.*[/\\])[^/\\]+[/\\]?$") or config_dir
        local ffmpeg_path = root_dir .. "ffmpeg.exe"
        local output = output_dir .. "/UltraMPV_Clip_" .. os.time() .. ".mp4"
        
        mp.osd_message("⏳ Processing local clip...", 2)

        -- Subprocess with precise arguments array to handle the process space flawlessly
        mp.command_native_async({
            name = "subprocess",
            playback_only = false,
            capture_stdout = true,
            capture_stderr = true,
            args = {
                ffmpeg_path, "-y", 
                "-ss", tostring(start_time), 
                "-i", path, 
                "-t", tostring(duration), 
                "-c", "copy", 
                "-avoid_negative_ts", "make_zero", 
                output
            }
        }, function(success, result, error)
            -- Evaluates the precise OS process exit codes
            if success and result and result.status == 0 then
                mp.osd_message("🎬 Local Clip Saved!", 3)
            else
                mp.osd_message("❌ Recording Failed", 3)
            end
        end)
    end
end

mp.add_key_binding(nil, "clip_toggle", toggle_record)