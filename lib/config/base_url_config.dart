//lib/config/base_url_config.dart
class BaseUrlConfig {
  static  final String baseUrlDevelopment = 'https://dummyjson.com';
  static final String baseUrlProduction = 'https://simplemaps.com/static/data/country-cities';
}

class ApiEndPoints{
  // Add your API endpoints here
  static final String loginEndpoint = '/auth/login';
  static final String getCitiesEndpoint = '/jo/jo_spreadsheet.json';
  static final String getInformationSourcesEndpoint = '/jo/jo_spreadsheet.json';
  static final String getBusinessSectorsEndpoint = '/jo/jo_spreadsheet.json';
  static final String getOpportunities = '/jo/jo_spreadsheet.json';
  static final String getProperty = '/jo/jo_spreadsheet.json';
  static final String getClients = '/jo/jo_spreadsheet.json';
  static final String getEnteredClients = '/jo/jo_spreadsheet.json';
  static final String getEnteredOpportunities = '/jo/jo_spreadsheet.json';
}