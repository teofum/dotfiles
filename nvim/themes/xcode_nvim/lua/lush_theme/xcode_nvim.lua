--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require("lush")
local hsl = lush.hsl

-- Theme colors
local base_text = hsl("#d8d8d8")
local dark_text = hsl("#828482")
local base_bg = hsl("#000000")
local bright_bg = hsl("#292830")

local xcode_pink = hsl("#ff7ab2")
local xcode_pink_dark = hsl("#98486a")
local xcode_teal = hsl("#acf2e4")
local xcode_teal_dark = hsl("#78c2b3")
local xcode_cyan = hsl("#6bdfff")
local xcode_cyan_dark = hsl("#4eb0cc")
local xcode_purple = hsl("#dabaff")
local xcode_purple_dark = hsl("#b281eb")
local xcode_orange = hsl("#ffa14f")
local xcode_orange_dark = hsl("#ff8170")
local xcode_yellow = hsl("#d9c97c")

local extra_lime = hsl("#a8c023")

local status_error = hsl(355, 90, 70)
local status_warn = hsl(40, 100, 75)
local status_info = hsl(180, 85, 75)
local status_hint = hsl(230, 85, 80)
local status_ok = hsl(130, 85, 75)

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    Normal({ bg = base_bg, fg = base_text }), -- Normal text
    Cursor({ bg = Normal.fg, fg = Normal.bg }), -- Character under the cursor
    CursorLine({}), -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.

    LineNr({ fg = dark_text.da(50) }), -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr({ fg = dark_text }), -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.

    Visual({ bg = dark_text, fg = Normal.bg }), -- Visual mode selection
    Title({ fg = xcode_pink, gui = "bold" }),

    DiffAdd({ fg = status_ok }), -- Diff mode: Added line |diff.txt|
    DiffChange({ fg = status_hint }), -- Diff mode: Changed line |diff.txt|
    DiffDelete({ fg = status_error }), -- Diff mode: Deleted line |diff.txt|
    DiffText({ fg = status_hint }), -- Diff mode: Changed text within a changed line |diff.txt|

    -- Nvim Tree
    Directory({ fg = xcode_teal }), -- Directory names (and other special names in listings)
    NvimTreeExecFile({ fg = xcode_cyan }),
    NvimTreeImageFile({ fg = xcode_cyan_dark }),
    NvimTreeSpecialFile({ fg = xcode_pink }),
    NvimTreeSymLink({ fg = xcode_orange }),
    NvimTreeModifiedIcon({}),
    NvimTreeGitDeletedIcon({ DiffDelete }),
    NvimTreeGitDirtyIcon({ DiffChange }),
    NvimTreeGitMergeIcon({ fg = status_info }),
    NvimTreeGitNewIcon({ DiffChange }),
    NvimTreeGitRenamedIcon({ DiffAdd }),
    NvimTreeGitStagedIcon({ DiffAdd }),

    -- ColorColumn    { }, -- Columns set with 'colorcolumn'
    -- Conceal        { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    -- CurSearch      { }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    -- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor     { }, -- Cursor in a focused terminal
    -- TermCursorNC   { }, -- Cursor in an unfocused terminal
    -- ErrorMsg       { }, -- Error messages on the command line
    -- VertSplit      { }, -- Column separating vertically split windows
    -- Folded         { }, -- Line used for closed folds
    -- FoldColumn     { }, -- 'foldcolumn'
    -- SignColumn     { }, -- Column where |signs| are displayed
    -- IncSearch      { }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    -- Substitute     { }, -- |:substitute| replacement text highlighting
    -- MatchParen     { }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- MsgArea        { }, -- Area for messages and cmdline
    -- MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg        { }, -- |more-prompt|
    -- NonText        { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    -- NormalFloat    { }, -- Normal text in floating windows.
    -- FloatBorder    { }, -- Border of floating windows.
    -- FloatTitle     { }, -- Title of floating windows.
    -- NormalNC       { }, -- normal text in non-current windows
    -- Pmenu          { }, -- Popup menu: Normal item.
    -- PmenuSel       { }, -- Popup menu: Selected item.
    -- PmenuKind      { }, -- Popup menu: Normal item "kind"
    -- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
    -- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
    -- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
    -- PmenuSbar      { }, -- Popup menu: Scrollbar.
    -- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
    -- Question       { }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine   { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    -- Search         { }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    -- SpecialKey     { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad       { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal     { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    -- StatusLine     { }, -- Status line of current window
    -- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- TabLine        { }, -- Tab pages line, not active tab page label
    -- TabLineFill    { }, -- Tab pages line, where there are no labels
    -- TabLineSel     { }, -- Tab pages line, active tab page label
    -- Title          { }, -- Titles for output from ":set all", ":autocmd" etc.
    -- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg     { }, -- Warning messages
    -- Whitespace     { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    -- Winseparator   { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    -- WildMenu       { }, -- Current match in 'wildmenu' completion
    -- WinBar         { }, -- Window bar of current window
    -- WinBarNC       { }, -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment({ fg = dark_text }), -- Any comment

    Keyword({ fg = xcode_pink, gui = "bold" }), -- any other keyword

    Constant({ fg = xcode_purple_dark }), -- (*) Any constant
    String({ fg = xcode_orange_dark }), --   A string constant: "this is a string"
    Character({ fg = xcode_orange_dark }), --   A character constant: 'c', '\n'
    Number({ fg = xcode_yellow }), --   A number constant: 234, 0xff
    -- Boolean        { }, --   A boolean constant: TRUE, false
    Float({ Number }), --   A floating point constant: 2.3e10

    Identifier({ fg = xcode_teal }), -- (*) Any variable name
    Function({ fg = xcode_cyan_dark }), --   Function name (also: methods for classes)

    Statement({ Keyword }), -- (*) Any statement
    Conditional({ Keyword }), --   if, then, else, endif, switch, etc.
    Repeat({ Keyword }), --   for, do, while, etc.
    Label({ Keyword }), --   case, default, etc.
    -- Operator       { }, --   "sizeof", "+", "*", etc.
    Exception({ Keyword }), --   try, catch, throw

    PreProc({ fg = xcode_orange }), -- (*) Generic Preprocessor
    -- Include        { }, --   Preprocessor #include
    -- Define         { }, --   Preprocessor #define
    -- Macro          { }, --   Same as Define
    -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type({ Keyword }), -- (*) int, long, char, etc.
    StorageClass({ Keyword }), --   static, register, volatile, etc.
    Structure({ Keyword }), --   struct, union, enum, etc.
    -- Typedef        { }, --   A typedef

    Special({ fg = xcode_orange }), -- (*) Any special symbol
    -- SpecialChar    { }, --   Special character in a constant
    -- Tag            { }, --   You can use CTRL-] on this
    -- Delimiter      { }, --   Character that needs attention
    -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
    -- Debug          { }, --   Debugging statements

    -- Underlined     { gui = "underline" }, -- Text that stands out, HTML links
    -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error({ gui = "undercurl", sp = status_error }), -- Any erroneous construct
    Todo({ gui = "bold", fg = extra_lime }), -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    DiagnosticError({ fg = status_error }),
    DiagnosticWarn({ fg = status_warn }),
    DiagnosticInfo({ fg = status_info }),
    DiagnosticHint({ fg = status_hint }),
    DiagnosticOk({ fg = status_ok }),
    DiagnosticUnderlineError({ gui = "undercurl", sp = status_error }),
    DiagnosticUnderlineWarn({ gui = "undercurl", sp = status_warn }),
    DiagnosticUnderlineInfo({ gui = "undercurl", sp = status_info }),
    DiagnosticUnderlineHint({ gui = "undercurl", sp = status_hint }),
    DiagnosticUnderlineOk({ gui = "undercurl", sp = status_ok }),

    -- Tree-Sitter syntax groups. See :h treesitter-highlight-groups.
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function.
    sym("@type")({ fg = xcode_purple_dark, gui = "nocombine" }), -- Type
    sym("@type.builtin")({ Keyword }), -- Type
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
