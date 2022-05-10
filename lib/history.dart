import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localbet/main.dart';
import 'package:sqflite/sqflite.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
        body: Center(
          child: FutureBuilder<List<MatchBet>>(
            future: DatabaseHelper.instance.getMatchBet(),
            builder: (BuildContext context, AsyncSnapshot<List<MatchBet>> snapshot) {
              var list = snapshot.data;
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView.builder(
                      itemCount: list!.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  child: Text(list[index].shortcut1, style: TextStyle(fontSize: screenWidth * 0.07)),
                                  width: screenWidth * 0.17,
                                ),
                                SizedBox(
                                  child: Image.asset(pathforI(list[index].shortcut1, list[index].region1),
                                      height: screenWidth * 0.12, width: screenWidth * 0.12),
                                  width: screenWidth * 0.13,
                                ),
                                SizedBox(
                                  child: Image.asset(pathforI(list[index].shortcut2, list[index].region2),
                                      height: screenWidth * 0.12, width: screenWidth * 0.12),
                                  width: screenWidth * 0.13,
                                ),
                                SizedBox(
                                  child: Text(list[index].shortcut2, style: TextStyle(fontSize: screenWidth * 0.07)),
                                  width: screenWidth * 0.17,
                                ),
                                SizedBox(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: screenWidth * 0.08,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(''),
                                                  content: Text(
                                                    'Czy na pewno chcesz usunąć zakład z historii?',
                                                    style: TextStyle(fontSize: screenWidth * 0.06),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            DatabaseHelper.instance.remove(list[index].id!);
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('OK', style: TextStyle(fontSize: screenWidth * 0.06))),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('BACK', style: TextStyle(fontSize: screenWidth * 0.06)))
                                                  ],
                                                ));
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            color: list[index].winner == 'TEAM1' ? Colors.green.shade300 : Colors.red.shade300,
                          ),
                          height: screenWidth * 0.2,
                        );
                      });
                } else {
                  return Center(
                    child: Text('Brak meczy w historii'),
                  );
                }
              } else {
                return Center(
                  child: Text('Ładowanie...'),
                );
              }
            },
          ),
        ));
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
