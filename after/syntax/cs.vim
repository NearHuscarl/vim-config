" csharp plugin
syn clear xmlTag
syn clear xmlError
syn clear xmlEndTag
syn clear csXmlTag

" csClass and csIface override csGenericType
syn clear csClass
syn clear csIface

" remove new keyword and redefine it
syn clear csUnspecifiedStatement
syn keyword csUnspecifiedStatement as base checked event fixed in is lock operator out params ref sizeof stackalloc this unchecked unsafe

syn match   csUsed   display /[A-Z].*;/ contained
syn match   csUsing  display /^\s*using/ skipwhite nextgroup=csUsed

syn keyword csNewDecleration       new skipwhite nextgroup=csConstructor
syn match   csConstructor          /\h\w*(/he=e-1 contained

syn keyword csMonogameType         ContentManager GameTime GraphicsDeviceManager SpriteBatch SpriteFont Texture2D Vector2
syn keyword csType                 Random
syn match   csGenericType          /\h\w*\(<\h\w*>\s\)\@=/
syn keyword csDelegate             Func Action

syn match   csMethod               /\h\w*(/he=e-1
syn match   csGenericMethod        /\h\w*\(<\h\w*>(\)\@=/
syn match   csGenericTypeParameter /<\h\w*>/hs=s+1,he=e-1

hi  def link csUsing                     PreProc
hi  def link csUsed                      String

hi  def link csNewDecleration            Statement
hi! def link csModifier                  Statement

hi  def link csMonogameType              Type
hi  def link csGenericType               Type
hi  def link csGenericTypeParameter      Type

hi  def link csConstructor               Function
hi  def link csMethod                    Function
hi  def link csGenericMethod             Function
hi  def link csDelegate                  Function
