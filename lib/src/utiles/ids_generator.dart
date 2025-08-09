import 'package:math_expressions_builder/src/constants/math_element_type.dart';

int idsCounter = 0;

/// Generates a unique ID for a LaTeX element.
///
/// The ID is based on the element's type and its parent's ID to ensure that it
/// is unique within the tree.
String idsGenerator(METype type, String parentId) {
  String idPrefix;

  switch (type) {
    case METype.trunk:
      idPrefix = "t";
      break;
    case METype.node:
      idPrefix = "$parentId-n-norm";
      break;
    case METype.fractionNode:
      idPrefix = "$parentId-n-frac";
      break;
    case METype.numeratorNode:
      idPrefix = "$parentId-n-num";
      break;
    case METype.denominatorNode:
      idPrefix = "$parentId-n-den";
      break;
    case METype.squareRootNode:
      idPrefix = "$parentId-n-sqrt";
      break;
    case METype.cubeRootNode:
      idPrefix = "$parentId-n-cbrt";
      break;
    case METype.nthRootNode:
      idPrefix = "$parentId-n-nthrt";
      break;
    case METype.indexOfRootNode:
      idPrefix = "$parentId-n-idxrt";
      break;
    case METype.radicandNode:
      idPrefix = "$parentId-n-radicand";
      break;
    case METype.powerNode:
      idPrefix = "$parentId-n-pow";
      break;
    case METype.integralNode:
      idPrefix = "$parentId-n-int";
      break;
    case METype.summationNode:
      idPrefix = "$parentId-n-sum";
      break;
    case METype.numberLeaf:
      idPrefix = "$parentId-l-num";
      break;
    case METype.operatorLeaf:
      idPrefix = "$parentId-l-oper";
      break;
    case METype.variableLeaf:
      idPrefix = "$parentId-l-var";
      break;
    case METype.leaf:
      idPrefix = "$parentId-l-ess";
      break;
    default:
      idPrefix = "$parentId-unk";
  }

  idsCounter++;
  return "$idPrefix-$idsCounter";
}
