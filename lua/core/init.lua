_G.pcode = _G.pcode or {}
require("user.default")
require("core.lazy")
require("user.options")
require("user.autocommands")
require("user.keymaps")
require("cpp-config")
require("user.lsp_notify")
require("user.welcome_notify")
require("plugins.formatter")
require("user.learn_day")
require("user.forgetmap").setup()
require("user.macro_record")

