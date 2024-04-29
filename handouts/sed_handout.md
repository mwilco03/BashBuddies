# sed
---
## Syntax - a non-exhaustive overview

### REGEX ("regular expressions") in sed
#### some common symbols:
- **`^`**: denotes the beginning of something, or a position that precedes another.
- **`.`**: any printable character.
- **`*`**: zero or more of the preceding character(s).
- **`?`**: zero or one of the preceding character(s).
- **`$`**: denotes the end of something, or a position that follows another.
#### some common character-classes
- **`\s`**: a single space or tab (sometimes called "whitespace").
- **`\n`**: a single "newline" (a way of refering to the empty space between lines).
- **`\t`**: a single tab character.

---
### commandline options
- **`-i`**: edit files in place.
- **`-i<SUFFIX>`**: edit files in place after backing them up (creates a copy of <FILE> named <FILE><SUFFIX>).
- **`-n`**: only print where the pattern space is matched.

---
### command modes

#### i - insertion
- **`i<INPUT>`**: insert <INPUT> onto a new line above each line.
- **`<N>i<INPUT>`**: insert <INPUT> onto a new line above line number <N>.

#### d - delete
- **`^\s*$`**:  matches lines that begin with any amount of whitespace followed by end of line
```bash
## omit empty lines from output
sed '/^\s*$/d'

## delete empty lines from file
sed -i '/^\s*$/d' <FILE>
```

### s - search/substitution
- **`s/<a>/<b>/`**: replace first instance of <a> with <b>.
- **`<N>s/<a>/<b>/`**: replace <a> with <b> only on line <N>.

### g - global
- **`s/<a>/<b>/g`**: replace every occurence of <a> with <b>.

### p - print
- **`sed -n <A>,<B>p`**: combined with `-n` to selectively print a line or range of lines (<A> through <B>, for example).
```bash
# only print line number `${number}`
sed -n "${number}p" [<FILE>]

# only print lines `${first}` through `${last}`
sed -n "${first},${last}p" [<FILE>]
```

---
### daisy-chaining sed commands
#### seperator: semicolon
```bash
# replace <a> with <b> and then replace <c> with <d>:
sed 's/<a>/<b>/;s/<c>/<d>/'

# replace <a> with <b> and then replace <c> with <d> in >FILE>:
sed -i 's/<a>/<b>/;s/<c>/<d>/' <FILE>


# seperator: line-break
sed '
	s/replace-these/with-this/
	s/replace-these/with-this/
	...'
sed -i '
	s/replace-first-one-of/with-this/
	s/replace-every-one-of/with-this/g
	...
	' <FILE>
```


