local mpv_scripts_dir_path = os.getenv("HOME") ..  "/.config/mpv/scripts/"
function load(relative_path) dofile(mpv_scripts_dir_path .. relative_path) end
-- load("mpv-stats/stats.lua")
load("mpvSockets/mpvSockets.lua")
