import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/returns/model/return_list_model.dart';

class ReturnService {
  Dio client;

  ReturnService() : client = ClientFactory.buildClient();

  ReturnService.withClient(
    this.client,
  );

  Future<List<ReturnListModel>> getReturns() async {
    final response = await client.get(
      returnPath,
    );
    return List<ReturnListModel>.from(
      response.data.map(
        (returns) => ReturnListModel.fromJson(returns),
      ),
    );
  }
}
