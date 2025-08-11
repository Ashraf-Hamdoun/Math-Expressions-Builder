import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  group("Clear tree", () {
    test("should be cleared", () {
      final MathTree tree = MathTree();
      tree.addChildLeaf(METype.numberLeaf, "1");
      tree.addChildLeaf(METype.operatorLeaf, "-");
      tree.addChildNode(METype.functionNode, content: 'sin');
      tree.addChildLeaf(METype.numberLeaf, "8");
      tree.addChildLeaf(METype.numberLeaf, "5");

      expect(tree.toLaTeXString(), '\\(1-\\sin(85|)\\)');
      expect(tree.toMathString(), '(1-(sin(85)))');

      tree.clear();
      expect(tree.toLaTeXString(), "\\(|\\)");
      expect(tree.toMathString(), '()');
    });
  });
}
