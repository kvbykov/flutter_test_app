import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_case/blocs/weather/weather_bloc.dart';
import 'package:test_case/repositories/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (conetxt) => WeatherBloc(
        WeatherRepository(),
      ),
      child: const WeatherWidget(),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        children: [
          WeatherSearchForm(),
          Spacer(),
          WeatherStatusWidget(),
          Spacer(),
        ],
      ),
    );
  }
}

class WeatherSearchForm extends StatefulWidget {
  const WeatherSearchForm({super.key});

  @override
  State<WeatherSearchForm> createState() => _WeatherSearchFormState();
}

class _WeatherSearchFormState extends State<WeatherSearchForm> {
  final _controller = TextEditingController(text: 'Saratov');
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                  key: const Key('weather_text_field'),
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    labelText: 'city',
                  )),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => context
                    .read<WeatherBloc>()
                    .add(WeatherSearchSubmitted(_controller.text)),
                icon: const Icon(Icons.search),
                label: const Text('search'),
              ),
            ),
          ],
        );
      },
    );
  }
}

class WeatherStatusWidget extends StatelessWidget {
  const WeatherStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (conetxt, state) {
        if (state.isInitial) return const Text('click "search" button');
        if (state.isInProgress) return const CircularProgressIndicator();
        if (state.isFailure) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Text('failed! check the city name and internet connection'),
          );
        }
        return Column(
          children: [
            Text(
              state.city.value,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud),
                const SizedBox(width: 15),
                Text('temperature: ${state.weather.temperature}'),
              ],
            ),
          ],
        );
      },
    );
  }
}
