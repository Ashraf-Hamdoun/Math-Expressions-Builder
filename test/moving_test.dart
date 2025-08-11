import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  group("MathTree - Moving Cursor", () {
    late MathTree tree;

    setUp(() {
      tree = MathTree();
    });

    test("should move correctly within a complex expression", () {
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
        r'\(4+\frac{15-\sqrt{7}}{\sqrt[9]{|\frac{3}{8}}}\)',
      );
      expect(
        tree.toMathString(),
        '(4+((15-(sqrt(7))) / ((pow((((3) / (8))), 1 / (9))))))',
      );
    });

    test('should leave and enter function node correctly', () {
      tree.addChildLeaf(METype.numberLeaf, "4");
      tree.addChildLeaf(METype.operatorLeaf, "+");
      tree.addChildNode(METype.functionNode, content: "sin");
      tree.addChildLeaf(METype.variableLeaf, "x");

      expect(tree.toLaTeXString(), r'\(4+\sin(x|)\)');
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Leave the node
      tree.moveRight();
      expect(tree.toLaTeXString(), r'\(4+\sin(x)|\)');
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Enter the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+\sin(x|)\)');
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Moving through leaves of the node.
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+\sin(|x)\)');
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Leaving the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+|\sin(x)\)');
      expect(tree.toMathString(), '(4+(sin(x)))');

      // Enter the node
      tree.moveRight();
      expect(tree.toLaTeXString(), r'\(4+\sin(|x)\)');
      expect(tree.toMathString(), '(4+(sin(x)))');
    });

    test('should leave and enter inverse function node correctly', () {
      tree.addChildLeaf(METype.numberLeaf, "4");
      tree.addChildLeaf(METype.operatorLeaf, "+");
      tree.addChildNode(METype.inverseFunctionNode, content: "sin");
      tree.addChildLeaf(METype.variableLeaf, "x");

      expect(tree.toLaTeXString(), r'\(4+\sin(x|)^{-1}\)');
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Leave the node
      tree.moveRight();
      expect(tree.toLaTeXString(), r'\(4+\sin(x)^{-1}|\)');
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Enter the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+\sin(x|)^{-1}\)');
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Moving through leaves of the node.
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+\sin(|x)^{-1}\)');
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Leaving the node
      tree.moveLeft();
      expect(tree.toLaTeXString(), r'\(4+|\sin(x)^{-1}\)');
      expect(tree.toMathString(), '(4+(1 / sin(x)))');

      // Enter the node
      tree.moveRight();
      expect(tree.toLaTeXString(), r'\(4+\sin(|x)^{-1}\)');
      expect(tree.toMathString(), '(4+(1 / sin(x)))');
    });

    test('should handle integral node movement correctly', () {
      tree.addChildNode(METype.integralNode);
      tree.addChildLeaf(METype.numberLeaf, "0");
      tree.moveRight();
      tree.addChildLeaf(METype.textLeaf, "f(x)");

      expect(tree.toLaTeXString(), r'\(\int_{0}^{\square}\text{f(x)}|\)');
      expect(tree.toMathString(), '(integrate((0), (), ( f(x) )))');

      tree.moveLeft(); // At the start of integrand
      tree.moveLeft(); // Move to lower limit
      expect(tree.toLaTeXString(), r'\(\int_{0|}^{\square}\text{f(x)}\)');
      expect(tree.toMathString(), '(integrate((0), (), ( f(x) )))');

      tree.moveUp(); // Move to upper limit
      tree.addChildLeaf(METype.numberLeaf, '1');
      expect(tree.toLaTeXString(), r'\(\int_{0}^{1|}\text{f(x)}\)');
      expect(tree.toMathString(), '(integrate((0), (1), ( f(x) )))');

      tree.moveDown(); // Move back to lower limit
      expect(tree.toLaTeXString(), r'\(\int_{0|}^{1}\text{f(x)}\)');
      expect(tree.toMathString(), '(integrate((0), (1), ( f(x) )))');

      tree.moveRight(); // Move to integrand
      expect(tree.toLaTeXString(), r'\(\int_{0}^{1}|\text{f(x)}\)');
      expect(tree.toMathString(), '(integrate((0), (1), ( f(x) )))');

      tree.moveRight(); // Move to the end of integral
      tree.moveRight(); // Move out of integral
      expect(tree.toLaTeXString(), r'\(\int_{0}^{1}\text{f(x)}|\)');
      expect(tree.toMathString(), '(integrate((0), (1), ( f(x) )))');
    });

    test('should handle summation node movement correctly', () {
      tree.addChildNode(METype.summationNode);
      tree.addChildLeaf(METype.variableLeaf, "i");
      tree.addChildLeaf(METype.operatorLeaf, "=");
      tree.addChildLeaf(METype.numberLeaf, "1");
      tree.moveUp();
      tree.addChildLeaf(METype.variableLeaf, "n");
      tree.moveRight();
      tree.addChildLeaf(METype.textLeaf, "f(i)");

      expect(tree.toLaTeXString(), r'\(\sum_{i=1}^{n}\text{f(i)}|\)');
      expect(tree.toMathString(), '(summation((i=1), (n), ( f(i) )))');

      tree.moveLeft(); // Move back to start of summand
      tree.moveLeft(); // Move to lower limit
      expect(tree.toLaTeXString(), r'\(\sum_{i=1|}^{n}\text{f(i)}\)');
      expect(tree.toMathString(), '(summation((i=1), (n), ( f(i) )))');

      tree.moveUp(); // Move to upper limit
      expect(tree.toLaTeXString(), r'\(\sum_{i=1}^{n|}\text{f(i)}\)');
      expect(tree.toMathString(), '(summation((i=1), (n), ( f(i) )))');

      tree.moveDown(); // Move back to lower limit
      expect(tree.toLaTeXString(), r'\(\sum_{i=1|}^{n}\text{f(i)}\)');
      expect(tree.toMathString(), '(summation((i=1), (n), ( f(i) )))');

      tree.moveRight(); // Move to summand
      expect(tree.toLaTeXString(), r'\(\sum_{i=1}^{n}|\text{f(i)}\)');
      expect(tree.toMathString(), '(summation((i=1), (n), ( f(i) )))');

      tree.moveRight(); // Move until the end of summand
      tree.moveRight(); // Move out of summation
      expect(tree.toLaTeXString(), r'\(\sum_{i=1}^{n}\text{f(i)}|\)');
      expect(tree.toMathString(), '(summation((i=1), (n), ( f(i) )))');
    });
  });
}
