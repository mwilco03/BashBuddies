# Bash
## Points of consideration
- Case Sensitivity
- Shares aliases with PowerShell
  - ls curl man set sleep wget mkdir mv echo cat cd cp diff history pwd rm sort tee type
- **[man bash](http://man.he.net/?topic=bash&section=all)**
## Variables
- Variables must be touching assignment operator `=`.
  - `X="Hello World"   `✔️
  - `X = "Hello World" `❌
  - `X= "Hello World"  `❌
  - `X ="Hello World"  `❌
- Are invoked useing `$`
  - `echo $X`
  - `echo ${X}`

## Syntax
### Types
- **Scalars**: Hold single values, either a string or a number.
- **Arrays**: Used to store multiple values.
  - **Indexed arrays**: `arr=(value1 value2 value3)`
  - **Associative arrays** (declare explicitly): `declare -A arr; arr[key]=value`
- **Strings**: Text data that can be manipulated.
- **Integers**: Used for arithmetic operations.

### Bash-isms
- `|` Pass output of one command to another stringing them together.
- `&` Placed at the end of a command to send it to background.
- `-` Represents STDOUT, returns output to the screen when used with commands like `echo`.
- `>` Sends output to a file.
- `>>` Appends output to a file.
- `:` Used as a null command (no operation) but returns a zero exit status, helpful in scripts for syntax purposes.
- `[[]]` Enhances the traditional `[ ]` test command, allowing for more complex expressions and pattern matching.
- `$` Prefix for accessing the value of a variable.
- `/dev/<tcp|udp>/<HOST>/<PORT>` Used for creating TCP/UDP connections directly from the shell.
- `/dev/null` Anything sent here is thrown away.
- `$()` Command substitution, runs the command inside the parentheses and substitutes its output.
- `history` Shows the command history list.
- `!!` Repeats the last command executed.
- `!#` Repeats a specific command from the command history.
- `~/.bash_history` The default location for logging commands set by the `$HISTFILE` varible.
- ` ` By placing a space before your command it does not store that command to .bash_history
- `$HISTCONTROL` Varible controls which commands are stored in .bash_history (ignorespaces,ignoredups,both)
- `$HISTSIZE` Dictates the size (number of lines) of history to retain.
- `$HISTFILESIZE` Dictates the size in bytes of history to retain.
- `^FIND^REPLACE` Rerun the last command, finding and replacing the text.
- `.bash_profile` The code that is ran when you login. Useful to store functions and aliases.
 
### Conditional Statements
#### if
- **Syntax**: `if [ condition ]; then actions; fi`
- **Example**: `if [[ $X -gt 0 ]]; then echo "X is greater than zero"; fi`

### Loops
#### for loop
- **Syntax**: `for var in list; do actions; done`
- **Example**: `for i in {1..5}; do echo "Iteration $i"; done`

#### while loop
- **Syntax**: `while [ condition ]; do actions; done`
- **Example**: `while [[ $X -lt 10 ]]; do echo $X; X=$((X+1)); done`

### Brace Expansion
- **Example**: `echo {A..C}{1..3}`
- **Output**: `A1 A2 A3 B1 B2 B3 C1 C2 C3`

# Binaries

## Text Processing and Filtering
- **`awk`**: A powerful text processing and pattern scanning language.
  - **Common Flags**: `-F` (field separator), `-v` (variable assignment)
  - **Use Cases**: Transforming text data, extracting columns, and complex filtering.
  - **Examples**:
    - **Command**: `echo -e "name,age\nAlice,21\nBob,22" | awk -F',' '{print $2}'` 
    - **Outputs**:
      - `age`
      - `21`
      - `22`

- **`sed`**: Stream editor for filtering and transforming text.
  - **Common Flags**: `-i` (edit files in-place), `-e` (add script)
  - **Use Cases**: Find and replace text within files.
  - **Example**: 
    - **Command**: `echo "hello world" | sed 's/world/universe/'` **Outputs**: `hello universe`

- **`tr`**: Translate or delete characters.
  - **Common Flags**: `-d` (delete characters), `-s` (squeeze repeated characters)
  - **Use Cases**: Convert lowercase to uppercase, remove or replace characters.
  - **Example**: 
    - **Command**: `echo "hello" | tr '[:lower:]' '[:upper:]'`    **Outputs**: `HELLO`
    - **Command**: `echo "hello\tworld" | tr '\t' ' '`            **Outputs**: `hello world`
        
- **`cut`**: Remove sections from each line of files.
  - **Common Flags**: `-f` (fields), `-d` (delimiter)
  - **Use Cases**: Extract columns from text data.
  - **Example**:  
    - **Command**: `echo "name,age" | cut -d',' -f1` **Outputs**: `name`

- **`grep`**: Search for patterns in text.
  - **Common Flags**: `-i` (ignore case), `-r` (recursive), `-E` (extended regex), `-v` (exclude)
  - **Use Cases**: Search for text in files, highlighting matching lines.
  - **Examples**:
    - **Command**: `echo "hello" | grep 'Hello'`     **Outputs**: Nothing no match (case sensitivity)
    - **Command**: `echo "hello" | grep -i 'Hello'`  **Outputs**: `hello`
    - **Command**: `echo "hello" | grep -v 'ello'`   **Outputs**: Nothing excluded match
     
- **`uniq`**: Report or omit repeated lines.
  - **Common Flags**: `-c` (count), `-u` (unique)
  - **Use Cases**: Finding or filtering out duplicate entries in a sorted file.
  - **Example**: 
    - **Command**: `echo -e "apple\napple\nbanana" | sort | uniq | sort`
    - **Outputs**:
      - `apple`
      - `banana`
    - **Command**: `echo -e "apple\napple\nbanana\napple" | uniq`
    - **Outputs**:
      - `apple`
      - `banana`
      - `apple`

- **`awk '!a[$0]++'`**: Remove duplicate lines, keeping the first occurrence.
  - **Use Case**: Similar to `uniq`, but works, and works on unsorted data.
  - **Example**:  
    - **Command**: `echo -e "apple\napple\nbanana" | awk '!a[$0]++'`
    - **Outputs**:
      - `apple`
      - `banana`

## File Manipulation / Analysis
- **`cat`**: Concatenate and display files.
  - **Common Flags**: `-n` (number all output lines)
  - **Use Cases**: Combine multiple files or display file contents.
  - **Example**:  
    - **Command**: `cat file.txt` **Outputs**: Outputs the contents of `file.txt`

- **`tac`**: Concatenate and print files in reverse.
  - **Use Case**: Display file contents starting from the last line.
  - **Example**:  Outputs "line3", "line2", "line1".
    - **Command**: `echo -e "line1\nline2\nline3" | tac`
    - **Outputs**:
      - `line3`
      - `line2`
      - `line1`
  
- **`lolcat`**: Concatenate and print files rainbows and unicorns.
  - **Use Case**: Display file contents with color.
  - **Example**:  Outputs "line3", "line2", "line1".
    - **Command**: `echo -e "line1\nline2\nline3" | lolcat` **Outputs**: Smiles

- **`head`**: Output the first part of files.
  - **Common Flags**: `-n` (number of lines)
  - **Use Cases**: View the beginning of a file.
  - **Example**: `` Outputs "line1" and "line2".
    - **Command**: `echo -e "line1\nline2\nline3" | head -n 2`
    - **Outputs**:
      - `line1`
      - `line2`

- **`tail`**: Output the last part of files.
  - **Common Flags**: `-n` (number of lines), `-f` (follow file growth)
  - **Use Cases**: Monitor changes in file content dynamically.
  - **Example**: 
    - **Command**: `echo -e "line1\nline2\nline3" | tail -n 2`
    - **Outputs**:
      - `line2`
      - `line3`

- **`wc`**: Print newline, word, and byte counts for each file.
  - **Common Flags**: `-l` (lines), `-w` (words), `-c` (bytes)
  - **Use Cases**: Count lines, words, or characters in a file.
  - **Example**:  
    - **Command**: `echo "hello world" | wc -w`       **Outputs**: `2`
    - **Command**: `echo -e "hello\nworld" | wc -l`   **Outputs**: `2`
   
## Data Manipulation
### `seq`
- **Description**: Print a sequence of numbers.
- **Common Flags**: `-s` (separator), `-w` (equal width)
- **Use Case**: Generate sequences of numbers for loops and lists.
- **Example**:
  - **Command**: `seq 1 5`
  - **Output**:
    - `1`
    - `2`
    - `3`
    - `4`
    - `5`

### `shuf`
- **Description**: Generate random permutations.
- **Common Flags**: `-n` (output count)
- **Use Case**: Randomly shuffle lines in a file or list.
- **Example**:
  - **Command**: `echo -e "1\n2\n3" | shuf`
  - **Output**: Random order of `1`, `2`, and `3`

### `sort`
- **Description**: Sort lines of text files.
- **Common Flags**: `-n` (numeric sort), `-r` (reverse), `-u` (unique)
- **Use Case**: Sort data in files.
- **Example**:
  - **Command**: `echo -e "3\n1\n2" | sort`
  - **Output**:
    - `1`
    - `2`
    - `3`

## Network Tools
### `curl`
- **Description**: Transfer data from or to a server.
- **Common Flags**: `-o` (output file), `-L` (follow redirects), `-k` (ignore ssl error),
- **Common Flags**: `-s` (silent), `-f` (fail quietly), `-k` (ignore ssl error),
- **Common Flags**: `-H` (header), `-A` (user-agent), `-d` (data),
- **Use Case**: Downloading files or querying web services.
- **Example**:
  - **Command**: `curl -o example.html http://example.com`
  - **Output**: Downloads `example.com` into `example.html`.
  - **Command**: `curl -ksL http://example.com`
  - **Output**: Returns html content, follwoing links, ignoring certificate errors, no progress bar.

### `wget`
- **Description**: Non-interactive network downloader.
- **Common Flags**: `-r` (recursive), `-O` (output document)
- **Use Case**: Downloading files from the internet.
- **Example**:
  - **Command**: `wget -O example.html http://example.com`
  - **Output**: Downloads `example.com` into `example.html`

## Search and Locate Commands
### `man`
- **Description**: Interface to the system reference manuals.
- **Use Case**: Accessing manual pages for other commands.
- **Example**:
  - **Command**: `man ls` **Output**: Displays the manual page for the `ls` command.

### `which`
- **Description**: Locate a command.
- **Use Case**: Finding the full path of shell commands.
- **Example**:
  - **Command**: `which ls`
  - **Output**: `/bin/ls`

### `locate`
- **Description**: Find files by name. Must be used in conjunction with updatedb.
- **Use Case**: Quickly searching for files by name, using an indexed database.
- **Example**:
  - **Command**: `locate myfile.txt`
  - **Output**: Lists paths containing `myfile.txt`

### `find`
- **Description**: Search for files in a directory hierarchy.
- **Common Flags**: `-name` (file name), `-iname` (file case insensitivename),
- **Common Flags**: `-type` (type of file directory(d)/file(f)), `-or` (used when serching for multiples)
- **Common Flags**: `-exec` (execute command after finding file), `-and` (used when serching for multiples)
- **Use Case**: Finding files and performing actions on them.
- **Example**:
  - **Command**: `find /home -name "example.txt"` **Output**: `/home/user/example.txt`
  - **Command**: `find /home -iname "example.txt"` **Output**: `/home/user/Example.txt`
  - **Command**: `find /home -type d "ec2-user"` **Output**: `/home/user/ec2-user`

### `command`
- **Description**: Perform a simple command or display information about commands.
- **Use Case**: Check if a command exists and run it.
- **Example**:
  - **Command**: `command -v ls` **Output**: `/bin/ls`

## Advanced Text Searching
### `fzf`
- **Description**: A command-line fuzzy finder.
- **Use Case**: Search through complex lists and command histories quickly.
- **Example**:
  - **Command**: `echo -e "apple\nbanana\ncarrot" | fzf`
  - **Output**: Interactive search interface for list selection.

## Compressed File Viewing
### `zgrep`
- **Description**: `grep` through compressed files.
- **Use Case**: Searching inside compressed files without explicitly decompressing.
- **Example**:
  - **Command**: `zgrep "pattern" file.gz`
  - **Output**: Lines matching "pattern" in `file.gz`

### `zcat`
- **Description**: Display compressed files.
- **Use Case**: Viewing the contents of gzipped files without decompressing.
- **Example**:
  - **Command**: `zcat file.gz`
  - **Output**: Displays the contents of `file.gz`

## Editors
### `vi`
- **Description**: Classic text editor with powerful features.
- **Use Case**: Editing text files, programming, script editing, no quitting, no escape.
- **Example**:
  - **Command**: `vi file.txt`
  - **Output**: Opens `file.txt` in the `vi` editor.

### `nano`
- **Description**: Newer text editor with powerful features.
- **Use Case**: Editing text files, programming, script editing, intuitive.
- **Example**:
  - **Command**: `nano file.txt`
  - **Output**: Opens `file.txt` in the `nano` editor.

## Helpers
### `nohup`
- **Description**: Shorthand for no hang up means to continue running the command but return the shell.
- **Use Case**: Long running command will output to `nohup.out` can continue working in that shell.
- **Example**:
  - **Command**: `nohup echo "hello world"`
  - **Output**: `nohup: ignoring input and appending output to 'nohup.out'`
  - **Command**: `nohup echo "hello world" &`
  - **Output**: `nohup: ignoring input and appending output to 'nohup.out'`
 
### `tmux`
- **Description**: Shorthand for terminal multiplexer.
- **Use Case**: Long running command will output to a different terminal can split screen.
- **Example**:
  - **Command**: `tmux`
  - **Output**: Allows to split screen. (Browser functionality limited)

### `fg`
- **Description**: Shorthand for foreground.
- **Use Case**: Returns a backgrounded process to foreground.
- **Example**:
  - **Command**: `fg`
  - **Output**: Allows alllows backgrounded process to be presented.
