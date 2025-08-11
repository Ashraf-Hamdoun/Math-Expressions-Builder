import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/elements/math_tree.dart';

/// A controller to simplify adding common mathematical inputs to a [MathTree].
///
/// This class provides an intuitive, "button-press" like interface for building
/// expressions, abstracting away the underlying `METype` and content details.
/// It is ideal for creating UIs like on-screen calculators.
///
/// It also includes a listener pattern to notify consumers of changes to the
/// expression tree.
class MathInputController {
  final MathTree _mathTree;
  final List<void Function()> _listeners = [];

  /// Creates a controller that modifies the given [mathTree].
  MathInputController(this._mathTree);

  /// Adds a [listener] that will be called whenever the expression changes.
  void addListener(void Function() listener) {
    _listeners.add(listener);
  }

  /// Removes a previously added [listener].
  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  /// Notifies all registered listeners of a change.
  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// Adds the number 0 to the expression.
  void pressZero() {
    _mathTree.addChildLeaf(METype.numberLeaf, '0');
    _notifyListeners();
  }

  /// Adds the number 1 to the expression.
  void pressOne() {
    _mathTree.addChildLeaf(METype.numberLeaf, '1');
    _notifyListeners();
  }

  /// Adds the number 2 to the expression.
  void pressTwo() {
    _mathTree.addChildLeaf(METype.numberLeaf, '2');
    _notifyListeners();
  }

  /// Adds the number 3 to the expression.
  void pressThree() {
    _mathTree.addChildLeaf(METype.numberLeaf, '3');
    _notifyListeners();
  }

  /// Adds the number 4 to the expression.
  void pressFour() {
    _mathTree.addChildLeaf(METype.numberLeaf, '4');
    _notifyListeners();
  }

  /// Adds the number 5 to the expression.
  void pressFive() {
    _mathTree.addChildLeaf(METype.numberLeaf, '5');
    _notifyListeners();
  }

  /// Adds the number 6 to the expression.
  void pressSix() {
    _mathTree.addChildLeaf(METype.numberLeaf, '6');
    _notifyListeners();
  }

  /// Adds the number 7 to the expression.
  void pressSeven() {
    _mathTree.addChildLeaf(METype.numberLeaf, '7');
    _notifyListeners();
  }

  /// Adds the number 8 to the expression.
  void pressEight() {
    _mathTree.addChildLeaf(METype.numberLeaf, '8');
    _notifyListeners();
  }

  /// Adds the number 9 to the expression.
  void pressNine() {
    _mathTree.addChildLeaf(METype.numberLeaf, '9');
    _notifyListeners();
  }

  /// Adds a custom number string to the expression.
  void pressNumber(String number) {
    _mathTree.addChildLeaf(METype.numberLeaf, number);
    _notifyListeners();
  }

  /// Adds the addition operator (+) to the expression.
  void pressPlus() {
    _mathTree.addChildLeaf(METype.operatorLeaf, '+');
    _notifyListeners();
  }

  /// Adds the subtraction operator (-) to the expression.
  void pressMinus() {
    _mathTree.addChildLeaf(METype.operatorLeaf, '-');
    _notifyListeners();
  }

  /// Adds the multiplication operator (×) to the expression.
  void pressMultiply() {
    _mathTree.addChildLeaf(METype.specialSymbolLeaf, 'times');
    _notifyListeners();
  }

  /// Adds the division operator (÷) to the expression.
  void pressDivide() {
    _mathTree.addChildLeaf(METype.specialSymbolLeaf, 'div');
    _notifyListeners();
  }

  /// Adds a custom operator string to the expression.
  void pressOperator(String operator) {
    _mathTree.addChildLeaf(METype.operatorLeaf, operator);
    _notifyListeners();
  }

  /// Adds a fraction node to the expression.
  void pressFraction() {
    _mathTree.addChildNode(METype.fractionNode);
    _notifyListeners();
  }

  /// Adds a square root node to the expression.
  void pressSquareRoot() {
    _mathTree.addChildNode(METype.squareRootNode);
    _notifyListeners();
  }

  /// Adds a cube root node to the expression.
  void pressCubeRoot() {
    _mathTree.addChildNode(METype.cubeRootNode);
    _notifyListeners();
  }

