import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PromptRepo {


  static Future<Uint8List?> genreateImage(String prompt) async {
    try{
        String url = "https://api.vyro.ai/v2/image/generations";
    Map<String,dynamic> headers = {
     'Authorization': dotenv.env['API_KEY'],
    };

    Map<String,dynamic> payload = {
        'prompt': prompt,
       'style': 'realistic',
        'aspect_ratio': '1:1',
    };
    Dio dio = Dio();
    dio.options = BaseOptions(
      headers:  headers,responseType: ResponseType.bytes
    );
    FormData formData = FormData.fromMap(payload);

    final response = await dio.post(url,data: formData);

    if(response.statusCode == 200)
    {
     Uint8List uint8list = Uint8List.fromList(response.data);
     return uint8list;
    }
    else {
      return null;
    }
    }
    catch (e) {
  log("Error: $e");
    return null;
    }
  
    
    

  }
}