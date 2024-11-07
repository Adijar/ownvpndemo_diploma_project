import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class APIs {
  static Future<List<Vpn>> getVPNServers() async {
    final List<Vpn> list_vpn = [];
    try {
      final res = await get(Uri.parse('https://swan03.pythonanywhere.com/'));
      final List<dynamic> decoded_body = jsonDecode(res.body);
      if (decoded_body.isNotEmpty) {
        for (int i = 0; i < decoded_body.length; ++i) {
          list_vpn.add(Vpn.fromJson(decoded_body[i]));
        }
      }
    } catch (e) {
      print('\ngetVPNServerse: $e');
    }
    list_vpn.shuffle();

    if (list_vpn.isNotEmpty) Pref.list_vpn = list_vpn;

    return list_vpn;
  }

  static Future<void> getIPDetails({required Rx<IPDetails> ipData}) async {
    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      ipData.value = IPDetails.fromJson(data);
    } catch (e) {
      print('\ngetIPDetailsE: $e');
    }
  }
}
