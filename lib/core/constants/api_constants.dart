class ApiConstants {
  static const baseUrl = 'https://hp-api.onrender.com/api';
  static const localBaseUrl = 'http://localhost:5000';
  static const characters = '/characters';
  static const spells = '/spells';
  static const houses = '/houses';
  static const students = '/characters/students';
  static const staff = '/characters/staff';
  static String charactersByHouse(String house) => '/characters/house/$house';
}

