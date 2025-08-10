import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  group("Movig between nodes", () {
    test("should move correctly", () {
      final MathTree tree = MathTree();

      tree.addChildLeaf(METype.numberLeaf, "4");
      tree.addChildLeaf(METype.operatorLeaf, "+");
      tree.addChildNode(METype.fractionNode);
      tree.addChildLeaf(METype.numberLeaf, "1");
      tree.addChildLeaf(METype.numberLeaf, "5");
      tree.addChildLeaf(METype.operatorLeaf, "-");
      tree.addChildNode(METype.squareRootNode);
      tree.addChildLeaf(METype.numberLeaf, "7");
      tree.moveDown();
      tree.addChildNode(METype.nthRootNode);
      tree.addChildLeaf(METype.numberLeaf, "9");
      tree.moveRight();
      tree.addChildNode(METype.fractionNode);
      tree.addChildLeaf(METype.numberLeaf, "3");
      tree.moveDown();
      tree.addChildLeaf(METype.numberLeaf, "8");
      tree.moveLeft();
      tree.moveLeft();

      expect(
        tree.toLaTeXString(),
        "\\(4+\\frac{15-\\sqrt{7}}{\\sqrt[9]{|\\frac{3}{8}}}\\)",
      );
      expect(
        tree.toMathString(),
        '(4+((15-(sqrt(7))) / ((pow((((3) / (8))), 1 / (9))))))',
      );
    });

    test('should leave and enter function node correctly', () {
      final MathTree tree = MathTree();

      tree.addChildLeaf(METype.numberLeaf, "4");
      tree.addChildLeaf(METype.operatorLeaf, "+");
      tree.addChildNode(METype.functionNode, content: "sin");
      tree.addChildLeaf(METype.variableLeaf, "x");

      expect(tree.toLaTeXString(), "\\(4+\\sin(x|)\\)");
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Leave the node
      tree.moveRight();
      expect(tree.toLaTeXString(), "\\(4+\\sin(x)|\\)");
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Enter the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), "\\(4+\\sin(x|)\\)");
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Moving throw leaves of the node.
      tree.moveLeft();
      expect(tree.toLaTeXString(), "\\(4+\\sin(|x)\\)");
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Leaving the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), "\\(4+|\\sin(x)\\)");
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Enter the node
      tree.moveRight();
      expect(tree.toLaTeXString(), "\\(4+\\sin(|x)\\)");
      expect(tree.toMathString(), '(4+(sin(x)))');
    });

    test('should leave and enter inverse function node correctly', () {
      final MathTree tree = MathTree();

      tree.addChildLeaf(METype.numberLeaf, "4");
      tree.addChildLeaf(METype.operatorLeaf, "+");
      tree.addChildNode(METype.inverseFunctionNode, content: "sin");
      tree.addChildLeaf(METype.variableLeaf, "x");

      expect(tree.toLaTeXString(), "\\(4+\\sin(x|)^{-1}\\)");
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Leave the node
      tree.moveRight();
      expect(tree.toLaTeXString(), "\\(4+\\sin(x)^{-1}|\\)");
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Enter the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), "\\(4+\\sin(x|)^{-1}\\)");
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Moving throw leaves of the node.
      tree.moveLeft();
      expect(tree.toLaTeXString(), "\\(4+\\sin(|x)^{-1}\\)");
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Leaving the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), "\\(4+|\\sin(x)^{-1}\\)");
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Enter the node
      tree.moveRight();
      expect(tree.toLaTeXString(), "\\(4+\\sin(|x)^{-1}\\)");
      expect(tree.toMathString(), '(4+(1 / sin(x)))');
    });

    test('should handle integral node correctly', () {
      final MathTree tree = MathTree();

      tree.addChildNode(METype.integralNode);
      tree.addChildLeaf(METype.numberLeaf, "0");
      tree.moveRight();
      tree.addChildLeaf(METype.textLeaf, "f(x)");

      expect(tree.toLaTeXString(), "\\(\\int_{0}^{\\square}\\text{f(x)}|\\)");
      expect(tree.toMathString(), '(integrate((0), (), ( f(x) )))');

      tree.moveLeft();
      expect(tree.toLaTeXString(), "\\(\\int_{0}^{\\square}|\\text{f(x)}\\)");
      expect(tree.toMathString(), '(integrate((0), (), ( f(x) )))');

      tree.moveLeft();
      tree.delete();
      tree.addChildLeaf(METype.variableLeaf, "a");
      expect(tree.toLaTeXString(), "\\(\\int_{a|}^{\\square}\\text{f(x)}\\)");
      expect(tree.toMathString(), '(integrate((a), (), ( f(x) )))');

      tree.moveUp();
      tree.addChildLeaf(METype.variableLeaf, "b");
      expect(tree.toLaTeXString(), "\\(\\int_{a}^{b|}\\text{f(x)}\\)");
      expect(tree.toMathString(), '(integrate((a), (b), ( f(x) )))');
    });
  });
}
