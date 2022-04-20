import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FaceBookLogin {

  // final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<Null> login(Function(String type, String id, String name, String photo) callback, Function(String) callbackError) async {

    try {
    LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.cancelled)
      return callbackError("login_canceled");
    var _userData = await FacebookAuth.instance.getUserData();

    var _photo = _userData["picture"]["data"]["url"];
    callback("facebook", _userData['id'], _userData['name'], _photo);

    } catch (e) {
      print(e);
      callbackError(e.toString());
    }


    // final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    //
    // switch (result.status) {
    //   case FacebookLoginStatus.loggedIn:
    //       try {
    //         _loginok(result.accessToken, callback);
    //       }catch (e){
    //       callbackError("$e");
    //       }
    //     break;
    //   case FacebookLoginStatus.cancelledByUser:
    //     dprint('Facebook login: Login cancelled by the user.');
    //     callbackError("login_canceled");
    //     break;
    //   case FacebookLoginStatus.error:
    //     var _error = 'Facebook login: Something went wrong with the login process.Here\'s the error Facebook gave us: ${result
    //         .errorMessage}';
    //     dprint(_error);
    //     callbackError(_error);
    //     break;
    // }
  }

  // _loginok(FacebookAccessToken accessToken,
  //     Function(String type, String id, String name, String photo) callback) async {
  //   dprint("Facebook login: token: ${accessToken.token}");
  //   dprint("Facebook login: userId: ${accessToken.userId}");
  //   var response = await http.get(Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken
  //       .token}')
  //       );
  //   var jsonResult = json.decode(response.body);
  //   dprint('Response status: ${response.statusCode}');
  //   dprint('Response body: ${response.body}');
  //
  //   Response ret = Response.fromJson(jsonResult);
  //   var _photo = 'https://graph.facebook.com/${accessToken.userId}/picture?type=square';
  //   callback("facebook", "${ret.id}", "${ret.name}", _photo);
  // }
}

class Response {
  String name;
  String firstName;
  String lastName;
  String email;
  String id;
  Response({required this.name, required this.firstName, required this.lastName, required this.email, required this.id});
  factory Response.fromJson(Map<String, dynamic> json){
    return Response(
      name: json['name'].toString(),
      firstName: json['first_name'].toString(),
      lastName: json['last_name'].toString(),
      email: json['email'].toString(),
      id: json['id'].toString(),
    );
  }
}
