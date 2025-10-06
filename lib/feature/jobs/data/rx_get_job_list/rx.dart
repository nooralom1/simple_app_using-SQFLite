// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, body_might_complete_normally_nullable

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_app/feature/jobs/data/rx_get_job_list/api.dart';
import 'package:simple_app/feature/jobs/model/job_list_model.dart';
import 'package:simple_app/helpers/toast.dart';
import 'package:simple_app/networks/rx_base.dart';

final class GetJobListRX extends RxResponseInt<ProductsModel> {
  final api = GetJobListApi.instance;

  GetJobListRX({required super.empty, required super.dataFetcher});

  ValueStream get commentSteam => dataFetcher.stream;

  Future<ProductsModel?> getJobListRX() async {
    try {
      final ProductsModel data = await api.getJobListApi();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      if (error is DioException) {
        ToastUtil.showShortToast(
          error.response?.data["message"] ?? "Unknown error",
        );
      }
      log(error.toString());
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 422) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);

    return false;
  }
}
