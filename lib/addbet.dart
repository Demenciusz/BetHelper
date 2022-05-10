// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localbet/main.dart';
import 'package:sqflite/sqflite.dart';

class AddBet extends StatefulWidget {
  const AddBet({Key? key}) : super(key: key);

  @override
  State<AddBet> createState() => _AddBetState();
}

final myRegex = RegExp(r'^[0-9]+\.[0-9][0-9]$');

class _AddBetState extends State<AddBet> {
  List<String> teamsR = ['LEC', 'LCK', 'LPL', 'LCS'];
  String? selectedRegion = 'LEC';
  String? selectedRegion2 = 'LEC';

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
  String? selectedTeam = 'G2';
  String? selectedTeam2 = 'G2';

  List<String> showedTeamsList = [];
  List<String> showedTeamsList2 = [];

  String winnerId = 'TEAM1';
  final firstBetController = TextEditingController();
  final secondBetController = TextEditingController();
  String firstBetValue = '';
  String secondBetValue = '';
  static final table = 'matchbet';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showedTeamsList = teamsScLec;
    showedTeamsList2 = teamsScLec;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              )
            ],
          ),
          SizedBox(
            child: TextField(
              controller: firstBetController,
              maxLength: 5,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Kurs',
                labelStyle: TextStyle(fontSize: screenWidth * 0.15),
              ),
            ),
            width: screenWidth * 0.5,
            height: screenWidth * 0.1,
          ),
          Row(
            children: [
              SizedBox(
                child: DropdownButton<String>(
                  dropdownColor: Color(0xff3D3D3D),
                  value: selectedRegion2,
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
                      selectedRegion2 = item;
                      if (selectedRegion2 == 'LEC') {
                        selectedTeam2 = 'G2';
                        showedTeamsList2 = teamsScLec;
                      } else if (selectedRegion2 == 'LPL') {
                        selectedTeam2 = 'FPX';
                        showedTeamsList2 = teamsScLpl;
                      } else if (selectedRegion2 == 'LCK') {
                        selectedTeam2 = 'T1';
                        showedTeamsList2 = teamsScLck;
                      } else {
                        selectedTeam2 = 'TSM';
                        showedTeamsList2 = teamsScLcs;
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
                  value: selectedTeam2,
                  items: showedTeamsList2
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
                                pathforI(item, selectedRegion2!),
                                height: screenWidth * 0.15,
                                width: screenWidth * 0.15,
                              )
                            ],
                          )))
                      .toList(),
                  onChanged: (item) => setState(
                    (() => selectedTeam2 = item),
                  ),
                ),
                width: screenWidth * 0.5,
                height: screenWidth * 0.15,
              )
            ],
          ),
          SizedBox(
            child: TextField(
              controller: secondBetController,
              maxLength: 5,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Kurs',
                labelStyle: TextStyle(fontSize: screenWidth * 0.1),
              ),
            ),
            width: screenWidth * 0.5,
            height: screenWidth * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Team1 is winner',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                ),
              ),
              Radio<String>(value: 'TEAM1', groupValue: winnerId, onChanged: (value) => setState(() => winnerId = 'TEAM1'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Team2 is winner',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                ),
              ),
              Radio<String>(value: 'TEAM2', groupValue: winnerId, onChanged: (value) => setState(() => winnerId = 'TEAM2'))
            ],
          ),
          SizedBox(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  firstBetValue = firstBetController.text;
                  firstBetValue = firstBetValue.replaceAll(',', '.');
                  secondBetValue = secondBetController.text;
                  secondBetValue = secondBetValue.replaceAll(',', '.');
                  if (('.'.allMatches(firstBetValue).length <= 1) && ('.'.allMatches(secondBetValue).length <= 1)) {
                    if (firstBetValue.isNotEmpty && secondBetValue.isNotEmpty) {
                      if ((myRegex.hasMatch(firstBetValue) | ('.'.allMatches(firstBetValue).isEmpty)) &&
                          (myRegex.hasMatch(secondBetValue) | ('.'.allMatches(secondBetValue).isEmpty))) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Dodaj Zakład'),
                                  content: Text('Czy na pewno chcesz dodać zakład?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          await DatabaseHelper.instance.add(MatchBet(
                                              shortcut1: selectedTeam!,
                                              shortcut2: selectedTeam2!,
                                              region1: selectedRegion!,
                                              region2: selectedRegion2!,
                                              betrate1: firstBetValue,
                                              betrate2: secondBetValue,
                                              winner: winnerId));

                                          Navigator.pop(context);
                                        },
                                        child: Text('OK')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Back'))
                                  ],
                                ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Błąd'),
                                  content: Text(
                                      'Kurs musi zawierać dwie liczby po przecinku lub występować bez przecinka w przypadku braku części setnej'),
                                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
                                ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Błąd'),
                                content: Text('Kurs jest pusty'),
                                actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
                              ));
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Błąd'),
                              content: Text('Kurs może zawierać TYLKO JEDEN przecinek lub kropkę'),
                              actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
                            ));
                  }
                });
              },
              child: Text(
                "DODAJ ZAKŁAD",
                style: TextStyle(fontSize: screenWidth * 0.09),
              ),
              style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColorDark),
            ),
            height: screenWidth * 0.2,
            width: screenWidth * 0.8,
          )
        ],
      ),
    );
  }

//path for lec team img
  String logoPathLEC(String item) {
    String pathforlogo = 'xd';
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
    return pathforlogo;
  }

//path for lck team img
  String logoPathLCK(String item) {
    String pathforlogo = 'xd';
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
    return pathforlogo;
  }

//path for lpl team img
  String logoPathLPL(String item) {
    String pathforlogo = 'xd';
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
    return pathforlogo;
  }

//path for lcs team img
  String logoPathLCS(String item) {
    String pathforlogo = 'xd';
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
        pathforlogo = 'assets/lcs/EG.png';
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
    return pathforlogo;
  }

//path for region img
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

  Widget logoView(String selectedRegion, String item) {
    switch (selectedRegion) {
      case 'LEC':
        return Image.asset(
          logoPathLEC(item),
          width: 50,
          height: 50,
        );
      case 'LCK':
        return Image.asset(
          logoPathLCK(item),
          width: 50,
          height: 50,
        );
      case 'LCS':
        return Image.asset(
          logoPathLCS(item),
          width: 50,
          height: 50,
        );
      case 'LPL':
        return Image.asset(
          logoPathLPL(item),
          width: 50,
          height: 50,
        );
    }
    return Image.asset('assets/lec/g2.png');
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
}

//Database db = await DatabaseHelper.instance.database;
                                          //List<Map> result = await db.query(table);
                                          //result.forEach((row) => print(row));
                                          //Future<List<MatchBet>> mat = DatabaseHelper.instance.getMatchBet();
                                          //List<MatchBet> lista = await mat;
                                          //print('NOWA LISTA------');
                                          //print(lista[1].id);