syn clear csUnspecifiedStatement
syn keyword csUnspecifiedStatement as base checked event fixed in is lock operator out params ref sizeof stackalloc this unchecked unsafe

syn keyword csMonogameType         ContentManager GameTime GraphicsDeviceManager SpriteBatch SpriteFont Texture2D
syn keyword csType                 Random
syn match   csMethod               /\.[A-Z]\w*[(<]/hs=s+1,he=e-1
syn match   csGenericType          /<\w\+>/hs=s+1,he=e-1

syn keyword csNewDecleration       new skipwhite nextgroup=csConstructor
syn match   csConstructor          /[A-Z]\w\+(/he=e-1 contained

syn match   csUsed   display /[A-Z].*;/ contained
syn match   csUsing  display /^\s*using/ skipwhite nextgroup=csUsed

hi  def link csNewDecleration            Statement
hi! def link csModifier                  Statement
hi  def link csUsing                     PreProc
hi  def link csUsed                      String
hi  def link csMonogameType              Type
hi  def link csGenericType               Type
hi  def link csConstructor               Function
hi  def link csMethod                    Function
