import 'package:math_expressions_builder/src/constants/directions.dart';
import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_leaf.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/elements/math_trunk.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_fraction_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_integral_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_nth_root_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_summation_node.dart';
import 'package:math_expressions_builder/src/utiles/leaves_generator.dart';
import 'package:math_expressions_builder/src/utiles/nodes_generator.dart';

/// The main class for building Math expressions.
///
/// This class provides a simple interface for creating and manipulating Math
/// expressions. It manages the underlying tree structure and the active node,
/// making it easy to add new elements and move the cursor.
class MathTree {
  final MathTrunk _trunk = MathTrunk(id: "t-0");
  late MathNode _activeParent;

  MathTree() {
    _trunk.clear();
    _activeParent = _trunk;
    _trunk.enterNode();
  }

  /// Returns the LaTeX string for the entire expression.
  String toLaTeXString() => _trunk.toLaTeXString();

  /// Returns the Math string for the entire expression.
  String toMathString() => _trunk.toMathString();

  /// Adds a leaf to the active node.
  void addChildLeaf(METype type, String content) {
    MathLeaf leaf = leavesGenerator(
      parent: _activeParent,
      type: type,
      content: content,
    );

    _activeParent.addChildLeaf(leaf);
  }

  /// Adds a node to the active node and enters it.
  void addChildNode(METype type, {String content = ""}) {
    MathNode node = nodesGenerator(
      parent: _activeParent,
      type: type,
      content: content,
    );

    _activeParent.addChildNode(node);
    _activeParent.leaveNode();
    if (node is MathFractionNode) {
      _activeParent = node.numerator;
    } else if (node is MathNthRootNode) {
      _activeParent = node.indexOfRoot;
    } else if (node is MathIntegralNode) {
      _activeParent = node.lowerLimit;
    } else if (node is MathSummationNode) {
      _activeParent = node.lowerLimit;
    } else {
      _activeParent = node;
    }
    _activeParent.enterNode();
  }

  /// Moves the cursor in the specified direction.
  void _move(Direction direction) {
    _activeParent.leaveNode();
    _activeParent = _activeParent.move(direction);
    _activeParent.enterNode();
  }

  /// Moves
  void moveUp() => _move(Direction.up);
  void moveDown() => _move(Direction.down);
  void moveLeft() => _move(Direction.left);
  void moveRight() => _move(Direction.right);

  void clear() {
    _activeParent.leaveNode();
    _trunk.clear();
    _activeParent = _trunk;
    _activeParent.enterNode();
  }

  /// Deletes the active child and updates the cursor position.
  void delete() {
    MathNode? node = _activeParent.deleteActiveChild();
    if (node != null) {
      // Parent will be changed!
      _activeParent.leaveNode();
      _activeParent = node;
      _activeParent.enterNode();
    }
  }
}
