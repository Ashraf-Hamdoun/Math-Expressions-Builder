import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_leaf.dart';

/// A leaf that represents a number.

class MathVariableLeaf extends MathLeaf {
  MathVariableLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => METype.variableLeaf.name;
}
