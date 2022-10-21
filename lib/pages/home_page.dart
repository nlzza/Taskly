import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:taskly/services/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;
  late HTTPService https;

  HomePageState();

  @override
  void initState() {
    super.initState();
    https = GetIt.instance.get<HTTPService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _dropDown(),
              _dataWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropDown() {
    List<String> s = ["bitcoin"];
    List<DropdownMenuItem<String>> d = s
        .map(
          (e) => DropdownMenuItem<String>(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        )
        .toList();
    return SizedBox(
      width: _deviceWidth * 0.40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 121, 19, 141),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButton(
          dropdownColor: Colors.white,
          items: d,
          onChanged: (value) {},
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          iconSize: 20,
          underline: Container(),
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _dataWidgets() {
    return FutureBuilder(
      future: https.get("/coins/bitcoin"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());
          return Text(data.toString());
        } else {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        }
      },
    );
  }
}
