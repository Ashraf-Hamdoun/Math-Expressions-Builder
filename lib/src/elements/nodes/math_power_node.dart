import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';

/// A node that represents a power.

class MathPowerNode extends MathNode {
  MathPowerNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  });

  @override
  String get getType => METype.powerNode.name;

  @override
  Expressions computeExpressions() {
    return Expressions(
      latex: "^{${super.computeExpressions().latex}}",
      math: '.ofPow${super.computeExpressions().math}',
    );
  }
}
