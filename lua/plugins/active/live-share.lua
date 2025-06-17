-------------------------------------------------------------------------------
-- Live-Share Plugin
-- https://github.com/azratul/live-share.nvim
-- Collaborate with others in real-time.
-------------------------------------------------------------------------------

return {
  "azratul/live-share.nvim",
  dependencies = {
    "jbyuki/instant.nvim",
  },
  config = function()
    vim.g.instant_username = "manny"
    local live_share = require("live-share")

    live_share.setup({
      -- port_internal = 9876, -- The local port to be used for the live share connection
      max_attempts = 40,  -- Maximum number of attempts to read the URL from service(serveo.net or localhost.run), every 250 ms
      -- service_url   = "/tmp/service.url",    -- Path to the file where the URL from serveo.net will be stored
      -- service_pid   = "/tmp/service.pid",    -- Path to the file where the PID of the SSH process will be stored

      service      = "nokey@localhost.run",  -- Service to use, options are serveo.net or localhost.run
      -- service = "serveo.net",              -- Service to use, options are serveo.net or localhost.run
    })
  end,
}
