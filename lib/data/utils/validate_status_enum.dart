class ValidateStatusEnum {
  static bool validateStatus(String? statusResponse, String statusEnum) {
    return (statusResponse != null &&
        statusResponse.compareTo(statusEnum) == 0);
  }
}