-----------------------------------
-- LOGIN SERVER SETTINGS
-----------------------------------
-- All settings are attached to the `xi.settings` object. This is published globally, and be accessed from C++ and any script.
-----------------------------------

xi = xi or {}
xi.settings = xi.settings or {}

xi.settings.login =
{
    -- Expected Client version (wrong version cannot log in)
    CLIENT_VER = "30220603_0",

    -- 0 - disabled (every version allowed)
    -- 1 - enabled - strict (only exact CLIENT_VER allowed)
    -- 2 - enabled - greater than or equal  (matching or greater than CLIENT_VER allowed, default)
    --
    -- WE STRONGLY ADVISE AGAINST LOCKING THE SERVER TO OLDER VERSIONS. IT IS A UNIVERSALLY BAD IDEA.
    VER_LOCK = 2,

    -- 0 - disabled (normal operation)
    -- 1 - enabled (only GM characters allowed online, no new character creation)
    MAINT_MODE = 0,

    -- Logging of user IP address to database (true/false)
    LOG_USER_IP = false,

    -- Allow account creation via the loader (true/false)
    ACCOUNT_CREATION = true,

    -- Allow character deletion through the lobby (true/false)
    CHARACTER_DELETION = true,
}
