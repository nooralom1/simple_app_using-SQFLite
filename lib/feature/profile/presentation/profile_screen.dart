import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_app/constants/app_constants.dart';
import 'package:simple_app/gen/assets.gen.dart';
import 'package:simple_app/gen/colors.gen.dart';
import 'package:simple_app/helpers/database_helper.dart';
import 'package:simple_app/helpers/di.dart';
import 'package:simple_app/helpers/ui_helpers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Map<String, dynamic>> savedJobs = [];
  String userName = "Loading...";
  String userEmail = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadSavedJobs();
    _loadUserData();
  }

  // Load saved jobs from SQLite
  void _loadSavedJobs() async {
    final jobs = await _databaseHelper.getSavedJobs();
    setState(() {
      savedJobs = jobs;
    });
  }

  void _loadUserData() async {
    final userData = await _databaseHelper.getUserDataByEmail(
      appData.read(loggedInEmail),
    );
    if (userData != null) {
      setState(() {
        userName = userData['name'];
        userEmail = userData['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.profileScreen.path),
          fit: BoxFit.fill,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(90.h),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.r),
                  child: CachedNetworkImage(
                    placeholder: (context, url) {
                      return CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 45.r,
                        child: const Center(
                          child: Icon(Icons.person, color: AppColors.cFFFFFF),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 45.r,
                        child: const Center(
                          child: Icon(Icons.error, color: AppColors.cFFFFFF),
                        ),
                      );
                    },
                    imageUrl:
                        "https://img.lovepik.com/png/20231128/3d-illustration-avatar-profile-man-collection-guy-cheerful_716220_wh1200.png",
                    width: 100.h,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              UIHelper.verticalSpace(24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Name:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.c000000,
                      fontSize: 18.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.56.h,
                    ),
                  ),
                  UIHelper.horizontalSpace(4.w),
                  Text(
                    userName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w500,
                      height: 1.56.h,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'E-mail:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.c000000,
                      fontSize: 18.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.56.h,
                    ),
                  ),
                  UIHelper.horizontalSpace(4.w),
                  Text(
                    userEmail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF919EAB),
                      fontSize: 16.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w500,
                      height: 1.56.h,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Total Saved Jobs:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.c000000,
                      fontSize: 18.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.56.h,
                    ),
                  ),
                  UIHelper.horizontalSpace(4.w),
                  Text(
                    "${savedJobs.length}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18.sp,
                      fontFamily: 'Public Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.56.h,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(42.h),
            ],
          ),
        ),
      ),
    );
  }
}
