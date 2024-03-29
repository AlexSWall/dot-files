" File:       monokai.vim
" Maintainer: Crusoe Xia (crusoexia)
" URL:        https://github.com/crusoexia/vim-monokai
" License:    MIT
"
" The colour palette is from http://www.colourlovers.com/
" The original code is from https://github.com/w0ng/vim-hybrid

" Initialisation
" --------------

if !has("gui_running") && &t_Co < 256
  finish
endif

if ! exists("g:monokai_gui_italic")
    let g:monokai_gui_italic = 0
endif

if ! exists("g:monokai_term_italic")
    let g:monokai_term_italic = 0
endif

let g:monokai_termcolors = 256 " does not support 16 color term right now.

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "monokai"

function! s:h(group, style)
  let s:ctermformat = "NONE"
  let s:guiformat = "NONE"
  if has_key(a:style, "format")
    let s:ctermformat = a:style.format
    let s:guiformat = a:style.format
  endif
  if g:monokai_term_italic == 0
    let s:ctermformat = substitute(s:ctermformat, ",italic", "", "")
    let s:ctermformat = substitute(s:ctermformat, "italic,", "", "")
    let s:ctermformat = substitute(s:ctermformat, "italic", "", "")
  endif
  if g:monokai_gui_italic == 0
    let s:guiformat = substitute(s:guiformat, ",italic", "", "")
    let s:guiformat = substitute(s:guiformat, "italic,", "", "")
    let s:guiformat = substitute(s:guiformat, "italic", "", "")
  endif
  if g:monokai_termcolors == 16
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  end
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")      ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")      ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")      ? a:style.sp.gui   : "NONE")
    \ "gui="     (!empty(s:guiformat) ? s:guiformat   : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (!empty(s:ctermformat) ? s:ctermformat   : "NONE")
endfunction

" Palettes
" --------

let s:white1      = { "gui": "#d0d0d0", "cterm": "252" }
let s:white2      = { "gui": "#bcbcbc", "cterm": "250" }
let s:white3      = { "gui": "#a8a8a8", "cterm": "248" }
let s:grey3       = { "gui": "#8a8a8a", "cterm": "245" }
let s:grey2       = { "gui": "#767676", "cterm": "243" }
let s:grey1       = { "gui": "#666666", "cterm": "242" }
let s:darkgrey    = { "gui": "#444444", "cterm": "238" }
let s:dark5       = { "gui": "#303030", "cterm": "236" }
let s:dark4       = { "gui": "#262626", "cterm": "235" }
let s:dark3       = { "gui": "#1c1c1c", "cterm": "234" }
let s:dark2       = { "gui": "#121212", "cterm": "233" }
let s:dark12      = { "gui": "#0d0d0d", "cterm": "233" }
let s:dark1       = { "gui": "#080808", "cterm": "232" }
let s:black       = { "gui": "#000000", "cterm": "0"   }

let s:pink        = { "gui": "#F92772", "cterm": "197" }
let s:green       = { "gui": "#A6E22D", "cterm": "148" }
let s:aqua        = { "gui": "#66d9ef", "cterm": "81" }
let s:darkblue    = { "gui": "#1d204d", "cterm": "27" }
let s:yellow      = { "gui": "#E6DB74", "cterm": "186" }
let s:orange      = { "gui": "#FD9720", "cterm": "208" }
let s:purple      = { "gui": "#ae81ff", "cterm": "141" }
let s:red         = { "gui": "#e73c50", "cterm": "196" }
let s:purered     = { "gui": "#ff0000", "cterm": "52" }
let s:darkred     = { "gui": "#5f0000", "cterm": "52" }

let s:addfg       = { "gui": "#d7ffaf", "cterm": "193" }
let s:addbg       = { "gui": "#5f875f", "cterm": "65" }
let s:delfg       = { "gui": "#ff8b8b", "cterm": "210" }
let s:delbg       = { "gui": "#f75f5f", "cterm": "124" }
let s:changefg    = { "gui": "#d7d7ff", "cterm": "189" }
let s:changebg    = { "gui": "#5f5f87", "cterm": "60" }

let s:cyan        = { "gui": "#A1EFE4" }
let s:br_green    = { "gui": "#9EC400" }
let s:br_yellow   = { "gui": "#E7C547" }
let s:br_blue     = { "gui": "#7AA6DA" }
let s:br_purple   = { "gui": "#B77EE0" }
let s:br_cyan     = { "gui": "#54CED6" }
let s:br_white    = { "gui": "#FFFFFF" }

" Highlighting 
" ------------

" editor
call s:h("Normal",        { "fg": s:white1,     "bg": s:dark1                                    })
call s:h("ColorColumn",   {                     "bg": s:dark12                                   })
call s:h("Cursor",        { "fg": s:dark1,      "bg": s:white1                                   })
call s:h("CursorColumn",  {                     "bg": s:dark4                                    })
call s:h("CursorLine",    {                     "bg": s:dark4                                    })
call s:h("NonText",       { "fg": s:dark5                                                        })
call s:h("Visual",        {                     "bg": s:dark5                                    })
call s:h("Search",        {                     "bg": s:darkblue                                 })
call s:h("MatchParen",    { "fg": s:purple,                         "format": "underline,bold"   })
call s:h("Question",      { "fg": s:yellow                                                       })
call s:h("ModeMsg",       { "fg": s:yellow                                                       })
call s:h("MoreMsg",       { "fg": s:yellow                                                       })
call s:h("ErrorMsg",      { "fg": s:dark1,      "bg": s:red,        "format": "standout"         })
call s:h("WarningMsg",    { "fg": s:red                                                          })
call s:h("VertSplit",     { "fg": s:dark5,      "bg": s:dark1                                    })
call s:h("LineNr",        { "fg": s:grey2,      "bg": s:dark1                                    })
call s:h("CursorLineNr",  { "fg": s:orange,     "bg": s:dark1                                    })
call s:h("SignColumn",    {                     "bg": s:dark1                                    })

" statusline
" I have absolutely abused StatusLine and StatusLineNC for my .vimrc
" statusline variable
call s:h("StatusLineNC",  { "bg": s:dark5,      "fg": s:dark1,      "format": "reverse,italic"   })
call s:h("StatusLine",    { "bg": s:white3,     "fg": s:dark1,      "format": "reverse"          })
call s:h("TabLineSel",    { "fg": s:white1,     "bg": s:dark3                                    })
call s:h("TabLine",       { "fg": s:grey2,      "bg": s:dark1                                    })
call s:h("TabLineFill",   { "fg": s:grey2,      "bg": s:dark1                                    })
call s:h("User1",         { "fg": s:yellow,     "bg": s:dark5,      "format": "bold"             })
call s:h("User2",         { "fg": s:orange,     "bg": s:dark5,      "format": "bold"             })
call s:h("User3",         { "fg": s:purple,     "bg": s:dark5,      "format": "bold"             })
call s:h("User4",         { "fg": s:aqua,       "bg": s:dark5,      "format": "bold"             })

" spell
call s:h("SpellBad",      { "fg": s:red,                            "format": "underline"        })
call s:h("SpellCap",      { "fg": s:purple,                         "format": "underline"        })
call s:h("SpellRare",     { "fg": s:aqua,                           "format": "underline"        })
call s:h("SpellLocal",    { "fg": s:pink,                           "format": "underline"        })

" misc
call s:h("SpecialKey",    { "fg": s:pink                                                         })
call s:h("Title",         { "fg": s:yellow                                                       })
call s:h("Directory",     { "fg": s:aqua                                                         })

" diff
call s:h("DiffAdd",       { "fg": s:addfg,      "bg": s:addbg                                    })
call s:h("DiffDelete",    { "fg": s:delfg,      "bg": s:delbg                                    })
call s:h("DiffChange",    { "fg": s:changefg,   "bg": s:changebg                                 })
call s:h("DiffText",      { "fg": s:dark1,      "bg": s:aqua                                     })

" fold
call s:h("Folded",        { "fg": s:grey1,      "bg": s:dark1                                    })
call s:h("FoldColumn",    {                     "bg": s:dark1                                    })
"        Incsearch"

" popup menu
call s:h("Pmenu",         { "fg": s:white2,     "bg": s:dark3                                    })
call s:h("PmenuSel",      { "bg": s:dark3,      "fg": s:aqua,       "format": "reverse,bold"     })
call s:h("PmenuThumb",    { "fg": s:dark3,      "bg": s:grey2                                    })
"        PmenuSbar"

" Generic Syntax Highlighting
" ---------------------------

call s:h("Constant",      { "fg": s:purple })
call s:h("Number",        { "fg": s:purple })
call s:h("Float",         { "fg": s:purple })
call s:h("Boolean",       { "fg": s:purple })
call s:h("Character",     { "fg": s:yellow })
call s:h("String",        { "fg": s:yellow })

call s:h("Type",          { "fg": s:aqua   })
call s:h("Structure",     { "fg": s:aqua   })
call s:h("StorageClass",  { "fg": s:aqua   })
call s:h("Typedef",       { "fg": s:aqua   })
    
call s:h("Identifier",    { "fg": s:green  })
call s:h("Function",      { "fg": s:green  })
                         
call s:h("Statement",     { "fg": s:pink   })
call s:h("Operator",      { "fg": s:pink   })
call s:h("Label",         { "fg": s:pink   })
call s:h("Keyword",       { "fg": s:pink   })

call s:h("PreProc",       { "fg": s:green  })
call s:h("Include",       { "fg": s:pink   })
call s:h("Define",        { "fg": s:pink   })
call s:h("Macro",         { "fg": s:green  })
call s:h("PreCondit",     { "fg": s:green  })
                           
call s:h("Special",       { "fg": s:purple })
call s:h("SpecialChar",   { "fg": s:pink   })
call s:h("Delimiter",     { "fg": s:pink   })
call s:h("SpecialComment",{ "fg": s:aqua   })
call s:h("Tag",           { "fg": s:pink   })

call s:h("Todo",          { "fg": s:orange, "format": "bold,italic" })
call s:h("Comment",       { "fg": s:grey1,  "format": "italic"      })
                         
call s:h("Underlined",    { "fg": s:green                   })
call s:h("Ignore",        {                                 })
call s:h("Error",         { "fg": s:red,    "bg": s:darkred })

" NerdTree
" --------

call s:h("NERDTreeOpenable",        { "fg": s:yellow })
call s:h("NERDTreeClosable",        { "fg": s:yellow })
call s:h("NERDTreeHelp",            { "fg": s:yellow })
call s:h("NERDTreeBookmarksHeader", { "fg": s:pink   })
call s:h("NERDTreeBookmarksLeader", { "fg": s:dark1  })
call s:h("NERDTreeBookmarkName",    { "fg": s:yellow })
call s:h("NERDTreeCWD",             { "fg": s:pink   })
call s:h("NERDTreeUp",              { "fg": s:white1 })
call s:h("NERDTreeDirSlash",        { "fg": s:grey2  })
call s:h("NERDTreeDir",             { "fg": s:grey2  })

" Syntastic
" ---------

hi! link SyntasticErrorSign Error
call s:h("SyntasticWarningSign",    { "fg": s:dark3, "bg": s:orange })

" coc
" ---

hi! link CocErrorSign Error
call s:h("CocErrorHighlight",       { "fg": s:red,                   "format": "underline" })
call s:h("CocErrorFloat",           { "fg": s:red,    "bg": s:dark1                        })

call s:h("CocWarningSign",          { "fg": s:orange, "bg": s:dark1                        })
call s:h("CocWarningHighlight",     {                                "format": "underline" })
call s:h("CocWarningFloat",         { "fg": s:orange, "bg": s:dark1                        })

call s:h("CocInfoSign",             { "fg": s:yellow, "bg": s:dark1                        })
call s:h("CocInfoHighlight",        {                                "format": "underline" })

call s:h("CocHintSign",             { "fg": s:grey2,  "bg": s:dark1                        })
call s:h("CocHintHighlight",        {                                "format": "underline" })

" Used by coc for unused variables
call s:h("Conceal",                 { "fg": s:grey3,                                       })

" Language highlight
" ------------------

" Java properties
call s:h("jpropertiesIdentifier",   { "fg": s:pink })

" Vim command
call s:h("vimCommand",              { "fg": s:pink })

" Javascript
call s:h("jsClassKeyword",      { "fg": s:aqua,   "format": "italic" })
call s:h("jsGlobalObjects",     { "fg": s:aqua,   "format": "italic" })
call s:h("jsFuncName",          { "fg": s:green                      })
call s:h("jsThis",              { "fg": s:orange, "format": "italic" })
call s:h("jsObjectKey",         { "fg": s:white1                     })
call s:h("jsFunctionKey",       { "fg": s:green                      })
call s:h("jsPrototype",         { "fg": s:aqua                       })
call s:h("jsExceptions",        { "fg": s:aqua                       })
call s:h("jsFutureKeys",        { "fg": s:aqua                       })
call s:h("jsBuiltins",          { "fg": s:aqua                       })
call s:h("jsStatic",            { "fg": s:aqua                       })
call s:h("jsSuper",             { "fg": s:orange, "format": "italic" })
call s:h("jsFuncArgRest",       { "fg": s:purple, "format": "italic" })                                 
call s:h("jsFuncArgs",          { "fg": s:orange, "format": "italic" })
call s:h("jsStorageClass",      { "fg": s:aqua,   "format": "italic" })
call s:h("jsDocTags",           { "fg": s:aqua,   "format": "italic" })
call s:h("jsFunction",          { "fg": s:aqua,   "format": "italic" })

" Typescript
call s:h("typescriptBraces",              { "fg": s:white1                     })
call s:h("typescriptParens",              { "fg": s:white1                     })
call s:h("typescriptOperator",            { "fg": s:pink                       })
call s:h("typescriptEndColons",           { "fg": s:white1                     })
call s:h("typescriptModule",              { "fg": s:aqua                       })
call s:h("typescriptPredefinedType",      { "fg": s:aqua                       })
call s:h("typescriptImport",              { "fg": s:pink                       })
call s:h("typescriptExport",              { "fg": s:pink                       })
call s:h("typescriptIdentifier",          { "fg": s:orange, "format": "italic" })
call s:h("typescriptVariable",            { "fg": s:aqua                       })
call s:h("typescriptCastKeyword",         { "fg": s:pink                       })
call s:h("typescriptAmbientDeclaration",  { "fg": s:pink                       })
call s:h("typescriptTestGlobal",          { "fg": s:pink                       })
call s:h("typescriptFuncKeyword",         { "fg": s:aqua                       })
call s:h("typescriptFuncTypeArrow",       { "fg": s:aqua                       })
call s:h("typescriptFuncType",            { "fg": s:orange, "format": "italic" })
call s:h("typescriptFuncName",            { "fg": s:green                      })
call s:h("typescriptArrowFuncArg",        { "fg": s:orange, "format": "italic" })
call s:h("typescriptCall",                { "fg": s:orange, "format": "italic" })
call s:h("typescriptClassKeyword",        { "fg": s:aqua,   "format": "italic" })
call s:h("typescriptClassName",           { "fg": s:white1                     })
call s:h("typescriptClassHeritage",       { "fg": s:white1                     })
call s:h("typescriptInterfaceKeyword",    { "fg": s:aqua,   "format": "italic" })
call s:h("typescriptInterfaceName",       { "fg": s:white1                     })
call s:h("typescriptObjectLabel",         { "fg": s:green                      })
call s:h("typescriptMember",              { "fg": s:green                      })
call s:h("typescriptTypeReference",       { "fg": s:purple, "format": "italic" })
call s:h("typescriptTypeParameter",       { "fg": s:purple, "format": "italic" })
call s:h("typescriptOptionalMark",        { "fg": s:pink                       })
call s:h("tsxAttrib",                     { "fg": s:green                      })
call s:h("tsxTagName",                    { "fg": s:pink                       })

" Dart
call s:h("dartStorageClass",    { "fg": s:pink   })
call s:h("dartExceptions",      { "fg": s:pink   })
call s:h("dartConditional",     { "fg": s:pink   })
call s:h("dartRepeat",          { "fg": s:pink   })
call s:h("dartTypedef",         { "fg": s:pink   })
call s:h("dartKeyword",         { "fg": s:pink   })
call s:h("dartConstant",        { "fg": s:purple })
call s:h("dartBoolean",         { "fg": s:purple })
call s:h("dartCoreType",        { "fg": s:aqua   })
call s:h("dartType",            { "fg": s:aqua   })
                                 
" HTML
call s:h("htmlTag",             { "fg": s:white1 })
call s:h("htmlEndTag",          { "fg": s:white1 })
call s:h("htmlTagName",         { "fg": s:pink   })
call s:h("htmlArg",             { "fg": s:green  })
call s:h("htmlSpecialChar",     { "fg": s:purple })

" XML
call s:h("xmlTag",              { "fg": s:pink   })
call s:h("xmlEndTag",           { "fg": s:pink   })
call s:h("xmlTagName",          { "fg": s:orange })
call s:h("xmlAttrib",           { "fg": s:green  })

" JSX
call s:h("jsxTag",              { "fg": s:white1 })
call s:h("jsxCloseTag",         { "fg": s:white1 })
call s:h("jsxCloseString",      { "fg": s:white1 })
call s:h("jsxPunct",            { "fg": s:white1 })
call s:h("jsxClosePunct",       { "fg": s:white1 })
call s:h("jsxTagName",          { "fg": s:pink   })
call s:h("jsxComponentName",    { "fg": s:pink   })
call s:h("jsxAttrib",           { "fg": s:green  })
call s:h("jsxEqual",            { "fg": s:white1 })
call s:h("jsxBraces",           { "fg": s:white1 })

" CSS
call s:h("cssProp",             { "fg": s:yellow })
call s:h("cssUIAttr",           { "fg": s:yellow })
call s:h("cssFunctionName",     { "fg": s:aqua   })
call s:h("cssColor",            { "fg": s:purple })
call s:h("cssPseudoClassId",    { "fg": s:purple })
call s:h("cssClassName",        { "fg": s:green  })
call s:h("cssValueLength",      { "fg": s:purple })
call s:h("cssCommonAttr",       { "fg": s:pink   })
call s:h("cssBraces" ,          { "fg": s:white1 })
call s:h("cssClassNameDot",     { "fg": s:pink   })
call s:h("cssURL",              { "fg": s:orange, "format": "underline,italic" })

" LESS
call s:h("lessVariable",        { "fg": s:green })

" SASS
call s:h("sassMixing",          { "fg": s:aqua  })
call s:h("sassMixin",           { "fg": s:aqua  })
call s:h("sassFunctionDecl",    { "fg": s:aqua  })
call s:h("sassReturn",          { "fg": s:aqua  })
call s:h("sassClass",           { "fg": s:green })
call s:h("sassClassChar",       { "fg": s:pink  })
call s:h("sassIdChar",          { "fg": s:pink  })
call s:h("sassControl",         { "fg": s:aqua  })
call s:h("sassFor",             { "fg": s:aqua  })

" ruby
call s:h("rubyInterpolationDelimiter",  {                })
call s:h("rubyInstanceVariable",        {                })
call s:h("rubyGlobalVariable",          {                })
call s:h("rubyClassVariable",           {                })
call s:h("rubyPseudoVariable",          {                })
call s:h("rubyFunction",                { "fg": s:green  })
call s:h("rubyStringDelimiter",         { "fg": s:yellow })
call s:h("rubyRegexp",                  { "fg": s:yellow })
call s:h("rubyRegexpDelimiter",         { "fg": s:yellow })
call s:h("rubySymbol",                  { "fg": s:purple })
call s:h("rubyEscape",                  { "fg": s:purple })
call s:h("rubyInclude",                 { "fg": s:pink   })
call s:h("rubyOperator",                { "fg": s:pink   })
call s:h("rubyControl",                 { "fg": s:pink   })
call s:h("rubyClass",                   { "fg": s:pink   })
call s:h("rubyDefine",                  { "fg": s:pink   })
call s:h("rubyException",               { "fg": s:pink   })
call s:h("rubyRailsARAssociationMethod",{ "fg": s:orange })
call s:h("rubyRailsARMethod",           { "fg": s:orange })
call s:h("rubyRailsRenderMethod",       { "fg": s:orange })
call s:h("rubyRailsMethod",             { "fg": s:orange })
call s:h("rubyConstant",                { "fg": s:aqua   })
call s:h("rubyBlockArgument",           { "fg": s:orange })
call s:h("rubyBlockParameter",          { "fg": s:orange })

" eruby
call s:h("erubyDelimiter",              {                })
call s:h("erubyRailsMethod",            { "fg": s:aqua   })

" c
call s:h("cLabel",                      { "fg": s:pink   })
call s:h("cStructure",                  { "fg": s:aqua   })
call s:h("cStorageClass",               { "fg": s:pink   })
call s:h("cInclude",                    { "fg": s:pink   })
call s:h("cDefine",                     { "fg": s:pink   })
call s:h("cSpecial",                    { "fg": s:purple })

" Markdown
call s:h("markdownCode",       { "fg": s:purple, "format": "italic" } )
call s:h("markdownListMarker", { "fg": s:purple                     } )

" vim-notes
call s:h("notesTitle",        { "fg": s:aqua,        "format": "bold"        } )
call s:h("notesAtxMarker",    { "fg": s:pink,        "format": "italic,bold" } )
call s:h("notesShortHeading", { "fg": s:white1,       "format": "bold"       } )
call s:h("notesListBullet",   { "fg": s:purple                               } )
call s:h("notesListNumber",   { "fg": s:purple,      "format": "italic"      } )
call s:h("notesBold",         {                      "format": "bold"        } )
call s:h("notesDoneMarker",   { "fg": s:green                                } )

" Terminal Colors
" ---------------
if has('nvim')
  let g:terminal_color_0  = s:dark1.gui
  let g:terminal_color_1  = s:red.gui
  let g:terminal_color_2  = s:green.gui
  let g:terminal_color_3  = s:yellow.gui
  let g:terminal_color_4  = s:aqua.gui
  let g:terminal_color_5  = s:purple.gui
  let g:terminal_color_6  = s:cyan.gui
  let g:terminal_color_7  = s:white1.gui
  let g:terminal_color_8  = s:darkgrey.gui
  let g:terminal_color_9  = s:pink.gui
  let g:terminal_color_10 = s:br_green.gui
  let g:terminal_color_11 = s:br_yellow.gui
  let g:terminal_color_12 = s:br_blue.gui
  let g:terminal_color_13 = s:br_purple.gui
  let g:terminal_color_14 = s:br_cyan.gui
  let g:terminal_color_15 = s:br_white.gui
else
  let g:terminal_ansi_colors = [
        \ s:dark1.gui,
        \ s:red.gui,
        \ s:green.gui,
        \ s:yellow.gui,
        \ s:aqua.gui,
        \ s:purple.gui,
        \ s:cyan.gui,
        \ s:white1.gui,
        \ s:darkgrey.gui,
        \ s:pink.gui,
        \ s:br_green.gui,
        \ s:br_yellow.gui,
        \ s:br_blue.gui,
        \ s:br_purple.gui,
        \ s:br_cyan.gui,
        \ s:br_white.gui]
endif
