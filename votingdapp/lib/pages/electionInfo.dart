import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:votingdapp/services/functions.dart';
import 'package:web3dart/web3dart.dart';

class ElectionInfo extends StatefulWidget {
  final Web3Client bnbClient;
  final String electionName;
  const ElectionInfo(
      {Key? key, required this.bnbClient, required this.electionName})
      : super(key: key);

  @override
  _ElectionInfoState createState() => _ElectionInfoState();
}

class _ElectionInfoState extends State<ElectionInfo> {
  TextEditingController addCandidateController = TextEditingController();
  TextEditingController authorizeVoterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.electionName),
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FutureBuilder<List>(
                        future: getCanidatesNum(widget.bnbClient),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Text(
                            snapshot.data![0].toString(),
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          );
                        }),
                    Text('Total Canidates')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
