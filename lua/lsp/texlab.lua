local M = {}

M.settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = "latexmk",
        args = {"-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-xelatex"},
        onSave = false,
        forwardSearchAfter = true
      },
      auxDirectory = ".",
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = {
          "-r",
          "%l",
          "%p",
          "%f"
        }
      },
      chktex = {
        onOpenAndSave = false,
        onEdit = false
      },
      diagnosticsDelay = 300,
      latexFormatter = "latexindent",
      latexindent = {
        ["local"] = nil, -- local is a reserved keyword
        modifyLineBreaks = false
      },
      bibtexFormatter = "texlab",
      formatterLineLength = 80
    }
}

return M
