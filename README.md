# Atlas

> A systems language, statically typed, strongly typed, and oriented towards transparency.

---

## Philosophy

This language is designed under a central principle:

> The compiler must not hide important costs or behaviors.

The user must be able to understand what is happening by reading the code, without needing to know hidden compiler rules. For this reason:

- Type conversions are explicit.
- Object copies are explicit.
- Memory references are explicit.
- Errors are explicit.
- Generic constraints are explicit.

The goal is to provide a simpler experience than Rust but safer and more expressive than C, with a compiler that can implement itself (_self-hosting_) naturally.

---

## Main Features

- Compiled (LLVM backend)
- Statically typed
- Strongly typed
- No _Garbage Collector_ (GC-free)
- Memory management via RAII
- Value semantics by default
- Generics with monomorphization
- Structural generic constraints (`where`)
- Error system based on `Result`
- Exhaustive _pattern matching_
- FFI with C
- Native modules per file
- Explicit _nullable_ pointers
- No inheritance
- Standard library implemented in the language itself

---

## Primitive Types

### Integers

```
int      // native CPU size
uint     // unsigned integer, native CPU size

int8     int16     int32     int64
uint8    uint16    uint32    uint64
```

### Reals

```
float    // 64 bits

float32
float64
```

### Others

```
bool
char
```

---

## Variables

Mutable variables are declared with `var` and immutable variables with `const`.

```
var x = 10;
const y = 20;
```

The type can be explicitly specified or inferred by the compiler. Both forms are equivalent:

```
var x: int32 = 10;
var x = 10;
```

When specified, the type goes after the variable name, separated by a colon:

```
var name: String = "example";
var count: uint32 = 0;
```

The keyword `const` applies to both local variables and class fields:

```
const MAX: uint32 = 1024;
```

---

## Operators

### Arithmetic

```
+    -    *    /    %
```

### Comparison

```
==    !=    <    >    <=    >=
```

### Booleans

The language accepts both the symbolic and textual forms, with identical meaning:

```
&&    ||    !       // symbolic form
and   or    not     // textual form
```

### Operator Overloading

Operators can be overloaded within classes, but **not** within structs. The compiler will not allow the use of an operator between two types unless an explicit definition exists for that combination.

```
class Vector {
    public x: float32;
    public y: float32;

    fn operator+(self, other: Vector): Vector {
        // ...
    }
}
```

---

## Expressions

Parentheses group expressions and are treated like any other expression, without special rules:

```
if (a > b) and (c > d) {
    // ...
}

var x = (a + b) * c;
```

---

## References and Pointers

To get the address of a variable, `@` is used:

```
var p = @x;
```

To dereference a pointer, `*` is used:

```
*p = 20;
```

The type of a pointer is also declared with `@`:

```
var p: @int32;
```

These two symbols represent opposite and complementary operations:
`@x` gets the address of a value; `*p` accesses the pointed value.

### Nullable Pointers

A pointer that can be `null` is declared by adding `?` to the type:

```
var file: @File?;
```

A pointer without `?` is always valid; the compiler does not allow it to be `null`:

```
var file: @File;
```

The compiler performs _flow analysis_: inside an `if` block that checks for non-nullability, the pointer is considered valid and no additional conversion is necessary:

```
if file != null {
    file.read();    // the compiler knows that file is not null here
}
```

Any operation on a nullable pointer outside of this type of check is a compilation error.

---

## Arrays

### Fixed-size Array

The size is part of the type. It is allocated in the memory location where it is declared (stack or inline):

```
var numbers: int[10];
```

### Slices

A slice is a view over existing memory. Internally it contains a pointer and a length, but it **is not** a dynamic array nor the owner of the memory:

```
[]int
```

Slices allow passing sequences of any size to functions without copying:

```
fn process(values: []int) {
    // ...
}
```

A function with a `[]int` parameter accepts an `int[10]`, an `int[100]`, or any `Array<int>` without copying.

### Dynamic Array

`Array<T>` is a class in the standard library that manages dynamic memory. It is not a primitive type of the compiler:

```
var tokens: Array<Token> = Array<Token>();
```

---

## Strings

`String` **is not a compiler type**. Text literals are represented internally as an array of `char`:

```
"Hola"    // internally: char[5]
```

The `String` class is defined entirely in the standard library. Conversion from a literal is performed automatically when the context requires it:

```
var s: String = "Hola";
```

The compiler translates this to `String::from("Hola")` without `String` being a special type. If you want to be explicit:

```
var s = String::from("Hola");
```

---

## Structs

Structs contain **data only**. They do not have methods, constructors, destructors, or visibility modifiers: all fields are always public.

```
struct Point {
    x: int;
    y: int;
}
```

### Initialization

Structs are initialized by specifying fields by name. The order does not matter:

