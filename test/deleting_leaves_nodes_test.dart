import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should delete leaves correctly', () {
    final MathTree tree = MathTree();

    tree.addChildLeaf(METype.numberLeaf, '5');
    tree.addChildLeaf(METype.operatorLeaf, '+');
    tree.addChildLeaf(METype.numberLeaf, '9');
    tree.addChildLeaf(METype.numberLeaf, '0');

    expect(tree.toLaTeXString(), '\\(5+90|\\)');
    expect(tree.toMathString(), '(5+90)');

    tree.delete();

    expect(tree.toLaTeXString(), '\\(5+9|\\)');
    expect(tree.toMathString(), '(5+9)');

    tree.moveLeft();
    tree.delete();

    expect(tree.toLaTeXString(), '\\(5|9\\)');
    expect(tree.toMathString(), '(59)');

    tree.addChildLeaf(METype.operatorLeaf, '-');

    expect(tree.toLaTeXString(), '\\(5-|9\\)');
    expect(tree.toMathString(), '(5-9)');
  });

  test('should delete function node if it is empty', () {
    MathTree tree = MathTree();

    tree.addChildLeaf(METype.numberLeaf, '1');
    tree.addChildLeaf(METype.operatorLeaf, '-');
    tree.addChildNode(METype.functionNode, content: 'f');
    tree.addChildLeaf(METype.variableLeaf, 'x');

    expect(tree.toLaTeXString(), '\\(1-\\f(x|)\\)');
    expect(tree.toMathString(), '(1-(f(x)))');

    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString(), '\\(1-|\\)');
    expect(tree.toMathString(), '(1-)');
  });

  test('should delete fraction node if it is empty', () {
    final MathTree tree = MathTree();

    tree.addChildLeaf(METype.numberLeaf, '5');
    tree.addChildLeaf(METype.operatorLeaf, '+');
    tree.addChildNode(METype.fractionNode);
    tree.addChildLeaf(METype.numberLeaf, '9');
    tree.addChildLeaf(METype.numberLeaf, '0');

    expect(tree.toLaTeXString(), '\\(5+\\frac{90|}{\\square}\\)');
    expect(tree.toMathString(), '(5+((90) / ()))');

    tree.delete();
    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString(), '\\(5+|\\)');
    expect(tree.toMathString(), '(5+)');
  });

  test('should delete nth root node if it is empty', () {
    MathTree tree = MathTree();

    tree.addChildLeaf(METype.numberLeaf, '5');
    tree.addChildLeaf(METype.operatorLeaf, '+');
    tree.addChildNode(METype.nthRootNode);
    tree.addChildLeaf(METype.numberLeaf, '4');
    tree.moveRight();
    tree.addChildLeaf(METype.numberLeaf, '9');

    expect(tree.toLaTeXString(), '\\(5+\\sqrt[4]{9|}\\)');
    expect(tree.toMathString(), '(5+(pow((9), 1 / (4))))');

    tree.delete();
    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString(), '\\(5+|\\)');
    expect(tree.toMathString(), '(5+)');
  });
}
