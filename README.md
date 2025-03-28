# 🌱 Ghibli.nvim

A whimsical Neovim color scheme inspired by the magical worlds of Studio Ghibli films, featuring soft dark backgrounds, vibrant pastel accents, and the iconic Ghibli aesthetic.
<!-- 
![Ghibli.nvim Theme](https://via.placeholder.com/800x450) -->

## ✨ Features

- 🎨 Color palette inspired by various Studio Ghibli films
- 🌿 Balanced color scheme with earthy tones and vibrant accents
- 🌟 Support for Treesitter, LSP, and popular plugins
- 🖋️ Font recommendations to complete the Ghibli aesthetic
- 🌃 Soft dark theme by default, evoking the magical nighttime scenes in Ghibli films

## 🌊 Installation

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'patil-suraj/ghibli.nvim',
  config = function()
    -- Load the colorscheme
    require('ghibli').colorscheme()
  end
}
```

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'patil-suraj/ghibli.nvim',
  lazy = false, -- make sure we load this during startup
  priority = 1000, -- load before other plugins
  config = function()
    require('ghibli').colorscheme()
  end,
}
```

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'patil-suraj/ghibli.nvim'
```

After installation with vim-plug, add to your init.vim:

```vim
colorscheme ghibli
```

## 🍃 Usage

After installation, set the colorscheme:

```vim
" In Vim script
colorscheme ghibli
```

```lua
-- In Lua
vim.cmd[[colorscheme ghibli]]
```

Or use the plugin command:

```vim
:GhibliTheme
```

## 🌸 Font Recommendations

For the complete Ghibli experience, consider using one of these fonts:

- **JetBrains Mono** - Clean, modern font with ligatures
- **Cascadia Code** - Beautiful coding font with ligatures
- **Comic Mono** - A legible monospace version of Comic Sans that gives a slight hand-drawn feel
- **Victor Mono** - Features beautiful italics perfect for the theme's italic comments


## 🧙‍♂️ Inspiration

The color palette draws inspiration from various Studio Ghibli films:

- **My Neighbor Totoro** - Greens and earthy tones
- **Spirited Away** - Rich blues and magical accents
- **Howl's Moving Castle** - Warm tones and night skies
- **Ponyo** - Vibrant reds and ocean blues
- **Princess Mononoke** - Forest greens and natural tones
- **Kiki's Delivery Service** - Deep blues and warm browns

<!-- ## 📸 Screenshots

![Editing Lua](https://via.placeholder.com/800x450)
![Editing Python](https://via.placeholder.com/800x450)
![Editing Javascript](https://via.placeholder.com/800x450) -->

## 🌟 Credits

Created with love by a Ghibli fan for Ghibli fans who code.

## 📝 License

MIT License