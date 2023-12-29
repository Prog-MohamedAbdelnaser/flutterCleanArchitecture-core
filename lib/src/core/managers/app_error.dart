
class AppError{
  final String  ? title ;
  final String? asset ;
  final String message ;
  final String? buttonName ;
  final bool defaultAction ;
  final ErrorType errorType ;
  AppError({ this.title,  this.asset, required this.message, this.buttonName,this.defaultAction=false,required this.errorType});
}
enum ErrorType{
  Unknown ,
  UnAuthorized ,
  RequiredRegisteration,
  Timeout ,
  Data
}