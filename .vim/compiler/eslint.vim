if exists("current_compiler")
  finish
endif
let current_compiler = "eslint"

CompilerSet makeprg=yarn\ run\ lint:js\ -f\ unix\ $*
