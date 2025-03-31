-- File structure:
-- ghibli.nvim/
-- ├── lua/
-- │   └── ghibli.lua  (Main file with all the code)
-- └── colors/
--     └── ghibli.lua  (Enables :colorscheme ghibli)

-- === Main file (lua/ghibli.lua) ===
-- Contains all theme code and functionality

local M = {}

-- Default configuration
M.config = {
  style = "light", -- "light" or "dark"
}

-- Function to set the configuration
function M.setup(options)
  options = options or {}
  M.config = vim.tbl_deep_extend("force", M.config, options)
end

-- Color palettes inspired by Studio Ghibli films
local colors = {
  light = {
    -- Base colors
    bg = "#f9eed8",          -- Warm parchment background (from cursor-app image)
    bg_alt = "#f3e4c7",      -- Slightly darker parchment
    fg = "#5a4a3a",          -- Warm brown text
    fg_alt = "#7a6a5a",      -- Secondary text color (lighter brown)
    
    -- Ghibli signature colors
    totoro_green = "#7fb069", -- Muted green
    chihiro_red = "#e05c5c",  -- Warm brick red
    calcifer = "#ff9c3c",     -- Bright amber flame
    haku_teal = "#5da99f",    -- Dusty teal
    ponyo_pink = "#e5928c",   -- Dusty rose
    forest_green = "#6b8e6b", -- Forest green
    soot_sprite = "#5a4a3a",  -- Soot sprites (darker brown)
    kiki_blue = "#5873a0",    -- Deep dusty blue (darkened for contrast)
    zeniba_purple = "#8b749e", -- Dusty purple
    catbus_orange = "#e6a264", -- Warm amber orange
    sky_blue = "#68c5d2",     -- Bright sky blue (from first image)
    laputa_gold = "#d5a55e",  -- Golden amber
    
    -- UI element colors
    line = "#f0ddc7",         -- Line background (slightly darker than bg)
    selection = "#e6d5b8",    -- Selection background (darker parchment)
    comment = "#91a385",      -- Sage green comments (darkened for contrast)
    guides = "#d5c9b6",       -- Indentation guides
    visual = "#e6d1b0",       -- Visual selection
    pmenu_bg = "#f1e2c7",     -- Popup menu background
    pmenu_sel = "#e9d5b0",    -- Popup menu selection
    
    -- Syntax colors
    string = "#6a9155",       -- Darker green for strings (for contrast)
    number = "#c56a50",       -- Warmer orange-red for numbers
    keyword = "#5873a0",      -- Dusty blue for keywords
    func = "#b86e41",         -- Darker amber for functions
    constant = "#9d7592",     -- Dusty mauve for constants
    type = "#448581",         -- Darker teal for types
    builtin = "#b37941",      -- Amber brown for builtins
    operator = "#7a6a5a",     -- Warm gray for operators
    error = "#e15d67",        -- Red for errors
    warning = "#d29346",      -- Amber for warnings
    info = "#5873a0",         -- Blue for info
    hint = "#6b9762",         -- Green for hints
    
    -- Transparent for terminal background
    none = "NONE",
  },
  
  dark = {
    -- Base colors
    bg = "#2c2b2a",          -- Medium-dark warm background
    bg_alt = "#343331",      -- Slightly lighter background
    fg = "#e0d9c8",          -- Warm light text
    fg_alt = "#c0b9a8",      -- Secondary text color (slightly darker)
    
    -- Ghibli signature colors
    totoro_green = "#8bc177", -- Brighter green for dark bg
    chihiro_red = "#e67373",  -- Brighter warm red
    calcifer = "#ff9c3c",     -- Bright amber flame (unchanged)
    haku_teal = "#6bbfb5",    -- Brighter teal for dark bg
    ponyo_pink = "#f0a59e",   -- Brighter dusty rose
    forest_green = "#7da47d", -- Brighter forest green
    soot_sprite = "#1a1917",  -- Darker soot sprites
    kiki_blue = "#7e96c0",    -- Brighter dusty blue for dark bg
    zeniba_purple = "#a58eb2", -- Brighter dusty purple
    catbus_orange = "#f3b27a", -- Brighter amber orange
    sky_blue = "#7fd8e5",     -- Brighter sky blue
    laputa_gold = "#e3b978",  -- Brighter golden amber
    
    -- UI element colors
    line = "#38352f",         -- Line background (slightly lighter than bg)
    selection = "#4a4641",    -- Selection background
    comment = "#a1b395",      -- Brighter sage green comments
    guides = "#504c46",       -- Indentation guides
    visual = "#4a4641",       -- Visual selection
    pmenu_bg = "#38352f",     -- Popup menu background
    pmenu_sel = "#4a4641",    -- Popup menu selection
    
    -- Syntax colors
    string = "#8cb376",       -- Brighter green for strings
    number = "#de866c",       -- Brighter orange-red for numbers
    keyword = "#7e96c0",      -- Brighter dusty blue for keywords
    func = "#d38a5d",         -- Brighter amber for functions
    constant = "#b38eac",     -- Brighter mauve for constants
    type = "#5ead9b",         -- Brighter teal for types
    builtin = "#cc935d",      -- Brighter amber brown for builtins
    operator = "#c0b9a8",     -- Warmer gray for operators
    error = "#e67883",        -- Brighter red for errors
    warning = "#e2a962",      -- Brighter amber for warnings
    info = "#7e96c0",         -- Brighter blue for info
    hint = "#87b37e",         -- Brighter green for hints
    
    -- Transparent for terminal background
    none = "NONE",
  }
}

