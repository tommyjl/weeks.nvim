" Enable case-sensitivity
syn case match

syn match weeksDate /\d\{4\}-W\d\{2}-\d/
syn match weeksTime /\d\+.\?\d*h/
syn match weeksProject / \([a-zA-Z]\+:\?\)\+/
syn match weeksComment /\/\/.*/

hi def link weeksDate Statement
hi def link weeksTime Number
hi def link weeksProject Ignore
hi def link weeksComment Comment
