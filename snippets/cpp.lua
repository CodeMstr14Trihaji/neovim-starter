local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Fungsi untuk waktu lengkap (tanggal + jam)
local datetime = function() return os.date("%Y-%m-%d %H:%M") end
-- Fungsi untuk nama file
local filename = function() return vim.fn.expand("%:t") end

return {

  s("cppmain", fmt([[
int main() {{
    {}
    return 0;
}}
  ]], { i(1, "// Write your code here") })),

  s("cppout", fmt([[cout << {} << endl;]], { i(1) })),

  s("cppin", fmt([[cin >> {};]], { i(1) })),

  s("cppfor", fmt([[
for (int {} = {}; {} {}; {}) {{
    {}
}}
  ]], {
    i(1, "i"),
    i(2, "0"),
    rep(1),
    i(3, "< n"),
    i(4, "++" .. "i"),
    i(5, "// Write your code here")
  })),

  s("cppwhile", fmt([[
while ({}) {{
    {}
}}
  ]], { i(1, "condition"), i(2, "// Write your code here") })),

  s("cppif", fmt([[
if ({}) {{
    {}
}}
  ]], { i(1, "condition"), i(2, "// Write your code here") })),

  s("cppelse", fmt([[
else {{
    {}
}}
  ]], { i(1, "// Write your code here") })),

  s("cppelseif", fmt([[
else if ({}) {{
    {}
}}
  ]], { i(1, "condition"), i(2, "// Write your code here") })),

  s("cppswitch", fmt([[
switch ({}) {{
    case {}:
        {};
        break;
    default:
        {};
}}
  ]], {
    i(1, "variable"),
    i(2, "value"),
    i(3, "// Write your code here"),
    i(4, "// Write your code here")
  })),

  s("cppvfunc", fmt([[
{} {}({}) {{
    {}
}}
  ]], { i(1, "void"), i(2, "functionName"), i(3, "parameters"), i(4, "// Write your code here") })),

  s("cpprfunc", fmt([[
{} {}({}) {{
    {}
    return {};
}}
  ]], { i(1, "// return type"), i(2, "functionName"), i(3, "parameters"), i(4, "// Write your code here"), i(5) })),

  s("cppnvector", fmt([[
#include <iostream>
#include <vector>
using namespace std;

int main() {{
    int n;
    cin >> n;
    vector<int> arr(n);
    for (int &x : arr) cin >> x;
    {}
    for (int &x : arr) cout << x << " ";
    cout << "\n";
    return 0;
}}
  ]], { i(1, "// function") })),

  s("cpplib", fmt([[#include<{}>]], { i(1, "//library") })),

  s("cppcall", t("#include<bits/stdc++.h>")),

  s("cppusing", t("using namespace std;")),

  s("cppfastio", t({
    "inline void fastio(){",
    "   ios_base::sync_with_stdio(0);",
    "   cin.tie(0);",
    "   cout.tie(0);",
    "}"
  })),

  s("smallvec", t({
    "int n; cin >> n;",
    "vector<int> arr(n);"
  })),

  s("cppclass", fmt([[
class {} {{
   public:
       {}
}};
  ]], { i(1, "//name"), i(2, "//code") })),

  s("debugvar", fmt([[cout << "\nVar debug: " << {} << endl;]], { i(1, "variable") })),

  s("debugarr", t({
    'cout << "\\nArr debug: ";',
    'for(const auto & x : array) cout << x << " ";',
    'cout << endl;'
  })),

  s("passtest", t([[cout << "CHECKPOINT REACHED!\n";]])),

  s("cpprofil", {
    t({"/*"}),                    -- baris awal komentar
    t({"", "Author  = trihajikhr"}), -- baris author
    t({"", "Date    = "}), f(datetime), -- baris date
    t({"", "File    = "}), f(filename), -- baris file
    t({"", "*/"}),                -- akhir komentar
  }),
}
