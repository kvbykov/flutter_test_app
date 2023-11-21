part of 'calculator_bloc.dart';

enum Operation { plus, minus, multiply, divide, none }

extension OperationX on Operation {
  String get string {
    switch (this) {
      case Operation.plus:
        return '+';
      case Operation.divide:
        return '÷';
      case Operation.minus:
        return '-';
      case Operation.multiply:
        return '×';
      default:
        return '';
    }
  }
}

// TODO: initial .first and .second values should not be zeros
final class CalculatorState extends Equatable {
  final num first;
  final num second;
  final Operation operation;
  final String result;

  const CalculatorState({
    this.first = 0,
    this.second = 0,
    this.operation = Operation.none,
    this.result = '',
  });

  CalculatorState copyWith({
    num? first,
    num? second,
    Operation? operation,
    String? result,
  }) {
    return CalculatorState(
      first: first ?? this.first,
      second: second ?? this.second,
      operation: operation ?? this.operation,
      result: result ?? this.result,
    );
  }

  @override
  List<Object> get props => [first, second, operation, result];
}
