import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';

/// A node that represents a cube root.

class MathCubeRootNode extends MathNode {
  MathCubeRootNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  });

  @override
  String get getType => METype.cubeRootNode.name;

  @override
  Expressions computeExpressions() {
    return Expressions(
        latex: "\\sqrt[3]{${super.computeExpressions().latex}}",
        dart: "pow(${super.computeExpressions().dart}, 1/3)");
  }
}
