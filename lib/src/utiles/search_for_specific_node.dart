import 'package:math_expressions_builder/src/constants/directions.dart';
import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_integral_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_node_with_initial_type.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_summation_node.dart';

/// Searches for a specific node in the LaTeX tree.
///
/// This function is used to find a node that can handle a vertical move, such as
/// a fraction or a root.
MathNode? searchForSpecificNode(MathNode parent, Direction direction) {
  MathNode? proposedParent;
  MathNode? grandParent = parent.parent;

  if (grandParent != null) {
    if (direction == Direction.down) {
      if (grandParent is MathNodeWithInitialType &&
          grandParent.initialType == METype.numeratorNode) {
        proposedParent = grandParent.move(direction);
      } else if (grandParent is MathNodeWithInitialType &&
          grandParent.initialType == METype.upperLimitNode) {
        proposedParent = grandParent.move(direction);
      } else if (grandParent is MathNodeWithInitialType &&
          grandParent.initialType == METype.integrandNode &&
          (grandParent.parent is MathSummationNode ||
              grandParent.parent is MathIntegralNode)) {
        proposedParent = grandParent.move(direction);
      } else {
        proposedParent = searchForSpecificNode(grandParent, Direction.down);
      }
    } else {
      if (grandParent is MathNodeWithInitialType &&
          grandParent.initialType == METype.denominatorNode) {
        proposedParent = grandParent.move(direction);
      } else if (grandParent is MathNodeWithInitialType &&
          grandParent.initialType == METype.lowerLimitNode) {
        proposedParent = grandParent.move(direction);
      } else if (grandParent is MathNodeWithInitialType &&
          grandParent.initialType == METype.integrandNode &&
          (grandParent.parent is MathSummationNode ||
              grandParent.parent is MathIntegralNode)) {
        proposedParent = grandParent.move(direction);
      } else {
        proposedParent = searchForSpecificNode(grandParent, Direction.up);
      }
    }
  }

  return proposedParent;
}
