

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslatorAppFrist extends StatefulWidget {
  const TranslatorAppFrist({Key? key}) : super(key: key);

  @override
  State<TranslatorAppFrist> createState() => _TranslatorAppFristState();
}

class _TranslatorAppFristState extends State<TranslatorAppFrist> {
  List<String> languages = ['English', 'Arabic'];
  String from = 'en';
  String to = 'ar';
  String data = '';
  String selectedvalue = 'English';
  String selectedvalue2 = 'Arabic';
  TextEditingController controller = TextEditingController(text: '');
  final formkey = GlobalKey<FormState>();
  bool isloading = false;

  Future<void> translate() async {
    try {
      if (formkey.currentState!.validate()) {
        setState(() {
          isloading = true;
        });
        final translator = GoogleTranslator();
        final translation = await translator.translate(
          controller.text,
          from: from,
          to: to,
        );
        setState(() {
          data = translation.text;
          isloading = false;
        });
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Internet not Connected'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  void initState() {
    controller.clear();
    data = '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 50, 46, 165),
          ),
        ),
        title: const Text(
          'Translator App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 87, 104, 254),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('From'),
                  const SizedBox(width: 100),
                  DropdownButton(
                    value: selectedvalue,
                    focusColor: Colors.transparent,
                    items: languages.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.clear();
                      data = '';
                      setState(() {
                        selectedvalue = value.toString();
                        from = value == 'English' ? 'en' : 'ar';
                        // Automatically switch "To" language
                        selectedvalue2 =
                            value == 'English' ? 'Arabic' : 'English';
                        to = value == 'English' ? 'ar' : 'en';
                      });
                      translate(); // Trigger translation
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: Form(
                key: formkey,
                child: TextFormField(
                  controller: controller,
                  maxLines: null,
                  minLines: null,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    errorStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('To'),
                  const SizedBox(width: 100),
                  DropdownButton(
                    value: selectedvalue2,
                    focusColor: Colors.transparent,
                    items: languages.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.clear();

                      setState(() {
                        selectedvalue2 = value.toString();
                        to = value == 'English' ? 'en' : 'ar';
                      });
                      translate(); // Trigger translation
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: SelectableText(
                  data,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: translate,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.indigo.shade900),
                fixedSize: MaterialStatePropertyAll(const Size(300, 45)),
              ),
              child: isloading
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text('Translate'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: TranslatorAppFrist(),
//   ));
// }

// // Make sure your Internet is Connected
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:translator/translator.dart';

// class TranslatorAppFrist extends StatefulWidget {
//   const TranslatorAppFrist({super.key});

//   @override
//   State<TranslatorAppFrist> createState() => _TranslatorAppFristState();
// }

// class _TranslatorAppFristState extends State<TranslatorAppFrist> {
//   List<String> languages = [
//     'English',
//     'Arabic',
//   ];
//   List<String> languagescode = [
//     'en',
//     'ar',
//   ];
//   final translator = GoogleTranslator();
//   String from = 'en';
//   String to = 'ar';
//   String data = '';
//   String selectedvalue = 'English';
//   String selectedvalue2 = 'Arabic';
//   TextEditingController controller = TextEditingController(text: '');
//   final formkey = GlobalKey<FormState>();
//   bool isloading = false;
//   translate() async {
//     try {
//       if (formkey.currentState!.validate()) {
//         await translator
//             .translate(controller.text, from: from, to: to)
//             .then((value) {
//           data = value.text;
//           isloading = false;
//           setState(() {});
//           // controller.clear();
//           // print(value);
//         });
//       }
//     } on SocketException catch (_) {
//       isloading = true;
//       SnackBar mysnackbar = const SnackBar(
//         content: Text('Internet not Connected'),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 5),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(mysnackbar);
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller.dispose();
//   }
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   translate();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         flexibleSpace: Container(
//             decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 50, 46, 165),
//         )),
//         title: const Text(
//           'Translator App',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
//         ),
//       ),
//       backgroundColor: const Color.fromARGB(255, 87, 104, 254),
//       body: SingleChildScrollView(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 30,
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 40),
//             decoration: BoxDecoration(
//                 color: Colors.indigo.shade100,
//                 borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('From'),
//                 const SizedBox(
//                   width: 100,
//                 ),
//                 DropdownButton(
//                   value: selectedvalue,
//                   focusColor: Colors.transparent,
//                   items: languages.map((lang) {
//                     return DropdownMenuItem(
//                       value: lang,
//                       child: Text(lang),
//                       onTap: () {
//                         if (lang == languages[0]) {
//                           from = languagescode[0];
//                         } else if (lang == languages[1]) {
//                           from = languagescode[1];
//                         }
//                         setState(() {
//                           data = '';
//                           controller.clear();
//                           // print(from);
//                         });
//                       },
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     selectedvalue = value!;
//                   },
//                 )
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(20),
//             margin: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//                 color: Colors.blueGrey.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.black)),
//             child: Form(
//               key: formkey,
//               child: TextFormField(
//                 controller: controller,
//                 maxLines: null,
//                 minLines: null,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                   return null;
//                 },
//                 textInputAction: TextInputAction.done,
//                 decoration: const InputDecoration(
//                     enabledBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     errorStyle: TextStyle(color: Colors.white)),
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 40),
//             decoration: BoxDecoration(
//                 color: Colors.indigo.shade100,
//                 borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('To'),
//                 const SizedBox(
//                   width: 100,
//                 ),
//                 DropdownButton(
//                   value: selectedvalue2,
//                   focusColor: Colors.transparent,
//                   items: languages.map((lang) {
//                     return DropdownMenuItem(
//                       value: lang,
//                       child: Text(lang),
//                       onTap: () async {
//                         if (lang == languages[0]) {
//                           to = languagescode[0];
//                         } else if (lang == languages[1]) {
//                           to = languagescode[1];
//                         }
//                         setState(() {
//                           print(lang);
//                           data = '';
//                           controller.clear();
//                           print(from);
//                         });
//                       },
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     selectedvalue2 = value!;
//                   },
//                 )
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(20),
//             margin: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//                 color: Colors.blueGrey.withOpacity(0.3),
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.black)),
//             child: Center(
//               child: SelectableText(
//                 data,
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           ElevatedButton(
//               onPressed: translate,
//               style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStatePropertyAll(Colors.indigo.shade900),
//                   fixedSize: const MaterialStatePropertyAll(Size(300, 45))),
//               child: isloading
//                   ? const SizedBox.square(
//                       dimension: 20,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                       ),
//                     )
//                   : const Text('Translate')),
//           const SizedBox(
//             height: 30,
//           )
//         ],
//       )),
//     );
//   }
// }