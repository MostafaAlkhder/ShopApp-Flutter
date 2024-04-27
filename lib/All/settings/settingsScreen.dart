import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/bloc/ShopCubit/shopCubit.dart';
import 'package:shopapp/bloc/ShopCubit/shopStates.dart';
import 'package:shopapp/coomon/constance.dart';
import 'package:shopapp/shared/components.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AnimatedConditionalBuilder(
      condition: ShopCubit.get(context).shopProfileLoginModel != null,
      fallback: (context) => Center(child: CircularProgressIndicator()),
      builder: (context) => BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).shopProfileLoginModel;
          nameController.text = model!.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email',
                      prefix: Icons.email),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   color: Colors.blue,
                  //   child: MaterialButton(
                  //     onPressed: () {
                  //       if (formKey.currentState!.validate()) {
                  //         ShopCubit.get(context).updateUserData(
                  //           name: nameController.text,
                  //           phone: phoneController.text,
                  //           email: emailController.text,
                  //         );
                  //       }
                  //     },
                  //     child: Text(
                  //       "UPDATE",
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 20),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    width: double.infinity,
                    color: Colors.blue,
                    child: MaterialButton(
                      onPressed: () {
                        signOut(context);
                      },
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
