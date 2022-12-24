


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../payment/cubit/cubit.dart';
import '../payment/cubit/states.dart';
import '../payment/toggle_screen.dart';

class RegisterScreen extends StatelessWidget {
  var firstNameController=TextEditingController();
  var lastNameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneNumberController=TextEditingController();
  var priceController=TextEditingController();
  final _formKey = GlobalKey<FormState>();



  RegisterScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: defaultColor,
        shadowColor: Colors.transparent,
        title: Text(
          'Charity',
          style:
          TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 35,

          ),
        ),


      ),
      body: BlocProvider(
        create: (context)=>PaymentCubit(),
        child: BlocConsumer<PaymentCubit,PaymentStates>(
          listener: (context,state){
            if (state is PaymentOrderIdSuccessState)
            {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>ToggleScreen(
                amount: priceController.text,
                email: emailController.text,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                phone: phoneNumberController.text,
              )));
            }
            if (state is PaymentErrorState)
              {
                if (kDebugMode) {
                  print(state.error);
                }
              }
            if (state is PaymentOrderIdErrorState)
            {
              if (kDebugMode) {
                print(state.error);
              }}


          } ,
          builder:(context,state){
            return SafeArea(
              child:

              Stack(

                children: [

                  Form(
                    key: _formKey,

                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(



                          children: [


                            Image(image: AssetImage('assets/register_photo.jpg',),width: 250,height: 250,),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(text: TextSpan(children: [
                                TextSpan(text: 'Donate now for',style: TextStyle(fontSize: 25,color: Colors.grey,fontFamily: 'futura')),
                                TextSpan(text: ' homeless ',style: TextStyle(fontSize: 25,color: defaultColor, fontFamily: 'futura')),
                                TextSpan(text: 'people',style: TextStyle(fontSize: 25,color: Colors.grey,fontFamily: 'futura')),
                              ])),
                            ),
                            SizedBox(height: 10,),
                            // Text('Donate now for homeless people',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25),),
                            SizedBox(height: 10,),
                            defaultFormField(
                              controller: firstNameController,
                              type: TextInputType.name,
                              validate: (String? value){
                                if (value!.isEmpty){
                                  return 'please don\'t leave this field empty';
                                }
                              },
                              label: 'first name',
                              prefix: Icons.person,

                            ),
                            SizedBox(height: 20,),
                            defaultFormField(
                              controller: lastNameController,
                              type: TextInputType.name,
                              validate: (String? value){
                                if (value!.isEmpty){
                                  return 'please don\'t leave this field empty';
                                }
                              },
                              label: 'last name',
                              prefix: Icons.person,

                            ),
                            SizedBox(height: 20,),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value){
                                if (!value!.endsWith('@gmail.com')){
                                  return 'this isn\'t an Email format';
                                }
                              },
                              label: 'Email',
                              prefix: Icons.email,

                            ),
                            SizedBox(height: 20,),
                            defaultFormField(
                              controller: phoneNumberController,
                              type: TextInputType.phone,
                              validate: (String? value){
                                if (value!.length<9){
                                  return 'this isn\'t a phone number format';
                                }
                              },
                              label: 'phone',
                              prefix: Icons.phone,

                            ),
                            SizedBox(height: 20,),
                            defaultFormField(
                              controller: priceController ,
                              type: TextInputType.number,
                              validate: (String? value){
                                if (value!.isEmpty){
                                  return 'please don\'t leave this field empty';
                                }
                              },
                              label: 'Sum in EGP',
                              prefix: Icons.payments,

                            ),
                            SizedBox(height: 30,),
                            defaultButton(function: (){
                              if (_formKey.currentState!.validate()){
                                PaymentCubit.get(context).getFirstToken(priceController.text);

                              }

                            }, text: 'GO TO DONATE',radius: 20,)

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );

          } ,

        ),
      ),
    );
  }
}