  /// Adds an nth root node to the expression.
  void pressNthRoot() {
    _mathTree.addChildNode(METype.nthRootNode);
    _notifyListeners();
  }

  /// Adds a power node (superscript) to the expression.
  void pressPower() {
    _mathTree.addChildNode(METype.powerNode);
    _notifyListeners();
  }

  /// Adds an integral node to the expression.
  void pressIntegral() {
    _mathTree.addChildNode(METype.integralNode);
    _notifyListeners();
  }

  /// Adds a summation node to the expression.
  void pressSummation() {
    _mathTree.addChildNode(METype.summationNode);
    _notifyListeners();
  }

  /// Adds a function node (e.g., `sin`, `cos`) to the expression.
  void pressFunction(String functionName) {
    _mathTree.addChildNode(METype.functionNode, content: functionName);
    _notifyListeners();
  }

  /// Adds the sine function to the expression.
  void pressSine() => pressFunction('sin');

  /// Adds the cosine function to the expression.
  void pressCosine() => pressFunction('cos');

  /// Adds the tangent function to the expression.
  void pressTangent() => pressFunction('tan');

  /// Adds the natural logarithm (ln) function to the expression.
  void pressNaturalLog() => pressFunction('ln');

  /// Adds the base-10 logarithm (log) function to the expression.
  void pressLog() => pressFunction('log');

  /// Adds the inverse sine function to the expression.
  void pressInversedSine() => pressInverseFunction('sin');

  /// Adds the inverse cosine function to the expression.
  void pressInversedCosine() => pressInverseFunction('cos');

  /// Adds the inverse tangent function to the expression.
  void pressInversedTangent() => pressInverseFunction('tan');

  /// Adds the symbol for Pi (π) to the expression.
  void pressPi() => pressSpecialSymbol('pi');

  /// Adds the symbol for Euler's number (e) to the expression.
  void pressEuler() => pressVariable('e');

  /// Adds a left parenthesis to the expression.
  void pressLeftParenthesis() => pressSymbol('(');

  /// Adds a right parenthesis to the expression.
  void pressRightParenthesis() => pressSymbol(')');

  /// Adds a left bracket to the expression.
  void pressLeftBracket() => pressSymbol('[');

  /// Adds a right bracket to the expression.
  void pressRightBracket() => pressSymbol(']');

  /// Adds a left brace to the expression.
  void pressLeftBrace() => pressSymbol('{');

  /// Adds a right brace to the expression.
  void pressRightBrace() => pressSymbol('}');

  /// Adds an inverse function node to the expression.
  void pressInverseFunction(String functionName) {
    _mathTree.addChildNode(METype.inverseFunctionNode, content: functionName);
    _notifyListeners();
  }

  /// Adds a variable leaf to the expression.
  void pressVariable(String variable) {
    _mathTree.addChildLeaf(METype.variableLeaf, variable);
    _notifyListeners();
  }

  /// Adds a symbol leaf to the expression.
  void pressSymbol(String symbol) {
    _mathTree.addChildLeaf(METype.symbolLeaf, symbol);
    _notifyListeners();
  }

  /// Adds a special symbol leaf (a LaTeX command) to the expression.
  void pressSpecialSymbol(String symbol) {
    _mathTree.addChildLeaf(METype.specialSymbolLeaf, symbol);
    _notifyListeners();
  }

  /// Adds a text leaf to the expression.
  void pressText(String text) {
    _mathTree.addChildLeaf(METype.textLeaf, text);
    _notifyListeners();
  }

  /// Moves the cursor up in the expression tree.
  void moveUp() {
    _mathTree.moveUp();
    _notifyListeners();
  }

  /// Moves the cursor down in the expression tree.
  void moveDown() {
    _mathTree.moveDown();
    _notifyListeners();
  }

  /// Moves the cursor left in the expression tree.
  void moveLeft() {
    _mathTree.moveLeft();
    _notifyListeners();
  }

  /// Moves the cursor right in the expression tree.
  void moveRight() {
    _mathTree.moveRight();
    _notifyListeners();
  }

  /// Deletes the element at the current cursor position.
  void pressDelete() {
    _mathTree.delete();
    _notifyListeners();
  }

  /// Clears the entire expression tree.
  void pressClear() {
    _mathTree.clear();
    _notifyListeners();
  }
}