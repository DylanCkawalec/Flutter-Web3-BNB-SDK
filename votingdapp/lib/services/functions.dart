//all backend functions for interacting with Smart Contract

import 'package:flutter/services.dart';
import 'package:votingdapp/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

//loading the original contract after deployment
Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = mainContractAddress;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Election'),
      EthereumAddress.fromHex(contractAddress));

  return contract;
}

/*bnbClient may leave an error*/
// helper function
Future<String> callFunction(String funcName, List<dynamic> args,
    Web3Client bnbClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final bnbFunction = contract.function(funcName);
  final result = await bnbClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: bnbFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

//Smart Contract Functions

//Starting the election
Future<String> startElection(String name, Web3Client bnbClient) async {
  var response =
      await callFunction('startElection', [name], bnbClient, owner_private_key);
  print('BNB Election Started Successfully!');
  return response;
}

//adding canidates into voting list
Future<String> addCandidate(String name, Web3Client bnbClient) async {
  var response =
      await callFunction('addCandidate', [name], bnbClient, owner_private_key);
  print('BNB Canidate Added Successfully!');
  return response;
}

//authorise a single vote
Future<String> authorizeVoter(String voterAddress, Web3Client bnbClient) async {
  var response = await callFunction('authorizeVoter',
      [EthPrivateKey.fromHex(voterAddress)], bnbClient, owner_private_key);
  print('BNB Voter Authorized Successfully');
  return response;
}

//calling the 'ask' function
Future<List> getCanidatesNum(Web3Client bnbClient) async {
  List<dynamic> result = await ask('getNumCandidates', [], bnbClient);
  return result;
}

//getting the number of canidates
Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client bnbClient) async {
  final contract = await loadContract();
  final bnbFunction = contract.function(funcName);
  final result =
      bnbClient.call(contract: contract, function: bnbFunction, params: args);
  return result;
}

//for voting
Future<String> vote(int canidateIndex, Web3Client bnbClient) async {
  var response = await callFunction(
      "vote", [BigInt.from(canidateIndex)], bnbClient, voter_private_key);
  print("Vote Counted");
  return response;
}
