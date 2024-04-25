# Bash

## Variables
- Must be touching
- `X="Hello World"` ✔️
- `X = "s"` ❌
- `X= "s" ` ❌
- `X ="s" ` ❌

## Commands
### type

### Socket

### Conditional Statements
#### if

### Loops
#### for loop
#### while loop

### Brace Expansion

# Binaries
### Text Processing and Filtering:
- **`awk`**: A powerful text processing and pattern scanning language.
  - **Common Flags**: `-F` (field separator), `-v` (variable assignment)
  - **Use Case**: Transforming text data, extracting columns, and complex filtering.
  - **Example**:
  - `cat key_val.csv | awk '{print $1}'`
  - `cat key_val.csv | awk '{printf "%04d %s\n", NR, $0}'`
  - `TOTAL=$(cat /var/log/dpkg.log | wc -l ); <br></br>
    cat /var/log/dpkg.log | awk -v total=$TOTAL '{printf "%0*d %s\n", length(total), NR, $0}`
- **`sed`**: Stream editor for filtering and transforming text.
  - **Common Flags**: `-i` (edit files in-place), `-e` (add script)
  - **Use Case**: Find and replace text within files.
  - **Example**:
  - `cat key_val.csv | sed 's/key/other_key/g'`
- **`tr`**: Translate or delete characters.
  - **Common Flags**: `-d` (delete characters), `-s` (squeeze repeated characters)
  - **Use Case**: Convert lowercase to uppercase, remove or replace characters.
  - **Example**:
  - `cat key_val.csv | tr "\t" " "`
- **`cut`**: Remove sections from each line of files.
  - **Common Flags**: `-f` (fields), `-d` (delimiter)
  - **Use Case**: Extract columns from text data.
  - **Example**:
  - `cat key_val.csv | cut -d"," -f1`
- **`grep`**: Search for patterns in text.
  - **Common Flags**: `-i` (ignore case), `-r` (recursive), `-E` (extended regex), `-v` (exclude)
  - **Use Case**: Search for text in files, highlighting matching lines.
  - **Example**:
  - `cat key_val.csv | grep important'`
  - `cat key_val.csv | grep -v unimportant'`
- **`uniq`**: Report or omit repeated lines.
  - **Common Flags**: `-c` (count), `-u` (unique)
  - **Use Case**: Finding or filtering out duplicate entries in a sorted file.
  - **Example**:
  - `cat key_val.csv | sort | uniq | sort`
- **`awk '!a[$0]++'`**: Remove duplicate lines, keeping the first occurrence.
  - **Use Case**: Similar to `uniq`, but works on unsorted data.
  - **Example**:
  - `cat key_val.csv | awk '!a[$0]++'`

### File Manipulation:
- **`cat`**: Concatenate and display files.
  - **Common Flags**: `-n` (number all output lines)
  - **Use Case**: Combine multiple files or display file contents.
  - **Example**: `cat key_val.csv`
- **`tac`**: Concatenate and print files in reverse.
  - **Use Case**: Display file contents starting from the last line.
  - **Example**: `tac key_val.csv`
- **`head`**: Output the first part of files.
  - **Common Flags**: `-n` (number of lines)
  - **Use Case**: View the beginning of a file.
  - **Example**: `head key_val.csv`
- **`tail`**: Output the last part of files.
  - **Common Flags**: `-n` (number of lines), `-f` (follow file growth)
  - **Use Case**: Monitor changes in file content dynamically.
  - **Example**: `tail key_val.csv`
- **`wc`**: Print newline, word, and byte counts for each file.
  - **Common Flags**: `-l` (lines), `-w` (words), `-c` (bytes)
  - **Use Case**: Count lines, words, or characters in a file. (How big is it?)
  - **Example**: `wc -l key_val.csv`
  - **Example**: `cat `

### Data Manipulation:
- **`seq`**: Print a sequence of numbers.
  - **Common Flags**: `-s` (separator), `-w` (equal width)
  - **Use Case**: Generate sequences of numbers for loops and lists.
- **`shuf`**: Generate random permutations.
  - **Common Flags**: `-n` (output count)
  - **Use Case**: Randomly shuffle lines in a file or list.
- **`sort`**: Sort lines of text files.
  - **Common Flags**: `-n` (numeric sort), `-r` (reverse), `-u` (unique)
  - **Use Case**: Sort data in files.

### Network Tools:
- **`curl`**: Transfer data from or to a server.
  - **Common Flags**: `-o` (output file), `-L` (follow redirects)
  - **Use Case**: Downloading files or querying web services.
- **`wget`**: Non-interactive network downloader.
  - **Common Flags**: `-r` (recursive), `-O` (output document)
  - **Use Case**: Downloading files from the internet.

### Search and Locate Commands:
- **`man`**: Interface to the system reference manuals.
  - **Use Case**: Accessing manual pages for other commands.
- **`which`**: Locate a command.
  - **Use Case**: Finding the full path of shell commands.
- **`locate`**: Find files by name.
  - **Use Case**: Quickly searching for files by name, using an indexed database.
- **`find`**: Search for files in a directory hierarchy.
  - **Common Flags**: `-name` (file name), `-type` (type of file), `-exec` (execute command)
  - **Use Case**: Finding files and performing actions on them.
- **`command`**: Perform a simple command or display information about commands.
  - **Use Case**: Check if a command exists and run it.

### Editors:
- **`nano`**: Easy to use command-line text editor.
  - **Use Case**: Editing files directly in the terminal.
- **`vi`**: Classic text editor with powerful features.
  - **Use Case**: Editing text files, programming, script editing.

### Advanced Text Searching:
- **`fzf`**: A command-line fuzzy finder.
  - **Use Case**: Search through complex lists and command histories quickly.
- **`zgrep`**: `grep` through compressed files.
  - **Use Case**: Searching inside compressed files without explicitly decompressing.

### Compressed File Viewing:
- **`zcat`**: Display compressed files.
  - **Use Case**: Viewing the contents of gzipped files without decompressing.
- **`lolcat`**: Display files in rainbow colors.
  - **Use Case**: Adding colorful text output for file contents.