-- Terminal colors
local function get_terminal_colors(style)
  local c = colors[style]
  
  return {
    [1] = c.soot_sprite,   -- Black
    [2] = c.chihiro_red,   -- Red
    [3] = c.forest_green,  -- Green
    [4] = c.catbus_orange, -- Yellow
    [5] = c.kiki_blue,     -- Blue
    [6] = c.zeniba_purple, -- Magenta
    [7] = c.haku_teal,     -- Cyan
    [8] = c.fg,            -- White
    
    [9] = style == "light" and "#7a6a5a" or "#908880",   -- Bright Black
    [10] = c.chihiro_red,  -- Bright Red
    [11] = c.totoro_green, -- Bright Green
    [12] = c.laputa_gold,  -- Bright Yellow
    [13] = c.sky_blue,     -- Bright Blue
    [14] = c.ponyo_pink,   -- Bright Magenta
    [15] = c.haku_teal,    -- Bright Cyan
    [16] = style == "light" and "#3a2a1a" or "#f0ebe0",  -- Bright White
  }
end

-- Highlight helper function
local function highlight(group, opts)
  opts.fg = opts.fg or "NONE"
  opts.bg = opts.bg or "NONE"
  opts.sp = opts.sp or "NONE"
  opts.style = opts.style or "NONE"
  
  vim.api.nvim_set_hl(0, group, {
    fg = opts.fg,
    bg = opts.bg,
    sp = opts.sp,
    bold = opts.style:find("bold") and true,
    italic = opts.style:find("italic") and true,
    underline = opts.style:find("underline") and true,
  })
end

