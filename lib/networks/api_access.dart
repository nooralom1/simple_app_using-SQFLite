// SignUp
import 'package:rxdart/rxdart.dart';
import 'package:simple_app/feature/jobs/data/rx_get_job_list/rx.dart';
import 'package:simple_app/feature/jobs/model/job_list_model.dart';

GetJobListRX getJobListRXOBJ = GetJobListRX(
  empty: ProductsModel(),
  dataFetcher: BehaviorSubject<ProductsModel>(),
);
