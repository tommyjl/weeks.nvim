if exists('g:weeks_loaded')
  finish
endif
let g:weeks_loaded = 1

command! WeeksSummary lua require("weeks").summary()
