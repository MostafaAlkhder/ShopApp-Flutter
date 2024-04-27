import 'package:animated_conditional_builder/animated_conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/coomon/constance.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/shared/components.dart';
import 'package:shopapp/All/login/loginCubit.dart';
import 'package:shopapp/All/login/loginStates.dart';
import 'package:shopapp/All/register/registerScreen.dart';
import 'package:shopapp/shopLayout.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data?.token)
                  .then((value) {
                token = state.loginModel.data?.token;
                navigateAndFinish(context, ShopLayout());
                showToast(
                    message: state.loginModel.message,
                    state: ToastStates.SUCCESS);
              });
            } else {
              showToast(
                  message: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
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
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w900),
                          ),
                          const Text("login now to browse our hot offers",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          const SizedBox(
                            height: 30,
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
                            suffix: ShopLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: ShopLoginCubit.get(context).isPassword,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          AnimatedConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
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
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                // decoration: BoxDecoration(),
                                // borderRadius: BorderRadius.circular(radius), color: background),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: const Text("register"))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
