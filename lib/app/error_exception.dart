class Errors {
  static String showErrors(String errorCode){
    switch(errorCode){
      case 'ERROR_EMAIL_ALREADY_IN_USE':

        return "Email already use. Please use different email.";
      default:
        return "Something wrong!!!!";
    }
  }
}