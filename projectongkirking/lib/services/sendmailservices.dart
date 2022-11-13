part of 'services.dart';

class SendMailServices {
  static Future<http.Response> sendEmail(String mail) {
    return http.post(
      Uri.https("dtales.my.id", "/cirestapi/api/mahasiswa/sendmail"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'AFL-API-KEY': 'AFL-CloudComp_03-11-22',
      },
      body: jsonEncode(
        <String, dynamic>{
          'email': mail,
        },
      ),
    );
  }
}

//ini cc