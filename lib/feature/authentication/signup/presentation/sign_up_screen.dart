// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_app/common_widgets/custom_button.dart';
import 'package:simple_app/common_widgets/custom_text_form_field.dart';
import 'package:simple_app/gen/assets.gen.dart';
import 'package:simple_app/gen/colors.gen.dart';
import 'package:simple_app/helpers/all_routes.dart';
import 'package:simple_app/helpers/database_helper.dart';
import 'package:simple_app/helpers/navigation_service.dart';
import 'package:simple_app/helpers/toast.dart';
import 'package:simple_app/helpers/ui_helpers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void dispose() {
    mailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = mailController.text.trim();
      String password = passController.text.trim();
      String confirmPassword = confirmPassController.text.trim();
      String name = nameController.text.trim();

      if (password != confirmPassword) {
        ToastUtil.showShortToast("Passwords do not match");
        return;
      }
      await _databaseHelper.saveUser(name, email, password);
      ToastUtil.showShortToast("Sign up successful");
      NavigationService.navigateTo(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
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
                  'Register to ScapeSync',
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
                  'Smarter landscaping starts here. Let AI transform your outdoor vision.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF637381),
                    fontSize: 14.sp,
                    fontFamily: 'Public Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.57.h,
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                // Name text field
                CommonTextFormField(
                  controller: nameController,
                  isPrefixIcon: false,
                  labelText: "Full Name",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name field is required";
                    } else {
                      return null;
                    }
                  },
                ),
                UIHelper.verticalSpace(24.h),
                // Email text field
                CommonTextFormField(
                  controller: mailController,
                  isPrefixIcon: false,
                  labelText: "Email address",
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
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
                  controller: passController,
                  isPrefixIcon: false,
                  labelText: "Password",
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
                UIHelper.verticalSpace(24.h),

                // Confirm password text field
                CommonTextFormField(
                  controller: confirmPassController,
                  isPrefixIcon: false,
                  labelText: "Confirm Password",
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: _isConfirmPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                    child: Icon(
                      !_isConfirmPasswordVisible
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

                UIHelper.verticalSpace(50.h),

                // Register button
                CustomButton(
                  text: "Register",
                  onTap: _signUp,
                  bgColor: AppColors.primaryColor,
                ),
                UIHelper.verticalSpace(32.h),

                // Login redirection text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?  ",
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
                        NavigationService.navigateTo(Routes.login);
                      },
                      child: Text(
                        "Login",
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
