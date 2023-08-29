import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showWidget = false; // Используется для определения, нужно ли показывать виджет

  void _toggleWidget() {
    setState(() {
      _showWidget = !_showWidget; // Переключение состояния виджета
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Widget Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _toggleWidget, // Вызывается при нажатии кнопки
              child: Text(_showWidget ? 'Скрыть виджет' : 'Показать виджет'),
            ),
            if (_showWidget) // Отображение виджета только при _showWidget == true
              MyCustomWidget(),
          ],
        ),
      ),
    );
  }
}

class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      color: Colors.blue,
      child: const Text(
        'Это созданный виджет!',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}