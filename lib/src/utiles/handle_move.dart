import 'package:math_expressions_builder/src/constants/directions.dart';
import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_element.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_fraction_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_integral_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_node_with_initial_type.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_nth_root_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_summation_node.dart';
import 'package:math_expressions_builder/src/utiles/search_for_specific_node.dart';

/// Handles the movement of the cursor in the LaTeX tree.
///
/// This function is responsible for determining the new active node based on the
/// current active node and the direction of movement. It also handles moving
/// in and out of nodes, such as fractions and roots.
MathNode? handleMove(Direction direction, MathNode parent) {
  MathNode? proposedParent;

  switch (direction) {
    case Direction.right:
      proposedParent = handleMoveRight(parent);
      break;
    case Direction.left:
      proposedParent = handleMoveLeft(parent);
      break;
    case Direction.up:
      proposedParent = handleMoveUp(parent);
      break;
    case Direction.down:
      proposedParent = handleMoveDown(parent);
      break;
  }

  if (proposedParent != null && proposedParent != parent) {
    if (proposedParent.childrenIDs.contains(parent.id)) {
      if (proposedParent is MathFractionNode) {
        proposedParent = proposedParent.move(direction);
      } else if (proposedParent is MathNthRootNode) {
        proposedParent = proposedParent.move(direction);
      } else if (proposedParent is MathIntegralNode) {
        proposedParent = proposedParent.move(direction);
      } else if (proposedParent is MathSummationNode) {
        proposedParent = proposedParent.move(direction);
      }
    } else {
      if (proposedParent is MathFractionNode) {
        proposedParent = proposedParent.numerator;
      } else if (proposedParent is MathNthRootNode) {
        proposedParent = proposedParent.indexOfRoot;
      } else if (proposedParent is MathIntegralNode) {
        proposedParent = proposedParent.lowerLimit;
      } else if (proposedParent is MathSummationNode) {
        proposedParent = proposedParent.lowerLimit;
      }
    }
  }

  return proposedParent;
}

/// Handles moving the cursor to the right.
MathNode? handleMoveRight(MathNode parent) {
  MathNode? proposedParent;
  MathNode? grandParent = parent.parent;
  int position = parent.position;

  // Still inside the parent and there are available moves.
  if (position < parent.children.length - 1) {
    // if the next child is a node, then we must enter it
    if (parent.children[position + 1] is MathNode) {
      parent.position++;
      proposedParent = parent.children[position + 1] as MathNode;
    } else {
      parent.position++;
      proposedParent = parent;
    }
  } else {
    // At the end and the available move to go outside.
    if (grandParent != null) {
      if (grandParent is MathIntegralNode) {
        proposedParent = grandParent.move(Direction.right);
      } else if (grandParent is MathSummationNode) {
        proposedParent = grandParent.move(Direction.right);
      } else {
        proposedParent = grandParent;
      }
    } else {
      proposedParent = null;
    }
  }

  return proposedParent;
}

/// Handles moving the cursor to the left.
MathNode? handleMoveLeft(MathNode parent) {
  MathNode? proposedParent;
  MathNode? grandParent = parent.parent;
  int position = parent.position;

  if (position > 0) {
    MathElement mathElement = parent.children[position];
    if (mathElement is MathNode) {
      proposedParent = mathElement;
    } else {
      parent.position--;
      proposedParent = parent;
    }
  } else {
    if (grandParent != null) {
      if (grandParent is MathFractionNode) {
        proposedParent = grandParent.move(Direction.left);
      }
      if (grandParent is MathIntegralNode) {
        proposedParent = grandParent.move(Direction.left);
      } else if (grandParent is MathSummationNode) {
        proposedParent = grandParent.move(Direction.left);
      } else {
        grandParent.position--;
        proposedParent = grandParent;
      }
    } else {
      proposedParent = null;
    }
  }

  return proposedParent;
}

/// Handles moving the cursor down.
MathNode? handleMoveDown(MathNode parent) {
  MathNode? proposedParent;
  MathNode? grandParent = parent.parent;

  if (grandParent != null) {
    if (parent is MathNodeWithInitialType &&
        parent.initialType == METype.numeratorNode) {
      proposedParent = (grandParent as MathFractionNode).denominator;
    } else if (parent is MathNodeWithInitialType &&
        parent.initialType == METype.upperLimitNode) {
      if (grandParent is MathIntegralNode) {
        proposedParent = grandParent.lowerLimit;
      } else if (grandParent is MathSummationNode) {
        proposedParent = grandParent.lowerLimit;
      }
    } else {
      proposedParent = searchForSpecificNode(parent, Direction.down);
    }
  } else {
    proposedParent = null;
  }

  return proposedParent;
}

/// Handles moving the cursor up.
MathNode? handleMoveUp(MathNode parent) {
  MathNode? proposedParent;
  MathNode? grandParent = parent.parent;

  if (grandParent != null) {
    if (parent is MathNodeWithInitialType &&
        parent.initialType == METype.denominatorNode) {
      proposedParent = (grandParent as MathFractionNode).numerator;
    } else if (parent is MathNodeWithInitialType &&
        parent.initialType == METype.lowerLimitNode) {
      if (grandParent is MathIntegralNode) {
        proposedParent = grandParent.upperLimit;
      } else if (grandParent is MathSummationNode) {
        proposedParent = grandParent.upperLimit;
      }
    } else {
      proposedParent = searchForSpecificNode(parent, Direction.up);
    }
  } else {
    proposedParent = null;
  }

  return proposedParent;
}