---
## NOTES
- **seperator**: if you need to use '/' characters in the regex search pattern, then use '|' as the field seperator.  for example: `'s|replace/this|with/this|'`
- **variables**: if you would like to use variables, wrap the command in " instead of ' .  for example: `"s/${1}/${2}/"`
- **specials**: some special characters must be braced in the search pattern portion of the command.  for example (to remove '\'): `'s/[\\]//'`


---
## misc/programmatic usage examples

#### housekeeping: a quick explanation of the bash-centric syntax used in the following examples
- **`"$*","${*}","$@","${@}"`**: the array of positional parameters, aka commandline arguments (for subtle differences, see: ["bash handout"](bash_handout.md))
- **`${!#}`**: a ["pointer"](bash_handout.md#pointers) to the final ["positional parameter"](bash_handout.md#positional%20parameters)
- **`${*:2}`**: all ["positional parameters"](bash_handout.md#positional%20parameters) starting from $2
- **`${*:2:$#-2}`**: every ["positional parameter"](bash_handout.md#positional%20parameters) except the first and last
- **`${*:1:$#-1}`**: every ["positional parameter"](bash_handout.md#positional%20parameters) other than the last

### inserting
#### dynamically insert into output streams
```bash
## insert $* onto a new line preceding every line
insert() { sed "i$*"; }
```
```bash
## insert $* onto a new line preceding every line except the last
insert() { sed "$!i$*"; }
```
```bash
## insert ${*:2} onto a new line preceding (thus becoming) line number $1
insert() { sed "${1}i${*:2}"; }

## insert ${*:1:$#-1} onto a new line preceding (thus becoming) line number ${!#}
insert() { sed "${!#}i${*:1:$#-1}"; }
```
#### dynamically insert into files
```bash
## insert ${*:2} onto a new line preceding every line in <FILE>( $1 )
insert() { sed -i "i${*:2}" "$1"; }

## insert ${*:1:$#-1} onto a new line preceding every line in <FILE>( ${!#} )
insert() { sed -i "i${*:1:$#-1}" "${!#}"; }
```
```bash
## insert ${*:3} onto a new line preceding (thus becoming) line number $2 in <FILE>( $1 ) 
insert() { sed -i "${2}i${*:3}" "$1"; }

## insert ${*:2:$#-2} onto a new line preceding (thus becoming) line number $1 in <FILE>( ${!#} )
insert() { sed -i "${1}i${*:2:$#-2}" "${!#}"; }
```

### prepending
#### dynamically prepend lines in output stream
```bash
## prepend every line with $*
prepend() { sed "s|^|$*"; }
```
```bash
## prepend every line except the first with $*
#prepend() { sed "^!s|^|$*"; }

## prepend every line except the last with $*
prepend() { sed "$!s|^|$*"; }
```
```bash
## prepend line number $1 with ${*:2}
prepend() { sed "${1}s|^|${*:2}"; }

## prepend line number ${!#} with ${*:1:$#-1}
prepend() { sed "${!#}s|^|${*:1:$#-1}"; }
```
#### dynamically prepend lines in files
```bash
## prepend every line in <FILE>( $1 ) with ${*:2}
prepend() { sed -i "s|^|${*:2}" "$1"; }

## prepend every line with ${*:1:$#-1} in <FILE>( ${!#} )
prepend() { sed -i "s|^|${*::$#-1}" "${!#}"; }
```
```bash
## prepend line number $1 in <FILE>( $2 ) with ${*:3}
prepend() { sed -i "${1}s|^|${*:3}" "$2"; }

## prepend line number $1 with ${*:2:$#-2} in <FILE>( ${!#} )
prepend() { sed -i "${1}s|^|${*:2:$#-2}" "${!#}"; }
```

### appending
#### dynamically append lines in output stream
```bash
## append $* to every line
append() { sed "s|$|$*"; }
```
```bash
## append $* to every line except the last
append() { sed "$!s|$|$*"; }
```
```bash
## append ${*:2} to line number $1
append() { sed "${1}s|$|${*:2}"; }

## append ${*:1:$#-1} to line number ${!#}
append() { sed "${!#}s|$|${*:1:$#-1}"; }
```
#### dynamically append lines in files
```bash
## append ${*:2} to every line in <FILE>( $1 )
append() { sed -i "s|$|${*:2}" "$1"; }

## append ${*:1:$#-1} to every line in <FILE>( ${!#} )
append() { sed -i "s|$|${*::$#-1}" "${!#}"; }
```
```bash
## append ${*:3} to line number $1 in <FILE>( $2 )
append() { sed -i "${1}s|$|${*:3}" "$2"; }

## append ${*:2:$#-2} to line number $1 in <FILE>( ${!#} )
append() { sed -i "${1}s|$|${*:2:$#-2}" "${!#}"; }
```

---
### misc csv & json
```bash
# prepend lines with double-quotes
sed 's/^/"/'
# append double-quotes to lines
sed 's/$/"/'

# prepend only the first line with a '['
sed '1s/^/[/'
# append ']' to the final line
sed '$s/$/]/'

# replace every instance of ((any amount of '"')(any amount of whitespace)(one or more ':')(any amount of whitespace)(any amount of '"'))  with  '": "'
sed 's|[\"]*\s*[\:]*[\:][\:]*\s*[\"]*|": "|g'

# replace every instance of (any amount of whitespace)(one or more ',')(any amount of whitespace)  with   ', '
sed 's|\s*[\,]\s*|, |g'

# append a comma to every line except the last
sed '$!s/$/,/'

```


---
## Conditional Logic
In `sed`, the stream editor, conditionals are not structured in the same way as in traditional programming languages like C or Python.
Instead, `sed` uses pattern matching, branching commands, and specific flags to control the flow of execution based on conditions.
Here’s a breakdown of how you can implement conditional logic in `sed`:

### 1. Pattern Matching
The most basic form of conditional in `sed` is direct pattern matching. Commands in `sed` can be prefixed with an address or a pattern, and the command will only execute if the input line matches the pattern.

For example, to delete lines containing the word "error":
```bash
sed '/error/d' file.txt
```

### 2. Branching with `b`, `t`, `T`
`sed` supports basic branching with the `b`, `t`, and `T` commands, which can be used to jump to labels based on conditions.

- **`b` (branch)**: Unconditionally jumps to a label. If no label is specified, it jumps to the end of the script, effectively skipping all remaining commands.
- **`t` (test)**: Branches to a label if the last `s///` (substitute) command made a substitution.
- **`T`**: The opposite of `t`; it branches to a label if the last `s///` command did not make a substitution.

#### Example of `t` and `T`
Here's an example where `t` is used to branch if a substitution is successful:
```bash
sed '/^#/d; s/old/new/; t label; :label; s/example/test/' file.txt
```
This script will delete lines starting with `#`, try to replace "old" with "new", and if the substitution is successful, it jumps to `label` where another substitution happens.

### 3. Using `n` and `N` for Conditional Execution
The `n` and `N` commands can also be part of conditional logic by controlling the flow of input lines into the pattern space.

- **`n`**: Reads the next line of input into the pattern space, replacing the current contents, and starts the next cycle of commands.
- **`N`**: Appends the next line of input to the pattern space along with a newline.

These can be used to conditionally process lines based on their content or order.

### 4. Complex Conditions with `{}` Blocks
You can group commands within `{}` to create more complex conditional blocks. This is useful when you want to execute multiple commands based on a single address or pattern match.

```bash
sed '/pattern/{
  s/find/replace/
  b
  :label
  s/find2/replace2/
}' file.txt
```
In this script, if a line matches `/pattern/`, `sed` performs a substitution, then unconditionally branches to the end of the script (skipping to the next input line), or to a label where another substitution is made.

### 5. Negating Conditions
You can negate a condition using `!`. For example, to execute a command on lines that do not match a pattern:
```bash
sed '/pattern/!d' file.txt
```
This deletes all lines that do not match `/pattern/`.

These examples illustrate the fundamental ways `sed` handles conditional logic, leveraging its pattern space, line addressing, and branching capabilities.
For more detailed information, you can refer to the [GNU Sed Manual](https://www.gnu.org/software/sed/manual/sed.html).

