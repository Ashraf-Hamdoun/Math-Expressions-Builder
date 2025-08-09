/// The type of a LaTeX element.
///
/// User-facing types are marked below. Internal types are for package use only.
enum METype {
  // Internal types (not for direct user use)
  trunk,
  node,
  leaf,
  numeratorNode,
  denominatorNode,
  indexOfRootNode,
  radicandNode,
  lowerLimitNode,
  upperLimitNode,
  integrandNode,
  summandNode,
  placeHolderLeaf,

  // User-facing node types
  functionNode, // e.g., sin(x)
  inverseFunctionNode, // e.g., sin^{-1}(x)
  fractionNode,
  squareRootNode,
  cubeRootNode,
  nthRootNode,
  powerNode,
  integralNode,
  summationNode,

  // User-facing leaf types
  numberLeaf,
  operatorLeaf,
  variableLeaf,
  symbolLeaf,
  specialSymbolLeaf,
  textLeaf,
}

extension METypeUserFacing on METype {
  /// Returns true if this type is intended for user code.
  bool get isUserFacing => const {
        METype.functionNode,
        METype.inverseFunctionNode,
        METype.fractionNode,
        METype.squareRootNode,
        METype.cubeRootNode,
        METype.nthRootNode,
        METype.powerNode,
        METype.integralNode,
        METype.summationNode,
        METype.numberLeaf,
        METype.operatorLeaf,
        METype.variableLeaf,
        METype.symbolLeaf,
        METype.specialSymbolLeaf,
        METype.textLeaf,
      }.contains(this);
}
