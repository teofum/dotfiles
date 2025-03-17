local autosave_group = vim.api.nvim_create_augroup("autosave", { clear = true })
local delay = 100

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  group = autosave_group,
  callback = function(ctx)
    vim.api.nvim_buf_set_var(ctx.buf, "autosave_queued", false)
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*",
  group = autosave_group,
  callback = function(ctx)
    local ok, queued = pcall(vim.api.nvim_buf_get_var, ctx.buf, "autosave_queued")
    if not ok then
      return
    end

    if not queued then
      -- Manually trigger the BufWrite... events
      -- This triggers things like autoformatting, cargo check, etc
      vim.api.nvim_command("doautocmd BufWritePre")
      vim.api.nvim_command("silent w")
      vim.api.nvim_command("doautocmd BufWritePost")

      vim.api.nvim_buf_set_var(ctx.buf, "autosave_queued", true)
      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(ctx.buf) then
          vim.api.nvim_buf_set_var(ctx.buf, "autosave_queued", false)
        end
      end, delay)
    end
  end,
})
