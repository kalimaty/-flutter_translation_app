import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/translate_controller.dart';
import '../../helper/global.dart';
import '../../widget/custom_btn.dart';
import '../../widget/custom_loading.dart';
import '../../widget/language_sheet.dart';

class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

class _TranslatorFeatureState extends State<TranslatorFeature> {
  final _c = TranslateController();

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        //app bar
        appBar: AppBar(
          title: const Text('Multi Language Translator'),
        ),

        //body
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .1),
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //from language
              InkWell(
                onTap: () {
                  Get.bottomSheet(LanguageSheet(c: _c, s: _c.from));
                  _c.textC.clear();
                  _c.resultC.clear();
                },
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * .4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child:
                      Obx(() => Text(_c.from.isEmpty ? 'Auto' : _c.from.value)),
                ),
              ),

              //swipe language btn
              IconButton(
                  onPressed: _c.swapLanguages,
                  icon: Obx(
                    () => Icon(
                      CupertinoIcons.repeat,
                      color: _c.to.isNotEmpty && _c.from.isNotEmpty
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  )),

              //to language
              InkWell(
                onTap: () {
                  Get.bottomSheet(LanguageSheet(c: _c, s: _c.to));
                  _c.textC.clear();
                  _c.resultC.clear();
                },
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * .4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Obx(() => Text(_c.to.isEmpty ? 'To' : _c.to.value)),
                ),
              ),
            ]),

            //text field
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mq.width * .04, vertical: mq.height * .035),
              child: TextFormField(
                controller: _c.textC,
                minLines: 5,
                maxLines: null,
                onTapOutside: (e) {
                  FocusScope.of(context).unfocus();
                  _c.resultC.clear();
                },
                onTap: () {
                  _c.resultC.clear();
                  _c.textC.clear();
                },
                decoration: const InputDecoration(
                    hintText: 'Translate anything you want...',
                    hintStyle: TextStyle(fontSize: 13.5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),

            //result field
            Obx(() => _translateResult()),

            //for adding some space
            SizedBox(height: mq.height * .04),

            //translate btn
            CustomBtn(
              onTap: _c.googleTranslate,
              // onTap: _c.translate,
              text: 'Translate',
            ),
            SizedBox(height: mq.height * .04),
            CustomBtn(
              onTap: () {
                if (_c.textC.text != '' || _c.resultC.text != '') {
                  _c.resultC.clear();
                  _c.textC.clear();
                }
                _c.to.isNotEmpty ? _c.to.value = 'To' : '';
                _c.from.isNotEmpty ? _c.from.value = 'Auto' : '';
              },
              // onTap: _c.translate,
              text: 'resset',
            )
          ],
        ),
      ),
    );
  }

  Widget _translateResult() => switch (_c.status.value) {
        Status.none => const SizedBox(),
        Status.complete => Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                _c.resultC.clear();
                _c.textC.clear();
              },
              controller: _c.resultC,
              maxLines: null,
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
              decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
        Status.loading => const Align(child: CustomLoading())
      };
}
