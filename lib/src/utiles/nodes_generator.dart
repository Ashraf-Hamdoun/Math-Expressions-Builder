import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_function_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_integral_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_inverse_function_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_summation_node.dart';
import 'package:math_expressions_builder/src/utiles/ids_generator.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_cube_root_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_fraction_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_node_with_initial_type.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_nth_root_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_power_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_square_root_node.dart';

/// A factory for creating LaTeX node elements.
///
/// This function is responsible for creating the correct type of node based on
/// the provided [METype].
MathNode nodesGenerator({
  required MathNode parent,
  required METype type,
  required String content,
}) {
  MathNode node;
  switch (type) {
    case METype.functionNode:
      node = MathFunctionNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
        function: content,
      );
      break;

    case METype.inverseFunctionNode:
      node = MathInverseFunctionNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
        function: content,
      );
      break;

    case METype.fractionNode:
      node = MathFractionNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case METype.squareRootNode:
      node = MathSquareRootNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case METype.cubeRootNode:
      node = MathCubeRootNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case METype.nthRootNode:
      node = MathNthRootNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case METype.powerNode:
      node = MathPowerNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case METype.integralNode:
      node = MathIntegralNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    case METype.summationNode:
      node = MathSummationNode(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
      );
      break;

    default:
      node = MathNodeWithInitialType(
        id: idsGenerator(type, parent.id),
        parent: parent,
        updateParent: (childId, childValue) =>
            parent.onUpdateChildren(childId, childValue),
        initialType: type,
      );
  }
  return node;
}
