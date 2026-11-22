-- ~/.config/hypr/hyprland.lua
local modules = {
    "lua.monitors",
    "lua.monitor_rules",
    "lua.environment",
    "lua.auto_start",
    "lua.keybindings",
    "lua.layout",
    "lua.general",
    "lua.animations",
    "lua.windows_workspaces",
    "lua.misc",
}

for _, imports in ipairs(modules) do
    local success, err = pcall(require, imports)
    if not success then
        -- This prints the error to Hyprland
        print("[Hyprland Config Error] Failed to load " .. imports .. "  " .. tostring(err))
    end
end
