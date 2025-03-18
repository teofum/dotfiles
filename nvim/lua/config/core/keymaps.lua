-- Mappings

-- Remap cursor keys to the actual resting positions on the home row
-- It's not the 1980s anymore; keyboards are different now!
vim.keymap.set({ "n", "v" }, "j", "h") -- j = left
vim.keymap.set({ "n", "v" }, "k", "k") -- k = up
vim.keymap.set({ "n", "v" }, "l", "j") -- l = down
vim.keymap.set({ "n", "v" }, ";", "l") -- ; = right

-- Move fast zoom
vim.keymap.set({ "n", "v" }, "<S-j>", "0") -- j = left
vim.keymap.set({ "n", "v" }, "<S-k>", "10k") -- k = up
vim.keymap.set({ "n", "v" }, "<S-l>", "10j") -- l = down
vim.keymap.set({ "n", "v" }, "<C-S-;>", "$") -- ; = right

-- Also remap the Ctrl+[key] combos, used by the tmux navigator plugin
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateLeft<cr>") -- j = left
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>") -- k = up
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateDown<cr>") -- l = down
vim.keymap.set("n", "<C-;>", "<cmd>TmuxNavigateRight<cr>") -- ; = right
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>") -- ; = right

-- Move lines
vim.keymap.set("n", "<C-S-l>", ":m .+1<cr>==")
vim.keymap.set("n", "<C-S-k>", ":m .-2<cr>==")
vim.keymap.set("i", "<C-S-l>", "<esc>:m .+1<cr>==gi")
vim.keymap.set("i", "<C-S-k>", "<esc>:m .-2<cr>==gi")
vim.keymap.set("v", "<C-S-l>", "<esc>:m '>+1<cr>gv=gv")
vim.keymap.set("v", "<C-S-k>", "<esc>:m '<-2<cr>gv=gv")

-- Multicursor plugin
-- vim.keymap.set({ "n", "v" }, "m", "<cmd>MCunderCursor<cr>")
