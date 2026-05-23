import 'package:lab_house/common/router/router_builder.dart';
import 'package:lab_house/common/router/routes.m.dart';
import 'package:lab_house/modules/home/home_router.dart';

extension RoutesGenerateBuilder on Routes {
  RouterBuilder get builder {
    switch (this) {
      case Routes.home:
        return HomeRouter.shared;
    }
  }
}