-- Define the colorscheme
function M.apply()
  local style = M.config.style
  local c = colors[style]
  local terminal_colors = get_terminal_colors(style)
  
  -- Syntax highlighting groups
  local syntax = {
    -- Editor UI
    Normal = { fg = c.fg, bg = c.bg },
    NormalFloat = { fg = c.fg, bg = c.bg_alt },
    ColorColumn = { bg = c.line },
    Cursor = { fg = c.bg, bg = c.fg },
    CursorLine = { bg = c.line },
    CursorColumn = { bg = c.line },
    Directory = { fg = c.kiki_blue },
    DiffAdd = { fg = c.forest_green, bg = c.bg_alt },
    DiffChange = { fg = c.catbus_orange, bg = c.bg_alt },
    DiffDelete = { fg = c.chihiro_red, bg = c.bg_alt },
    DiffText = { fg = c.kiki_blue, bg = c.bg_alt },
    EndOfBuffer = { fg = c.guides },
    ErrorMsg = { fg = c.error },
    VertSplit = { fg = c.guides },
    Folded = { fg = c.comment, bg = c.line },
    FoldColumn = { fg = c.guides },
    SignColumn = { fg = c.guides },
    IncSearch = { fg = c.bg, bg = c.kiki_blue },
    Substitute = { fg = c.bg, bg = c.chihiro_red },
    LineNr = { fg = c.guides },
    CursorLineNr = { fg = c.catbus_orange },
    MatchParen = { fg = c.calcifer, style = "bold" },
    ModeMsg = { fg = c.fg_alt },
    MoreMsg = { fg = c.forest_green },
    NonText = { fg = c.guides },
    Pmenu = { fg = c.fg, bg = c.pmenu_bg },
    PmenuSel = { fg = c.fg, bg = c.pmenu_sel },
    PmenuSbar = { bg = c.pmenu_bg },
    PmenuThumb = { bg = c.fg_alt },
    Question = { fg = c.forest_green },
    QuickFixLine = { fg = c.bg, bg = c.kiki_blue },
    Search = { fg = c.bg, bg = c.kiki_blue, style = "bold" },
    SpecialKey = { fg = c.guides },
    SpellBad = { sp = c.chihiro_red, style = "undercurl" },
    SpellCap = { sp = c.catbus_orange, style = "undercurl" },
    SpellLocal = { sp = c.totoro_green, style = "undercurl" },
    SpellRare = { sp = c.zeniba_purple, style = "undercurl" },
    StatusLine = { fg = c.fg, bg = c.line },
    StatusLineNC = { fg = c.fg_alt, bg = c.bg_alt },
    TabLine = { fg = c.fg, bg = c.bg_alt },
    TabLineFill = { bg = c.bg },
    TabLineSel = { fg = c.bg, bg = c.kiki_blue },
    Title = { fg = c.kiki_blue, style = "bold" },
    Visual = { bg = c.visual },
    VisualNOS = { bg = c.visual },
    WarningMsg = { fg = c.warning },
    Whitespace = { fg = c.guides },
    WildMenu = { fg = c.fg, bg = c.pmenu_sel },
    
    -- Syntax
    Comment = { fg = c.comment, style = "italic" },
    Constant = { fg = c.constant },
    String = { fg = c.string },
    Character = { fg = c.string },
    Number = { fg = c.number },
    Boolean = { fg = c.number },
    Float = { fg = c.number },
    Identifier = { fg = c.fg },
    Function = { fg = c.func },
    Statement = { fg = c.keyword },
    Conditional = { fg = c.keyword },
    Repeat = { fg = c.keyword },
    Label = { fg = c.zeniba_purple },
    Operator = { fg = c.operator },
    Keyword = { fg = c.keyword },
    Exception = { fg = c.keyword },
    PreProc = { fg = c.zeniba_purple },
    Include = { fg = c.zeniba_purple },
    Define = { fg = c.zeniba_purple },
    Macro = { fg = c.zeniba_purple },
    PreCondit = { fg = c.zeniba_purple },
    Type = { fg = c.type },
    StorageClass = { fg = c.type },
    Structure = { fg = c.type },
    Typedef = { fg = c.type },
    Special = { fg = c.calcifer },
    SpecialChar = { fg = c.calcifer },
    Tag = { fg = c.ponyo_pink },
    Delimiter = { fg = c.fg },
    SpecialComment = { fg = c.comment, style = "italic" },
    Debug = { fg = c.chihiro_red },
    Underlined = { style = "underline" },
    Ignore = { fg = c.guides },
    Error = { fg = c.error },
    Todo = { fg = c.bg, bg = c.catbus_orange },
    
    -- LSP
    DiagnosticError = { fg = c.error },
    DiagnosticWarn = { fg = c.warning },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },
    DiagnosticUnderlineError = { sp = c.error, style = "undercurl" },
    DiagnosticUnderlineWarn = { sp = c.warning, style = "undercurl" },
    DiagnosticUnderlineInfo = { sp = c.info, style = "undercurl" },
    DiagnosticUnderlineHint = { sp = c.hint, style = "undercurl" },
    
    -- TreeSitter
    ["@variable"] = { fg = c.fg },
    ["@function"] = { fg = c.func },
    ["@function.builtin"] = { fg = c.builtin },
    ["@function.macro"] = { fg = c.zeniba_purple },
    ["@keyword"] = { fg = c.keyword },
    ["@keyword.function"] = { fg = c.keyword },
    ["@keyword.operator"] = { fg = c.operator },
    ["@keyword.return"] = { fg = c.keyword },
    ["@conditional"] = { fg = c.keyword },
    ["@repeat"] = { fg = c.keyword },
    ["@label"] = { fg = c.zeniba_purple },
    ["@string"] = { fg = c.string },
    ["@string.regex"] = { fg = c.laputa_gold },
    ["@string.escape"] = { fg = c.calcifer },
    ["@character"] = { fg = c.string },
    ["@number"] = { fg = c.number },
    ["@boolean"] = { fg = c.number },
    ["@float"] = { fg = c.number },
    ["@type"] = { fg = c.type },
    ["@type.builtin"] = { fg = c.type },
    ["@attribute"] = { fg = c.zeniba_purple },
    ["@property"] = { fg = c.fg },
    ["@field"] = { fg = c.fg },
    ["@parameter"] = { fg = c.fg, style = "italic" },
    ["@parameter.reference"] = { fg = c.fg, style = "italic" },
    ["@constructor"] = { fg = c.type },
    ["@tag"] = { fg = c.ponyo_pink },
    ["@tag.attribute"] = { fg = c.func },
    ["@tag.delimiter"] = { fg = c.operator },
    ["@punctuation.delimiter"] = { fg = c.operator },
    ["@punctuation.bracket"] = { fg = c.operator },
    ["@punctuation.special"] = { fg = c.operator },
    ["@comment"] = { fg = c.comment, style = "italic" },
    ["@operator"] = { fg = c.operator },
    ["@constant"] = { fg = c.constant },
    ["@constant.builtin"] = { fg = c.constant },
    ["@constant.macro"] = { fg = c.constant },
    ["@include"] = { fg = c.zeniba_purple },
    ["@exception"] = { fg = c.keyword },
    ["@text"] = { fg = c.fg },
    ["@text.title"] = { fg = c.kiki_blue, style = "bold" },
    ["@text.uri"] = { fg = c.string, style = "underline" },
    ["@text.underline"] = { style = "underline" },
    ["@text.todo"] = { fg = c.bg, bg = c.catbus_orange },
    
    -- Git
    GitSignsAdd = { fg = c.forest_green },
    GitSignsChange = { fg = c.catbus_orange },
    GitSignsDelete = { fg = c.chihiro_red },
    
    -- NvimTree
    NvimTreeNormal = { fg = c.fg, bg = c.bg_alt },
    NvimTreeFolderName = { fg = c.kiki_blue },
    NvimTreeRootFolder = { fg = c.forest_green, style = "bold" },
    NvimTreeEmptyFolderName = { fg = c.fg_alt },
    NvimTreeSymlink = { fg = c.calcifer },
    NvimTreeExecFile = { fg = c.func, style = "bold" },
    
    -- Telescope
    TelescopeNormal = { fg = c.fg, bg = c.bg_alt },
    TelescopeBorder = { fg = c.guides, bg = c.bg_alt },
    TelescopePromptBorder = { fg = c.guides, bg = c.bg_alt },
    TelescopeResultsBorder = { fg = c.guides, bg = c.bg_alt },
    TelescopePreviewBorder = { fg = c.guides, bg = c.bg_alt },
    TelescopeMatching = { fg = c.kiki_blue, style = "bold" },
    TelescopePromptPrefix = { fg = c.kiki_blue },
    TelescopeSelection = { bg = c.selection },
    
    -- Bufferline
    BufferLineFill = { bg = c.bg },
    BufferLineBackground = { fg = c.fg_alt, bg = c.bg_alt },
    BufferLineBufferVisible = { fg = c.fg, bg = c.bg_alt },
    BufferLineBufferSelected = { fg = c.bg, bg = c.kiki_blue },
    BufferLineTab = { fg = c.fg, bg = c.bg_alt },
    BufferLineTabSelected = { fg = c.bg, bg = c.kiki_blue },
    BufferLineTabClose = { fg = c.chihiro_red, bg = c.bg },
    BufferLineIndicatorSelected = { fg = c.haku_teal, bg = c.kiki_blue },
    
    -- Dashboard
    DashboardHeader = { fg = c.forest_green },
    DashboardCenter = { fg = c.kiki_blue },
    DashboardShortcut = { fg = c.ponyo_pink },
    DashboardFooter = { fg = c.comment },
  }
  
  -- Apply highlights
  for group, opts in pairs(syntax) do
    highlight(group, opts)
  end
  
  -- Set terminal colors
  for i, color in pairs(terminal_colors) do
    vim.g["terminal_color_" .. i - 1] = color
  end
  
  -- Add commands to load the theme and toggle between styles
  vim.cmd([[command! GhibliTheme lua require('ghibli').colorscheme()]])
  vim.cmd([[command! GhibliToggle lua require('ghibli').toggle()]])
  
  -- Style-specific font recommendations
  if style == "light" then
    vim.cmd([[
      " Recommended fonts for the Ghibli light theme:
      " - 'Cascadia Code' with ligatures
      " - 'JetBrains Mono' for a clean look
      " - 'Comic Mono' for a slightly playful but readable style
      " - 'Victor Mono' for beautiful italics (especially for comments)
      "
      " Example font configuration for your terminal:
      " For iTerm2: Use 'JetBrains Mono' at 13pt with ligatures enabled
      " For Windows Terminal: Use 'Cascadia Code PL' with ligatures 
      " For Alacritty, add to your alacritty.yml:
      "   font:
      "     normal:
      "       family: "JetBrains Mono"
      "     italic:
      "       family: "Victor Mono"
      "       style: "Italic"
      "
      " To enhance the light theme experience, consider:
      " - Increasing font weight for better contrast
      " - Using a warm-tinted terminal background that matches #f9eed8
    ]])
  else
    vim.cmd([[
      " Recommended fonts for the Ghibli dark theme:
      " - 'JetBrains Mono' for a clean look
      " - 'Cascadia Code' with ligatures
      " - 'Victor Mono' for beautiful italics (especially for comments)
      " - 'Fira Code' for a more technical feel
      "
      " Example font configuration for your terminal:
      " For iTerm2: Use 'JetBrains Mono' at 13pt with ligatures enabled
      " For Windows Terminal: Use 'Cascadia Code PL' with ligatures 
      " For Alacritty, add to your alacritty.yml:
      "   font:
      "     normal:
      "       family: "JetBrains Mono"
      "     italic:
      "       family: "Victor Mono"
      "       style: "Italic"
      "
      " To enhance the dark theme experience, consider:
      " - Using a font weight of medium or regular
      " - Using a warm-tinted terminal background that matches #2c2b2a
    ]])
  end
end

-- Set the colorscheme
function M.colorscheme()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  
  vim.o.termguicolors = true
  vim.g.colors_name = "ghibli"
  
  M.apply()
end

-- Toggle between light and dark mode
function M.toggle()
  M.config.style = M.config.style == "light" and "dark" or "light"
  M.colorscheme()
  vim.notify("Switched to " .. M.config.style .. " mode", vim.log.levels.INFO)
end

-- Return the module
return M


-- === Colors file (colors/ghibli.lua) ===
-- This minimal file enables :colorscheme command

-- require('ghibli').colorscheme()
-- This is a separate file in colors/ghibli.lua