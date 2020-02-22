call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '',
      \ 'selected_icon': '✓',
      \ })

call defx#custom#column('ident', {
      \ 'ident': '  ',
      \ })

call defx#custom#column('filename', {
      \ 'min_width': 40,
      \ 'max_width': 100,
      \ 'root_marker_highlight': 'Folded',
      \ })

call defx#custom#column('time', {
      \ 'format': '%Y %b %e %H:%M:%S',
      \ })

call defx#custom#option('_', {
      \ 'columns': 'git:mark:indent:icon:filename',
      \ 'split': 'no',
      \ 'buffer_name': 'defxplorer',
      \ 'show_ignored_files': 1,
      \ 'resume': 1,
      \ })
