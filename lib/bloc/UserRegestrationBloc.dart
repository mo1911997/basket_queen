
import 'package:aaishani_store_user_app/models/Model_MobileVerification.dart';
import 'package:aaishani_store_user_app/models/Model_UserRegistration.dart';
import 'package:aaishani_store_user_app/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class UserRegistrationBloc{

  var firstName =BehaviorSubject<String>();
  var lastName =BehaviorSubject<String>();
  var emailId =BehaviorSubject<String>();
  var mobileNo =BehaviorSubject<String>();
  var password =BehaviorSubject<String>();
  var otp =BehaviorSubject<String>();

  Function(String) get getFirstName => firstName.sink.add;
  Function(String) get getLastName => lastName.sink.add;
  Function(String) get getEmailId => emailId.sink.add;
  Function(String) get getMobileNo => mobileNo.sink.add;
  Function(String) get getPassword => password.sink.add;
  Function(String) get getOTP => otp.sink.add;

  Future<Model_UserRegistration> modelUserRegistration;
  Future<Model_MobileVerification> modelMobileVerification;
  Repository repository=Repository();
  requestUserRegistration()
  {
    modelUserRegistration= repository.requestUserRegistration(firstName.value+" "+ lastName.value, mobileNo.value, emailId.value,password.value);
    return modelUserRegistration;
  }

  mobileVerification()
  {
    modelMobileVerification =repository.requestMobileVerification(mobileNo.value, otp.value, "registration");
    return modelMobileVerification;
  }

  close()
  {
    firstName.close();
    lastName.close();
    emailId.close();
    mobileNo.close();
    password.close();
    otp.close();
  }

}

final  UserRegistrationBloc userRegistrationBloc = UserRegistrationBloc();