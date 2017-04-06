# AP R Language Coding Standards

## Physical Structure

### Spacing

Indentation: 2 spaces

Use only spaces (soft tabs = spaces)

80 characters per line

Obey English language standards unless over-ruled by other standards

* Function calls should not have space between function name and left paren
    * *Exception*: 'if' should have a space

```
## Preferred:
if (x > 0) { y <- x + 2 }
## Okay:
if (x > 0) {y <- x + 2}


## Okay for simple conditions:
if (x > 0 && y > 0) { quadrant <- 1 }
## Okay:
if (
  x > 0 &&
  y > 0
) {
  quadrant <- 1
}
```
**Binary operators :** Include 1 space between operator and operand
```
## Good
a <- x
a + x
a / 3

## Bad
y/3
3- 2
1 +a
```
*Exception: *Exponents
```
## Okay
a / 3^x
```
*Exception*: Membership, Attribute operators indicating part-to whole relation
```
## Good
df$x
object@name
genericMethod.class

## Bad
df $ y
```
**Comments:**
See section on Comments standards

### Grouping Operators

**Quotes ( “, ' )**:

obey width standard, breaking strings with paste0

***Squigglies ( { , } ) **: *

* All code blocks get curly braces, even single lines.
    * Emphasize / demarcate code structure
    * adding a new line won't require dev to re-evaluate whether curly braces are there


```
## Good
get_inner_text_start_pos <- function(
  f_string,       # comment for f_string
  target_string,  # comment for target_string
  start_pos = 1
) {

  f_string_pos <- regexpr(
    f_string,
    substr(
      target_string,
      start_pos,
      nchar(
        target_string
      )
    )
  )

  string_start_pos <- f_string_pos[[1]] +  # start of f_string
    attr(f_string_pos, "match.length") +   # length of f_string
    1                                      # length of (

  return(string_start_pos + start_pos - 1) # returns -1 if f_string not found
}
```
Except when 1 parameter / 1 statement - can go in same line:
```
## GOOD
returnNull <- function(...) {
  return(NULL)
}

returnNull <- function(
  the_x_variable,
  the_y_variable
) {
  return(NULL)
}

## BAD:
returnNull <- function(
  the_x_variable,
  the_y_variable
) { return(NULL) }

## OKAY
returnNull <- function(...) { return(NULL) }

```
***Brackets ( [, ] ) :***
In one line if this obeys 80 char limit and element-wise comments not needed. Else, 1 index per line & obey Squiggly standards.
```
[x, y]
[x, ]
[, y]
```

***Parens ( (, ) ) :***
In one line if this obeys 80 char limit and element-wise comments not needed. Else, 1 index per line & obey Squiggly standards.

## Nomenclature

### Single Dots

Dots will be used to denote constancy (see function arguments and constants)

### Variables

Should be nouns

camelCase

### Files

end with .R

no spaces

no dots

start with letter

### Functions

Should be verbs

snake_case

### Function Arguments

Should be nouns
```
foo <- function(in.fooArgument_nv) {
  fooArgument_nv <- 2 * in.fooArgument_nv
}

*Exception: overwriting when memory is a concern*

foo <- function(in.fooArgument_nv) {
  ## overwriting fooArgumentIn_nv to save memory
  fooArgument_nv <- 2 * fooArgumentIn_nv
}
```
### Packages / Directories

camelCase

write with / not \

### Constants
Use `c.`:

```
c.pi_n
c.alphabet_vn
```
### Typing

Use a form of reverse hungarian notation with underscores
underscore +

* one character indicating {**d**ata **f**rame, **m**atrix, **l**ist, **v**ector, model **o**bject, or **s**ingle value} +

* one character indicating {**b**oolean, **i**nteger, **n**umeric, **c**haracter, comple**x**, **r**aw}

*Exceptions*:

Dataframes are _df with no type indicator, and their column names are treated as vector names (underscore + ‘v’ + type character).
Lists are _l, and otherwise treated as data frames (see above).
Examples:
```
foo_df <- data.frame(
    piDigits_vn = c(3, 1, 4, 1, 5, 9),

    eDigits_vn = c(2, 7, 1, 8, 2, 8),

    euclidLetters_vc = c(‘e’, ‘u’, ‘c’, ‘l’, ‘i’, ‘d’)
)
```


## Usage

### Functions

* Favor a functional style of programming minimizing the use of object oriented language features
* All execution paths should terminate in a “return” statement.
* Favor paste0 to paste for space-concatenated strings
* Use namespacing for foreign packages
* Pass function arguments by name, in order, wherever argument names exist. When they don't (e.g. '...'), still pass by order.
* Always use return when returning

```
## GOOD
returnTrue <- function(...) {
  return(TRUE)
}

## BAD
returnTRUE <- function(...) {
  TRUE
}
```

### Packages

Choice of package is an architectural problem. See architecture standards.

### Operators

* Use `=` only within function calls or where local assignment specifically required. Otherwise, use `<-`
* Do not use global assignment (`<<-) without commenting reasoning why
* Use appropriate form of `&` / `&&` and `|` / `||` : http://stackoverflow.com/questions/6558921/r-boolean-operators-and
* Use `^` not `pow()` (NOTE: `-1^2 = -(1^2) = -1`)
* If using non-standard operator, document source package

### Constants

* Use “TRUE” not “T”, etc.
* Use named constants when they exist in base R
* Define constants exactly

## Idioms

* Reserve print function in product code for debugging; use a forthcoming helper function to print and flush
* Warnings, Messages, and Errors should be provided via forthcoming print-flushing helper functions

### Object Naming

Models should obey variable naming standards
```
myLinearModel_o <- lm(
  formula = myFormula,
  data = myData
)
```

## Modularity

### Packages

### Functions

### Classes

### Scripts

### Language boundaries

### Apis

## Documentation

### Design - Math

### Design - Architecture

### Design - UX

### Comments

* Header comment should exist in every file to clarify whether new code should belong in this file

```
# I can still insert comments like this
# and it won't get picked up by rOxygen2
# or inserted into documentation

#' @param foo comment for foo
#' @param bar comment for bar
#' @author AP Coding Standard Police
f(
  foo,
  bar
)
```

* In-line comments should have min. 2 spaces between code and comment
* Comments pertaining to a single line of code should start on that line and may continue after:

```
getCapitalAlphabet() {
  return(
    upper(
      letters  # letters is lowercase
      # and ...
    )
  )
}
```
* A comment pertaining to multiple lines of code should start on its own line immediately above the lines of code.
* Commenting out code - use Rstudio default functionality - insert # followed by 1 space on each line

```
f(
  foo,
  bar
) {
  # why old code is commented out
#   Old code
  New code
}
```
* If intentionally sacrificing readability for correctness / performance, where practical, comment out more readable version and include above.
* Conserve old code when it contains valuable information

### End-User

* Translated strings are never used for anything other than user interface. In particular, they are not used to name or otherwise identify variables or states.

### Tooling

* Use roxygen2 tags: https://cran.r-project.org/web/packages/roxygen2/index.html

### Tech Debt

* intentional insertion of tech debt should be directly acknowledged and commented
```
### TECH DEBT               ###
### R environments are hard ###
f(...) {
  the.data <<- ...
}
```


### Coding Tooling

* lintr (Dylan will research)
* use standard rprofile.site file

### Encoding

Use UTF-8
