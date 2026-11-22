local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("h1", {
        t("# "),
        i(1, "Heading"),
        i(0),


    }),

    s("todo", {
        t("- [ ] "),
        i(1, "Task"),
        i(0),
    }),

     s("bash", {
        t({"```bash", ""}),
        i(1, "command"),
        t({"", "```"}),
        i(0),
    }),

    s("yaml", {
        t({"```yaml", ""}),
        i(1, "command"),
        t({"", "```"}),
        i(0),
    }),



}
