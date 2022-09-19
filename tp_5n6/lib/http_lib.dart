import 'package:dio/dio.dart';
import 'package:tp_5n6/transfer.dart';

Future<SignupResponse> signup(SignupRequest s) async {
  try {
    var response = await Dio().post(
        'https://10.0.2.2/api/id/signup',
        data: s
    );
    print(response);
    return  SignupResponse.fromJson(response.data);

  } catch (e) {
    print(e);
    throw(e);
  }
}