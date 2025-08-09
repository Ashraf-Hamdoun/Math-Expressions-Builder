import 'package:math_expressions_builder/src/constants/directions.dart';
import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_node_with_initial_type.dart';
import 'package:math_expressions_builder/src/utiles/ids_generator.dart';

/// A node that represents a summation.
///
/// It contains three children: a lower limit, an upper limit, and the summand (expression).
class MathSummationNode extends MathNode {
  late final MathNode lowerLimit;

  late final MathNode upperLimit;

  late final MathNode summand;

  MathSummationNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  }) {
    // Initialize the lower limit child node

    lowerLimit = MathNodeWithInitialType(
      id: idsGenerator(METype.lowerLimitNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: METype.lowerLimitNode,
    );

    // Initialize the upper limit child node

    upperLimit = MathNodeWithInitialType(
      id: idsGenerator(METype.upperLimitNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: METype.upperLimitNode,
    );

    // Initialize the summand (function) child node

    summand = MathNodeWithInitialType(
      id: idsGenerator(METype.summandNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: METype.summandNode,
    );

    // Add the children to the integral node

    addChildNode(lowerLimit);

    addChildNode(upperLimit);

    addChildNode(summand);

    // Set the initial position to start in the lower limit

    position = 1;
  }

  @override
  String get getType => METype.summationNode.name;

  @override
  Expressions computeExpressions() {
    // Returns the full LaTeX string for the integral, including

    // the lower limit, upper limit, and the summand.
    // The \int command is prefixed, and the limits are in a subscript and superscript.
    // We add a small space `\,` before a placeholder differential 'dx' for clarity,
    // which is a standard practice in LaTeX.
    return Expressions(
        latex:
            "\\sum_{${lowerLimit.computeExpressions().latex}}^{${upperLimit.computeExpressions().latex}}${summand.computeExpressions().latex}",
        dart: 'summation');
  }

  @override
  MathNode move(Direction direction) {
    if (direction == Direction.left) {
      // Logic for moving left

      if (position == 3) {
        position = 1;

        return lowerLimit;
      } else {
        // Move out of the integral node to the left

        parent!.position--;

        return parent!;
      }
    } else {
      // direction == Direction.right

      // Logic for moving right

      if (position != 3) {
        position = 3;

        return summand;
      } else {
        // Move out of the integral node to the right

        parent!.position++;

        return parent!;
      }
    }
  }

  @override
  MathNode? deleteActiveChild() {
    MathNode activeChild = children[position] as MathNode;

    // If the active child is not empty, handle the deletion within the child.

    if (activeChild.children.isNotEmpty) {
      return activeChild.deleteActiveChild();
    }

    // If the active child is empty, delete it from the children list.

    // The integral node can only be deleted if all of its children are empty.

    if (lowerLimit.children.isEmpty &&
        upperLimit.children.isEmpty &&
        summand.children.isEmpty) {
      // All children are empty, so we can delete the integral node itself.

      parent!.deleteActiveChild();

      return parent;
    }

    // A child is empty, but others are not. Move to the previous position.

    if (position > 1) {
      position--;

      return this;
    } else {
      // If the first child (lowerLimit) is empty, move to the parent.

      parent!.deleteActiveChild();

      return parent;
    }
  }
}
