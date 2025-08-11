import 'package:math_expressions_builder/math_expressions_builder.dart';

/// Demonstrates the core functionalities of the `math_expressions_builder` package.
///
/// This file showcases how to create, manipulate, and render mathematical
/// expressions programmatically, highlighting the package's key features in a
/// clear and professional manner.
void main() {
  print('--- Math Expressions Builder Examples ---');

  // Example 1: Building a simple expression using the core MathTree.
  buildSimpleExpression();

  // Example 2: Using the MathInputController for a more intuitive,
  // "button-press" like experience, ideal for UIs.
  useMathInputController();

  // Example 3: Constructing a fraction and demonstrating cursor navigation
  // between its numerator and denominator.
  buildAndNavigateFraction();

  // Example 4: Building a complex expression with nested elements to
  // showcase the power and reliability of the tree-based structure.
  buildComplexExpression();

  // Example 5: Creating a definite integral with upper and lower bounds.
  buildIntegral();

  // Example 6: Creating a summation with a defined range.
  buildSummation();
}

/// Example 1: Builds a simple expression `1 + sqrt(9)`.
///
/// This demonstrates the basic `addChildLeaf` and `addChildNode` methods.
void buildSimpleExpression() {
  print('\n--- Example 1: Simple Expression ---');
  final tree = MathTree();

  // Build the expression: 1 + sqrt(9)
  tree.addChildLeaf(METype.numberLeaf, '1');
  tree.addChildLeaf(METype.operatorLeaf, '+');
  tree.addChildNode(METype.squareRootNode);
  tree.addChildLeaf(METype.numberLeaf, '9');

  // The `toLaTeXString` method generates a string for rendering.
  // The '|' character indicates the current cursor position.
  print('LaTeX Output: ${tree.toLaTeXString()}');

  // The `toMathString` method generates a string suitable for computation.
  print('Math Output:  ${tree.toMathString()}');
}

/// Example 2: Uses the `MathInputController` to build `1/2 + sqrt(16)`.
///
/// The controller provides a simplified, high-level API for building
/// expressions, which is perfect for creating on-screen keyboards or calculators.
void useMathInputController() {
  print('\n--- Example 2: Using MathInputController ---');
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
  print('Math Output:  ${tree.toMathString()}');
}

/// Example 3: Builds a fraction `2 + 8/5` and demonstrates cursor navigation.
///
/// This shows how the cursor intelligently moves into and out of different
/// parts of a node (e.g., from numerator to denominator).
void buildAndNavigateFraction() {
  print('\n--- Example 3: Building and Navigating a Fraction ---');
  final tree = MathTree();

  tree.addChildLeaf(METype.numberLeaf, '2');
  tree.addChildLeaf(METype.operatorLeaf, '+');
  print('Step 1:  ${tree.toLaTeXString()}'); // Output: \(2+|\)

  // Add a fraction; the cursor automatically moves to the numerator.
  tree.addChildNode(METype.fractionNode);
  print('Step 2:  ${tree.toLaTeXString()}'); // Output: \(2+\frac{|}{\square}\)

  // Populate the numerator.
  tree.addChildLeaf(METype.numberLeaf, '8');
  print('Step 3:  ${tree.toLaTeXString()}'); // Output: \(2+\frac{8|}{\square}\)

  // Move the cursor to the denominator.
  tree.moveDown();
  print('Step 4:  ${tree.toLaTeXString()}'); // Output: \(2+\frac{8}{|}\)

  // Populate the denominator.
  tree.addChildLeaf(METype.numberLeaf, '5');
  print('Step 5:  ${tree.toLaTeXString()}'); // Output: \(2+\frac{8}{5|}\)

  print('\nFinal LaTeX Output: ${tree.toLaTeXString()}');
  print('Final Math Output:  ${tree.toMathString()}');
}