```
var p = Point {
    x: 10,
    y: 20
};
```

With explicit type:

```
var p: Point = Point {
    x: 10,
    y: 20
};
```

### Copying

Structs are copied with `=`:

```
var a = Point { x: 1, y: 2 };
var b = a;    // copy
```

### Nesting

A struct can contain other structs, both at the module level, inside a class, or inside a function:

```
struct Position {
    x: int32;
    y: int32;
}

struct Entity {
    position: Position;
    health: int32;
}
```

Local structs inside a function:

```
fn parse() {
    struct ParseState {
        index: uint;
        depth: uint;
    }

    var state = ParseState { index: 0, depth: 0 };
    // ...
}
```

### Recursive Types

A struct **cannot contain itself** directly, as its size would be undefined. The compiler detects this case and generates an error. The solution is to use a pointer:

```
// ERROR: infinite size
struct Node {
    next: Node;
}

// Correct
struct Node {
    value: int;
    next: @Node?;
}
```

---

## Classes

Classes encapsulate **data and behavior**. Unlike structs, they have methods, visibility, and automatic lifetime management (RAII).

```
class File {
    private handle: int;

    fn init(path: String) {
        // constructor
    }

    fn read(self): []uint8 {
        // ...
    }

    fn destroy() {
        // destructor
    }
}
```

### Visibility

Class fields are **private by default**. To expose them, use `public`:

```
class Config {
    private version: uint32;
    public name: String;
}
```

A `const` field inside a class indicates that its value cannot change once initialized:

```
class Token {
    public const kind: TokenKind;
    public const lexeme: String;
}
```

### Constructor

The constructor is defined with the name `init`. When the user instantiates a class by writing `ClassName(args)`, the compiler automatically maps this call to `ClassName::init(args)`:

```
var f = File("test.txt");    // calls File::init("test.txt")
```

If no `init` is defined, the compiler generates a default one that initializes each field to its zero value.

### Destructor

The destructor is defined with `destroy()` and is executed automatically when the object goes out of scope. This guarantees that resources are released without manual intervention (RAII):

```
fn process() {
    var f = File("data.txt");
    // ... file usage ...
}   // f.destroy() is executed automatically here
```

If a class contains another class as a field, the field's destructor is executed automatically when the container is destroyed, in reverse order of declaration.
If no `destroy` is defined, the compiler generates a default one.

**Note:** The compiler explicitly **forbids** manually calling `.destroy()` on a class instance (e.g., `f.destroy()`) to prevent accidental double-free errors. The compiler guarantees memory safety by managing the destructor calls automatically.

### Instance Methods

An instance method has `self` as its first parameter. The compiler interprets it as a reference to the instance (`@ClassName`). Both forms are equivalent:

```
fn length(self): uint64 { ... }
fn length(self: @String): uint64 { ... }
```

If a method must explicitly work on a copy of the instance, this can be specified:

```
fn clone(self: String): String { ... }
```

### Type-associated Functions

A function inside a class **without** the `self` parameter is a type-associated function, equivalent to `static` in other languages. It is called with `::`:

```
class String {
    fn from(chars: char[]): String {
        // ...
    }
}

var s = String::from("Hola");
```

There is no `static` keyword. The presence or absence of `self` is the only criterion.

### Copying and Cloning

A class **cannot be copied with `=`**. Any attempt is a compilation error:

```
var a = File("a.txt");
var b = a;    // ERROR: 'File' cannot be copied
```

To make an explicit copy, the class must define a `clone()` method:

```
var b = a.clone();
```

To pass an instance to a function without making a copy of it, it is passed by reference:

```
fn process(file: @File) { ... }

process(@myFile);
```

### Classes and Nesting

In version 1, **classes inside classes are not allowed**. Structs inside classes are allowed:

```
class Parser {
    struct State {
        index: uint;
        depth: uint;
    }

    private state: State;
}
```

---

## Enums

Enums define a set of named integer constants:

```
enum Color {
    Red,
    Green,
    Blue
}
```

Internally, `Red = 0`, `Green = 1`, `Blue = 2`. Values are accessed with `::`:

```
var c: Color = Color::Red;
```

---

## Choices

Choices are sum types: a variable of this type can contain exactly one of the defined variants, each with its own associated data.

```
choice Token {
    Identifier(String),
    Number(int64),
    StringLiteral(String),
    EndOfFile
}
```

Unlike enums, variants can carry data of different types. A variant without parentheses does not contain data.

The `Result` type of the standard library is defined as a choice:

```
choice Result<T, E> {
    Ok(T),
    Error(E)
}
```

---

## Generics

The language supports generic programming via monomorphization: for each concrete type combination, the compiler generates specific code. There is no implicit boxing or casting.

```
class Array<T> {
    // ...
}

var tokens: Array<Token>;
var indices: Array<int32>;
```

