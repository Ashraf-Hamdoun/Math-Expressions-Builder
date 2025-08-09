import 'package:math_expressions_builder/src/core/models/expressions.dart';

import 'math_node.dart';

/// The base class for all Math elements, both nodes and leaves.
///
/// It defines the common interface for all elements in the LaTeX tree,
/// including a unique [id], a reference to the [parent] node, and support for
/// caching the LaTeX string representation to avoid unnecessary re-computation.
///
/// The [isDirty] flag is used to track whether the cached LaTeX string is
/// up-to-date. When an element is modified, it and its ancestors are marked as
/// dirty, indicating that their LaTeX representation needs to be recomputed.
/// This ensures that the tree is always in a consistent state.
abstract class MathElement {
  final String id;
  final MathNode? parent;

  bool isDirty = true;
  Expressions _cachedExpressions = Expressions(latex: "", dart: "");
  // String _cachedDartString = "";

  MathElement({required this.id, required this.parent});

  /// Returns the type of the element, used for identification and debugging.
  String get getType;

  /// Returns a string with information about the element, including its type and ID.
  String get info => "$getType id: $id (value: ${toLaTeXString()})";

  /// Computes the LaTeX string for the element.
  ///
  /// This method is called by [toLaTeXString] when the element is dirty.
  /// Subclasses must implement this method to define their LaTeX representation.
  Expressions computeExpressions();

  /// Returns the LaTeX string for the element, using a cached value if available.
  ///
  /// If the element is dirty, it recomputes the string and updates the cache.
  /// This ensures that the LaTeX string is only computed when necessary.
  String toLaTeXString() {
    if (isDirty) {
      _cachedExpressions = computeExpressions();
      isDirty = false;
    }
    return _cachedExpressions.latex;
  }

  String toDartString() {
    if (isDirty) {
      _cachedExpressions = computeExpressions();
      isDirty = false;
    }
    return _cachedExpressions.dart;
  }

  /// Marks the element and its ancestors as dirty.
  ///
  /// When an element is modified, this method is called to ensure that the
  /// entire branch of the tree is updated.
  void setDirty() {
    if (!isDirty) {
      isDirty = true;
      parent?.setDirty();
    }
  }
}
