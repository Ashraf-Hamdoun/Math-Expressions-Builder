import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  group('MathInputController', () {
    test('should build a simple expression correctly', () {
      MathTree mathTree = MathTree();
      MathInputController controller = MathInputController(mathTree);

      controller.pressOne();
      controller.pressPlus();
      controller.pressEight();

      expect(mathTree.toLaTeXString(), '\\(1+8|\\)');
      expect(mathTree.toMathString(), '(1+8)');
    });
  });
}