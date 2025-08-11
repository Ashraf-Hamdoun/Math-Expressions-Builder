import 'package:math_expressions_builder/math_expressions_builder.dart';

/// A command-line application to demonstrate the capabilities of the
/// `math_expressions_builder` package.
///
/// This example builds the quadratic formula to showcase how easily complex,
/// nested expressions can be constructed.
void main(List<String> args) {
  print('--- Math Expressions Builder CLI Demonstration ---');

  // This example builds the quadratic formula: x = \frac{-b \pm \sqrt{b^2-4ac}}{2a}
  print('\nBuilding the Quadratic Formula:');

  final tree = MathTree();

  // Start with x =
  tree.addChildLeaf(METype.variableLeaf, 'x');
  tree.addChildLeaf(METype.operatorLeaf, '=');

  // Create the main fraction
  tree.addChildNode(METype.fractionNode);

  // --- Numerator: -b \pm \sqrt{b^2-4ac} ---
  tree.addChildLeaf(METype.operatorLeaf, '-');
  tree.addChildLeaf(METype.variableLeaf, 'b');
  tree.addChildLeaf(METype.specialSymbolLeaf, 'pm'); // \pm symbol
  tree.addChildNode(METype.squareRootNode);

  // Inside the square root: b^2-4ac
  tree.addChildLeaf(METype.variableLeaf, 'b');
  tree.addChildNode(METype.powerNode);
  tree.addChildLeaf(METype.numberLeaf, '2');
  tree.moveRight(); // Exit power
  tree.addChildLeaf(METype.operatorLeaf, '-');
  tree.addChildLeaf(METype.numberLeaf, '4');
  tree.addChildLeaf(METype.variableLeaf, 'a');
  tree.addChildLeaf(METype.variableLeaf, 'c');
  tree.moveRight(); // Exit square root

  // --- Denominator: 2a ---
  tree.moveDown();
  tree.addChildLeaf(METype.numberLeaf, '2');
  tree.addChildLeaf(METype.variableLeaf, 'a');

  // Print the final results
  print('\nLaTeX Output:');
  print('  ${tree.toLaTeXString()}');

  print('\nComputable Math String:');
  print('  ${tree.toMathString()}');

  print('\nDemonstration complete.');
}
