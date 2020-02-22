let g:airline_section_b =  ''

"Files percentage, lines, line
" let g:airline_section_z = '%3p%%%#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__#%3v'
let g:airline_section_z = airline#section#create(['%3p%%', 'linenr', 'maxlinenr'])
