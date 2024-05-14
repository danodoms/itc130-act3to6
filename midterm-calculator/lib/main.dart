import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorModel(),
      child: MaterialApp(
        home: CalculatorScreen(),
      ),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Consumer<CalculatorModel>(
                builder: (context, model, child) {
                  return Text(
                    model.display,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          ),
          Divider(height: 1),
          Column(
            children: [
              buildButtonRow(context, ['7', '8', '9', '/']),
              buildButtonRow(context, ['4', '5', '6', 'x']),
              buildButtonRow(context, ['1', '2', '3', '-']),
              buildButtonRow(context, ['0', '.', '=', '+']),
              buildButtonRow(context, ['C']),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(BuildContext context, List<String> labels) {
    return Row(
      children: labels.map((label) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(24),
              ),
              onPressed: () => context.read<CalculatorModel>().input(label),
              child: Text(label, style: TextStyle(fontSize: 24)),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CalculatorModel extends ChangeNotifier {
  String _display = '';
  String _operand = '';
  double _value = 0.0;
  String _operator = '';

  String get display => _display;

  void input(String char) {
    if (char == 'C') {
      _clear();
    } else if (char == '=') {
      _calculate();
    } else if ('+-*/'.contains(char)) {
      _setOperator(char);
    } else {
      _append(char);
    }
    notifyListeners();
  }

  void _clear() {
    _display = '';
    _operand = '';
    _value = 0.0;
    _operator = '';
  }

  void _append(String char) {
    _display += char;
  }

  void _setOperator(String operator) {
    if (_operator.isEmpty) {
      _value = double.tryParse(_display) ?? 0.0;
    } else {
      _calculate();
    }
    _operator = operator;
    _display = '';
  }

  void _calculate() {
    double operand = double.tryParse(_display) ?? 0.0;
    if (_operator == '+') _value += operand;
    if (_operator == '-') _value -= operand;
    if (_operator == '*') _value *= operand;
    if (_operator == '/') _value /= operand;
    _display = _value.toString();
    _operator = '';
  }
}
