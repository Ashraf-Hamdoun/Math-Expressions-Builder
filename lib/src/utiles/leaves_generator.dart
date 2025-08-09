import 'package:math_expressions_builder/src/constants/math_element_type.dart';
import 'package:math_expressions_builder/src/core/math_leaf.dart';
import 'package:math_expressions_builder/src/core/math_node.dart';
import 'package:math_expressions_builder/src/elements/leaves/math_number_leaf.dart';
import 'package:math_expressions_builder/src/elements/leaves/math_operator_leaf.dart';
import 'package:math_expressions_builder/src/elements/leaves/math_special_symbol_leaf.dart';
import 'package:math_expressions_builder/src/elements/leaves/math_symbol_leaf.dart';
import 'package:math_expressions_builder/src/elements/leaves/math_text_leaf.dart';
import 'package:math_expressions_builder/src/elements/leaves/math_variable_leaf.dart';
import 'package:math_expressions_builder/src/utiles/ids_generator.dart';

/// A factory for creating LaTeX leaf elements.
///
/// This function is responsible for creating the correct type of leaf based on
/// the provided [METype].
MathLeaf leavesGenerator({
  required MathNode parent,
  required METype type,
  required String content,
}) {
  MathLeaf leaf;
  switch (type) {
    case METype.numberLeaf:
      leaf = MathNumberLeaf(
        child: content,
        id: idsGenerator(METype.numberLeaf, parent.id),
        parent: parent,
      );
      break;

    case METype.operatorLeaf:
      leaf = MathOperatorLeaf(
        child: content,
        id: idsGenerator(METype.operatorLeaf, parent.id),
        parent: parent,
      );
      break;

    case METype.variableLeaf:
      leaf = MathVariableLeaf(
        child: content,
        id: idsGenerator(METype.operatorLeaf, parent.id),
        parent: parent,
      );
      break;

    case METype.symbolLeaf:
      leaf = MathSymbolLeaf(
        child: content,
        id: idsGenerator(METype.symbolLeaf, parent.id),
        parent: parent,
      );
      break;

    case METype.specialSymbolLeaf:
      leaf = MathSpecialSymbolLeaf(
        child: content,
        id: idsGenerator(METype.specialSymbolLeaf, parent.id),
        parent: parent,
      );
      break;

    case METype.textLeaf:
      leaf = MathTextLeaf(
        child: content,
        id: idsGenerator(METype.textLeaf, parent.id),
        parent: parent,
      );
      break;

    default:
      leaf = MathNumberLeaf(
        child: content,
        id: idsGenerator(METype.leaf, parent.id),
        parent: parent,
      );
  }
  return leaf;
}
