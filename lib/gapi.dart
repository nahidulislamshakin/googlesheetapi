import 'package:googlesheetsapi/user.dart';
import 'package:gsheets/gsheets.dart';
class Gapi{
  static final _spreadsheetid = "1QRMbyLPsutWLHoVZUbP-HTqFU-_-majZC77lwXND9Mw";
  static const _credentials = r'''{
  "type": "service_account",
  "project_id": "gsheets-356318",
  "private_key_id": "372a9d71371187d9b8373f11774f6aa389f201b6",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDRivBHWK7xUAdU\nKpXf6RPeFb/Y7RFGKyhEugx8QeY3HiPoBJT+NIpdcLY8sSmMHDJjBnQZdqgqspYa\nAHhoV5kq2mdEJfZY3oEkApq2l2D0rMRE3wzhFMWMN+kn6hUG2Bix0/LyEw3lwA4r\nVtcqlqjBzzXzs1zhFAkzG1bvJzQ79Zi6epqG3LqU4PFImtB/VyOWhllx9rUKx+Cy\nv5H6ovKRRp/VwPhS/2ifPMWPiySqZbH71+eJRfGej0h/fughxn9HcX73nwR+o9yc\noI4q+ukrN2ARtLEGY46amQUZWSFGRUcTzS2/865cZ2ojlNb2iZGdckxS+frJgqws\nm1Q61P3VAgMBAAECggEAWIuDBEsTxdHg/u5t3avCovaC1po60fFbt0r9CqbYLtNU\nLe99vDucemauA1CDs3qYyiKIfdgXsM89QWiQeNsHVMXsnC4EfsIrRPm6wcyPAmVd\nHJM6gIREA//+TMkMMJOxP7fF8ggeN8cj1amBC7SVRCyY6k2RQmUyi/+SCUYCOxFF\nw2NiTyk3aqn76DBLqHJvyWumcKaZMkMozvGcNTZ0A8Hlx8U1b4+ZESk01mwkR6fO\n2QD0IOsinj+xmvgaunvtA0OHE1ZovQDt7E2SKHDlSKL1w5MhsfnnpFDfLr+dwR7W\nMKTFAH3eV0DKba8o/c67vjfBstnx4qUpD54Q1BCf8wKBgQDqBNFWAjsq5wtMgbQf\npckRqyyIBYbR5lOu/DMuyh8DwZqKXKy8IfW7Efg6TY+pNIBoWUGR+oxrYBxIj8dh\nup88nkYJP9eM+9d0421IcspYjdho+9r/z6ci6LwGHHlVJ94fCvMqATH6enmf0Edi\nfpwoiCvLgI6s+2pEFp8jatdoGwKBgQDlOZKHtBJBM+ucifZnCdqut9pUgFpeWSyM\nLKMgXH8+eEeg4975QL9siAwFccF6h1yJKqNpzsrxx/AKauo8bAmT6gtKwxW0AAo0\n+LKcBGWqTbsy1Xwq8DxBaRSEC6S39uzn1ugKhyG9mM6nmuDePmd7dfHs8tUDFHl2\naV2A1RRwzwKBgQDOq46MXNAQJZeu62U+BdW7Cub7AZZ9TOJeyVASZGJbmOF4jDvo\nsj0oBsioBNN45Wr5vMnRt+nG8kxIMOIuhvgWOtkzVfRxCADRtABRWT8mUa7rmHFi\nNesvQ0a6Ru9IqzrZQ3xYflG7GerLns9MRvB2QzwaLuDSF/9TPn8wcizmPQKBgAJz\nrDKRZYSXBpUlEKKng1RNGSPAP7c0ovpY2+HTu3SymqmI5nCqFaIWjnJcdiJWYlIB\nR8Aw+xC8/79Mx3af/TY80aQaFBhZy8InStnKXkAFFtSDXhGjgjF860BCU5+4H26X\naOH78gtyH/vA91jJOBgk+dJ8AnVG+cmfdOWU4eQXAoGACbu5as9MPvzsPIToTAnF\nv/2pn/eo6GABLFW4EjQv4JiF6tTf0Rmj0Ty7VfOzRII2VmutqYDsaCM1YaiRsx9X\nQb0EF7HYIomrOmCuIC8qA+LjMNoA7pLhk/e0owPWAlG/5bbnWHX33x6yTAqp9XoO\n59sMNjsS5yKQAD28Sf0B9s8=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-356318.iam.gserviceaccount.com",
  "client_id": "100709453853697358695",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-356318.iam.gserviceaccount.com"
}
''';
  static final gsheets = GSheets(_credentials);
  static Worksheet? usersheet;

  static Future init()async{
    final spreadsheet = await gsheets.spreadsheet(_spreadsheetid);
    usersheet = await getWorkSheet(spreadsheet, title: 'users');
    final firstRow = UserFields.getFields();
    usersheet!.values.insertRow(1, firstRow);
  }
  static Future<Worksheet> getWorkSheet(Spreadsheet spreadsheet, {required String title})async{
    try{
      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>>rowList) async{
    if(usersheet == null) return;
    usersheet!.values.map.appendRows(rowList);
  }

}