-- File structure:
-- ghibli.nvim/
-- ├── lua/
-- │   └── ghibli.lua  (Main file with all the code)
-- └── colors/
--     └── ghibli.lua  (Enables :colorscheme ghibli)

-- === Main file (lua/ghibli.lua) ===
-- Contains all theme code and functionality

local M = {}

-- Color palette inspired by Studio Ghibli films
local colors = {
  -- Base colors
  bg = "#2a2d3d",          -- Soft dark background (night sky in Ghibli films)
  bg_alt = "#343748",      -- Slightly lighter background
  fg = "#d5d1c8",          -- Light text for dark background
  fg_alt = "#a9a7a2",      -- Secondary text color
  
  -- Ghibli signature colors
  totoro_green = "#78a383", -- Totoro's body color
  chihiro_red = "#ff7070",  -- Chihiro's clothes (brightened for dark bg)
  calcifer = "#ff913c",     -- Calcifer's fiery body
  haku_teal = "#67b5b7",    -- Haku's dragon color
  ponyo_pink = "#ffa7a7",   -- Ponyo's dress/hair
  forest_green = "#7aa489", -- Forest green (Princess Mononoke) (brightened)
  soot_sprite = "#9a9a9a",  -- Soot sprites from Spirited Away (lightened)
  kiki_blue = "#7fa3d7",    -- Kiki's deep blue (brightened)
  zeniba_purple = "#b59ed8", -- Zeniba's purple accents (brightened)
  catbus_orange = "#ffb777", -- Catbus orange (brightened)
  sky_blue = "#a4cff4",     -- Ghibli sky blue
  laputa_gold = "#ffd280",  -- Laputa/Castle in the Sky gold (brightened)
  
  -- UI element colors
  line = "#363a4f",         -- Line background (darker)
  selection = "#404868",    -- Selection background (dark blue)
  comment = "#8c9a88",      -- Soft forest comment color
  guides = "#4b4f64",       -- Indentation guides (darker)
  visual = "#4a4332",       -- Visual selection (dark warm brown)
  pmenu_bg = "#383b4d",     -- Popup menu background
  pmenu_sel = "#404e69",    -- Popup menu selection
  
  -- Syntax colors repurposed from Ghibli palette
  string = "#a2cc8e",       -- Green for strings (forest) (brightened)
  number = "#e3a195",       -- Rusty red for numbers (brightened)
  keyword = "#81a7cc",      -- Sky blue for keywords (brightened)
  func = "#d5a278",         -- Brown for functions (brightened)
  constant = "#c295c0",     -- Purple for constants (brightened)
  type = "#7fb5b5",         -- Teal for types (brightened)
  builtin = "#d4a578",      -- Orange brown for builtins (brightened)
  operator = "#a2a6bc",     -- Muted blue-gray for operators (brightened)
  error = "#e15d67",        -- Bright red for errors
  warning = "#dbac66",      -- Amber for warnings
  info = "#65a6dd",         -- Light blue for info
  hint = "#7caf7f",         -- Green for hints
  
  -- Transparent for terminal background
  none = "NONE",
}

-- Terminal colors
local terminal_colors = {
  [1] = colors.soot_sprite,   -- Black
  [2] = colors.forest_green,  -- Red
  [3] = colors.totoro_green,  -- Green
  [4] = colors.catbus_orange, -- Yellow
  [5] = colors.kiki_blue,     -- Blue
  [6] = colors.zeniba_purple, -- Magenta
  [7] = colors.haku_teal,     -- Cyan
  [8] = colors.fg,            -- White
  
  [9] = colors.soot_sprite,   -- Bright Black
  [10] = colors.chihiro_red,  -- Bright Red
  [11] = colors.forest_green, -- Bright Green
  [12] = colors.laputa_gold,  -- Bright Yellow
  [13] = colors.sky_blue,     -- Bright Blue
  [14] = colors.ponyo_pink,   -- Bright Magenta
  [15] = colors.haku_teal,    -- Bright Cyan
  [16] = colors.fg_alt,       -- Bright White
}

