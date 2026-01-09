local prevPos = nil
local timeAFK = 0
local kickWarning = false
local captchaActive = false
local captchaSolved = false
local captchaSolution = 0
local captchaQuestion = ""
local captchaTimer = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- 

        local playerPed = PlayerPedId()
        local currentPos = GetEntityCoords(playerPed, true)

        if prevPos and not captchaActive then
            local dist = #(prevPos - currentPos)
            if dist < 0.5 then
                timeAFK = timeAFK + 1
            else
                timeAFK = 0
                kickWarning = false
            end
        end

        prevPos = currentPos

        
        if timeAFK >= Config.WarningTime and timeAFK < Config.MaxAFKTime and not captchaActive then
            kickWarning = true
        elseif timeAFK < Config.WarningTime then
            kickWarning = false
        end

        
        if timeAFK >= Config.MaxAFKTime and not captchaActive then
            StartCaptcha()
        end
        
        
        if captchaActive then
            captchaTimer = captchaTimer - 1
            if captchaTimer <= 0 then
                TriggerServerEvent("cy-antiafk:kickPlayer", Config.Locales.kick_reason)
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if kickWarning and not captchaActive then
            DrawTxt(Config.Locales.warning_text, 0.5, 0.9, 0.4, 0.4, true, 255, 0, 0, 255, true)
        end

        if captchaActive then
            DisableControlAction(0, 0x8CC9CD42, true) -- Disable inputs if needed, here mostly Menu behavior
            
            DrawTxt(Config.Locales.captcha_title, 0.5, 0.3, 0.7, 0.7, true, 255, 0, 0, 255, true)
            DrawTxt(Config.Locales.solve_math .. captchaQuestion, 0.5, 0.4, 0.6, 0.6, true, 255, 255, 0, 255, true)
            DrawTxt(Config.Locales.chat_help, 0.5, 0.45, 0.4, 0.4, true, 255, 255, 255, 255, true)
            DrawTxt(string.format(Config.Locales.remaining_time, captchaTimer), 0.5, 0.5, 0.4, 0.4, true, 255, 255, 255, 255, true)
        end
    end
end)

function StartCaptcha()
    captchaActive = true
    kickWarning = false
    local num1 = math.random(1, 10)
    local num2 = math.random(1, 10)
    captchaSolution = num1 + num2
    captchaQuestion = num1 .. " + " .. num2
    captchaTimer = Config.CaptchaTimeout
    
    TriggerEvent("vorp:TipRight", string.format(Config.Locales.chat_question, captchaQuestion), 10000)
end

RegisterCommand("afk", function(source, args, rawCommand)
    if captchaActive then
        local input = tonumber(args[1])
        if input == captchaSolution then
            captchaActive = false
            timeAFK = 0
            TriggerEvent("vorp:TipRight", Config.Locales.chat_success, 4000)
        else
            TriggerEvent("vorp:TipRight", Config.Locales.chat_fail, 4000)
        end
    else

    end
end, false)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end