### Constraints with `where`

To restrict which types can be used with a generic, the `where` block is used. Constraints are **structural**: the type does not need to declare any interface or trait; the compiler simply checks that the required signatures exist.

```
fn print<T>(value: T)
where T (
    fn format(self): String;
)
{
    // ...
}
```

With multiple generic parameters and multiple requirements for each:

```
fn sort<T, K>(values: []T, extractor: K)
where T (
    fn compare(self, other: T): int;
    fn format(self): String;
)
where K (
    fn extract(self, item: T): int;
)
{
    // ...
}
```

Each `where TypeName (...)` block groups the requirements of its generic parameter. If the passed type does not implement any of the required signatures, the compiler generates an error indicating exactly which signature is missing.

To satisfy a constraint, the class simply needs to define the corresponding methods:

```
class Person {
    public name: String;

    fn format(self): String {
        return self.name;
    }
}

print(Person { name: "Marc" });    // valid: Person has 'format'
```

There is no `implements` keyword, interface system, or registry: the compiler resolves it by direct inspection of the type.

---

## Error Management

Error handling is done with the `Result<T, E>` type of the standard library, defined as a choice. There are no exceptions.

A function that can fail returns `Result`:

```
fn open(path: String): Result<File, Error> {
    // ...
}
```

To handle the result explicitly, `match` is used:

```
match File::open("data.txt") {
    Ok(file) => {
        // file usage
    }
    Error(err) => {
        // error handling
    }
}
```

### The `?` Operator

The `?` operator propagates the error automatically: if the result is `Error`, the current function returns immediately with that error; if it is `Ok`, it extracts the inner value.

```
fn load(): Result<String, Error> {
    var file = File::open("data.txt")?;    // file is of type File, not Result
    var content = file.read()?;
    return Ok(content);
}
```

The `?` operator is **only valid inside functions that return `Result`**. Using it in a function with any other return type is a compilation error.

---

## Pattern Matching

`match` allows pattern matching on enums, choices, and values:

```
match token {
    Token::Identifier(name) => {
        // ...
    }
    Token::Number(value) => {
        // ...
    }
    Token::EndOfFile => {
        // ...
    }
    _ => {
        // default case
    }
}
```

`match` is **exhaustive**: if not all possible cases of an enum or choice are covered, and `_` is not included, the compiler generates an error. This guarantees that no cases are unhandled silently.

---

## Flow Control

### Conditionals

Conditions do not require parentheses, but accept them as normal expressions:

```
if x > 0 {
    // ...
} else if x == 0 {
    // ...
} else {
    // ...
}
```

With expressions in parentheses:

```
if (a > b) and (c > d) {
    // ...
}
```

### Loops

```
while condition {
    // ...
}
```

### Return

```
return value;
```

---

## Functions

```
fn add(a: int, b: int): int {
    return a + b;
}
```

The return type goes after the parameters, separated by a colon, consistently with variable and parameter type declarations. A function without a return value simply omits the type:

```
fn greet(name: String) {
    // ...
}
```

### Generic Functions

```
fn identity<T>(value: T): T {
    return value;
}
```

With constraints:

```
fn serialize<T>(value: T): []uint8
where T (
    fn serialize(self): []uint8;
)
{
    return value.serialize();
}
```

### Overloading

Function overloading **does not exist**. Each function within a scope must have a unique name. Functions associated with different types live in separate namespaces and do not conflict.

---

## Modules

Every file is automatically a module. No explicit declaration is needed.

```
// file: lexer.atl
// this file defines the 'lexer' module
```

### Importing

```
import lexer;
import parser;
import ast;
```

### Access

Accessing module elements is done with `::`, which acts as a namespace separator. This avoids ambiguity with the `.` member access operator for objects:

```
var t = lexer::Token;
var p = parser::Parser("source");
```

The `.` operator is for operations on instances; `::` is for namespaces and type-associated functions.

### Exporting

By default, module elements are not visible from the outside. To export them, `export` is used:

```
export class Lexer {
    private source: String;

    public fn tokenize(): Array<Token> {
        // ...
    }
}

export enum TokenKind {
    Identifier,
    Number,
    StringLiteral
}
```

The `export` keyword is independent of `public` and `private`: `export` controls visibility between modules; `public`/`private` controls visibility within a class.

---

## Type Conversion

### Primitive Types

Conversions between compatible primitive types (integers, reals, pointers) are done with the `cast<T>` intrinsic function:

```
var x: int32 = 10;
var y = cast<int64>(x);

var raw = cast<@uint8>(ptr);
var typed = cast<@Token>(raw);
```

### User-Defined Types

Semantic conversions between classes are defined as associated functions, conventionally named `from`:

```
class String {
    fn from(chars: char[]): String {
        // ...
    }
}

var s = String::from("Hola");
```

