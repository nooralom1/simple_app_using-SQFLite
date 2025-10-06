// ignore_for_file: unused_field, deprecated_member_use, unnecessary_string_interpolations
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_app/feature/jobs/presentation/jobs_screen.dart';
import 'package:simple_app/feature/profile/presentation/profile_screen.dart';
import 'package:simple_app/feature/saved_jobs/presentation/saved_jobs_screen.dart';
import 'package:simple_app/gen/assets.gen.dart';
import 'package:simple_app/gen/colors.gen.dart';
import 'package:simple_app/helpers/helper_methods.dart';

final class NavigationScreen extends StatefulWidget {
  final int? pageNum;

  const NavigationScreen({super.key, this.pageNum});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  final List _screens = [
    const JobsScreen(),
    const SavedJobsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageNum ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: SizedBox(
          height: 70.h,
          child: CustomNavigationBar(
            iconSize: 24.r,
            strokeColor: AppColors.primaryColor,
            backgroundColor: AppColors.cFFFFFF,
            items: [
              CustomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 0
                      ? Assets.icons.chome2
                      : Assets.icons.chome1,
                ),
                title: _currentIndex == 0
                    ? Text(
                        "Home",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.10.w,
                        ),
                      )
                    : const SizedBox(),
              ),
              CustomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 1 ? Assets.icons.jobs2 : Assets.icons.jobs1,
                ),
                title: _currentIndex == 1
                    ? Text(
                        "Saved Jobs",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
              ),
              CustomNavigationBarItem(
                icon: SvgPicture.asset(
                  _currentIndex == 2
                      ? Assets.icons.cprofile2
                      : Assets.icons.cprofile1,
                ),
                title: _currentIndex == 2
                    ? Text(
                        "Profile",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontFamily: 'Public Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
