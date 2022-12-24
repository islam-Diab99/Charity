
import 'package:charity/modules/payment/ref_code_screen.dart';
import 'package:charity/modules/payment/vodafone_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';


import '../../shared/components/constants.dart';
import 'card_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


enum PaymentMethods {vodafoneCash,card,refCode,noSelect}


class ToggleScreen extends StatefulWidget {
   ToggleScreen({Key? key, required this.firstName, required this.lastName, required this.email, required this.phone, required this.amount}) : super(key: key);
final String firstName;
   final String lastName;
final String email;
final String phone;
final String amount;


  @override
  State<ToggleScreen> createState() => _ToggleScreenState();
}

class _ToggleScreenState extends State<ToggleScreen> {
   var selectedMethod=PaymentMethods.noSelect;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>PaymentCubit() ,
      child: BlocConsumer<PaymentCubit,PaymentStates>(
        listener: (context,state){
          if(state is RequestVodafoneUrlErrorState && selectedMethod==PaymentMethods.vodafoneCash)
          {
            print(state.error);

          }
          if(state is RequestCardTokenSuccessState && selectedMethod==PaymentMethods.card)
          {
           // launchUrl(Uri.parse(
           //     'https://www.accept.paymob.com/api/acceptance/iframes/709776?payment_token=$payMobFinalTokenCard'
           // ));
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CardScreen()));

            print('this is final$payMobFinalTokenCard');
          }
          if(state is RequestReferenceCodeSuccessState && selectedMethod==PaymentMethods.refCode)
          {

            Navigator.push(context, MaterialPageRoute(builder: (context)=>const RefCodeScreen()));

            print('this is final$payMobFinalTokenCard');
          }

          if(state is RequestVodafoneUrlSuccessState && selectedMethod==PaymentMethods.vodafoneCash)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> VodafoneScreen()));

            }

        },
        builder:(context,state)=> Scaffold(
          backgroundColor:Color.fromRGBO(37, 90, 123,1),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            title: Text('Payment Method',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),),
            leading: IconButton( onPressed: () {Navigator.pop(context);  }, icon: Icon(Icons.arrow_back_ios),),
            backgroundColor: Color.fromRGBO(37, 90, 123,1),
          ),

          body:

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50,),

              Stack(
                alignment: Alignment.bottomCenter,
                children: [

                  Container(
                    height:600

                    ,decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(50),topEnd: Radius.circular(50))
                  ),
                    child:   Padding(
                      padding: const EdgeInsets.only(top: 50,),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(height: 60,),

                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text('Choose your Payment Method',style: TextStyle(color: Colors.grey,fontSize: 20),),
                          ),
                          SizedBox(height: 20,),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectedMethod=PaymentMethods.card;
                                  });

                                },
                                child: Container(
                                  height: 100,
                                  color: selectedMethod==PaymentMethods.card?Color.fromRGBO(37, 90, 123,.2):Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Row(children: [
                                      Image(image: AssetImage('assets/card.png'),width: 70,height: 70,),
                                      SizedBox(width: 20,),
                                      Text('Credit / Debit Card',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,
                                          color: Color.fromRGBO(93, 93, 93, 1)),)
                                    ],),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectedMethod=PaymentMethods.refCode;
                                  });

                                  print(selectedMethod);
                                },
                                child: Container(
                                  height: 100,
                                  color: selectedMethod==PaymentMethods.refCode?Color.fromRGBO(37, 90, 123,.2):Colors.white,

                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Row(children:  [
                                      Image(image: AssetImage('assets/payment_machine.png'),width: 70,height: 70,),
                                      SizedBox(width: 20,),
                                      Text('Payment with Reference Code',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,
                                          color: Color.fromRGBO(93, 93, 93, 1)),)
                                    ],),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectedMethod=PaymentMethods.vodafoneCash;
                                  });
                                },
                                child: Container(
                                  height: 100,
                                  color: selectedMethod==PaymentMethods.vodafoneCash?Color.fromRGBO(37, 90, 123,.2):Colors.white,

                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Row(children:  [
                                      Image(image: AssetImage('assets/vodafone.PNG'),width: 100,height: 100,),
                                      SizedBox(width: 20,),
                                      Text('Vodafone Cash',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,
                                          color: Color.fromRGBO(93, 93, 93, 1)),)
                                    ],),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height:80,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(37, 90, 123,1),
                              borderRadius: BorderRadius.circular(35)

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Container(

                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(1,3),blurRadius: 1),],
                                        borderRadius: BorderRadius.circular(50)),
                                    height: 50,

                                    width: 130,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Text('Pay',style:
                                          TextStyle(color: Color.fromRGBO(37, 90, 123,1),fontWeight: FontWeight.bold,fontSize: 25)),
                                          SizedBox(width: 8,),
                                          Icon(Icons.arrow_forward,size: 22,color:Color.fromRGBO(37, 90, 123,1))
                                        ],
                                      ),
                                    )

                                ),
                                onTap: (){

                                  if(selectedMethod==PaymentMethods.refCode)
                                    {
                                      PaymentCubit.get(context).getFinalTokenKiosk(widget.amount, widget.firstName, widget.lastName, widget.email, widget.phone);
                                    }
                                  else if(selectedMethod==PaymentMethods.card)
                                    {
                                      PaymentCubit.get(context).getFinalTokenCard(widget.amount, widget.firstName, widget.lastName, widget.email, widget.phone);

                                    }
                                  else if(selectedMethod==PaymentMethods.vodafoneCash)
                                  {
                                    PaymentCubit.get(context).getFinalTokenVodafone(widget.amount, widget.firstName, widget.lastName, widget.email, widget.phone);

                                  }
                                },
                              ),
                              RichText(text: TextSpan(children: [
                                TextSpan(text: '${MoneyFormatter(
                                    amount: int.parse(widget.amount).toDouble()
                                ).output.nonSymbol} ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,)),
                                TextSpan(text: ' EGP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,))
                              ]))
                            ],),),


                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
}
