import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  group('MathTree - Deleting Elements', () {
    late MathTree tree;

    setUp(() {
      tree = MathTree();
    });

    test('should delete leaves correctly', () {
      tree.addChildLeaf(METype.numberLeaf, '5');
      tree.addChildLeaf(METype.operatorLeaf, '+');
      tree.addChildLeaf(METype.numberLeaf, '9');
      tree.addChildLeaf(METype.numberLeaf, '0');

      expect(tree.toLaTeXString(), r'\(5+90|\)');
      expect(tree.toMathString(), '(5+90)');

      tree.delete();

      expect(tree.toLaTeXString(), r'\(5+9|\)');
      expect(tree.toMathString(), '(5+9)');

      tree.moveLeft();
      tree.delete();

      expect(tree.toLaTeXString(), r'\(5|9\)');
      expect(tree.toMathString(), '(59)');

      tree.addChildLeaf(METype.operatorLeaf, '-');

      expect(tree.toLaTeXString(), r'\(5-|9\)');
      expect(tree.toMathString(), '(5-9)');
    });

    test('should delete function node if it is empty', () {
      tree.addChildLeaf(METype.numberLeaf, '1');
      tree.addChildLeaf(METype.operatorLeaf, '-');
      tree.addChildNode(METype.functionNode, content: 'f');
      tree.addChildLeaf(METype.variableLeaf, 'x');

      expect(tree.toLaTeXString(), r'\(1-\f(x|)\)');
      expect(tree.toMathString(), '(1-(f(x)))');

      tree.delete(); // Delete x
      tree.delete(); // Delete empty function node

      expect(tree.toLaTeXString(), r'\(1-|\)');
      expect(tree.toMathString(), '(1-)');
    });

    test('should delete fraction node if it is empty', () {
      tree.addChildLeaf(METype.numberLeaf, '5');
      tree.addChildLeaf(METype.operatorLeaf, '+');
      tree.addChildNode(METype.fractionNode);
      tree.addChildLeaf(METype.numberLeaf, '9');
      tree.addChildLeaf(METype.numberLeaf, '0');

      expect(tree.toLaTeXString(), r'\(5+\frac{90|}{\square}\)');
      expect(tree.toMathString(), '(5+((90) / ()))');

      tree.delete(); // Delete 0
      tree.delete(); // Delete 9
      tree.delete(); // Delete empty fraction node

      expect(tree.toLaTeXString(), r'\(5+|\)');
      expect(tree.toMathString(), '(5+)');
    });

    test('should delete nth root node if it is empty', () {
      tree.addChildLeaf(METype.numberLeaf, '5');
      tree.addChildLeaf(METype.operatorLeaf, '+');
      tree.addChildNode(METype.nthRootNode);
      tree.addChildLeaf(METype.numberLeaf, '4');
      tree.moveRight();
      tree.addChildLeaf(METype.numberLeaf, '9');

      expect(tree.toLaTeXString(), r'\(5+\sqrt[4]{9|}\)');
      expect(tree.toMathString(), '(5+(pow((9), 1 / (4))))');

      tree.delete(); // Delete 9
      // Move automaticaly to index of root
      tree.delete(); // Delete 4
      tree.delete(); // Delete empty nth root node

      expect(tree.toLaTeXString(), r'\(5+|\)');
      expect(tree.toMathString(), '(5+)');
    });

    test('should delete integral node if all its children are empty', () {
      tree.addChildLeaf(METype.numberLeaf, '1');
      tree.addChildLeaf(METype.operatorLeaf, '+');
      tree.addChildNode(METype.integralNode);

      expect(tree.toLaTeXString(), r'\(1+\int_{|}^{\square}\square\)');
      expect(tree.toMathString(), '(1+integrate((), (), ()))');

      // Move to upper limit and delete it (it's empty)
      tree.moveUp();
      tree.delete();
      // Move to integrand and delete it (it's empty)
      tree.moveRight();
      tree.delete();
      // Move to lower limit and delete it (it's empty)
      tree.moveLeft();
      tree.delete();

      // Now the integral node itself should be deleted
      expect(tree.toLaTeXString(), r'\(1+|\)');
      expect(tree.toMathString(), '(1+)');
    });

    test('should delete summation node if all its children are empty', () {
      tree.addChildLeaf(METype.numberLeaf, '1');
      tree.addChildLeaf(METype.operatorLeaf, '+');
      tree.addChildNode(METype.summationNode);

      expect(tree.toLaTeXString(), r'\(1+\sum_{|}^{\square}\square\)');
      expect(tree.toMathString(), '(1+summation((), (), ()))');

      // Move to upper limit and delete it (it's empty)
      tree.moveUp();
      tree.delete();
      // Move to summand and delete it (it's empty)
      tree.moveRight();
      tree.delete();
      // Move to lower limit and delete it (it's empty)
      tree.moveLeft();
      tree.delete();

      // Now the summation node itself should be deleted
      expect(tree.toLaTeXString(), r'\(1+|\)');
      expect(tree.toMathString(), '(1+)');
    });
  });
}
