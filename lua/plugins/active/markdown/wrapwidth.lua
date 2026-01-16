-------------------------------------------------------------------------------
-- Wrapwidth Plugin
-- https://github.com/rickhowe/wrapwidth
-- Soft-wrap at specific column using virtual text padding.
-------------------------------------------------------------------------------

return {
  "rickhowe/wrapwidth",
  ft = "markdown",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.cmd("Wrapwidth 100")
      end,
    })
  end,
}
