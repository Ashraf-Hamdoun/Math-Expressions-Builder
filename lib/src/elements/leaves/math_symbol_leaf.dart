import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_leaf.dart';

/// A leaf that represents a common mathematical symbol.
/// These symbols can be rendered as they are.

class MathSymbolLeaf extends MathLeaf {
  MathSymbolLeaf({
    required super.id,
    required super.parent,
    required super.child,
  });

  @override
  String get getType => METype.symbolLeaf.name;

  // For many symbols like (), [], +, -, the string itself is the LaTeX output.
  // This class is a simple passthrough.
}
