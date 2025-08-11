import 'package:math_expressions_builder/src/constants/directions.dart';
import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/elements/math_trunk.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_fraction_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_integral_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_nth_root_node.dart';
import 'package:math_expressions_builder/src/elements/nodes/math_summation_node.dart';
import 'package:math_expressions_builder/src/utiles/leaves_generator.dart';
import 'package:math_expressions_builder/src/utiles/nodes_generator.dart';

/// The main class for building and manipulating mathematical expressions.
///
/// `MathTree` provides a user-friendly interface for constructing complex
/// math expressions programmatically. It abstracts the underlying tree structure,
/// managing the cursor and active node automatically.
///
/// Use this class to add, remove, and navigate through elements of an expression.
class MathTree {
  final MathTrunk _trunk = MathTrunk(id: 't-0');
  late MathNode _activeParent;

  /// Creates a new, empty math expression tree.
  MathTree() {
    _trunk.clear();
    _activeParent = _trunk;
    _trunk.enterNode();
  }

  /// Returns the full LaTeX string representation of the expression.
  ///
  /// This string is suitable for rendering with any LaTeX engine.
  /// The '|' character indicates the current cursor position.
  String toLaTeXString() => _trunk.toLaTeXString();

  /// Returns a string representation of the expression suitable for computation.
  ///
  /// This output is a simplified, Dart-like string (e.g., `(1+(sqrt(9)))`).
  String toMathString() => _trunk.toMathString();

  /// Adds a leaf element (e.g., number, operator) to the expression at the
  /// current cursor position.
  ///
  /// [type] specifies the type of leaf, and [content] is its value.
  void addChildLeaf(METype type, String content) {
    final leaf = leavesGenerator(
      parent: _activeParent,
      type: type,
      content: content,
    );

    _activeParent.addChildLeaf(leaf);
  }

  /// Adds a structural node (e.g., fraction, root) to the expression at the
  /// current cursor position.
  ///
  /// The cursor automatically moves into the new node's primary input field.
  /// For example, after adding a `fractionNode`, the cursor will be in the
  /// numerator.
  void addChildNode(METype type, {String content = ''}) {
    final node = nodesGenerator(
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

  /// Moves the cursor in the specified [direction].
  void _move(Direction direction) {
    _activeParent.leaveNode();
    _activeParent = _activeParent.move(direction);
    _activeParent.enterNode();
  }

  /// Moves the cursor up to the parent node or a node in an upper position.
  void moveUp() => _move(Direction.up);

  /// Moves the cursor down to a child node or a node in a lower position.
  void moveDown() => _move(Direction.down);

  /// Moves the cursor one position to the left.
  void moveLeft() => _move(Direction.left);

  /// Moves the cursor one position to the right.
  void moveRight() => _move(Direction.right);

  /// Clears the entire expression tree, resetting it to an empty state.
  void clear() {
    _activeParent.leaveNode();
    _trunk.clear();
    _activeParent = _trunk;
    _activeParent.enterNode();
  }

  /// Deletes the element immediately to the left of the cursor.
  ///
  /// If the cursor is at the beginning of a node, this may delete the node
  /// itself if it's empty, or move the cursor out of the node.
  void delete() {
    final node = _activeParent.deleteActiveChild();
    if (node != null) {
      // The active parent might change after a deletion.
      _activeParent.leaveNode();
      _activeParent = node;
      _activeParent.enterNode();
    }
  }
}
