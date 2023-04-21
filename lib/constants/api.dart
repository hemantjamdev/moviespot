import 'package:moviespot/constants/strings.dart';
import 'package:tmdb_api/tmdb_api.dart';

class API {
  static TMDB tmdb = TMDB(
    ApiKeys(Strings.apiKeyV3, Strings.apiReadAccessTokenv4),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
      showUrlLogs: true,
      showInfoLogs: true,
      showWarningLogs: true,
    ),
  );
}
