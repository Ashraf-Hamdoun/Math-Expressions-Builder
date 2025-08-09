import 'package:math_expressions_builder/src/constants/directions.dart';
import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_node_with_initial_type.dart';
import 'package:math_expressions_builder/src/utiles/ids_generator.dart';

/// A node that represents an nth root.

class MathNthRootNode extends MathNode {
  late final MathNode indexOfRoot;
  late final MathNode radicand;

  MathNthRootNode({
    required super.id,
    required super.parent,
    required super.updateParent,
  }) {
    indexOfRoot = MathNodeWithInitialType(
      id: idsGenerator(METype.indexOfRootNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: METype.indexOfRootNode,
    );

    radicand = MathNodeWithInitialType(
      id: idsGenerator(METype.radicandNode, id),
      parent: this,
      updateParent: (childId, childValue) =>
          onUpdateChildren(childId, childValue),
      initialType: METype.radicandNode,
    );

    addChildNode(indexOfRoot);
    addChildNode(radicand);

    position = 1;
  }

  @override
  String get getType => METype.nthRootNode.name;

  @override
  Expressions computeExpressions() {
    return Expressions(
        latex:
            "\\sqrt[${indexOfRoot.computeExpressions().latex}]{${radicand.computeExpressions().latex}}",
        dart:
            "pow(${radicand.computeExpressions().dart}, 1 / ${indexOfRoot.computeExpressions().dart})");
  }

  @override
  MathNode move(Direction direction) {
    if (position == 1 && direction == Direction.right) {
      position = 2;
      return radicand;
    } else if (position == 2 && direction == Direction.left) {
      position = 1;
      return indexOfRoot;
    } else {
      if (direction == Direction.right) {
        return parent!;
      } else if (direction == Direction.left) {
        parent?.position--;
        return parent!;
      } else {
        return parent!.move(direction);
      }
    }
  }

  @override
  MathNode? deleteActiveChild() {
    if (indexOfRoot.children.length == 1 && radicand.children.length == 1) {
      // Nth root node is empty, you can delete it.
      parent!.deleteActiveChild();
      return parent;
    } else {
      if (position == 2) {
        position == 1;
        return indexOfRoot.deleteActiveChild();
      } else {
        return null;
      }
    }
  }
}
