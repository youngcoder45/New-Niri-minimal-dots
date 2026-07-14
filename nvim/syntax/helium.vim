" Helium syntax file
" Author: Nykenik24

if exists("b:current_syntax")
  finish
endif

setlocal iskeyword=a-z,A-Z,_,48-57

syn keyword heliumKeyword
  \ fn mod struct record interface is new return const and or catch
  \ true false none if else for in do while switch default raise init
  \ enum variant alias use from export extern comp defer noop

syn keyword heliumType int float string bool char object void

syn match heliumInteger "\<\d\+\>"

syn match heliumFloat   "\<\d\+\.\d\+\>"

syn region heliumString start='"' end='"' skip='\\"' oneline

syn match heliumChar "'\\.'" 
syn match heliumChar "'[^']'"

syn match heliumComment "#.*$"

syn match heliumShortcut "\$[a-zA-Z_][a-zA-Z_0-9]*"

syn match heliumCall "\<[a-zA-Z_][a-zA-Z_0-9]*\ze\s*("

syn match heliumOperator "\.\.\."

syn match heliumOperator ":="   
syn match heliumOperator "+="   
syn match heliumOperator "-="  
syn match heliumOperator "\*=" 
syn match heliumOperator "/=" 
syn match heliumOperator "%=" 
syn match heliumOperator "==" 
syn match heliumOperator "!=" 
syn match heliumOperator ">=" 
syn match heliumOperator "<=" 
syn match heliumOperator "++"
syn match heliumOperator "--"
syn match heliumOperator "??"
syn match heliumOperator "=>" 

syn match heliumOperator "+"
syn match heliumOperator "-"
syn match heliumOperator "\*"
syn match heliumOperator "/"
syn match heliumOperator "%"
syn match heliumOperator "="
syn match heliumOperator ">"
syn match heliumOperator "<"
syn match heliumOperator "!"
syn match heliumOperator "?"
syn match heliumOperator "@"

syn match heliumPunct "[.,;:|()[\]{}]"

hi def link heliumKeyword   Keyword
hi def link heliumType      Type
hi def link heliumInteger   Number
hi def link heliumFloat     Float
hi def link heliumString    String
hi def link heliumChar      Character
hi def link heliumComment   Comment
hi def link heliumShortcut  Special
hi def link heliumCall      Function
hi def link heliumOperator  Operator
hi def link heliumPunct     Delimiter

let b:current_syntax = "helium"

