import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_leaf.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';

/// A leaf that represents a plain text string within a mathematical expression.
/// It wraps the text in a LaTeX `\text{...}` command.

class MathTextLeaf extends MathLeaf {
  MathTextLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => METype.textLeaf.name;

  @override
  Expressions computeExpressions() {
    // The child string represents the text content.
    // We wrap it in a \text{} command to display it correctly in math mode.
    return Expressions(latex: '\\text{$child}', math: ' $child ');
  }
}
