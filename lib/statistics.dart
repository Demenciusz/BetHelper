import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localbet/main.dart';
import 'package:sqflite/sqflite.dart';

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  List<String> teamsR = ['LEC', 'LCK', 'LPL', 'LCS'];
  String? selectedRegion = 'LEC';
  List<String> teamsScLec = ['AST', 'BDS', 'FNC', 'G2', 'MAD', 'MSF', 'RGE', 'SK', 'VIT', 'XL'];
  List<String> teamsScLck = ['BRO', 'DK', 'DRX', 'GEN', 'HLE', 'KDF', 'KT', 'LSB', 'NS', 'T1'];
  List<String> teamsScLcs = ['100', 'C9', 'CLG', 'DIG', 'EG', 'FLY', 'GG', 'IMT', 'TL', 'TSM'];
  List<String> teamsScLpl = [
    'AL',
    'BLG',
    'CO',
    'EDG',
    'FPX',
    'IG',
    'JDG',
    'LGD',
    'LNG',
    'OMG',
    'RA',
    'RNG',
    'TES',
    'TT',
    'UP',
    'V5',
    'WBG',
    'WE',
  ];
  String? selectedTeam;
  List<String> showedTeamsList = [];
  List<MatchBet> list = [];
  late Future<List<MatchBet>> DBlist;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      Future<List<MatchBet>> mat = DatabaseHelper.instance.getMatchBet();
      List<MatchBet> lista = await mat;
      list = await mat;
    });
    super.initState();
    showedTeamsList = teamsScLec;
    selectedTeam = 'G2';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gamepad),
            Text('BetApp'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.155,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                child: DropdownButton<String>(
                  dropdownColor: Color(0xff3D3D3D),
                  value: selectedRegion,
                  items: teamsR
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item,
                                style: TextStyle(fontSize: screenWidth * 0.1),
                              ),
                              Image.asset(
                                logoPathRegions(item),
                                height: screenWidth * 0.15,
                                width: screenWidth * 0.15,
                              )
                            ],
                          )))
                      .toList(),
                  onChanged: (item) => setState(
                    (() {
                      selectedRegion = item;
                      if (selectedRegion == 'LEC') {
                        selectedTeam = 'G2';
                        showedTeamsList = teamsScLec;
                      } else if (selectedRegion == 'LPL') {
                        selectedTeam = 'FPX';
                        showedTeamsList = teamsScLpl;
                      } else if (selectedRegion == 'LCK') {
                        selectedTeam = 'T1';
                        showedTeamsList = teamsScLck;
                      } else {
                        selectedTeam = 'TSM';
                        showedTeamsList = teamsScLcs;
                      }
                    }),
                  ),
                ),
                width: screenWidth * 0.5,
                height: screenWidth * 0.15,
              ),
              SizedBox(
                child: DropdownButton<String>(
                  dropdownColor: Color(0xff3D3D3D),
                  value: selectedTeam,
                  items: showedTeamsList
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item,
                                style: TextStyle(fontSize: screenWidth * 0.1),
                              ),
                              Image.asset(
                                pathforI(item, selectedRegion!),
                                height: screenWidth * 0.15,
                                width: screenWidth * 0.15,
                              )
                            ],
                          )))
                      .toList(),
                  onChanged: (item) => setState(
                    (() => selectedTeam = item),
                  ),
                ),
                width: screenWidth * 0.5,
                height: screenWidth * 0.15,
              ),
            ],
          ),
          SizedBox(
            child: Row(
              children: [
                SizedBox(
                  child: Text(
                    'WR: ',
                    style: TextStyle(fontSize: screenWidth * 0.08),
                  ),
                  width: screenWidth * 0.5,
                ),
                SizedBox(
                  child: Text(winrateString(selectedTeam!, 1), style: TextStyle(fontSize: screenWidth * 0.08)),
                  width: screenWidth * 0.5,
                )
              ],
            ),
            height: screenWidth * 0.3,
          ),
          SizedBox(
            child: Row(
              children: [
                SizedBox(
                  child: Text('WR Jako Faworyt: ', style: TextStyle(fontSize: screenWidth * 0.08)),
                  width: screenWidth * 0.5,
                ),
                SizedBox(
                  child: Text(winrateString(selectedTeam!, 2), style: TextStyle(fontSize: screenWidth * 0.08)),
                  width: screenWidth * 0.5,
                )
              ],
            ),
            height: screenWidth * 0.3,
          ),
          SizedBox(
            child: Row(
              children: [
                SizedBox(
                  child: Text('WR Jako Underdog: ', style: TextStyle(fontSize: screenWidth * 0.08)),
                  width: screenWidth * 0.5,
                ),
                SizedBox(
                  child: Text(winrateString(selectedTeam!, 3), style: TextStyle(fontSize: screenWidth * 0.08)),
                  width: screenWidth * 0.5,
                )
              ],
            ),
            height: screenWidth * 0.3,
          )
        ],
      ),
    );
  }

  String logoPathRegions(String item) {
    String pathforlogo = 'xd';
    switch (item) {
      case 'LCK':
        pathforlogo = 'assets/regions/lck.png';
        break;
      case 'LCS':
        pathforlogo = 'assets/regions/lcs.png';
        break;
      case 'LEC':
        pathforlogo = 'assets/regions/lec.png';
        break;
      case 'LPL':
        pathforlogo = 'assets/regions/lpl.png';
        break;
    }
    return pathforlogo;
  }

  String pathforI(String item, String region) {
    String pathforlogo = 'xd';
    switch (region) {
      case 'LEC':
        switch (item) {
          case 'G2':
            pathforlogo = 'assets/lec/g2.png';
            break;
          case 'AST':
            pathforlogo = 'assets/lec/ast.png';
            break;
          case 'BDS':
            pathforlogo = 'assets/lec/bds.png';
            break;
          case 'FNC':
            pathforlogo = 'assets/lec/fnc.png';
            break;
          case 'MAD':
            pathforlogo = 'assets/lec/mad.png';
            break;
          case 'MSF':
            pathforlogo = 'assets/lec/msf.png';
            break;
          case 'RGE':
            pathforlogo = 'assets/lec/rge.png';
            break;
          case 'SK':
            pathforlogo = 'assets/lec/sk.png';
            break;
          case 'VIT':
            pathforlogo = 'assets/lec/vit.png';
            break;
          case 'XL':
            pathforlogo = 'assets/lec/xl.png';
            break;
        }
        break;
      case 'LCK':
        switch (item) {
          case 'BRO':
            pathforlogo = 'assets/lck/bro.png';
            break;
          case 'DK':
            pathforlogo = 'assets/lck/dk.png';
            break;
          case 'DRX':
            pathforlogo = 'assets/lck/drx.png';
            break;
          case 'GEN':
            pathforlogo = 'assets/lck/gen.png';
            break;
          case 'HLE':
            pathforlogo = 'assets/lck/hle.png';
            break;
          case 'KDF':
            pathforlogo = 'assets/lck/kdf.png';
            break;
          case 'KT':
            pathforlogo = 'assets/lck/kt.png';
            break;
          case 'LSB':
            pathforlogo = 'assets/lck/lsb.png';
            break;
          case 'NS':
            pathforlogo = 'assets/lck/ns.png';
            break;
          case 'T1':
            pathforlogo = 'assets/lck/t1.png';
            break;
        }
        break;
      case 'LCS':
        switch (item) {
          case '100':
            pathforlogo = 'assets/lcs/100.png';
            break;
          case 'C9':
            pathforlogo = 'assets/lcs/c9.png';
            break;
          case 'CLG':
            pathforlogo = 'assets/lcs/clg.png';
            break;
          case 'DIG':
            pathforlogo = 'assets/lcs/dig.png';
            break;
          case 'EG':
            pathforlogo = 'assets/lcs/eg.png';
            break;
          case 'FLY':
            pathforlogo = 'assets/lcs/fly.png';
            break;
          case 'GG':
            pathforlogo = 'assets/lcs/gg.png';
            break;
          case 'IMT':
            pathforlogo = 'assets/lcs/imt.png';
            break;
          case 'TL':
            pathforlogo = 'assets/lcs/tl.png';
            break;
          case 'TSM':
            pathforlogo = 'assets/lcs/tsm.png';
            break;
        }
        break;
      case 'LPL':
        switch (item) {
          case 'AL':
            pathforlogo = 'assets/lpl/al.png';
            break;
          case 'BLG':
            pathforlogo = 'assets/lpl/blg.png';
            break;
          case 'CO':
            pathforlogo = 'assets/lpl/co.png';
            break;
          case 'EDG':
            pathforlogo = 'assets/lpl/edg.png';
            break;
          case 'FPX':
            pathforlogo = 'assets/lpl/fpx.png';
            break;
          case 'IG':
            pathforlogo = 'assets/lpl/ig.png';
            break;
          case 'JDG':
            pathforlogo = 'assets/lpl/jdg.png';
            break;
          case 'LGD':
            pathforlogo = 'assets/lpl/lgd.png';
            break;
          case 'LNG':
            pathforlogo = 'assets/lpl/lng.png';
            break;
          case 'OMG':
            pathforlogo = 'assets/lpl/omg.png';
            break;
          case 'RA':
            pathforlogo = 'assets/lpl/ra.png';
            break;
          case 'RNG':
            pathforlogo = 'assets/lpl/rng.png';
            break;
          case 'TES':
            pathforlogo = 'assets/lpl/tes.png';
            break;
          case 'TT':
            pathforlogo = 'assets/lpl/tt.png';
            break;
          case 'UP':
            pathforlogo = 'assets/lpl/up.png';
            break;
          case 'V5':
            pathforlogo = 'assets/lpl/v5.png';
            break;
          case 'WBG':
            pathforlogo = 'assets/lpl/wbg.png';
            break;
          case 'WE':
            pathforlogo = 'assets/lpl/we.png';
            break;
        }
        break;
    }
    return pathforlogo;
  }

  // Widget newtext(String teamStats, int option) {
  //   String textValue = '';
  //   double winrate = 0;
  //   int wins = 0;
  //   int losers = 0;
  //   int games = 0;

  //   if (option == 1) {
  //     for (int i = 0; i < list.length; i++) {
  //       if (list[i].betrate1 == teamStats && list[i].winner == 'TEAM1') {
  //         wins = wins + 1;
  //       } else if (list[i].betrate2 == teamStats && list[i].winner == 'TEAM2') {
  //         wins = wins + 1;
  //         games++;
  //       }
  //     }
  //     winrate = (wins / games) * 100;
  //     textValue = winrate.toString();

  //     return Text(textValue + '%');
  //   }
  //   return Text(textValue);
  // }

  String winrateString(String teamStats, int option) {
    String textValue = '';
    double winrate = 0;
    int wins = 0;
    int losers = 0;
    int games = 0;
    if (option == 1) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].shortcut1.toString() == teamStats) {
          games++;
          if (list[i].winner.toString() == 'TEAM1') {
            wins++;
          }
        } else if (list[i].shortcut2.toString() == teamStats) {
          games++;
          if (list[i].winner.toString() == 'TEAM2') {
            wins++;
          }
        }
      }
      winrate = (wins / games) * 100;
      textValue = winrate.toStringAsFixed(2);

      if (games != 0) {
        return textValue + '%';
      } else
        return 'brak danych';
    }
    if (option == 2) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].shortcut1 == teamStats && double.parse(list[i].betrate1) <= double.parse(list[i].betrate2)) {
          games++;
          if (list[i].winner.toString() == 'TEAM1') {
            wins++;
          }
        } else if (list[i].shortcut2 == teamStats && double.parse(list[i].betrate1) > double.parse(list[i].betrate2)) {
          games++;
          if (list[i].winner.toString() == 'TEAM2') {
            wins++;
          }
        }
      }
      winrate = (wins / games) * 100;
      textValue = winrate.toStringAsFixed(2);

      if (games != 0) {
        return textValue + '%';
      } else
        return 'brak danych';
    }
    if (option == 3) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].shortcut1 == teamStats && double.parse(list[i].betrate1) > double.parse(list[i].betrate2)) {
          games++;
          if (list[i].winner.toString() == 'TEAM1') {
            wins++;
          }
        } else if (list[i].shortcut2 == teamStats && double.parse(list[i].betrate1) <= double.parse(list[i].betrate2)) {
          games++;
          if (list[i].winner.toString() == 'TEAM2') {
            wins++;
          }
        }
      }
      winrate = (wins / games) * 100;
      textValue = winrate.toStringAsFixed(2);

      if (games != 0) {
        return textValue + '%';
      } else
        return 'brak danych';
    }
    return 'cos nie tak';
  }
}
