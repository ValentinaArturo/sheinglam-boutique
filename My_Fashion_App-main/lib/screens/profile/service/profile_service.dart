import 'package:dio/dio.dart';
import 'package:my_fashion_app/factory/client_factory.dart';
import 'package:my_fashion_app/resources/api_constants.dart';
import 'package:my_fashion_app/screens/profile/model/profile_mode.dart';

class ProfileService {
  Dio client;

  ProfileService() : client = ClientFactory.buildClient();

  ProfileService.withClient(
    this.client,
  );

  Future<ProfileListModel> getProfile({
    required int id,
}) async {
    final response = await client.get(
      '$clientePath/$id',
    );
    return ProfileListModel.fromJson(response.data);
  }
}
