import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_case/blocs/calculator/calculator_bloc.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorBloc(),
      child: const CalculatorWidget(),
    );
  }
}

class CalculatorResultWidget extends StatelessWidget {
  const CalculatorResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
        builder: (context, state) {
      return Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              state.result,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CalculatorWidget extends StatelessWidget {
  const CalculatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalculatorResultWidget(),
          SizedBox(height: 80),
          CalculatorControlWidget(),
        ],
      ),
    );
  }
}

class CalculatorControlWidget extends StatelessWidget {
  const CalculatorControlWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const [
          CalculatorTileWidget(event: NumberPressed('1'), symbol: '1'),
          CalculatorTileWidget(event: NumberPressed('2'), symbol: '2'),
          CalculatorTileWidget(event: NumberPressed('3'), symbol: '3'),
          CalculatorTileWidget(
              event: OperationPressed('+'), symbol: '+', color: Colors.orange),
          CalculatorTileWidget(event: NumberPressed('4'), symbol: '4'),
          CalculatorTileWidget(event: NumberPressed('5'), symbol: '5'),
          CalculatorTileWidget(event: NumberPressed('6'), symbol: '6'),
          CalculatorTileWidget(
              event: OperationPressed('-'), symbol: '-', color: Colors.orange),
          CalculatorTileWidget(event: NumberPressed('7'), symbol: '7'),
          CalculatorTileWidget(event: NumberPressed('8'), symbol: '8'),
          CalculatorTileWidget(event: NumberPressed('9'), symbol: '9'),
          CalculatorTileWidget(
              event: OperationPressed('×'), symbol: '×', color: Colors.orange),
          CalculatorTileWidget(event: NumberPressed('0'), symbol: '0'),
          CalculatorTileWidget(
              event: Cleared(), symbol: 'c', color: Colors.redAccent),
          CalculatorTileWidget(
              event: OperationPressed('÷'), symbol: '÷', color: Colors.orange),
          CalculatorTileWidget(
              event: ResultRequested(), symbol: '=', color: Colors.blueGrey),
        ],
      ),
    );
  }
}

class CalculatorTileWidget extends StatelessWidget {
  final String symbol;
  final CalculatorEvent event;
  final Color? color;

  const CalculatorTileWidget({
    super.key,
    required this.event,
    required this.symbol,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final tileColor = color ?? Colors.white.withOpacity(0.06);
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: 80,
        height: 80,
        child: InkWell(
          onTap: () => context.read<CalculatorBloc>().add(event),
          borderRadius: BorderRadius.circular(60),
          child: ColoredBox(
            color: tileColor,
            child: Center(
              child: Text(
                symbol,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
