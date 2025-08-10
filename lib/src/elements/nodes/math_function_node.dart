import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';

/// A node that represents a function.

class MathFunctionNode extends MathNode {
  final String function;
  MathFunctionNode({
    required super.id,
    required super.parent,
    required super.updateParent,
    required this.function,
  });

  @override
  String get getType => METype.functionNode.name;

  @override
  Expressions computeExpressions() {
    return Expressions(
      latex: "\\$function(${super.computeExpressions().latex})",
      math: "($function${super.computeExpressions().math})",
    );
  }
}
