import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_leaf.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';

/// A leaf that represents a special character or command in LaTeX.
/// These symbols require a specific LaTeX string representation.

class MathSpecialSymbolLeaf extends MathLeaf {
  MathSpecialSymbolLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => METype.specialSymbolLeaf.name;

  @override
  Expressions computeExpressions() {
    return Expressions(latex: '\\$child', dart: child);
  }
}
