import 'package:clima/components/background_image.dart';
import 'package:clima/components/text_display.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/image_change.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool popped = false;
  String city;
  PageController controller = PageController(initialPage: 0);
  ValueNotifier<int> pageNo = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      DataDisplay(
        locationMode: true,
      ),
      if (popped)
        DataDisplay(
          locationMode: false,
          cityName: city,
        )
    ];
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(),
          Container(
            padding: EdgeInsets.only(bottom: 20.0),
            constraints: BoxConstraints.expand(),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() {
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          });
                        },
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var cityName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CityScreen(),
                            ),
                          );
                          if (cityName != null) {
                            setState(() {
                              city = cityName;
                              popped = true;
                              controller.jumpToPage(1);
                            });
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      onPageChanged: (page) {
                        pageNo.value = page;
                      },
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      children: pages,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: pageNo,
            builder: (context, value, _) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: PageViewDotIndicator(
                    currentItem: value,
                    count: pages.length,
                    unselectedColor: Colors.grey,
                    selectedColor: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DataDisplay extends StatefulWidget {
  final bool locationMode;
  final String cityName;
  const DataDisplay({Key key, @required this.locationMode, this.cityName})
      : super(key: key);
  @override
  _DataDisplayState createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  String city;
  String weatherIcon;
  String message;
  String temp;

  Future<WeatherModel> getData() async {
    WeatherModel data = WeatherModel();
    if (widget.locationMode) {
      await data.init();
    } else {
      await data.getCityData(widget.cityName);
    }
    city = data.city.toString();
    message = data.message;
    temp = data.temp.toStringAsFixed(1);
    weatherIcon = data.weatherIcon;
    backgroundImage.imageChange(data.bgimage);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
        Widget child;
        if (snapshot.hasData) {
          child = TextDisplay(
            city: city,
            temp: temp,
            message: message,
            weatherIcon: weatherIcon,
          );
        } else if (snapshot.hasError) {
          child = Center(
            child: Text(
              'Error has occured',
              style: kMessageTextStyle.copyWith(
                color: Colors.red.shade700,
              ),
            ),
          );
        } else {
          child = Center(
            child: SpinKitWave(
              color: Colors.grey,
            ),
          );
        }
        return child;
      },
    );
  }
}