-- Highlight helper function
local function highlight(group, opts)
  opts.fg = opts.fg or colors.none
  opts.bg = opts.bg or colors.none
  opts.sp = opts.sp or colors.none
  opts.style = opts.style or colors.none
  
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
function M.setup()
  -- Syntax highlighting groups
  local syntax = {
    -- Editor UI
    Normal = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg_alt },
    ColorColumn = { bg = colors.line },
    Cursor = { fg = colors.bg, bg = colors.fg },
    CursorLine = { bg = colors.line },
    CursorColumn = { bg = colors.line },
    Directory = { fg = colors.kiki_blue },
    DiffAdd = { fg = colors.forest_green, bg = colors.bg_alt },
    DiffChange = { fg = colors.catbus_orange, bg = colors.bg_alt },
    DiffDelete = { fg = colors.chihiro_red, bg = colors.bg_alt },
    DiffText = { fg = colors.kiki_blue, bg = colors.bg_alt },
    EndOfBuffer = { fg = colors.guides },
    ErrorMsg = { fg = colors.error },
    VertSplit = { fg = colors.guides },
    Folded = { fg = colors.comment, bg = colors.line },
    FoldColumn = { fg = colors.guides },
    SignColumn = { fg = colors.guides },
    IncSearch = { fg = colors.bg, bg = colors.laputa_gold },
    Substitute = { fg = colors.bg, bg = colors.chihiro_red },
    LineNr = { fg = colors.guides },
    CursorLineNr = { fg = colors.catbus_orange },
    MatchParen = { fg = colors.calcifer, style = "bold" },
    ModeMsg = { fg = colors.fg_alt },
    MoreMsg = { fg = colors.forest_green },
    NonText = { fg = colors.guides },
    Pmenu = { fg = colors.fg, bg = colors.pmenu_bg },
    PmenuSel = { fg = colors.fg, bg = colors.pmenu_sel },
    PmenuSbar = { bg = colors.pmenu_bg },
    PmenuThumb = { bg = colors.fg_alt },
    Question = { fg = colors.forest_green },
    QuickFixLine = { fg = colors.bg, bg = colors.kiki_blue },
    Search = { fg = colors.bg, bg = colors.laputa_gold, style = "bold" },
    SpecialKey = { fg = colors.guides },
    SpellBad = { sp = colors.chihiro_red, style = "undercurl" },
    SpellCap = { sp = colors.catbus_orange, style = "undercurl" },
    SpellLocal = { sp = colors.totoro_green, style = "undercurl" },
    SpellRare = { sp = colors.zeniba_purple, style = "undercurl" },
    StatusLine = { fg = colors.fg, bg = colors.line },
    StatusLineNC = { fg = colors.fg_alt, bg = colors.bg_alt },
    TabLine = { fg = colors.fg, bg = colors.bg_alt },
    TabLineFill = { bg = colors.bg },
    TabLineSel = { fg = colors.fg, bg = colors.sky_blue },
    Title = { fg = colors.kiki_blue, style = "bold" },
    Visual = { bg = colors.visual },
    VisualNOS = { bg = colors.visual },
    WarningMsg = { fg = colors.warning },
    Whitespace = { fg = colors.guides },
    WildMenu = { fg = colors.fg, bg = colors.pmenu_sel },
    
    -- Syntax
    Comment = { fg = colors.comment, style = "italic" },
    Constant = { fg = colors.constant },
    String = { fg = colors.string },
    Character = { fg = colors.string },
    Number = { fg = colors.number },
    Boolean = { fg = colors.number },
    Float = { fg = colors.number },
    Identifier = { fg = colors.fg },
    Function = { fg = colors.func },
    Statement = { fg = colors.keyword },
    Conditional = { fg = colors.keyword },
    Repeat = { fg = colors.keyword },
    Label = { fg = colors.zeniba_purple },
    Operator = { fg = colors.operator },
    Keyword = { fg = colors.keyword },
    Exception = { fg = colors.keyword },
    PreProc = { fg = colors.zeniba_purple },
    Include = { fg = colors.zeniba_purple },
    Define = { fg = colors.zeniba_purple },
    Macro = { fg = colors.zeniba_purple },
    PreCondit = { fg = colors.zeniba_purple },
    Type = { fg = colors.type },
    StorageClass = { fg = colors.type },
    Structure = { fg = colors.type },
    Typedef = { fg = colors.type },
    Special = { fg = colors.calcifer },
    SpecialChar = { fg = colors.calcifer },
    Tag = { fg = colors.ponyo_pink },
    Delimiter = { fg = colors.fg },
    SpecialComment = { fg = colors.comment, style = "italic" },
    Debug = { fg = colors.chihiro_red },
    Underlined = { style = "underline" },
    Ignore = { fg = colors.guides },
    Error = { fg = colors.error },
    Todo = { fg = colors.bg, bg = colors.catbus_orange },
    
    -- LSP
    DiagnosticError = { fg = colors.error },
    DiagnosticWarn = { fg = colors.warning },
    DiagnosticInfo = { fg = colors.info },
    DiagnosticHint = { fg = colors.hint },
    DiagnosticUnderlineError = { sp = colors.error, style = "undercurl" },
    DiagnosticUnderlineWarn = { sp = colors.warning, style = "undercurl" },
    DiagnosticUnderlineInfo = { sp = colors.info, style = "undercurl" },
    DiagnosticUnderlineHint = { sp = colors.hint, style = "undercurl" },
    
    -- TreeSitter
    ["@variable"] = { fg = colors.fg },
    ["@function"] = { fg = colors.func },
    ["@function.builtin"] = { fg = colors.builtin },
    ["@function.macro"] = { fg = colors.zeniba_purple },
    ["@keyword"] = { fg = colors.keyword },
    ["@keyword.function"] = { fg = colors.keyword },
    ["@keyword.operator"] = { fg = colors.operator },
    ["@keyword.return"] = { fg = colors.keyword },
    ["@conditional"] = { fg = colors.keyword },
    ["@repeat"] = { fg = colors.keyword },
    ["@label"] = { fg = colors.zeniba_purple },
    ["@string"] = { fg = colors.string },
    ["@string.regex"] = { fg = colors.laputa_gold },
    ["@string.escape"] = { fg = colors.calcifer },
    ["@character"] = { fg = colors.string },
    ["@number"] = { fg = colors.number },
    ["@boolean"] = { fg = colors.number },
    ["@float"] = { fg = colors.number },
    ["@type"] = { fg = colors.type },
    ["@type.builtin"] = { fg = colors.type },
    ["@attribute"] = { fg = colors.zeniba_purple },
    ["@property"] = { fg = colors.fg },
    ["@field"] = { fg = colors.fg },
    ["@parameter"] = { fg = colors.fg, style = "italic" },
    ["@parameter.reference"] = { fg = colors.fg, style = "italic" },
    ["@constructor"] = { fg = colors.type },
    ["@tag"] = { fg = colors.ponyo_pink },
    ["@tag.attribute"] = { fg = colors.func },
    ["@tag.delimiter"] = { fg = colors.operator },
    ["@punctuation.delimiter"] = { fg = colors.operator },
    ["@punctuation.bracket"] = { fg = colors.operator },
    ["@punctuation.special"] = { fg = colors.operator },
    ["@comment"] = { fg = colors.comment, style = "italic" },
    ["@operator"] = { fg = colors.operator },
    ["@constant"] = { fg = colors.constant },
    ["@constant.builtin"] = { fg = colors.constant },
    ["@constant.macro"] = { fg = colors.constant },
    ["@include"] = { fg = colors.zeniba_purple },
    ["@exception"] = { fg = colors.keyword },
    ["@text"] = { fg = colors.fg },
    ["@text.title"] = { fg = colors.kiki_blue, style = "bold" },
    ["@text.uri"] = { fg = colors.string, style = "underline" },
    ["@text.underline"] = { style = "underline" },
    ["@text.todo"] = { fg = colors.bg, bg = colors.catbus_orange },
    
    -- Git
    GitSignsAdd = { fg = colors.forest_green },
    GitSignsChange = { fg = colors.catbus_orange },
    GitSignsDelete = { fg = colors.chihiro_red },
    
    -- NvimTree
    NvimTreeNormal = { fg = colors.fg, bg = colors.bg_alt },
    NvimTreeFolderName = { fg = colors.kiki_blue },
    NvimTreeRootFolder = { fg = colors.forest_green, style = "bold" },
    NvimTreeEmptyFolderName = { fg = colors.fg_alt },
    NvimTreeSymlink = { fg = colors.calcifer },
    NvimTreeExecFile = { fg = colors.func, style = "bold" },
    
    -- Telescope
    TelescopeNormal = { fg = colors.fg, bg = colors.bg_alt },
    TelescopeBorder = { fg = colors.guides, bg = colors.bg_alt },
    TelescopePromptBorder = { fg = colors.guides, bg = colors.bg_alt },
    TelescopeResultsBorder = { fg = colors.guides, bg = colors.bg_alt },
    TelescopePreviewBorder = { fg = colors.guides, bg = colors.bg_alt },
    TelescopeMatching = { fg = colors.laputa_gold, style = "bold" },
    TelescopePromptPrefix = { fg = colors.kiki_blue },
    TelescopeSelection = { bg = colors.selection },
    
    -- Bufferline
    BufferLineFill = { bg = colors.bg },
    BufferLineBackground = { fg = colors.fg_alt, bg = colors.bg_alt },
    BufferLineBufferVisible = { fg = colors.fg, bg = colors.bg_alt },
    BufferLineBufferSelected = { fg = colors.fg, bg = colors.sky_blue },
    BufferLineTab = { fg = colors.fg, bg = colors.bg_alt },
    BufferLineTabSelected = { fg = colors.bg, bg = colors.kiki_blue },
    BufferLineTabClose = { fg = colors.chihiro_red, bg = colors.bg },
    BufferLineIndicatorSelected = { fg = colors.haku_teal, bg = colors.sky_blue },
    
    -- Dashboard
    DashboardHeader = { fg = colors.forest_green },
    DashboardCenter = { fg = colors.kiki_blue },
    DashboardShortcut = { fg = colors.ponyo_pink },
    DashboardFooter = { fg = colors.comment },
  }
  
  -- Apply highlights
  for group, opts in pairs(syntax) do
    highlight(group, opts)
  end
  
  -- Set terminal colors
  for i, color in pairs(terminal_colors) do
    vim.g["terminal_color_" .. i - 1] = color
  end
  
  -- Add a command to load the theme
  vim.cmd([[command! GhibliTheme lua require('ghibli').colorscheme()]])
  
  -- Recommended terminal font settings (displayed as a comment)
  vim.cmd([[
    " Recommended fonts for the Ghibli theme:
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
  ]])
end

-- Set the colorscheme
function M.colorscheme()
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  
  vim.o.termguicolors = true
  vim.g.colors_name = "ghibli"
  
  M.setup()
end

-- Return the module
return M


-- === Colors file (colors/ghibli.lua) ===
-- This minimal file enables :colorscheme command

-- require('ghibli').colorscheme()
-- This is a separate file in colors/ghibli.lua