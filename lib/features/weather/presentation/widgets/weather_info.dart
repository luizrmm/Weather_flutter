import 'package:flutter/widgets.dart';
import 'package:teste_flutter/features/weather/domain/entities/weather.dart';
import 'package:teste_flutter/features/weather/presentation/widgets/weather_Image.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;

  const WeatherInfo({Key key, this.weather}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 6),
          child: Text(
            weather.cityName,
            style: TextStyle(fontSize: 32),
          ),
        ),
        Text(
          'Last update ${weather.time}',
          style: TextStyle(fontSize: 14),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 16),
          child: Text(
            weather.description,
            style: TextStyle(fontSize: 20),
          ),
        ),
        WeatherConditionWidget(condition: weather.conditionSlug),
        Padding(
          padding: const EdgeInsets.only(top: 26),
          child: Text(
            '${weather.temperature}ºC',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ],
    );
  }
}
