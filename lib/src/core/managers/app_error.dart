
class AppError{
  final String  ? title ;
  final String asset ;
  final String message ;
  final String buttonName ;
  final bool excepted ;
  final bool defaultAction ;
  final ErrorType errorType ;
  AppError({required this.title, required this.asset, required this.message,this.excepted=true,required this.buttonName,this.defaultAction=false,required this.errorType});
}
enum ErrorType{
  Unknown ,
  UnAuthorized ,
  RequiredRegisteration,
  Timeout ,
  Data
}