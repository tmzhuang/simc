local _, simc = ...

function simc.PrintError(msg)
    simc.Print("|cffff6666" .. msg .. "|r")
end

function simc.Print(msg)
    local f = SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
    f:AddMessage("|cff00ff00simc:|r " .. msg)
end
