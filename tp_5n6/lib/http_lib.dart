import 'package:tp_5n6/transfer.dart';

Future<SignupResponse> signup(SignupRequest s) async {
  try {
    var response = await SingletonDio.getDio().post(
        'https://kickmyb-server.herokuapp.com/api/id/signup',
        data: s
    );
    print(response);
    return  SignupResponse.fromJson(response.data);

  } catch (e) {
    print(e);
    throw(e);
  }
}