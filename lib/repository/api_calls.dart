import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:unstudio_assignment/repository/api_end_points.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  Future<Either<Map<String, dynamic>, String>> getAllGarmentsData() async {
    try {
      String endpoint = ApiEndPoints.getAllGarments;
      Uri url = Uri.parse(endpoint);
      http.Response networkResponse = await http.get(url);

      if (networkResponse.statusCode == 200) {
        final decodedData = jsonDecode(networkResponse.body);
        return left((decodedData as Map<String, dynamic>));
      } else {
        log(networkResponse.body);
        return right(
            networkResponse.reasonPhrase ?? "Error while retriving garments. Error code ${networkResponse.statusCode}");
      }
    } on SocketException catch (e) {
      log(e.toString());
      return right(e.message);
    } catch (e) {
      log(e.toString());
      return right(e.toString());
    }
  }
}
