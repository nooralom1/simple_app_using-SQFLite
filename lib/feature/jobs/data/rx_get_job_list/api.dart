import 'package:dio/dio.dart';
import 'package:simple_app/feature/jobs/model/job_list_model.dart';
import 'package:simple_app/networks/dio/dio.dart';
import 'package:simple_app/networks/endpoints.dart';
import 'package:simple_app/networks/exception_handler/data_source.dart';

final class GetJobListApi {
  static final GetJobListApi _singleton = GetJobListApi._internal();
  GetJobListApi._internal();
  static GetJobListApi get instance => _singleton;

  Future<ProductsModel> getJobListApi() async {
    try {
      Response response = await getHttp(Endpoints.jobList());
      if (response.statusCode == 200) {
        final data = ProductsModel.fromJson(response.data);
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
