import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/core/models/expressions.dart';
import '../constants/math_element_type.dart';
import 'math_element.dart';

/// The base class for all Math leaf elements.
///
/// Leaf elements are the terminal nodes of the LaTeX tree and hold the actual
/// content, such as numbers and operators. They do not have children.
///
/// The [child] property holds the string value of the leaf, which is used to
/// generate the LaTeX string.
abstract class MathLeaf extends MathElement {
  /// The content of the leaf, such as a number or an operator.
  final String child;

  MathLeaf({required super.id, required super.parent, required this.child});

  /// Creates a placeholder leaf, which is used to represent an empty space in the tree.
  factory MathLeaf.placeHolder({required MathNode parent}) {
    return _MathPlaceholderLeaf(
      id: "${parent.id}-pholder",
      parent: parent,
      child: '',
    );
  }

  @override
  String get getType => METype.leaf.name;

  /// Returns the LaTeX string for the leaf, which is just its content.
  @override
  Expressions computeExpressions() {
    return Expressions(latex: child, dart: child);
  }
}

/// A concrete implementation of a placeholder leaf.
class _MathPlaceholderLeaf extends MathLeaf {
  _MathPlaceholderLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => METype.placeHolderLeaf.name;
}
