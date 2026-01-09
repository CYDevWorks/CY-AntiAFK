Config = {}


Config.MaxAFKTime = 60       -- 1 Minute (Max AFK Time before Captcha)
Config.WarningTime = 40      -- 40 Seconds (Warning)
Config.CaptchaTimeout = 60    -- Time to solve Captcha

-- Texte / Locales
Config.Locales = {
    warning_text = "You will be kicked soon for inactivity! Move!",
    captcha_title = "AFK CHECK",
    solve_math = "Solve the equation: ",
    chat_help = "Type in chat: /afk <Result>",
    remaining_time = "Remaining time: %ss",
    chat_message_header = "Anti-AFK",
    chat_question = "Are you still there? Calculate: %s | Type /afk [Result]",
    chat_success = "Captcha correct! AFK timer reset.",
    chat_fail = "Wrong result!",
    kick_reason = "AFK limit exceeded (Captcha not solved)"
}
