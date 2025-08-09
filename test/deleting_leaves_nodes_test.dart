import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should delete leaves correctly', () {
    final MathTree tree = MathTree();

    tree.addChildLeaf(METype.numberLeaf, '5');
    tree.addChildLeaf(METype.operatorLeaf, '+');
    tree.addChildLeaf(METype.numberLeaf, '9');
    tree.addChildLeaf(METype.numberLeaf, '0');

    tree.delete();
    tree.moveLeft();
    tree.delete();

    tree.addChildLeaf(METype.operatorLeaf, '-');

    expect(tree.toLaTeXString(), equals('\\(5-|9\\)'));
  });

  test('should delete function node if it is empty', () {
    MathTree tree = MathTree();

    tree.addChildLeaf(METype.numberLeaf, '1');
    tree.addChildLeaf(METype.operatorLeaf, '-');
    tree.addChildNode(METype.functionNode, content: 'f');
    tree.addChildLeaf(METype.variableLeaf, 'x');

    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString(), equals('\\(1-|\\)'));
  });

  test('should delete fraction node if it is empty', () {
    final MathTree tree = MathTree();

    tree.addChildLeaf(METype.numberLeaf, '5');
    tree.addChildLeaf(METype.operatorLeaf, '+');
    tree.addChildNode(METype.fractionNode);
    tree.addChildLeaf(METype.numberLeaf, '9');
    tree.addChildLeaf(METype.numberLeaf, '0');

    tree.delete();
    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString(), equals('\\(5+|\\)'));
  });

  test('should delete nth root node if it is empty', () {
    MathTree tree = MathTree();

    tree.addChildLeaf(METype.numberLeaf, '5');
    tree.addChildLeaf(METype.operatorLeaf, '+');
    tree.addChildNode(METype.nthRootNode);
    tree.addChildLeaf(METype.numberLeaf, '4');
    tree.moveRight();
    tree.addChildLeaf(METype.numberLeaf, '9');

    tree.delete();
    tree.delete();
    tree.delete();

    expect(tree.toLaTeXString(), equals('\\(5+|\\)'));
  });
}
