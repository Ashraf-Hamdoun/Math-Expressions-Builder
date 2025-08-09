import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_leaf.dart';

/// A leaf that represents a number.

class MathNumberLeaf extends MathLeaf {
  MathNumberLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => METype.numberLeaf.name;
}
