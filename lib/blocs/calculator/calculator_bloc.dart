import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState()) {
    on<NumberPressed>(_onNumberPressed);
    on<OperationPressed>(_onOperationPressed);
    on<ResultRequested>(_onResultRequested);
    on<Cleared>(_onCleared);
  }

  void _onCleared(
    Cleared event,
    Emitter<CalculatorState> emit,
  ) {
    emit(const CalculatorState());
  }

  void _onNumberPressed(
    NumberPressed event,
    Emitter<CalculatorState> emit,
  ) {
    if (state.first != 0 &&
        state.second != 0 &&
        state.operation == Operation.none) {
      emit(state.copyWith(
        first: event.value,
        operation: Operation.none,
        second: 0,
        result: '${event.value}',
      ));
      return;
    }
    if (state.operation == Operation.none) {
      final first =
          state.first != 0 ? state.first * 10 + event.value : event.value;
      emit(state.copyWith(
        first: first,
        result: '$first',
      ));
    } else {
      final second =
          state.second != 0 ? state.second * 10 + event.value : event.value;
      emit(
        state.copyWith(
          second: second,
          result: '${state.first} ${state.operation.string} $second',
        ),
      );
    }
  }

  void _onOperationPressed(
    OperationPressed event,
    Emitter<CalculatorState> emit,
  ) {
    // Chained operations are not supported, so it just returns null if state.second and state.operation have already been set
    if (state.second == 0 && state.operation == Operation.none) {
      final Operation operation;
      switch (event.operation) {
        case '+':
          operation = Operation.plus;
          break;

        case '-':
          operation = Operation.minus;
          break;
        case '×':
          operation = Operation.multiply;
          break;
        case '÷':
          operation = Operation.divide;
          break;

        // just because Dart can't tell if switch-case is exhaustive
        // TODO: change Event.operation type to Operation
        default:
          operation = Operation.plus;
      }
      emit(state.copyWith(
        operation: operation,
        result: '${state.first} ${event.operation}',
      ));

      return;
    }
  }

  void _onResultRequested(
    ResultRequested event,
    Emitter<CalculatorState> emit,
  ) {
    final operation = state.operation;
    if (operation == Operation.none) {
      return;
    } else {
      num result = 0;
      switch (operation) {
        case Operation.plus:
          result = state.first + state.second;
          break;
        case Operation.minus:
          result = state.first - state.second;
          break;
        case Operation.multiply:
          result = state.first * state.second;
          break;
        case Operation.divide:
          if (state.second == 0) break;
          result = state.first / state.second;
          break;
        case Operation.none:
          break;
      }

      emit(state.copyWith(
        first: result,
        second: 0,
        result: '$result',
        operation: Operation.none,
      ));
    }
  }
}
