# Code Plagiarism Detector

This project implements a code plagiarism detection algorithm. The algorithm works by tokenizing, fingerprinting, indexing, and reporting similarities among source code files. The algorithm uses k-grams and a rolling hash function for efficient comparison.

## How the Plagarism Detecion Algorithm Works

1. **Tokenization:**

   - Lexical Analysis: Lex is used to perform lexical analysis on the source code. Lexical analysis involves breaking the source code into tokens. In the compiler.l file, regular expressions define the patterns for various tokens, such as keywords, identifiers, and literals.
   - Syntax Analysis: Yacc is employed for syntax analysis. In the compiler.y file, the context-free grammar specifies the syntactic structure of the source code. Rules define how different elements in the code, such as statements and expressions, are parsed.

2. **Fingerprinting:**

   - To measure similarities between files, The algorithm finds common sequences of tokens using subsequences of fixed length called k-grams. These k-grams are hashed using a rolling hash function (similar to Rabin-Karp string matching algorithm). The selected hashes are stored as fingerprints.

3. **Indexing:**

   - The algorithm creates an index containing the fingerprints of all files. For each fingerprint encountered, it stores the file where the fingerprint was found.

4. **Reporting:**
   - The algorithm collects fingerprints occurring in more than one file and aggregates the results into a report. The report includes file pairs with at least one common fingerprint, along with metrics such as similarity and total overlap.

## Running Instructions

### How to run

1.  **Installation:**

    - Install the required dependencies:
      ```bash
      yacc, lex, python
      ```

2.  **Usage:**

    - Create compiler:

      ```bash
      yacc -d compiler.y && lex compiler.l && gcc y.tab.c lex.yy.c -ly -ll -o c_compiler
      ```

    - Compile a single c file:

      ```bash
      ./c_compiler test.c output.txt
      ```

    - Compile all c files in a folder (set the folder inside the bash file):

      ```bash
      chmod +x compile_all.sh
      ./compile_all.sh
      ```

    - Run the plagiarism detection algorithm by executing the following command (change the input folder inside the python file):
      ```bash
      python detector.py
      ```
    - The results will be written to the specified output file inside the python file.

## Project Structure

- `compiler.y`: Yacc file defining the syntax rules and actions.
- `compiler.l`: Lex file specifying the lexical analysis patterns.
- `compile_all.sh`: Shell script for compiling all C files and get the grammar.
- `lex.yy.c, y.tab.c, y.tab.h`: Generated files during Yacc and Lex compilation.
- `detector.py`: The main script implementing the plagarism detection algorithm.
- `c/`: Folder containing C source files for plagiarism detection.
- `output.txt`: Text file for storing the results of the plagiarism detection.

## Sample Output

```
- Files: /path/to/file1.c and /path/to/file2.c
  Similarity: 60.00%
  Total Overlap: 11
```
