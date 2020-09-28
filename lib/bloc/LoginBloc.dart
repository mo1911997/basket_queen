import 'package:aaishani_store_user_app/models/ModelCommonResponse.dart';
import 'package:aaishani_store_user_app/models/Model_Login.dart';
import 'package:aaishani_store_user_app/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc
{
  var userName=BehaviorSubject<String>();
  var password=BehaviorSubject<String>();
  var token=BehaviorSubject<String>();

  Function(String) get getUserName => userName.sink.add;
  Function(String) get getPassword => password.sink.add;
  Function(String) get getToken => token.sink.add;
  Future <Model_Login> modelLogin;
  Future <ModelCommonResponse> modelCommonResponse;
  Repository repository = Repository();
  requestLogin() async{
    modelLogin =repository.requestLogin(userName.value,password.value);
    return modelLogin;
  }

  updateFCM() async{
    modelCommonResponse=repository.updateFCM(token.value);
    return modelCommonResponse;
  }
  void close()
  {
    userName.close();
    password.close();
  }
}

final LoginBloc loginBloc =LoginBloc();