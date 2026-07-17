class CalculatorLogic {
  String _displayText = '0';
  String _expressionText = '';
  bool _justEvaluated = false;

  String get displayText => _displayText;

  String handleButton(String buttonText) {
    switch (buttonText) {
      case 'C':
        return _clearLast();
      case 'AC':
        clear();
        return _displayText;
      case '+':
      case '-':
      case '*':
      case '/':
        return _appendOperator(buttonText);
      case '=':
        return _calculateResult();
      default:
        return _appendDigit(buttonText);
    }
  }

  void clear() {
    _displayText = '0';
    _expressionText = '';
    _justEvaluated = false;
  }

  String _appendDigit(String input) {
    if (_justEvaluated) {
      _expressionText = '';
      _displayText = '0';
      _justEvaluated = false;
    }

    if (_displayText == '0' && _expressionText.isEmpty) {
      _expressionText = input;
      _displayText = input;
    } else {
      _expressionText += input;
      _displayText = _expressionText;
    }

    return _displayText;
  }

  String _appendOperator(String operation) {
    if (_displayText.contains('=')) {
      _expressionText = _displayText.split('=').first;
      _displayText = _expressionText;
    }

    if (_expressionText.isEmpty) {
      _expressionText = '0$operation';
      _displayText = _expressionText;
      return _displayText;
    }

    final lastChar = _expressionText.substring(_expressionText.length - 1);
    if (RegExp(r'[+\-*/]').hasMatch(lastChar)) {
      _expressionText =
          _expressionText.substring(0, _expressionText.length - 1) + operation;
    } else {
      _expressionText += operation;
    }

    _displayText = _expressionText;
    _justEvaluated = false;
    return _displayText;
  }

  String _clearLast() {
    if (_displayText.contains('=')) {
      final beforeResult = _displayText.split('=').first;
      _expressionText = beforeResult;
      _displayText = beforeResult.isEmpty ? '0' : beforeResult;
      _justEvaluated = false;
      return _displayText;
    }

    if (_expressionText.isEmpty || _displayText == '0') {
      clear();
      return _displayText;
    }

    _expressionText = _expressionText.substring(0, _expressionText.length - 1);
    _displayText = _expressionText.isEmpty ? '0' : _expressionText;
    _justEvaluated = false;
    return _displayText;
  }

  String _calculateResult() {
    if (_expressionText.isEmpty) {
      return _displayText;
    }

    final result = _evaluateExpression(_expressionText);
    final formattedResult = _formatResult(result);

    // Optional fun message for the group project.
    // This is isolated so normal calculator behavior stays intact.
    final funMessage = _getFunMessage(_expressionText, formattedResult);
    _displayText = funMessage ?? '$_expressionText=$formattedResult';
    _justEvaluated = true;
    return _displayText;
  }

  String? _getFunMessage(String expression, String formattedResult) {
    final normalizedExpression = expression.replaceAll(' ', '');

    if (normalizedExpression == '2+2' && formattedResult == '4') {
      return '2+2=4 ahm depende kung 3 yan, kung 3 edi 5';
    }

    return null;
  }

  double _evaluateExpression(String expression) {
    final sanitized = expression.replaceAll(' ', '');
    if (sanitized.isEmpty) {
      return 0;
    }

    final values = <double>[];
    final operations = <String>[];
    final buffer = StringBuffer();

    void applyOperation() {
      if (operations.isEmpty || values.length < 2) {
        return;
      }

      final rightValue = values.removeLast();
      final leftValue = values.removeLast();
      final operation = operations.removeLast();

      switch (operation) {
        case '+':
          values.add(leftValue + rightValue);
          break;
        case '-':
          values.add(leftValue - rightValue);
          break;
        case '*':
          values.add(leftValue * rightValue);
          break;
        case '/':
          if (rightValue == 0) {
            values.add(double.nan);
          } else {
            values.add(leftValue / rightValue);
          }
          break;
      }
    }

    for (final char in sanitized.split('')) {
      if (char == '+' || char == '-' || char == '*' || char == '/') {
        if (buffer.isNotEmpty) {
          values.add(double.parse(buffer.toString()));
          buffer.clear();
        }

        while (operations.isNotEmpty &&
            _precedence(operations.last) >= _precedence(char)) {
          applyOperation();
        }
        operations.add(char);
      } else {
        buffer.write(char);
      }
    }

    if (buffer.isNotEmpty) {
      values.add(double.parse(buffer.toString()));
    }

    while (operations.isNotEmpty) {
      applyOperation();
    }

    return values.isEmpty ? 0 : values.last;
  }

  int _precedence(String operation) {
    switch (operation) {
      case '*':
      case '/':
        return 2;
      case '+':
      case '-':
        return 1;
      default:
        return 0;
    }
  }

  String _formatResult(double value) {
    if (value.isNaN) {
      return 'Error';
    }

    if (value == value.toInt().toDouble()) {
      return value.toInt().toString();
    }

    return value.toString();
  }
}
