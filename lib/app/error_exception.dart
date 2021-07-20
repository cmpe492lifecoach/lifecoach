class Errors {
  static String showErrors(String errorCode){
    switch(errorCode){
      case 'ERROR_EMAIL_ALREADY_IN_USE':

        return "Email already use. Please use different email.";



      case 'ERROR_USER_NOT_FOUND' :
        return "User Not Found!!!";

      default:
        return "Something wrong!!!!";
    }
  }
}