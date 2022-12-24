abstract class PaymentStates{}

class PaymentInitialState extends PaymentStates{}
class PaymentSuccessState extends PaymentStates{}
class PaymentErrorState extends PaymentStates{
  String error;
  PaymentErrorState(this.error);
}

class PaymentOrderIdSuccessState extends PaymentStates{}
class PaymentOrderIdErrorState extends PaymentStates{
  String error;
  PaymentOrderIdErrorState(this.error);
}

class RequestCardTokenSuccessState extends PaymentStates{}
class RequestCardTokenErrorState extends PaymentStates{
  String error;
  RequestCardTokenErrorState(this.error);
}

class RequestReferenceCodeSuccessState extends PaymentStates{}
class RequestReferenceCodeErrorState extends PaymentStates{
  String error;
  RequestReferenceCodeErrorState(this.error);
}

class RequestRefTokenSuccessState extends PaymentStates{}
class RequestRefTokenErrorState extends PaymentStates{
  String error;
  RequestRefTokenErrorState(this.error);
}

class RequestVodafoneTokenSuccessState extends PaymentStates{}
class RequestVodafoneTokenErrorState extends PaymentStates{
  String error;
  RequestVodafoneTokenErrorState(this.error);
}

class RequestVodafoneUrlSuccessState extends PaymentStates{}
class RequestVodafoneUrlErrorState extends PaymentStates{
  String error;
  RequestVodafoneUrlErrorState(this.error);
}