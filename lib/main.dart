import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("Webview",style: TextStyle(fontSize: 15),),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Webview()) );
          },
          child: Text("Webview"),
        )
      ),
    );
  }
}

class Webview extends StatefulWidget {
  const Webview({super.key});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {

  final Completer<WebViewController> r1 = Completer<WebViewController>();
  int load = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  IndexedStack(
                    index: load,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/1.09,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                    SizedBox(
                    height: MediaQuery.of(context).size.height/1.09,
                    child: WebView(
                      onPageFinished: (finish){
                        setState(() {
                          load = 1;
                        });
                      },
                      initialUrl: 'https://successoftinfotech.com/',
                      gestureNavigationEnabled: true,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        r1.complete(webViewController);
                      },
                    )
                  ),
                    ],
                  )
                ],
              ),
            ],
          ),
      ),
    );
  }
}
