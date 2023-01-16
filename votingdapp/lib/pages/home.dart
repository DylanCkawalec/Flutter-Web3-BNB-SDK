import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:votingdapp/pages/electionInfo.dart';
import 'package:votingdapp/services/functions.dart';
import 'package:votingdapp/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? bnbClient;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    bnbClient = Web3Client(chainstack_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BNB Election'),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  filled: true, hintText: 'Enter BNB Election Name'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    onPressed: () async {
                      if (controller.text.length > 0) {
                        await startElection(controller.text, bnbClient!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ElectionInfo(
                                    bnbClient: bnbClient!,
                                    electionName: controller.text)));
                      }
                    },
                    child: Text('Start a BNB Election')))
          ],
        ),
      ),
    );
  }
}
