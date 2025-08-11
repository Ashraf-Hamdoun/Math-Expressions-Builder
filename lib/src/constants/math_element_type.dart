/// Defines the type of a mathematical element in the expression tree.
///
/// User-facing types are used to add new elements to the tree, while
/// internal types are used by the package for constructing complex nodes.
enum METype {
  // ---- Internal types (for package use only) ----

  /// The root of the expression tree.
  trunk,

  /// A generic node.
  node,

  /// A generic leaf.
  leaf,

  /// The numerator part of a fraction node.
  numeratorNode,

  /// The denominator part of a fraction node.
  denominatorNode,

  /// The index part of an nth-root node.
  indexOfRootNode,

  /// The radicand (content) part of a root node.
  radicandNode,

  /// The lower limit part of an integral or summation node.
  lowerLimitNode,

  /// The upper limit part of an integral or summation node.
  upperLimitNode,

  /// The integrand part of an integral node.
  integrandNode,

  /// The summand part of a summation node.
  summandNode,

  /// A placeholder leaf, representing an empty spot in the tree.
  placeHolderLeaf,

  // ---- User-facing node types ----

  /// A function node, like `sin(x)` or `log(x)`.
  functionNode,

  /// An inverse function node, like `sin^{-1}(x)`.
  inverseFunctionNode,

  /// A fraction node with a numerator and a denominator.
  fractionNode,

  /// A square root node.
  squareRootNode,

  /// A cube root node.
  cubeRootNode,

  /// An nth-root node with an editable index.
  nthRootNode,

  /// A power node (superscript).
  powerNode,

  /// An integral node with limits and an integrand.
  integralNode,

  /// A summation node with limits and a summand.
  summationNode,

  // ---- User-facing leaf types ----

  /// A leaf containing a number.
  numberLeaf,

  /// A leaf containing a standard operator (+, -, etc.).
  operatorLeaf,

  /// A leaf containing a variable (x, y, etc.).
  variableLeaf,

  /// A leaf containing a symbol that can be rendered directly (e.g., '(', ']').
  symbolLeaf,

  /// A leaf containing a special symbol that requires a LaTeX command (e.g., 'pi', 'pm').
  specialSymbolLeaf,

  /// A leaf containing plain text to be rendered within a `\text{...}` command.
  textLeaf,
}

/// An extension on [METype] to check if a type is intended for public use.
extension METypeUserFacing on METype {
  /// Returns true if this type is a user-facing type for adding elements.
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