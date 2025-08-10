# Math Expressions Builder

[![pub version](https://img.shields.io/pub/v/math_expressions_builder.svg)](https://pub.dev/packages/math_expressions_builder)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
![stability: stable](https://img.shields.io/badge/stability-stable-green.svg)

> **Status:** This package is considered **stable** and ready for production use.

## Programmatic LaTeX and Dart Math Expression Construction

`math_expressions_builder` is a powerful and intuitive Dart package for programmatically constructing, manipulating, and rendering complex mathematical expressions. It elevates your app beyond simple string concatenation by providing a sophisticated tree-based data model. This ensures that your expressions are always syntactically correct and semantically rich.

This package is ideal for educational apps, scientific calculators, dynamic formula editors, or any Dart/Flutter project that requires generating and managing intricate mathematical notation with precision and control.

## Why `math_expressions_builder`?

While you can build math expressions with string concatenation, it quickly becomes complex and error-prone, especially with nested elements like fractions, roots, and functions. `math_expressions_builder` solves this by representing each expression as a logical tree.

-   **Syntactic Correctness**: The tree structure ensures that expressions are always well-formed. You can't create an invalid state, like a fraction with no denominator.
-   **Easy Manipulation**: The built-in cursor allows you to navigate the expression and insert or delete elements at any point, just like in a real math editor.
-   **Complex Structures Made Simple**: Easily create deeply nested expressions that would be a nightmare to manage with strings.
-   **Dual Output**: Generate both render-ready LaTeX and a computable Dart-like string from the same expression tree.

## Key Capabilities

-   **🌳 Hierarchical Tree-Based Model**: Represents expressions as a logical tree of nodes (`FractionNode`, `IntegralNode`) and leaves (`NumberLeaf`, `OperatorLeaf`), allowing for robust management of complex formulas.
-   **✍️ Intelligent Cursor-Based Manipulation**: Features an advanced cursor for precise, programmatic navigation (`moveUp`, `moveDown`, `moveLeft`, `moveRight`) and targeted editing. The cursor intelligently moves into and out of nested elements.
-   **✨ Dual Expression Representation**:
    -   `toLaTeXString()`: Generates a beautiful, render-ready LaTeX string, compatible with any LaTeX rendering engine (like `flutter_math_fork`). It includes a `|` character to show the current cursor position.
    -   `toMathString()`: Generates a structured, Dart-like string representation (e.g., `(1+(sqrt(9)))`) suitable for computation, logging, or transformation into another format.
-   **🧮 Comprehensive LaTeX Element Support**: Out-of-the-box support for a wide array of math constructs, including:
    -   Fractions (`\frac{...}{...}`)
    -   Roots (Square `\sqrt{...}`, Cube `\sqrt[3]{...}`, Nth `\sqrt[n]{...}`)
    -   Powers and Superscripts (`^{...}`)
    -   Functions (`\sin(...)`, `\cos(...)`) and Inverse Functions (`\sin^{-1}(...)`)
    -   Integrals (`\int_{...}^{...}{...}`)
    -   Summations (`\sum_{...}^{...}{...}`)
    -   Standard operators, numbers, variables, and symbols.
-   **🚀 Pure Dart & Cross-Platform**: Developed entirely in Dart for seamless integration and consistent performance across mobile, web, and desktop.
-   **⚡️ Optimized for Performance**: Uses a dirty-checking mechanism to re-render only the modified parts of the expression, ensuring high performance in dynamic UIs.

## Visual Demonstration

![Package Demo](https://place-hold.it/700x400?text=Dynamic+LaTeX+Building+and+Cursor+Navigation)

*The above is a placeholder. Replace with a real GIF or screenshot to showcase dynamic LaTeX building and cursor navigation for best results.*

---

## Getting Started

Add `math_expressions_builder` to your `pubspec.yaml`:

```yaml
dependencies:
  math_expressions_builder: ^1.0.3 # Always use the latest stable version
```

Then, run `flutter pub get` or `dart pub get`.

Import the library in your Dart code:

```dart
import 'package:math_expressions_builder/math_expressions_builder.dart';
```

## Usage Example: `toLaTeXString` and `toMathString`

This example demonstrates how the same tree can produce two different outputs.

```dart
import 'package:math_expressions_builder/math_expressions_builder.dart';

void main() {
  final tree = MathTree();

  // Build the expression: 1 + sqrt(9)
  tree.addChildLeaf(METype.numberLeaf, "1");
  tree.addChildLeaf(METype.operatorLeaf, "+");
  tree.addChildNode(METype.squareRootNode);
  tree.addChildLeaf(METype.numberLeaf, "9");

  // Generate the LaTeX string for rendering
  final latexString = tree.toLaTeXString();
  print('LaTeX Output: $latexString');
  // Output: LaTeX Output: \(1+\sqrt{9|}\)

  // Generate the math string for computation or analysis
  final mathString = tree.toMathString();
  print('Math Output: $mathString');
  // Output: Math Output: (1+(sqrt(9)))
}
```

## In-Depth Example: Constructing a Fraction

This example shows how to build `2 + 8/5` and how the cursor moves intelligently.

```dart
final tree = MathTree();

tree.addChildLeaf(METype.numberLeaf, "2");
tree.addChildLeaf(METype.operatorLeaf, "+");
print(tree.toLaTeXString()); // Output: \(2+|\)

// Add a fraction node; cursor automatically moves to the numerator.
tree.addChildNode(METype.fractionNode);
print(tree.toLaTeXString()); // Output: \(2+\frac{|}{\square}\)

// Populate the numerator.
tree.addChildLeaf(METype.numberLeaf, "8");
print(tree.toLaTeXString()); // Output: \(2+\frac{8|}{\square}\)

// Move the cursor to the denominator.
tree.moveDown();
print(tree.toLaTeXString()); // Output: \(2+\frac{8}{|}\)

// Populate the denominator.
tree.addChildLeaf(METype.numberLeaf, "5");
print(tree.toLaTeXString()); // Output: \(2+\frac{8}{5|}\)
```

For more detailed examples, including integrals, summations, and the `MathInputController`, please see the file in `example/math_expressions_builder_example.dart`.

## API Reference

The API is designed for clarity and power.

-   **`MathTree`**: The main class for managing the expression.
    -   `toLaTeXString()`: Returns the render-ready LaTeX string.
    -   `toMathString()`: Returns the computable/parsable math string.
    -   `addChildLeaf(METype type, String content)`: Adds an atomic element (number, operator).
    -   `addChildNode(METype type, {String content = ""})`: Adds a structural element (fraction, root) and moves the cursor inside it.
    -   `moveUp()`, `moveDown()`, `moveLeft()`, `moveRight()`: Navigates the cursor through the expression tree.
    -   `delete()`: Removes the element to the left of the cursor.
    -   `clear()`: Resets the tree to an empty state.
-   **`MathInputController`**: A convenience wrapper around `MathTree` for a "calculator button" style of input.
    -   `pressOne()`, `pressPlus()`, `pressFraction()`, etc.
-   **`METype`**: An enum that defines all supported types of leaves and nodes, ensuring type safety.

## Advanced Topics

-   **Interactive UIs**: The cursor-based manipulation is perfect for building custom on-screen math keyboards in Flutter.
-   **Custom Rendering**: Pair the LaTeX output with any rendering engine, like [`flutter_math_fork`](https://pub.dev/packages/flutter_math_fork), to display the expressions.
-   **Extensibility**: The modular design allows you to extend the package with your own `MathNode` and `MathLeaf` subclasses for custom symbols or structures.

## Contributing

Contributions are welcome! If you find a bug, have a feature request, or want to contribute code, please check the [issue tracker](https://github.com/Ashraf-Hamdoun/Math-Expressions-Builder/issues) and consider opening a pull request.

## License

This package is distributed under the [MIT License](LICENSE).
