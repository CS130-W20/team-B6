import 'package:flutter/material.dart';


// void main() => runApp(new MyApp());
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new DiscoverPage(),
//     );
//   }
// }

class DiscoverPage extends StatelessWidget {

  void disoverButtonPressed(topic) {

    print (topic + ' button has been pressed');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new GridView.count(
  primary: false,
  padding: const EdgeInsets.all(20),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  crossAxisCount: 2,
  children: <Widget>[
    
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Business'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/business.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Technology'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/technology.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Sports'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/sports.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Entertainment'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/entertainment.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Science'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/science.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Politics'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/politics.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Startups'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/startups.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('International'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/international.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Automobile'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/automobile.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    Container(
      child: InkWell(
      onTap: () => disoverButtonPressed('Travel'), // handle your onTap here
      child: Container(
      padding: const EdgeInsets.all(8),
      child: new Image.asset("images/travel.png"),
      decoration: BoxDecoration(
      border: Border.all(color: Colors.black26)
      ),
    ),
    ),
    ),
    
  ],
  )

            
  )
  );
    
  }
}
