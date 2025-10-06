import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_app/common_widgets/custom_button.dart';
import 'package:simple_app/common_widgets/custom_text_form_field.dart';
import 'package:simple_app/constants/app_constants.dart';
import 'package:simple_app/gen/assets.gen.dart';
import 'package:simple_app/gen/colors.gen.dart';
import 'package:simple_app/helpers/all_routes.dart';
import 'package:simple_app/helpers/database_helper.dart';
import 'package:simple_app/helpers/di.dart';
import 'package:simple_app/helpers/navigation_service.dart';
import 'package:simple_app/helpers/toast.dart';
import 'package:simple_app/helpers/ui_helpers.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      bool isValidUser = await _databaseHelper.isUserExists(email, password);
      if (isValidUser) {
        appData.write(loggedInEmail, email);
        appData.write(kKeyIsLoggedIn, true);
        ToastUtil.showShortToast("Sign up successful");
        NavigationService.navigateTo(Routes.navigation);
      } else {
        ToastUtil.showShortToast("Invalid email or password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UIHelper.verticalSpace(120.h),
                Image.asset(
                  Assets.images.appLogo.path,
                  width: 117.w,
                  height: 48.h,
                ),
                UIHelper.verticalSpace(24.h),
                Text(
                  'Sign in to ScapeSync',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF212B36),
                    fontSize: 20.sp,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.50.h,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Text(
                  'Your AI-powered landscaping assistant is ready.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF637381),
                    fontSize: 14.sp,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.57.h,
                  ),
                ),
                UIHelper.verticalSpace(77.h),

                // Email text field
                CommonTextFormField(
                  isPrefixIcon: false,
                  labelText: "Email address",
                  hintText: "Enter your email",
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value ?? "");
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    } else if (!emailValid) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                ),
                UIHelper.verticalSpace(24.h),

                // Password text field
                CommonTextFormField(
                  controller: passwordController,
                  isPrefixIcon: false,
                  labelText: "Password",
                  hintText: "Enter your password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: _isPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      !_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xff637381),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return "Enter Minimum 8 Digit";
                    } else {
                      return null;
                    }
                  },
                ),
                UIHelper.verticalSpace(17.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Forgot password?',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w600,
                          height: 1.57,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(48.h),

                // Login button
                CustomButton(onTap: _login, text: "Login"),
                UIHelper.verticalSpace(24.h),

                // Registration redirect text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account? ',
                      style: TextStyle(
                        color: const Color(0xFF212B36),
                        fontSize: 14.sp,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.57.h,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationService.navigateTo(Routes.signup);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w600,
                          height: 1.57.h,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
