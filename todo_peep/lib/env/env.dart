import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'MISTRAL_API_KEY') // the .env variable.
  static const String apiKey = _Env.apiKey;
}
