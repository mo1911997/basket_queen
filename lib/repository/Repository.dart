import 'package:aaishani_store_user_app/NetworkProvider/ApiProvider.dart';
import 'package:aaishani_store_user_app/models/ModelCommonResponse.dart';
import 'package:aaishani_store_user_app/models/Model_Login.dart';
import 'package:aaishani_store_user_app/models/Model_MobileVerification.dart';
import 'package:aaishani_store_user_app/models/Model_UserRegistration.dart';
import 'package:aaishani_store_user_app/models/ServicesModel.dart';
import 'package:aaishani_store_user_app/models/model_album.dart';

class Repository{
  ApiProvider apiProvider=ApiProvider();
  Future <List<Model_Album>> get_album_data()=>apiProvider.get_album_data();

  Future <Model_Login> requestLogin(userName,password)=>apiProvider.requestLogin(userName,password);

  Future <Model_UserRegistration> requestUserRegistration(name,contact,email,password)=>apiProvider.requestUserRegistration(name,contact,email,password);

  Future <Model_MobileVerification> requestMobileVerification(contact,otp,flag)=>apiProvider.requestMobileVerification(contact,otp,flag);

  Future <ModelCommonResponse> updateFCM(fcmToken)=>apiProvider.updateFCM(fcmToken);

  Future<ServicesModel> getServices() => apiProvider.getServices();
}
