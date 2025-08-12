import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  group("MathTree - Adding Elements", () {
    late MathTree tree;

    setUp(() {
      tree = MathTree();
    });

    test('should add leaves correctly', () {
      tree.addChildLeaf(METype.numberLeaf, "5");
      tree.addChildLeaf(METype.operatorLeaf, "+");
      tree.addChildLeaf(METype.numberLeaf, "1");
      tree.addChildLeaf(METype.specialSymbolLeaf, 'times');
      tree.addChildLeaf(METype.variableLeaf, 'f');
      expect(tree.toLaTeXString(), r'\(5+1\timesf|\)');
      expect(tree.toMathString(), '(5+1*f)');
    });

    test("should add function node correctly", () {
      tree.addChildLeaf(METype.numberLeaf, "1");
      tree.addChildLeaf(METype.operatorLeaf, "-");
      tree.addChildNode(METype.functionNode, content: 'sin');
      tree.addChildLeaf(METype.numberLeaf, "8");
      tree.addChildLeaf(METype.numberLeaf, "5");

      expect(tree.toLaTeXString(), r'\(1-\sin(85|)\)');
      expect(tree.toMathString(), '(1-(sin(85)))');
    });

    test("should add inversed function node correctly", () {
      tree.addChildLeaf(METype.numberLeaf, "1");
      tree.addChildLeaf(METype.operatorLeaf, "-");
      tree.addChildNode(METype.inverseFunctionNode, content: 'sin');
      tree.addChildLeaf(METype.numberLeaf, "8");
      tree.addChildLeaf(METype.numberLeaf, "5");

      expect(tree.toLaTeXString(), r'\(1-\sin^{-1}(85|)\)');
      expect(tree.toMathString(), '(1-(asin(85)))');
    });

    test("should add fraction node correctly", () {
      tree.addChildLeaf(METype.numberLeaf, "2");
      tree.addChildLeaf(METype.operatorLeaf, "+");
      tree.addChildNode(METype.fractionNode);
      tree.addChildLeaf(METype.numberLeaf, "8");

      expect(tree.toLaTeXString(), r'\(2+\frac{8|}{\square}\)');
      expect(tree.toMathString(), '(2+((8) / ()))');
    });

    test("should add square root node correctly", () {
      tree.addChildLeaf(METype.numberLeaf, "4");
      tree.addChildLeaf(METype.operatorLeaf, "-");
      tree.addChildNode(METype.squareRootNode);
      tree.addChildLeaf(METype.numberLeaf, "9");

      expect(tree.toLaTeXString(), r'\(4-\sqrt{9|}\)');
      expect(tree.toMathString(), '(4-(sqrt(9)))');
    });

    test("should add cube root node correctly", () {
      tree.addChildLeaf(METype.numberLeaf, "3");
      tree.addChildLeaf(METype.operatorLeaf, "-");
      tree.addChildNode(METype.cubeRootNode);
      tree.addChildLeaf(METype.numberLeaf, "8");

      expect(tree.toLaTeXString(), r'\(3-\sqrt[3]{8|}\)');
      expect(tree.toMathString(), '(3-(pow((8), 1/3)))');
    });

    test("should add nth root node correctly", () {
      tree.addChildLeaf(METype.numberLeaf, "5");
      tree.addChildLeaf(METype.operatorLeaf, "+");
      tree.addChildNode(METype.nthRootNode);
      tree.addChildLeaf(METype.numberLeaf, "4");

      expect(tree.toLaTeXString(), r'\(5+\sqrt[4|]{\square}\)');
      expect(tree.toMathString(), '(5+(pow((), 1 / (4))))');
    });

    test("should add power node correctly", () {
      tree.addChildLeaf(METype.numberLeaf, "7");
      tree.addChildNode(METype.powerNode);
      tree.addChildLeaf(METype.numberLeaf, "4");
      tree.addChildLeaf(METype.numberLeaf, "5");

      expect(tree.toLaTeXString(), r'\(7^{45|}\)');
      expect(tree.toMathString(), '(7.ofPow(45))');
    });

    test("should add summation node correctly", () {
      tree.addChildNode(METype.summationNode);
      tree.addChildLeaf(METype.variableLeaf, "n");
      tree.addChildLeaf(METype.operatorLeaf, "=");
      tree.addChildLeaf(METype.numberLeaf, "0");
      tree.moveUp();
      tree.addChildLeaf(METype.specialSymbolLeaf, "infty");
      tree.moveRight();
      tree.addChildLeaf(METype.textLeaf, "f(n)");

      expect(tree.toLaTeXString(), r'\(\sum_{n=0}^{\infty}\text{f(n)}|\)');
      expect(tree.toMathString(), '(summation((n=0), (infty), ( f(n) )))');
    });

    test("should add integral node correctly", () {
      tree.addChildNode(METype.integralNode);
      tree.addChildLeaf(METype.variableLeaf, "a");
      tree.moveUp();
      tree.addChildLeaf(METype.variableLeaf, "b");
      tree.moveRight();
      tree.addChildLeaf(METype.variableLeaf, "f");
      tree.addChildLeaf(METype.variableLeaf, "(");
      tree.addChildLeaf(METype.variableLeaf, "x");
      tree.addChildLeaf(METype.variableLeaf, ")");
      tree.addChildLeaf(METype.variableLeaf, "d");
      tree.addChildLeaf(METype.variableLeaf, "x");

      expect(tree.toLaTeXString(), r'\(\int_{a}^{b}f(x)dx|\)');
      expect(tree.toMathString(), '(integrate((a), (b), (f(x)dx)))');
    });
  });
}