/// Example 4: Builds a complex expression `f(x) = x^2 + (sqrt(y)/5)`.
///
/// This showcases how robustly the tree handles nested nodes like powers,
/// fractions, and roots, ensuring a syntactically correct result.
void buildComplexExpression() {
  print('\n--- Example 4: Complex Nested Expression ---');
  final tree = MathTree();

  // Build f(x) = x^2 + ...
  tree.addChildLeaf(METype.variableLeaf, 'f');
  tree.addChildLeaf(METype.symbolLeaf, '(');
  tree.addChildLeaf(METype.variableLeaf, 'x');
  tree.addChildLeaf(METype.symbolLeaf, ')');
  tree.addChildLeaf(METype.operatorLeaf, '=');
  tree.addChildLeaf(METype.variableLeaf, 'x');
  tree.addChildNode(METype.powerNode);
  tree.addChildLeaf(METype.numberLeaf, '2');
  tree.moveRight(); // Move out of the power
  tree.addChildLeaf(METype.operatorLeaf, '+');

  // Build the fraction ... (sqrt(y)/5)
  tree.addChildNode(METype.fractionNode);
  tree.addChildNode(METype.squareRootNode);
  tree.addChildLeaf(METype.variableLeaf, 'y');
  tree.moveRight(); // Move out of the square root
  tree.moveDown(); // Move to the denominator
  tree.addChildLeaf(METype.numberLeaf, '5');

  print('LaTeX Output: ${tree.toLaTeXString()}');
  print('Math Output:  ${tree.toMathString()}');
}

/// Example 5: Builds a definite integral `∫[a,b] x^2 sin(x) dx`.
///
/// Demonstrates the creation of specialized calculus structures.
void buildIntegral() {
  print('\n--- Example 5: Definite Integral ---');
  final tree = MathTree();

  // Create the integral node. Cursor starts in the lower limit.
  tree.addChildNode(METype.integralNode);

  // Lower limit: a
  tree.addChildLeaf(METype.variableLeaf, 'a');

  // Move to upper limit and add: b
  tree.moveUp();
  tree.addChildLeaf(METype.variableLeaf, 'b');

  // Move to the integrand
  tree.moveRight();
  tree.addChildLeaf(METype.variableLeaf, 'x');
  tree.addChildNode(METype.powerNode);
  tree.addChildLeaf(METype.numberLeaf, '2');
  tree.moveRight(); // Move out of power

  // Add sin(x)
  tree.addChildNode(METype.functionNode, content: 'sin');
  tree.addChildLeaf(METype.variableLeaf, 'x');
  tree.moveRight(); // Move out of sin()

  // Add dx
  tree.addChildLeaf(METype.specialSymbolLeaf, 'cdot');
  tree.addChildLeaf(METype.variableLeaf, 'd');
  tree.addChildLeaf(METype.variableLeaf, 'x');

  print('LaTeX Output: ${tree.toLaTeXString()}');
  print('Math Output:  ${tree.toMathString()}');
}

/// Example 6: Builds a summation `Σ[i=1, n] (2i+1)`.
///
/// Demonstrates another common calculus structure.
void buildSummation() {
  print('\n--- Example 6: Summation ---');
  final tree = MathTree();

  // Create the summation node. Cursor starts in the lower limit.
  tree.addChildNode(METype.summationNode);

  // Lower limit: i=1
  tree.addChildLeaf(METype.variableLeaf, 'i');
  tree.addChildLeaf(METype.operatorLeaf, '=');
  tree.addChildLeaf(METype.numberLeaf, '1');

  // Move to upper limit and add: n
  tree.moveUp();
  tree.addChildLeaf(METype.variableLeaf, 'n');

  // Move to the summand
  tree.moveRight();
  tree.addChildLeaf(METype.symbolLeaf, '(');
  tree.addChildLeaf(METype.numberLeaf, '2');
  tree.addChildLeaf(METype.variableLeaf, 'i');
  tree.addChildLeaf(METype.operatorLeaf, '+');
  tree.addChildLeaf(METype.numberLeaf, '1');
  tree.addChildLeaf(METype.symbolLeaf, ')');

  print('LaTeX Output: ${tree.toLaTeXString()}');
  print('Math Output:  ${tree.toMathString()}');
}
