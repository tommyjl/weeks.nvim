# weeks.nvim

Adds support for a timetracking format using ISO week dates. The format uses
the file extension `.weeks`.

## Installation

[vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'tommyjl/weeks.nvim'
```

[packer](https://github.com/wbthomason/packer.nvim)

```lua
use 'tommyjl/weeks.nvim'
```

## Format

Each line is parsed independently. And can be either a `comment` or an `entry`.
Entries consist of a `week`, `time`, `project`, and an optional `comment`.

- week: is specified in the strptime-format "%G-W%V-%u"
- time: specified in hours---a number followed by the letter 'h'
- project: can be sectioned with colons
- comment: begins with `//`

### Example

You could have a file called 2021.weeks:

```weeks
// First week of the year!
2021-W01-1 3.0h employer:admin // Notes or description
2021-W01-1 4.5h employer:development
2021-W01-2 3.0h employer:admin
2021-W01-2 4.5h employer:development
2021-W01-3 7.5h employer:development
2021-W01-4 3.0h employer:admin
2021-W01-4 4.5h employer:development
2021-W01-5 7.5h employer:development
```

## See also

- https://en.wikipedia.org/wiki/ISO_week_date