When the compiler needs to convert a `char[N]` literal to `String` to satisfy a type annotation, it automatically searches for the corresponding `from` function.

---

## Memory Management

### Stack by Default

Every variable is allocated in the memory location where it is declared. There is no implicit heap allocation:

```
var f = File("test.txt");    // lives on the stack
```

### Explicit Heap

To allocate on the heap, the `memory` module of the standard library is used. The compiler does not know about `malloc` or any allocator; everything lives in the stdlib:

```
import memory;

var node = memory::new<Node>();
```

Internally, `memory` uses `malloc` and `free` via FFI, but the user works with a higher-level API. Memory allocated on the heap is automatically freed when the object goes out of scope, thanks to RAII.

### RAII

The lifetime of objects is managed by scope. When a variable goes out of its scope, the destructor is executed automatically in reverse order of creation. This applies to both the stack and the heap.

There is no Garbage Collector, no manual `free`, and no ownership system like Rust's.

---

## FFI

To declare external functions in C, `extern "C"` is used:

```
extern "C" fn malloc(size: uint64): @void;
extern "C" fn free(ptr: @void);
extern "C" fn printf(format: @char, ...): int;
```

The string indicates the ABI. In future versions, support for other ABIs is planned (`"stdcall"`, `"SystemV"`, etc.).

---

## Build System

For small projects, no configuration is needed. Compiling a single file:

```
atlas build main.atl
```

For larger projects, an optional `package.atl` file at the root of the project is used:

```
name    = "compiler"
version = "0.1.0"
entry   = "src/main.atl"
```

With this file, it is enough to run:

```
atlas build
```

The compiler finds the entry point, resolves all `import` statements, and compiles the entire project.

### Compiler Backend

Atlas targets **LLVM 18** for native code generation. LLVM 18 is the required version for building the bootstrapping compiler (`atlas` v0.1).

Install LLVM 18 on your system before building:

```bash
# Debian / Ubuntu
sudo apt install llvm-18 clang-18 libpolly-18-dev

# macOS (Homebrew)
brew install llvm@18

# Arch Linux
sudo pacman -S llvm18 clang
```

The Rust bootstrapping compiler links against LLVM 18 via the `llvm-sys` crate (`llvm-sys = "180"`), which requires the `llvm-config-18` binary to be available on `PATH`. Once installed, building the compiler is a standard Cargo command:

```bash
cargo build --release
```

---

## Comments

```
// line comment

/*
    multi-line
    comment
*/
```

---

## Keyword Summary

| Keyword | Usage |
|---|---|
| `var` | mutable variable declaration |
| `const` | immutable variable or field declaration |
| `fn` | function declaration |
| `struct` | pure data type |
| `class` | type with data and behavior |
| `enum` | enumeration of integer constants |
| `choice` | sum type with variants and data |
| `match` | pattern matching |
| `if` / `else` | conditionals |
| `while` | loop |
| `return` | function return |
| `import` | module import |
| `export` | exporting elements of a module |
| `public` | public visibility of a class field |
| `private` | private visibility of a class field (default) |
| `where` | constraints on generic parameters |
| `and` / `or` / `not` | boolean operators in textual form |
| `extern` | external function declaration (FFI) |
| `self` | reference to the current instance in methods |
| `null` | absent value of a nullable pointer |

---

## Complete Example

The following snippet illustrates the main language constructs working together:

```
import io;
import memory;

enum TokenKind {
    Identifier,
    Number,
    EndOfFile
}

export struct Position {
    line: uint32;
    column: uint32;
}

export choice Result<T, E> {
    Ok(T),
    Error(E)
}

export class Token {
    public const kind: TokenKind;
    public const lexeme: String;
    public const position: Position;

    fn init(kind: TokenKind, lexeme: String, pos: Position) {
        self.kind = kind;
        self.lexeme = lexeme;
        self.position = pos;
    }

    fn format(self): String {
        return self.lexeme;
    }
}

export class Lexer {
    private source: String;
    private index: uint32;

    fn init(source: String) {
        self.source = source;
        self.index = 0;
    }

    fn next(self): Result<Token, String> {
        if self.index >= self.source.length() {
            var pos = Position { line: 0, column: self.index };
            return Ok(Token(TokenKind::EndOfFile, "", pos));
        }

        // ... lexer logic ...

        return Error("unexpected character");
    }
}

fn printToken<T>(value: T)
where T (
    fn format(self): String;
)
{
    io::println(value.format());
}

fn main(): int {
    var lexer = Lexer("var x = 10;");

    while true {
        var token = lexer.next()?;

        match token.kind {
            TokenKind::EndOfFile => {
                return 0;
            }
            _ => {
                printToken(token);
            }
        }
    }

    return 0;
}
```