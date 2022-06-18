import '../models/weather_model.dart';
import '../services/weather_api_client.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  WeatherApiClient client = WeatherApiClient();
  Weather? data = Weather();
  String? cityName;
  Future<void> getData(String? cityName) async {
    if (cityName == null) {
      data = await client.getCurrentWeather("Dhaka");
    } else {
      data = await client.getCurrentWeather(cityName);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Weather',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: width,
                    child: Form(
                      key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: width * 0.8,
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: TextFormField(
                              controller: myController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please eneter the city name';
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                labelText: "Enter your City name",
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: width * 0.2,
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    cityName = myController.text;
                                    getData(cityName);
                                  });
                                }
                              },
                              child: const Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 504,
                    width: width,
                    child: FutureBuilder(
                      future: getData(cityName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (data == null) {
                            return const Center(
                                child: Text("There is no data"));
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 160,
                                      width: width,
                                      child: Column(
                                        children: [
                                          Image.network(
                                              "http://openweathermap.org/img/w/${data!.icon}.png"),
                                          Text(
                                            "${data!.temparature} \u2103",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${data!.location}",
                                            style: const TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 120,
                                                margin: const EdgeInsets.only(
                                                  left: 5,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Max: ${data!.max} \u2103",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 120,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "desc: ${data!.description}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 120,
                                                margin: const EdgeInsets.only(
                                                  right: 5,
                                                ),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Min: ${data!.min} \u2103",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 5,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.amber),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 260,
                                      width: width,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Text(
                                                      "Feels Like",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      "${data!.feels_like} \u2103",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Text(
                                                      "Pressure",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      "${data!.pressure}",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Text(
                                                      "Humidity",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 5),
                                                    child: Text(
                                                      "${data!.humidity}%",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Text(
                                                      "Wind",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 150,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            bottom: 5),
                                                    child: Text(
                                                      "${data!.wind} Km/h",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        } else {
                          return Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.only(top: 20),
                              child: const CircularProgressIndicator(
                                value: 0.8,
                              ));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
