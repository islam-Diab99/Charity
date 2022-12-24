import 'package:charity/modules/payment/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/first_token.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/dio.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitialState());
  static PaymentCubit get(context) => BlocProvider.of(context);
  FirstToken? firstToken;

  //get Authentication token

  Future getFirstToken(price) async {
    await DioHelperPayment.postData(
        url: 'auth/tokens', data: {'api_key': payMobApiKey}).then((value) {
      firstToken = FirstToken.fromJson(value.data);
      payMobToken = firstToken!.token.toString();
      emit(PaymentSuccessState());
    }).catchError((error) {
      emit(PaymentErrorState(error));
    }).whenComplete(() => getOrderId(price));
  }



  //get orderId using authentication token

  Future getOrderId(String price) async {
    await DioHelperPayment.postData(url: 'ecommerce/orders', data: {
      "auth_token": payMobToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "items": [],
      "currency": "EGP",
    }).then((value) {
      payMobOrderId = value.data['id'].toString();

      print(payMobOrderId);

      emit(PaymentOrderIdSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentOrderIdErrorState(error));
    });
  }

  Future getFinalTokenCard(String price, String firstName, String lastName,
      String email, String phone) async {
    await DioHelperPayment.postData(url: 'acceptance/payment_keys', data: {
      "auth_token": payMobToken,
      "amount_cents": '${int.parse(price) * 100}',
      "expiration": 3600,
      "order_id": payMobOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationIdCard,
      "lock_order_when_paid": "false"
    }).then((value) {
      payMobFinalTokenCard = value.data['token'].toString();

      print(payMobFinalTokenCard);

      emit(RequestCardTokenSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RequestCardTokenErrorState(error));
    });
  }

  Future getFinalTokenKiosk(String price, String firstName, String lastName,
      String email, String phone) async {
    await DioHelperPayment.postData(url: 'acceptance/payment_keys', data: {
      "auth_token": payMobToken,
      "amount_cents": '${int.parse(price) * 100}',
      "expiration": 3600,
      "order_id": payMobOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationIdKiosk,
      "lock_order_when_paid": "false"
    }).then((value) {
      payMobFinalTokenKiosk = value.data['token'];
      print(value.data['token'].toString());
      emit(RequestRefTokenSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RequestRefTokenErrorState(error));
    }).whenComplete(() => getReferenceCode(payMobFinalTokenKiosk));
  }

  Future getReferenceCode(String payMobFinalTokenKiosk) async {
    await DioHelperPayment.postData(url: 'acceptance/payments/pay', data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": payMobFinalTokenKiosk
    }).then((value) {
      kioskReferenceCode = value.data['id'].toString();

      emit(RequestReferenceCodeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RequestReferenceCodeErrorState(error));
    });
  }

  Future getFinalTokenVodafone(String price, String firstName, String lastName,
      String email, String phone) async {
    await DioHelperPayment.postData(url: 'acceptance/payment_keys', data: {
      "auth_token": payMobToken,
      "amount_cents": '${int.parse(price) * 100}',
      "expiration": 3600,
      "order_id": payMobOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstName,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": vodafoneIntegrationIdCard,
      "lock_order_when_paid": "false"
    }).then((value) {
      print(value.data['token']);
      payMobFinalTokenVodafone = value.data['token'].toString();

      emit(RequestVodafoneTokenSuccessState());
    }).catchError((error) {
      emit(RequestVodafoneTokenErrorState(error));
    }).whenComplete(() => getFinalUrlVodafone());
  }

  Future getFinalUrlVodafone() async {
    await DioHelperPayment.postData(url: 'acceptance/payments/pay', data: {
      "source": {"identifier": "vodafone cash", "subtype": "WALLET"},
      "payment_token": payMobFinalTokenVodafone
    }).then((value) {
      vodafoneUrl = value.data['redirect_url'].toString();
      print('pending is ${value.data['pending']}');
      print('this is url ${value.data['iframe_redirection_url']}');

      emit(RequestVodafoneUrlSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RequestVodafoneUrlErrorState(error.toString()));
    });
  }
}
