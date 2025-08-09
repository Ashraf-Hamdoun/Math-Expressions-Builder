import 'package:math_expressions_builder/src/constants/directions.dart';
import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_node_with_initial_type.dart';
import 'package:math_expressions_builder/src/utiles/ids_generator.dart';

/// A node that represents a fraction.

class MathFractionNode extends MathNode {
  late final MathNode numerator;
  late final MathNode denominator;

  MathFractionNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  }) {
    numerator = MathNodeWithInitialType(
      id: idsGenerator(METype.numeratorNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: METype.numeratorNode,
    );

    denominator = MathNodeWithInitialType(
      id: idsGenerator(METype.denominatorNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: METype.denominatorNode,
    );

    addChildNode(numerator);
    addChildNode(denominator);

    position = 1;
  }

  @override
  String get getType => METype.fractionNode.name;

  @override
  Expressions computeExpressions() {
    return Expressions(
        latex:
            "\\frac{${numerator.computeExpressions().latex}}{${denominator.computeExpressions().latex}}",
        dart:
            "(${numerator.computeExpressions().dart}) / (${denominator.computeExpressions().dart})");
  }

  @override
  MathNode move(Direction direction) {
    if (direction == Direction.left) {
      parent!.position--;
      return parent!;
    } else {
      return parent!;
    }
  }

  @override
  MathNode? deleteActiveChild() {
    if (numerator.children.length == 1 && denominator.children.length == 1) {
      // Fraction node is empty, you can delete it.
      parent!.deleteActiveChild();
      return parent;
    } else {
      return null;
    }
  }
}
