class AppUrl {

  
  // static var baseUrl = 'http://192.168.1.71:8000/';
    static var baseUrl = 'http://192.168.1.73:8000/';

  // static var loginEndPoint =  'http://192.168.1.72:8000/login/' ;
  static var loginEndPoint =  baseUrl+'login/' ; 
  static var resetpassword = baseUrl+'reset-password';
  static var passwordverify = baseUrl+'reset-password-verify';
  static var changepassword = baseUrl+'change-password';
  static var changepasswordverify = baseUrl+'change-password-verify';

  static var teacherregisterApiEndPoint =  baseUrl+'teachersignup/' ;
  static var addteacherApiEndPoint =  baseUrl+'addteacher/' ;

  static var studentregisterApiEndPoint =  baseUrl+'studentsignup/' ;
  static var studentenrollmentApiEndPoint =  baseUrl+'enrollment/' ;


  static var findteacherinmap=  baseUrl+'find_teachers/';
  
  static var teacherlists= baseUrl+'teacher/';
  // static var enrolledlists='http://192.168.1.72:8000/teacher/';

  static var classSubjectSearch= baseUrl+'classSubject/';




}