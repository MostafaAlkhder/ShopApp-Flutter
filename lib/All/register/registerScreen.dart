import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/All/register/registerCubit.dart';
import 'package:shopapp/All/register/registerStates.dart';
import 'package:shopapp/coomon/constance.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/shopLayout.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status == true) {
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data?.token)
                  .then((value) {
                token = state.registerModel.data?.token;
                navigateAndFinish(context, ShopLayout());
                showToast(
                    message: state.registerModel.message,
                    state: ToastStates.SUCCESS);
              });
            } else {
              showToast(
                  message: state.registerModel.message,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "REGISTER",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w900),
                      ),
                      const Text("register now to browse our hot offers",
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value is String) if (value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value is String) if (value.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value is String) if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value is String) if (value.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.email_outlined,
                        suffix: ShopRegisterCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopRegisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          }
                        },
                        isPassword: ShopRegisterCubit.get(context).isPassword,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      AnimatedConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        // condition: true,
                        fallback: (BuildContext context) {
                          return Center(child: CircularProgressIndicator());
                        },
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              child: Text(
                                "REGISTER",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            // decoration: BoxDecoration(),
                            // borderRadius: BorderRadius.circular(radius), color: background),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
