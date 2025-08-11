import 'package:math_expressions_builder/math_expressions_builder.dart';
import 'package:test/test.dart';

void main() {
  group('MathInputController - Basic Operations', () {
    late MathTree mathTree;
    late MathInputController controller;

    setUp(() {
      mathTree = MathTree();
      controller = MathInputController(mathTree);
    });

    test('should build a simple expression correctly', () {
      controller.pressOne();
      controller.pressPlus();
      controller.pressEight();

      expect(mathTree.toLaTeXString(), r'\(1+8|\)');
      expect(mathTree.toMathString(), '(1+8)');
    });

    test('should handle multi-digit numbers', () {
      controller.pressNumber("123");
      controller.pressMinus();
      controller.pressNumber("45");

      expect(mathTree.toLaTeXString(), r'\(123-45|\)');
      expect(mathTree.toMathString(), '(123-45)');
    });

    test('should handle multiplication and division symbols', () {
      controller.pressTwo();
      controller.pressMultiply();
      controller.pressThree();
      controller.pressDivide();
      controller.pressFour();

      expect(mathTree.toLaTeXString(), r'\(2\times3\div4|\)');
      expect(mathTree.toMathString(), '(2*3/4)');
    });
  });

  group('MathInputController - Function and Symbol Operations', () {
    late MathTree mathTree;
    late MathInputController controller;

    setUp(() {
      mathTree = MathTree();
      controller = MathInputController(mathTree);
    });

    test('should add sine function correctly', () {
      controller.pressSine();
      controller.pressVariable("x");

      expect(mathTree.toLaTeXString(), r'\(\sin(x|)\)');
      expect(mathTree.toMathString(), '(sin(x))');
    });

    test('should add cosine function correctly', () {
      controller.pressCosine();
      controller.pressVariable("y");

      expect(mathTree.toLaTeXString(), r'\(\cos(y|)\)');
      expect(mathTree.toMathString(), '(cos(y))');
    });

    test('should add tangent function correctly', () {
      controller.pressTangent();
      controller.pressNumber("45");

      expect(mathTree.toLaTeXString(), r'\(\tan(45|)\)');
      expect(mathTree.toMathString(), '(tan(45))');
    });

    test('should add natural logarithm correctly', () {
      controller.pressNaturalLog();
      controller.pressNumber("10");

      expect(mathTree.toLaTeXString(), r'\(\ln(10|)\)');
      expect(mathTree.toMathString(), '(ln(10))');
    });

    test('should add base-10 logarithm correctly', () {
      controller.pressLog();
      controller.pressNumber("100");

      expect(mathTree.toLaTeXString(), r'\(\log(100|)\)');
      expect(mathTree.toMathString(), '(log(100))');
    });

    test('should add inversed sine function correctly', () {
      controller.pressInversedSine();
      controller.pressNumber("0.5");

      expect(mathTree.toLaTeXString(), r'\(\sin(0.5|)^{-1}\)');
      expect(mathTree.toMathString(), '(1 / sin(0.5))');
    });

    test('should add inversed cosine function correctly', () {
      controller.pressInversedCosine();
      controller.pressNumber("0.8");

      expect(mathTree.toLaTeXString(), r'\(\cos(0.8|)^{-1}\)');
      expect(mathTree.toMathString(), '(1 / cos(0.8))');
    });

    test('should add inversed tangent function correctly', () {
      controller.pressInversedTangent();
      controller.pressNumber("1");

      expect(mathTree.toLaTeXString(), r'\(\tan(1|)^{-1}\)');
      expect(mathTree.toMathString(), '(1 / tan(1))');
    });

    test('should add Pi symbol correctly', () {
      controller.pressPi();
      expect(mathTree.toLaTeXString(), r'\(\pi|\)');
      expect(mathTree.toMathString(), '(pi)');
    });

    test('should add Euler\'s number correctly', () {
      controller.pressEuler();
      expect(mathTree.toLaTeXString(), r'\(e|\)');
      expect(mathTree.toMathString(), '(e)');
    });

    test('should add parentheses correctly', () {
      controller.pressLeftParenthesis();
      controller.pressOne();
      controller.pressPlus();
      controller.pressTwo();
      controller.pressRightParenthesis();

      expect(mathTree.toLaTeXString(), r'\((1+2)|\)');
      expect(mathTree.toMathString(), '((1+2))');
    });

    test('should add brackets correctly', () {
      controller.pressLeftBracket();
      controller.pressVariable("a");
      controller.pressMultiply();
      controller.pressVariable("b");
      controller.pressRightBracket();

      expect(mathTree.toLaTeXString(), r'\([a\times b]|\)');
      expect(mathTree.toMathString(), '([a*b])');
    });

    test('should add braces correctly', () {
      controller.pressLeftBrace();
      controller.pressNumber("10");
      controller.pressDivide();
      controller.pressNumber("2");
      controller.pressRightBrace();

      expect(mathTree.toLaTeXString(), r'\(\{10\div2\}|\)');
      expect(mathTree.toMathString(), '({10/2})');
    });
  });

  group('MathInputController - Complex Scenarios', () {
    late MathTree mathTree;
    late MathInputController controller;

    setUp(() {
      mathTree = MathTree();
      controller = MathInputController(mathTree);
    });

    test('should build a nested expression with functions and symbols', () {
      controller.pressSine();
      controller.pressLeftParenthesis();
      controller.pressPi();
      controller.pressDivide();
      controller.pressTwo();
      controller.pressRightParenthesis();

      expect(mathTree.toLaTeXString(), r'\(\sin((\pi\div2)|)\)');
      expect(mathTree.toMathString(), '(sin((pi/2)))');
    });

    test('should handle mixed operations and navigation', () {
      controller.pressFraction();
      controller.pressOne();
      controller.moveDown();
      controller.pressTwo();
      controller.moveRight();
      controller.pressPlus();
      controller.pressSquareRoot();
      controller.pressNumber("16");

      expect(mathTree.toLaTeXString(), r'\(\frac{1}{2}+\sqrt{16|}\)');
      expect(mathTree.toMathString(), '( (1) / (2) + (sqrt(16)) )');
    });

    test('should clear the tree', () {
      controller.pressOne();
      controller.pressPlus();
      controller.pressTwo();
      expect(mathTree.toLaTeXString(), r'\(1+2|\)');

      controller.pressClear();
      expect(mathTree.toLaTeXString(), r'\(|\)');
      expect(mathTree.toMathString(), '()');
    });

    test('should delete elements correctly', () {
      controller.pressOne();
      controller.pressPlus();
      controller.pressTwo();
      controller.pressDelete(); // Delete 2
      expect(mathTree.toLaTeXString(), r'\(1+|\)');
      expect(mathTree.toMathString(), '(1+)');

      controller.pressDelete(); // Delete +
      expect(mathTree.toLaTeXString(), r'\(1|\)');
      expect(mathTree.toMathString(), '(1)');
    });
  });

  group('MathInputController - Listener Pattern', () {
    late MathTree mathTree;
    late MathInputController controller;
    int listenerCallCount = 0;

    setUp(() {
      mathTree = MathTree();
      controller = MathInputController(mathTree);
      listenerCallCount = 0;
      controller.addListener(() {
        listenerCallCount++;
      });
    });

    test('listener should be called on state change', () {
      controller.pressOne();
      expect(listenerCallCount, 1);

      controller.pressPlus();
      expect(listenerCallCount, 2);

      controller.moveRight(); // Cursor movement is a state change
      expect(listenerCallCount, 3);

      controller.pressDelete();
      expect(listenerCallCount, 4);
    });

    test(
      'listener should not be called if no state change (e.g., move beyond bounds)',
      () {
        controller.pressOne();
        listenerCallCount = 0; // Reset for this specific test

        // Try to move left when at the beginning
        controller.moveLeft();
        expect(listenerCallCount, 0); // No change, listener not called

        // Try to delete when tree is empty
        controller.pressClear();
        listenerCallCount = 0;
        controller.pressDelete();
        expect(listenerCallCount, 0); // No change, listener not called
      },
    );

    test('listener can be removed', () {
      controller.pressOne();
      expect(listenerCallCount, 1);

      controller.removeListener(() {
        listenerCallCount++;
      }); // This won't remove the anonymous function added in setUp

      // To properly test removal, you need to store the function reference
      void testListener() {
        listenerCallCount++;
      }

      controller.removeListener(
        testListener,
      ); // This will fail if testListener wasn't added

      // Let's re-do this test properly
      controller = MathInputController(mathTree); // New controller instance
      listenerCallCount = 0;
      void specificListener() {
        listenerCallCount++;
      }

      controller.addListener(specificListener);
      controller.pressOne();
      expect(listenerCallCount, 1);

      controller.removeListener(specificListener);
      controller.pressTwo();
      expect(listenerCallCount, 1); // Should not increment after removal
    });
  });
}
