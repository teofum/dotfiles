local xcode_pink = "#ff7ab2"
local xcode_pink_dark = "#d847a4"
local xcode_teal = "#acf2e4"
local xcode_teal_dark = "#78c2b3"
local xcode_cyan = "#6bdfff"
local xcode_cyan_dark = "#4eb0cc"
local xcode_purple = "#dabaff"
local xcode_purple_dark = "#b281eb"
local xcode_orange = "#ffa14f"
local xcode_orange_dark = "#ff8170"
local xcode_yellow = "#d9c97c"

return {
  "rebelot/heirline.nvim",
  events = { "UiEnter" },
  config = function()
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    local colors = {
      normal_bg = utils.get_highlight("Normal").bg,
      normal_fg = utils.get_highlight("Normal").fg,

      dark_fg = utils.get_highlight("Comment").fg,

      mode_normal = utils.get_highlight("Normal").fg,
      mode_insert = xcode_pink,
      mode_visual = xcode_purple_dark,
      mode_replace = xcode_orange_dark,
      mode_command = xcode_cyan,
      mode_special = xcode_teal,

      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
    }

    local mode_color = function(self)
      return self:mode_color()
    end

    local mode_bg = function(self)
      return { bg = self:mode_color(), fg = "#000000" }
    end

    local vi_mode = {
      init = function(self)
        self.mode = vim.fn.mode(1)
      end,

      static = {
        mode_names = {
          n = "N ", -- Normal
          no = "Op", -- Operator-pending
          v = "V ", -- Visual by character
          ["\22"] = "Vb", -- Visual blockwise
          s = "S ", -- Select by character
          S = "S ", -- Select by line
          ["\19"] = "Sb", -- Select blockwise
          i = "I ", -- Insert
          R = "R ", -- Replace R
          c = "C ", -- Command-line editing
          r = "? ", -- Hit-enter prompt
          ["!"] = "! ", -- Shell or external command is executing
          t = "T ", -- Terminal mode: keys go to the job
        },
      },

      provider = function(self)
        local mode = self.mode:sub(1, 2)
        return " %2(" .. self.mode_names[mode] .. "%)"
      end,

      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
          vim.cmd("redrawstatus")
        end),
      },

      hl = { bold = true },
    }
    vi_mode = utils.surround({ "", "" }, mode_color, { vi_mode, hl = mode_bg })

    local ruler = {
      provider = " %3l:%2c ",
    }
    ruler = utils.surround({ "", "" }, mode_color, { ruler, hl = mode_bg })

    local filename_block = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }

    local filename = {
      provider = function(self)
        local fn = vim.fn.fnamemodify(self.filename, ":.")
        if fn == "" then
          return "[Untitled]"
        end
        if not conditions.width_percent_below(#fn, 0.25) then
          fn = vim.fn.pathshorten(fn)
        end
        return fn
      end,
      hl = { fg = "dark_fg" },
    }

    filename_block = utils.insert(filename_block, filename, { provider = "%<" })

    local file_type = {
      provider = function()
        return vim.bo.filetype
      end,
    }

    local file_encoding = {
      provider = function()
        local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        return enc ~= "utf-8" and "| " .. enc:upper()
      end,
    }

    local file_format = {
      provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= "unix" and "| " .. fmt:upper()
      end,
    }

    local file_info = utils.surround(
      { "", "" },
      "#282828",
      { file_type, file_format, file_encoding, hl = { bg = "#282828", fg = "normal_fg" } }
    )

    local lsp_status = {
      update = { "LspAttach", "LspDetach", "ModeChanged" },
      provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
          table.insert(names, server.name)
        end
        return table.concat(names, " ") .. " "
      end,
      hl = mode_bg,
    }

    lsp_status = utils.surround({ "", "" }, mode_color, { hl = mode_bg, lsp_status })

    local file_and_lsp = {
      {
        condition = conditions.lsp_attached,
        lsp_status,
      },
      {
        condition = conditions.lsp_attached,
        provider = "",
        hl = function(self)
          return { fg = "#282828", bg = self:mode_color() }
        end,
      },
      {
        condition = function()
          return not conditions.lsp_attached()
        end,
        provider = "",
        hl = { fg = "#282828", bg = "#000000" },
      },
      file_info,
    }

    file_info = utils.surround({ "", "" }, "#282828", { file_info, hl = { bg = "#000000" } })

    local diagnostics = {
      static = {
        error_icon = "E",
        warn_icon = "W",
        info_icon = "I",
        hint_icon = "H",
      },

      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,

      update = { "DiagnosticChanged", "BufEnter" },

      {
        provider = function(self)
          return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ")
        end,
        hl = { fg = "diag_error" },
      },
      {
        provider = function(self)
          return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
        end,
        hl = { fg = "diag_warn" },
      },
      {
        provider = function(self)
          return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
        end,
        hl = { fg = "diag_info" },
      },
      {
        provider = function(self)
          return self.hints > 0 and (self.hint_icon .. " " .. self.hints)
        end,
        hl = { fg = "diag_hint" },
      },
    }

    diagnostics = utils.surround({ "", "" }, "#282828", { diagnostics, hl = { bg = "#282828" } })

    diagnostics = {
      condition = conditions.has_diagnostics,
      diagnostics,
    }

    local space = {
      provider = " ",
    }

    local align = {
      provider = "%=",
    }

    local status_line = {
      condition = conditions.is_active,

      static = {
        mode_colors = {
          n = "mode_normal",
          v = "mode_visual",
          ["\22"] = "mode_visual",
          s = "mode_visual",
          S = "mode_visual",
          ["\19"] = "mode_visual",
          i = "mode_insert",
          R = "mode_replace",
          c = "mode_command",
          r = "mode_special",
          ["!"] = "mode_special",
          t = "mode_special",
        },
        mode_color = function(self)
          return self.mode_colors[conditions.is_active and vim.fn.mode() or "n"]
        end,
      },
      hl = { bg = "#000000" },

      vi_mode,
      space,
      filename_block,
      space,
      diagnostics,
      align,
      file_and_lsp,
      space,
      ruler,
    }

    local inactive_status_line = {
      condition = conditions.is_not_active,
      hl = { bg = "#000000" },

      filename_block,
      align,
      file_info,
    }

    require("heirline").load_colors(colors)
    require("heirline").setup({
      statusline = { status_line, inactive_status_line },
    })
  end,
}
