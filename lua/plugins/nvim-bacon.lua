return {
  {
    "Canop/nvim-bacon",
    opts = {
      quickfix = {
        enabled = true, -- Enable Quickfix integration
        event_trigger = true, -- Trigger QuickFixCmdPost after populating Quickfix list
      },
    },
    keys = {
      { "!!", "<cmd>BaconLoad<CR><cmd>w<CR><cmd>BaconNext<CR>", { desc = "Navigate to next bacon location" } },
      { "!,", "<cmd>BaconList<CR>", { desc = "Open bacon locations list" } },
    },
  },
}
