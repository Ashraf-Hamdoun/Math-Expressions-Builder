import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';

/// A node that represents a square root.

class MathSquareRootNode extends MathNode {
  MathSquareRootNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  });

  @override
  String get getType => METype.squareRootNode.name;

  @override
  Expressions computeExpressions() {
    return Expressions(
      latex: "\\sqrt{${super.computeExpressions().latex}}",
      math: "(sqrt${super.computeExpressions().math})",
    );
  }
}
