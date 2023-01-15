----------------------------------------
--- Discord Whitelist, Made by FAXES ---
----------------------------------------

--- Config ---
notWhitelisted = "ไม่มีไวท์ลิส ! ขอไวท์ลิสฟรีได้ที่ https://discord.gg/pjFpVhU" -- Message displayed when they are not whitelist with the role
noDiscord = "กรุณาเปิดโปรแกรม Discord ก่อนเข้าเล่น" -- Message displayed when discord is not found

roles = { -- Role nickname(s) needed to pass the whitelist
    "WHITELIST"
}


--- Code ---

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    deferrals.defer()
    deferrals.update("กำลังตรวจสอบไวท์ลิส")

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        for i = 1, #roles do
            if exports.discord_perms:IsRolePresent(src, roles[i]) then
                deferrals.done()
            else
                deferrals.done(notWhitelisted)
            end
        end
    else
        deferrals.done(noDiscord)
    end
end)