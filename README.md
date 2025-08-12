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
-   **✨ Simplified Input with `MathInputController`**: Offers a convenient, "button-press" like interface for quickly building expressions, abstracting away the underlying `METype` and content details for common inputs.
-   **🚀 Pure Dart & Cross-Platform Compatibility**: Developed entirely in Dart, ensuring seamless integration and consistent performance across all Dart and Flutter supported platforms (Web, Mobile, Desktop).
-   **⚡️ Optimized Performance**: Employs a "dirty-checking" mechanism to intelligently recompute only the modified segments of the LaTeX string, minimizing overhead and ensuring efficient rendering, particularly for dynamic or frequently updated expressions.

## Visual Demonstration

Building the quadratic formula programmatically:

![Quadratic Formula Demo](https://latex.codecogs.com/svg.latex?x=\frac{-b\pm\sqrt{b^2-4ac}}{2a})

*The above image is a rendered output of the quadratic formula, which can be built using this package as shown in the `bin` and `example` directories.*

---

## Getting Started

Add `math_expressions_builder` to your `pubspec.yaml`:

```yaml
dependencies:
  math_expressions_builder: ^1.1.3 # Always use the latest stable version
```

Then, run `flutter pub get` or `dart pub get`.

Import the library in your Dart code:

```dart
import 'package:math_expressions_builder/math_expressions_builder.dart';
```

## Usage Example

This example demonstrates how the same `MathTree` can produce two different outputs: a render-ready LaTeX string and a computable math string.

```dart
import 'package:math_expressions_builder/math_expressions_builder.dart';

void main() {
  final tree = MathTree();

  // Build the expression: 1 + sqrt(9)
  tree.addChildLeaf(METype.numberLeaf, '1');
  tree.addChildLeaf(METype.operatorLeaf, '+');
  tree.addChildNode(METype.squareRootNode);
  tree.addChildLeaf(METype.numberLeaf, '9');

  // 1. Generate the LaTeX string for rendering.
  // The '|' character indicates the current cursor position.
  final latexString = tree.toLaTeXString();
  print('LaTeX Output: $latexString');
  // Output: LaTeX Output: \(1+\sqrt{9|}\)

  // 2. Generate the math string for computation or analysis.
  final mathString = tree.toMathString();
  print('Math Output:  $mathString');
  // Output: Math Output:  (1+(sqrt(9)))
}
```

### Simplified Input with `MathInputController`

The `MathInputController` provides a more intuitive, "button-press" like interface for building expressions. This is ideal for creating UIs like on-screen calculators.

```dart
import 'package:math_expressions_builder/math_expressions_builder.dart';

void main() {
  final tree = MathTree();
  final controller = MathInputController(tree);

  // Build the expression: 1/2 + sqrt(16)
  controller.pressFraction();
  controller.pressOne();
  controller.moveDown();
  controller.pressTwo();
  controller.moveRight(); // Move out of the fraction
  controller.pressPlus();
  controller.pressSquareRoot();
  controller.pressNumber('16');

  print('LaTeX Output: ${tree.toLaTeXString()}');
  // Output: LaTeX Output: \(\frac{1}{2}+\sqrt{16|}\)

  print('Math Output:  ${tree.toMathString()}');
  // Output: Math Output:  ( (1) / (2) + (sqrt(16)) )
}
```

### Constructing and Navigating a Fraction

This example shows how to build a fraction and how the cursor moves intelligently between its numerator and denominator.

```dart
final tree = MathTree();

tree.addChildLeaf(METype.numberLeaf, '2');
tree.addChildLeaf(METype.operatorLeaf, '+');
print('Step 1:  ${tree.toLaTeXString()}');
// Output: Step 1:  \(2+|\)

// Add a fraction; the cursor automatically moves to the numerator.
tree.addChildNode(METype.fractionNode);
print('Step 2:  ${tree.toLaTeXString()}');
// Output: Step 2:  \(2+\frac{|}{\square}\)

// Populate the numerator.
tree.addChildLeaf(METype.numberLeaf, '8');
print('Step 3:  ${tree.toLaTeXString()}');
// Output: Step 3:  \(2+\frac{8|}{\square}\)

// Move the cursor to the denominator.
tree.moveDown();
print('Step 4:  ${tree.toLaTeXString()}');
// Output: Step 4:  \(2+\frac{8}{|}\)

// Populate the denominator.
tree.addChildLeaf(METype.numberLeaf, '5');
print('Step 5:  ${tree.toLaTeXString()}');
// Output: Step 5:  \(2+\frac{8}{5|}\)
```

For more detailed examples, including integrals, summations, and the `MathInputController`, please see the file in `example/math_expressions_builder_example.dart`.

## API Reference

The API is designed for clarity and power.

-   **`MathTree`**: The central class for managing the LaTeX expression.
    -   `addChildLeaf(METype type, String content)`: Appends a new leaf element (e.g., number, operator, symbol) at the current cursor position.
    -   `addChildNode(METype type, {String content = ""})`: Inserts a new structural node (e.g., fraction, root, power) at the cursor. The cursor then automatically moves into the node's primary input field.
    -   `moveUp()`, `moveDown()`, `moveLeft()`, `moveRight()`: Navigates the cursor through the expression tree. These methods intelligently handle transitions between nested nodes.
    -   `delete()`: Removes the element or node immediately to the left of the cursor. Handles complex node deletions gracefully.
    -   `clear()`: Resets the entire expression tree to an empty state.
    -   `toLaTeXString()`: A method that returns the fully rendered LaTeX string of the current expression, including the cursor marker.
-   **`MathInputController`**: Provides a simplified interface for common input actions.
    -   `pressZero()` through `pressNine()`: Add single digit numbers.
    -   `pressNumber(String number)`: Add multi-digit numbers.
    -   `pressPlus()`, `pressMinus()`, `pressMultiply()`, `pressDivide()`: Add common operators.
    -   `pressOperator(String operator)`: Add custom operators.
    -   `pressFraction()`, `pressSquareRoot()`, `pressCubeRoot()`, `pressNthRoot()`, `pressPower()`, `pressIntegral()`, `pressSummation()`: Add structural nodes.
    -   `pressFunction(String functionName)`, `pressInverseFunction(String functionName)`: Add function nodes.
    -   `pressVariable(String variable)`, `pressSymbol(String symbol)`, `pressSpecialSymbol(String symbol)`, `pressText(String text)`: Add various leaf types.
    -   `moveUp()`, `moveDown()`, `moveLeft()`, `moveRight()`: Navigate the cursor.
    -   `pressDelete()`: Delete the element at the cursor.
    -   `pressClear()`: Clear the entire tree.
-   **`METype`**: An enumeration defining all supported types of LaTeX leaves and nodes, ensuring type-safe and explicit element creation.

## Advanced Topics

-   **Interactive UIs**: The cursor-based manipulation is perfect for building custom on-screen math keyboards in Flutter.
-   **Custom Rendering**: Pair the LaTeX output with any rendering engine, like [`flutter_math_fork`](https://pub.dev/packages/flutter_math_fork), to display the expressions.
-   **Extensibility**: The modular design allows you to extend the package with your own `MathNode` and `MathLeaf` subclasses for custom symbols or structures.

## Contributing

Contributions are welcome! If you find a bug, have a feature request, or want to contribute code, please check the [issue tracker](https://github.com/Ashraf-Hamdoun/Math-Expressions-Builder/issues) and consider opening a pull request.

## License

This package is distributed under the [MIT License](LICENSE).
