# CY-AntiAFK

A simple and effective Anti-AFK system for RedM servers. This script monitors true player movement (coordinates) instead of just inputs, ensuring players are actually playing. Before kicking, it presents a math captcha that must be solved.

## Features

*   **Real Movement Detection:** Checks if the player's ped actually moves coordinates.
*   **Warning System:** Warns the player before the AFK timer runs out.
*   **Math Captcha:** Players must solve a simple math problem (e.g., `5 + 3`) to prove they are present.
*   **VORP Integration:** Uses VORP notifications (`vorp:TipRight`) for a seamless UI experience.
*   **Configurable:** All times, messages, and settings are easily adjustable in `config.lua`.

## Installation

1.  Download the resource and place it in your `resources` folder (e.g., `[standalone]/CY-AntiAFK`).
2.  Add `ensure CY-AntiAFK` to your `server.cfg`.
3.  Restart your server or run `refresh` and `ensure CY-AntiAFK`.

## Configuration

You can edit `config.lua` to change the settings:

```lua
Config.MaxAFKTime = 900       -- Total time in seconds before Captcha starts (Default: 15 minutes)
Config.WarningTime = 840      -- Time in seconds when the warning appears (Default: 14 minutes)
Config.CaptchaTimeout = 60    -- Time in seconds to solve the Captcha before kicking
```

## Usage

*   When a player stands still for the configured time, a warning text will appear on the screen.
*   If they remain AFK, a huge "AFK CHECK" text appears along with a math equation.
*   The player must type `/afk <result>` in the chat (e.g., `/afk 8`).
*   If solved correctly, the timer resets.
*   If failed or ignored, the player is kicked from the server.

## Dependencies

*   **VORP Core** (Required for the notification system used in `client.lua`. If you use another framework, simple change the `TriggerEvent("vorp:TipRight", ...)` lines).
