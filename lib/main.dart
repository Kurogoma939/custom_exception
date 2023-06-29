import 'package:custom_exception/exception/server_common_error.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Exception Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> fetchPikachuInfo() async {
    try {
      final Uri requestUrl =
          Uri.parse("https://pokeapi.co/api/v2/pokemon/pikachu");
      final response = await http.get(requestUrl);
      // ステータスコード別に例外を返す
      switch (response.statusCode) {
        case 200:
          // 200 OK
          debugPrint(response.toString());
          break;
        case 400:
        case 403:
          // 403 Forbidden
          throw const ServerCommonError(ServerCommonErrorCode.forbiddenError);
        case 500:
          // 500 Internal Server Error
          throw const ServerCommonError(
              ServerCommonErrorCode.internalServerError);
        default:
          // その他のステータスコード
          throw const ServerCommonError(ServerCommonErrorCode.systemError);
      }
    } on ServerCommonError catch (errorInfo) {
      // サーバー共通エラーの場合、定義したエラー情報を取得できる
      debugPrint(errorInfo.errorCode.toString());
      debugPrint(errorInfo.info.toString());
    } on Exception catch (_, stack) {
      debugPrint(stack.toString());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
              onPressed: () async {},
              child: const Text('Api test'),
            ),
          ],
        ),
      ),
    );
  }
}
