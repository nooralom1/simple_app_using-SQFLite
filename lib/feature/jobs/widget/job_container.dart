import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_app/gen/colors.gen.dart';
import 'package:simple_app/helpers/ui_helpers.dart';

class JobContainer extends StatelessWidget {
  final String title;
  final String companyName;
  final String salary;
  final String location;
  final bool isApplied;
  final void Function()? viewDetailsTap;
  final void Function()? applyOnTap;
  const JobContainer({
    super.key,
    required this.title,
    required this.companyName,
    required this.salary,
    required this.location,
    this.viewDetailsTap,
    this.applyOnTap,
    required this.isApplied,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewDetailsTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: ShapeDecoration(
          color: const Color(0xFFF9FAFB),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: const Color(0xFFDFE3E8)),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF212B36),
                fontSize: 20.sp,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Text(
              companyName,
              style: TextStyle(
                color: const Color(0xFF212B36),
                fontSize: 16.sp,
                fontFamily: 'Public Sans',
                fontWeight: FontWeight.w600,
                height: 1.50.h,
              ),
            ),
            UIHelper.verticalSpace(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      salary,
                      style: TextStyle(
                        color: const Color(0xFF161C24),
                        fontSize: 16.sp,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w600,
                        height: 1.50.h,
                      ),
                    ),
                    Text(
                      location,
                      style: TextStyle(
                        color: const Color(0xFF637381),
                        fontSize: 12.sp,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.50.h,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: applyOnTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 8.h,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFEDF7EC),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50.w,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      isApplied ? "Applied" : 'Apply',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                        fontFamily: 'Public Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
