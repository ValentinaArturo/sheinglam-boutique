import 'package:ecommerce_admin_panel/repository/repository_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final FlutterSecureStorage storage;

  UserRepository()
      : storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
          iOptions: IOSOptions(
            synchronizable: true,
          ),
        );

  UserRepository.withStorage(
    this.storage,
  );

  Future<String> getToken() async {
    return (await storage.read(
          key: token,
        )) ??
        emptyString;
  }

  Future<void> setToken(
    final String tokenValue,
  ) async {
    await storage.write(
      key: token,
      value: tokenValue,
    );
  }

  Future<String> getPosition() async {
    return (await storage.read(
          key: userPosition,
        )) ??
        emptyString;
  }

  Future<void> setPosition(
    final String userPositionValue,
  ) async {
    await storage.write(
      key: userPosition,
      value: userPositionValue,
    );
  }

  Future<String> getCountry() async {
    return (await storage.read(
          key: userCountry,
        )) ??
        emptyString;
  }

  Future<void> setCountry(
    final String userPositionValue,
  ) async {
    await storage.write(
      key: userCountry,
      value: userPositionValue,
    );
  }

  Future<String> getDeviceId() async {
    return (await storage.read(
          key: deviceId,
        )) ??
        emptyString;
  }

  Future<void> setDeviceId(
    final String deviceIdValue,
  ) async {
    await storage.write(
      key: deviceId,
      value: deviceIdValue,
    );
  }

  Future<String> getUserEmail() async {
    return (await storage.read(
          key: userEmail,
        )) ??
        emptyString;
  }

  Future<void> setUserEmail(
    final String userEmailValue,
  ) async {
    await storage.write(
      key: userEmail,
      value: userEmailValue,
    );
  }

  Future<String> getUserId() async {
    return (await storage.read(
          key: userId,
        )) ??
        emptyString;
  }

  Future<void> setUserId(
    final String userIdValue,
  ) async {
    await storage.write(
      key: userId,
      value: userIdValue,
    );
  }

  Future<String> getUserFullName() async {
    return (await storage.read(
          key: userFullName,
        )) ??
        emptyString;
  }

  Future<void> setUserFullName(
    final String userFullNameValue,
  ) async {
    await storage.write(
      key: userFullName,
      value: userFullNameValue,
    );
  }

  Future<String> getIsBoss() async {
    return (await storage.read(
          key: isBoss,
        )) ??
        emptyString;
  }

  Future<void> setIsBoss(
    final String isBossValue,
  ) async {
    await storage.write(
      key: isBoss,
      value: isBossValue,
    );
  }

  Future<String> getLanguage() async {
    return (await storage.read(
          key: language,
        )) ??
        emptyLanguage;
  }

  Future<void> setLanguage({
    required String languageValue,
  }) async {
    await storage.write(
      key: language,
      value: languageValue,
    );
  }

  Future<String> getPlatform() async {
    return (await storage.read(
          key: platform,
        )) ??
        'android';
  }

  Future<void> setPlatform(
    String platformValue,
  ) async {
    await storage.write(
      key: platform,
      value: platformValue,
    );
  }

  Future<String> getUserCompany() async {
    return (await storage.read(
          key: userCompany,
        )) ??
        emptyString;
  }

  Future<void> setUserCompany(
    final String companyValue,
  ) async {
    await storage.write(
      key: userCompany,
      value: companyValue,
    );
  }

  Future<String> getUserDepartment() async {
    return (await storage.read(
          key: userDepartment,
        )) ??
        emptyString;
  }

  Future<void> setUserDepartment(
    final String userDepartmentValue,
  ) async {
    await storage.write(
      key: userDepartment,
      value: userDepartmentValue,
    );
  }

  Future<String> getUserIsSession() async {
    return (await storage.read(
          key: userIsSession,
        )) ??
        emptyString;
  }

  Future<void> setUserIsSession(
    final String isSessionValue,
  ) async {
    await storage.write(
      key: userIsSession,
      value: isSessionValue,
    );
  }

  Future<String> getUserCode() async {
    return (await storage.read(
          key: userCode,
        )) ??
        emptyString;
  }

  Future<void> setUserCode(
    String userCodeValue,
  ) async {
    await storage.write(
      key: userCode,
      value: userCodeValue,
    );
  }

  Future<bool> isSession() async {
    return (await getToken()).isEmpty;
  }

  Future<void> clear() async {
    await storage.deleteAll();
  }

  Future<String> getProfileImage() async {
    return (await storage.read(
          key: profileImage,
        )) ??
        emptyString;
  }

  Future<void> setProfileImage(
    final String imageValue,
  ) async {
    await storage.write(
      key: profileImage,
      value: imageValue,
    );
  }

  Future<String> getIsFullRegistered() async {
    return (await storage.read(
          key: userFullRegistered,
        )) ??
        emptyString;
  }

  Future<void> setIsFullRegistered(
    final String userFullRegisteredValue,
  ) async {
    await storage.write(
      key: userFullRegistered,
      value: userFullRegisteredValue,
    );
  }

  Future<String> getRememberUser() async {
    return (await storage.read(
          key: rememberUser,
        )) ??
        emptyString;
  }

  Future<void> setRememberUser(
    final String companyValue,
  ) async {
    await storage.write(
      key: rememberUser,
      value: companyValue,
    );
  }

  Future<String> getTotalVacationAvailable() async {
    return (await storage.read(
          key: totalVacationAvailable,
        )) ??
        emptyString;
  }

  Future<void> setTotalVacationAvailable(
    final String totalVacationAvailableValue,
  ) async {
    await storage.write(
      key: totalVacationAvailable,
      value: totalVacationAvailableValue,
    );
  }

  Future<String> getPeriodVacationAvailable() async {
    return (await storage.read(
          key: periodVacationAvailable,
        )) ??
        emptyString;
  }

  Future<void> setPeriodVacationAvailable(
    final String periodVacationAvailableValue,
  ) async {
    await storage.write(
      key: periodVacationAvailable,
      value: periodVacationAvailableValue,
    );
  }

  Future<String> getDaysVacationAvailable() async {
    return (await storage.read(
          key: daysVacationAvailable,
        )) ??
        emptyString;
  }

  Future<void> setDaysVacationAvailable(
    final String daysVacationAvailableValue,
  ) async {
    await storage.write(
      key: daysVacationAvailable,
      value: daysVacationAvailableValue,
    );
  }

  Future<String> getContractTypeName() async {
    return (await storage.read(
          key: contractTypeName,
        )) ??
        emptyString;
  }

  Future<void> setContractTypeName(
    final String contractTypeNameValue,
  ) async {
    await storage.write(
      key: contractTypeName,
      value: contractTypeNameValue,
    );
  }
}
