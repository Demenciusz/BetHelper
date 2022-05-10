// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localbet/history.dart';
import 'package:localbet/statistics.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:localbet/addbet.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      routes: {'/addbet': (context) => const AddBet(), '/history': (context) => const History(), '/stats': (context) => const Statistic()},
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white24,
        //Colors.white24
        primaryColor: Color(0xff800000),
        primarySwatch: Colors.red,
      ),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.gamepad), Text('BetApp')],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addbet');
                  },
                  child: Text(
                    "DODAJ ZAKŁAD",
                    style: TextStyle(fontSize: screenWidth * 0.08),
                  ),
                  style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColorDark),
                ),
                height: screenWidth * 0.3,
                width: screenWidth * 0.8,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                  child: Text(
                    "HISTORIA",
                    style: TextStyle(fontSize: screenWidth * 0.08),
                  ),
                  style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColorDark),
                ),
                height: screenWidth * 0.3,
                width: screenWidth * 0.8,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/stats');
                  },
                  child: Text("STATYSTYKI", style: TextStyle(fontSize: screenWidth * 0.08)),
                  style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColorDark),
                ),
                height: screenWidth * 0.3,
                width: screenWidth * 0.8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MatchBet {
  final int? id;
  final String shortcut1;
  final String region1;
  final String region2;
  final String shortcut2;
  final String betrate1;
  final String betrate2;
  final String winner;

  MatchBet(
      {this.id,
      required this.shortcut1,
      required this.shortcut2,
      required this.region1,
      required this.region2,
      required this.betrate1,
      required this.betrate2,
      required this.winner});

  factory MatchBet.fromMap(Map<String, dynamic> json) => MatchBet(
      id: json['id'],
      shortcut1: json['shortcut1'],
      shortcut2: json['shortcut2'],
      region1: json['region1'],
      region2: json['region2'],
      betrate1: json['betrate1'],
      betrate2: json['betrate2'],
      winner: json['winner']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shortcut1': shortcut1,
      'shortcut2': shortcut2,
      'region1': region1,
      'region2': region2,
      'betrate1': betrate1,
      'betrate2': betrate2,
      'winner': winner
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'betapp.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE matchbet(
      id INTEGER PRIMARY KEY,
      shortcut1 TEXT,
      shortcut2 TEXT,
      region1 TEXT,
      region2 TEXT,
      betrate1 TEXT,
      betrate2 TEXT,
      winner TEXT
    ) 
  ''');
  }

  Future<List<MatchBet>> getMatchBet() async {
    Database db = await instance.database;
    var matchsbet = await db.query('matchbet', orderBy: 'id');
    List<MatchBet> matchbetList = matchsbet.isNotEmpty ? matchsbet.map((c) => MatchBet.fromMap(c)).toList() : [];
    return matchbetList;
  }

  Future<int> add(MatchBet matchbet) async {
    Database db = await instance.database;
    return await db.insert("matchbet", matchbet.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('matchbet', where: 'id = ?', whereArgs: [id]);
  }
}
