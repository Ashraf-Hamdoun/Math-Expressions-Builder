import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';

/// The root of the Math tree.
///
/// This class represents the main container for the Math expression and is
/// responsible for initiating the LaTeX string generation.
class MathTrunk extends MathNode {
  MathTrunk({
    required super.id,
    super.parent,
    super.updateParent = _defaultUpdateParent,
  });

  @override
  String get getType => METype.trunk.name;

  @override
  Expressions computeExpressions() {
    return Expressions(
        latex: "\\(${super.computeExpressions().latex}\\)",
        dart: super.computeExpressions().dart);
  }

  /// The default callback for child updates.
  static void _defaultUpdateParent(String childId, String childValue) {}
}
