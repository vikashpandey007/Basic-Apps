import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DynamicWidget> listDynamic = [DynamicWidget()];
  List data = [];

  Icon floatingIcon = Icon(Icons.add);

  addDynamic() {
    if (data.length != 0) {}
    setState(() {});
    if (listDynamic.length >= 10) {
      return;
    }
    listDynamic.add(DynamicWidget());
  }

  submitData() {
    // floatingIcon = Icon(Icons.arrow_back);
    data = [];

    // ignore: avoid_function_literals_in_foreach_calls
    listDynamic.forEach((widget) {
      final dic = {
        "item": widget.controller.text,
        "portion": widget.controller1.text
      };

      setState(() {
        data.add(dic);
      });
    });

    print(data);
  }

  @override
  Widget build(BuildContext context) {
    //

    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: listDynamic.length,
        itemBuilder: (_, index) => listDynamic[index],
      ),
    );

    Widget submitButton = Container(
      child: RaisedButton(
        onPressed: submitData,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Submit Data'),
        ),
      ),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic App'),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[dynamicTextField, submitButton],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addDynamic,
          child: floatingIcon,
        ),
      ),
    );
  }
}

class DynamicWidget extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'item '),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: TextField(
              controller: controller1,
              decoration: InputDecoration(hintText: 'portion '),
            ),
          ),
        ),
      ],
    );
  }
}
