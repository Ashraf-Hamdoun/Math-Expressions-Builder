import 'package:math_expressions_builder/math_expressions_builder.dart';

void main(List<String> args) {
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

  print("result : ${tree.toLaTeXString}");
  // 4+\frac{15-\sqrt{7}}{\sqrt[9]{\frac{3}{8|}}}
}
