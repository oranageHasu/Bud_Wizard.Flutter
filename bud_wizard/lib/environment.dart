const BASE_URL = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'https://localhost:9000/api/v1/',
);

bool isProduction() {
  return BASE_URL.contains('www.budwizard.ca');
}
