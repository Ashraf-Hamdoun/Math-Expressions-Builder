import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/elements/math_tree.dart';

/// A controller to simplify adding common mathematical inputs to a MathTree.
///
/// This class provides a more intuitive, "button-press" like interface
/// for frequently used numbers, operators, and structural elements.
class MathInputController {
  final MathTree _mathTree;

  MathInputController(this._mathTree);

  /// Adds the number 0 to the expression.
  void pressZero() => _mathTree.addChildLeaf(METype.numberLeaf, "0");

  /// Adds the number 1 to the expression.
  void pressOne() => _mathTree.addChildLeaf(METype.numberLeaf, "1");

  /// Adds the number 2 to the expression.
  void pressTwo() => _mathTree.addChildLeaf(METype.numberLeaf, "2");

  /// Adds the number 3 to the expression.
  void pressThree() => _mathTree.addChildLeaf(METype.numberLeaf, "3");

  /// Adds the number 4 to the expression.
  void pressFour() => _mathTree.addChildLeaf(METype.numberLeaf, "4");

  /// Adds the number 5 to the expression.
  void pressFive() => _mathTree.addChildLeaf(METype.numberLeaf, "5");

  /// Adds the number 6 to the expression.
  void pressSix() => _mathTree.addChildLeaf(METype.numberLeaf, "6");

  /// Adds the number 7 to the expression.
  void pressSeven() => _mathTree.addChildLeaf(METype.numberLeaf, "7");

  /// Adds the number 8 to the expression.
  void pressEight() => _mathTree.addChildLeaf(METype.numberLeaf, "8");

  /// Adds the number 9 to the expression.
  void pressNine() => _mathTree.addChildLeaf(METype.numberLeaf, "9");

  /// Adds a custom number string to the expression.
  void pressNumber(String number) =>
      _mathTree.addChildLeaf(METype.numberLeaf, number);

  /// Adds the addition operator (+) to the expression.
  void pressPlus() => _mathTree.addChildLeaf(METype.operatorLeaf, "+");

  /// Adds the subtraction operator (-) to the expression.
  void pressMinus() => _mathTree.addChildLeaf(METype.operatorLeaf, "-");

  /// Adds the multiplication operator (*) to the expression.
  void pressMultiply() =>
      _mathTree.addChildLeaf(METype.specialSymbolLeaf, "times");

  /// Adds the division operator (/) to the expression.
  void pressDivide() => _mathTree.addChildLeaf(METype.specialSymbolLeaf, "div");

  /// Adds a custom operator string to the expression.
  void pressOperator(String operator) =>
      _mathTree.addChildLeaf(METype.operatorLeaf, operator);

  /// Adds a fraction node to the expression.
  void pressFraction() => _mathTree.addChildNode(METype.fractionNode);

  /// Adds a square root node to the expression.
  void pressSquareRoot() => _mathTree.addChildNode(METype.squareRootNode);

  /// Adds a cube root node to the expression.
  void pressCubeRoot() => _mathTree.addChildNode(METype.cubeRootNode);

  /// Adds an nth root node to the expression.
  void pressNthRoot() => _mathTree.addChildNode(METype.nthRootNode);

  /// Adds a power node to the expression.
  void pressPower() => _mathTree.addChildNode(METype.powerNode);

  /// Adds an integral node to the expression.
  void pressIntegral() => _mathTree.addChildNode(METype.integralNode);

  /// Adds a summation node to the expression.
  void pressSummation() => _mathTree.addChildNode(METype.summationNode);

  /// Adds a function node to the expression.
  void pressFunction(String functionName) =>
      _mathTree.addChildNode(METype.functionNode, content: functionName);

  /// Adds an inverse function node to the expression.
  void pressInverseFunction(String functionName) =>
      _mathTree.addChildNode(METype.inverseFunctionNode, content: functionName);

  /// Adds a variable leaf to the expression.
  void pressVariable(String variable) =>
      _mathTree.addChildLeaf(METype.variableLeaf, variable);

  /// Adds a symbol leaf to the expression.
  void pressSymbol(String symbol) =>
      _mathTree.addChildLeaf(METype.symbolLeaf, symbol);

  /// Adds a special symbol leaf to the expression.
  void pressSpecialSymbol(String symbol) =>
      _mathTree.addChildLeaf(METype.specialSymbolLeaf, symbol);

  /// Adds a text leaf to the expression.
  void pressText(String text) => _mathTree.addChildLeaf(METype.textLeaf, text);

  /// Moves the cursor up in the expression tree.
  void moveUp() => _mathTree.moveUp();

  /// Moves the cursor down in the expression tree.
  void moveDown() => _mathTree.moveDown();

  /// Moves the cursor left in the expression tree.
  void moveLeft() => _mathTree.moveLeft();

  /// Moves the cursor right in the expression tree.
  void moveRight() => _mathTree.moveRight();

  /// Deletes the element at the current cursor position.
  void pressDelete() => _mathTree.delete();

  /// Clears the entire expression tree.
  void pressClear() => _mathTree.clear();
}
