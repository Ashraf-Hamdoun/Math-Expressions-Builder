import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';

/// A node with an initial type.

class MathNodeWithInitialType extends MathNode {
  final METype initialType;
  MathNodeWithInitialType({
    required super.id,
    required super.parent,
    required super.updateParent,
    required this.initialType,
  });

  @override
  String get getType => initialType.name;
}
