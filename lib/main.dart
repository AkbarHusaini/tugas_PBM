import 'package:flutter/material.dart';
import 'package:flutter_application_1/weather.dart';
import 'data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  DataService dataService = DataService();
  Weather weather = Weather();
  bool isFetch = false;

  @override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitur Cuaca'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isFetch
                  ? Column(
                      children: [
                        Image.network(
                          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 16),
                        Text(
                          '${weather.temp}° F',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(height: 8),
                        Text(
                          weather.description,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(height: 24),
              Container(
                width: 200,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: "Enter City",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isFetch = true;
                  });
                  weather = await dataService.fetchData(controller.text);
                  setState(() {});
                },
                child: Text('Search'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 58, 255, 133),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}