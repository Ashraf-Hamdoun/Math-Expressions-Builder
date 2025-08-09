import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_leaf.dart';

/// A leaf that represents an operator.

class MathOperatorLeaf extends MathLeaf {
  MathOperatorLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => METype.operatorLeaf.name;
}
