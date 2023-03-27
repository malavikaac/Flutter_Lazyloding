import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List dummyList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;
  @override
  void initState() {
    super.initState();

    dummyList = List.generate(10, (index) => "Item: ${index + 1}");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreList();
      }
    });
  }

  _getMoreList() {
    print("Get More List");
    {
      for (int i = _currentMax; i < _currentMax + 10; i++) {
        dummyList.add("Item : ${i + 1}");
      }
      _currentMax = _currentMax + 10;
      setState(() {});
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Lazy Loading",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          backgroundColor: Color.fromARGB(255, 56, 56, 56),
        ),
        body: ListView.builder(
            controller: _scrollController,
            itemExtent: 80,
            itemBuilder: ((context, index) {
              if (index == dummyList.length) {
                return CupertinoActivityIndicator();
              }
              return ListTile(
                title: Text(dummyList[index]),
              );
            }),
            itemCount: dummyList.length + 1));
  }
}
