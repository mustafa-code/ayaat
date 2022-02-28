import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

enum Method {post, get, put, patch, delete}

class ApiProvider {

  Dio dio = Dio();
  CancelToken cancelToken = CancelToken();

  ApiProvider() {
    initDioOptions();
  }

  initDioOptions() async {
    dio.options.connectTimeout = 120000; //80s
    dio.options.receiveTimeout = 120000; //80s
    dio.options.sendTimeout = 120000;
    dio.options.contentType = "application/json";

  	(dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
  	};

    dio.options.headers = {
      "Content-Type": "application/json",
    };
  }

  void close() {
    if(!cancelToken.isCancelled){
      cancelToken.cancel("Connection terminated!");
    }
    dio.close();
  }

  Future<Map<String, dynamic>> doRequest(String path, Method method,
      {Map<String, dynamic>? request}) async {

    dio.options.baseUrl = "http://192.168.38.221/sec/api/";

    request ??= {};
    try {
      Response? response;
      if (method == Method.post) {
        // log("request: ${json.encode(request)}");
        response = await dio.post(
          path,
          data: json.encode(request),
          cancelToken: cancelToken,
          onSendProgress: (int sent, int total) {},
          onReceiveProgress: (int receive, int total){},
        );
        // log("response.data: ${response.data}");
      } else if (method == Method.patch) {
        response = await dio.patch(path,
          data: FormData.fromMap(request),
          cancelToken: cancelToken,
        );
      } else if (method == Method.put) {
        response = await dio.put(path,
          data: FormData.fromMap(request),
          cancelToken: cancelToken,
        );
      } else if (method == Method.delete) {
        response = await dio.delete(path, queryParameters: request, cancelToken: cancelToken);
      } else if (method == Method.get) {
        log("request: ${json.encode(request)}");
        response = await dio.get(path,
          queryParameters: request,
        );
        // log("response.data: ${response.data}");
      }
      if (response != null) {
        if(response.statusCode == 200){
          var responseData = response.data;
          Map<String, dynamic> data = {};
          if(responseData is String){
            if(responseData.isNotEmpty){
              try{
                if(responseData.startsWith("(")){
                  responseData = responseData.substring(1, responseData.length - 1);
                }
                data = json.decode(responseData);
              } on FormatException catch(e){
                log("Exception: ${e.toString()}");
                if(["UploadProfile", "UploadLicense", "UploadGovernmentId", "UploadTransportPhoto"].contains(path)){
                  data = {
                    "code": 1,
                    "details": responseData,
                  };
                } else {
                  log("responseData: $responseData");
                  data = getErrorResponse(("Invalid data received!"));
                }
              } on Exception catch(e){
                log("Exception: ${e.toString()}");
                data = getErrorResponse(("Invalid data received!"));
              }
            } else {
              data = getErrorResponse(("Get empty response from our servers."));
            }
          } else if(responseData is Map<String, dynamic>){
            data = responseData;
          } else {
            data = getErrorResponse(("Unsupported response type."));
          }
          return data;
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        log("response.statusCode: ${e.response!.statusCode}");
        log("response.body: ${json.encode(e.response!.data)}");
      }
      log("Exception (${dio.options.baseUrl}$path): $e");
      return getErrorResponse(e.message);
    } on Exception catch(e){
      log("Exception (${dio.options.baseUrl}$path): $e");
    }
    return getErrorResponse(("Server error"));
  }

  getErrorResponse(message){
    return {
      "code": 500,
      "msg": message,
      "details": "Error message",
    };
  }
}