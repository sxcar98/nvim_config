local M = {}

M.settings = {
  texlab = {
    rootDirectory = nil,
    build = {
      executable = "latexmk",
      args = {"-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-xelatex"},
      onSave = true,
      forwardSearchAfter = true
    },
    auxDirectory = ".",
    forwardSearch = {
      executable = "C:/Users/sxcar98/AppData/Local/SumatraPDF/SumatraPDF.exe",
      args = {
        "-reuse-instance",
        "%p",
        "-forward-search",
        "%f",
        "%l"
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
