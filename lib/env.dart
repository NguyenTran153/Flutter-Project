enum Environment { dev, prod }

abstract class AppEnvironment {
  static late String baseUrl;
  static late String title;
  static late Environment _environment;
  static Environment get environment => _environment;
  static setupEnv(Environment env) {
    _environment = env;
    switch (env) {
      case Environment.dev:
        baseUrl = 'https://sandbox.api.lettutor.com';
        title = 'Dev';
        break;
      case Environment.prod:
        baseUrl = 'https://sandbox.api.lettutor.com';
        title = 'Prod';
        break;
    }
  }
}