part of 'calculator_bloc.dart';

sealed class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

final class NumberPressed extends CalculatorEvent {
  final String _number;
  int get value => int.parse(_number);

  const NumberPressed(String number) : _number = number;

  @override
  List<Object> get props => [_number];
}

final class OperationPressed extends CalculatorEvent {
  final String operation;

  const OperationPressed(this.operation);
}

final class ResultRequested extends CalculatorEvent {
  const ResultRequested();
}

final class Cleared extends CalculatorEvent {
  const Cleared();
}
