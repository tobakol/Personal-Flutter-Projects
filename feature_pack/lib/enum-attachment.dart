import 'dart:math';

enum BankName { BankA, BankB, BankC }

List<Map<String, dynamic>> accountList = [
  {
    'key4': 'Value4',
    'key5': 'ValueW',
    'key6': 'Value6',
  },
  {
    'key4': 'Value10',
    'key5': 'ValueX',
    'key6': 'Value11',
  },
  {
    'key4': 'Value15',
    'key5': 'ValueW',
    'key6': 'Value16',
  },
  {
    'key4': 'Value20',
    'key5': 'ValueZ',
    'key6': 'Value21',
  },
  {
    'key4': 'Value25',
    'key5': 'ValueX',
    'key6': 'Value26',
  },
  {
    'key4': 'Value30',
    'key5': 'ValueY',
    'key6': 'Value31',
  },
  {
    'key4': 'Value35',
    'key5': 'ValueZ',
    'key6': 'Value36',
  },
  {
    'key4': 'Value40',
    'key5': 'ValueW',
    'key6': 'Value41',
  },
  // Add more maps with different key-value pairs here
];

List<Map<String, String>> modifiedList = accountList.map((accountMap) {
  final repeatedValue = accountMap['key5'] as String;

  String key5String;
  switch (repeatedValue) {
    case 'ValueX':
      key5String = 'Bank B Name';
      break;
    case 'ValueY':
      key5String = 'Bank C Name';
      break;
    default:
      key5String = 'Bank A Name';
      break;
  }

  return {
    'key4': 'Value4', // You can customize 'key4' values as needed
    'key5': key5String,
    'key6': 'Value6', // You can customize 'key6' values as needed
  };
}).toList();
