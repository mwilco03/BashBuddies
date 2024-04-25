# Bash

## Variables
- Variables must not have spaces around the equals sign.
  - `X="Hello World"`   ✔️
  - `X = "Hello World"` ❌
  - `X= "Hello World"`  ❌
  - `X ="Hello World"`  ❌
- Are invoked useing `$`
  - `echo $X`

## Syntax

### Types
- **Scalars**: Hold single values, either a string or a number.
- **Arrays**: Used to store multiple values.
  - **Indexed arrays**: `arr=(value1 value2 value3)`
  - **Associative arrays** (declare explicitly): `declare -A arr; arr[key]=value`
      - **Not honored in all flavors**
- **Strings**: Text data that can be manipulated.
- **Integers**: Used for arithmetic operations.

### Bash-isms
- `-` Represents STDOUT, returns output to the screen when used with commands like `echo`.
- `:` Used as a null command (no operation) but returns a zero exit status, helpful in scripts for syntax purposes.
- `[[]]` Enhances the traditional `[ ]` test command, allowing for more complex expressions and pattern matching.
- `$` Prefix for accessing the value of a variable.
- `/dev/<tcp|udp>/<HOST>/<PORT>` Used for creating TCP/UDP connections directly from the shell.
- `$()` Command substitution, runs the command inside the parentheses and substitutes its output.
- `history` Shows the command history list.
- `!!` Repeats the last command executed.
- `!#` Repeats a specific command from the command history.

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

- **`awk '!a[$0]++'`**: Remove duplicate lines, keeping the first occurrence.
  - **Use Case**: Similar to `uniq`, but works, and works on unsorted data.
  - **Example**:  
    - **Command**: `echo -e "apple\napple\nbanana" | awk '!a[$0]++'`
    - **Outputs**:
      - `apple`
      - `banana`

## File Manipulation
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
