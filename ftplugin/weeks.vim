if exists('g:weeks_loaded')
  finish
endif
let g:weeks_loaded = 1

command! -nargs=? WeeksSummary lua require("weeks").summary("<args>")
