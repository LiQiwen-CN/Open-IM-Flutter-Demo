import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_demo/src/common/config.dart';
import 'package:openim_demo/src/utils/data_persistence.dart';
import 'package:openim_demo/src/widgets/im_widget.dart';

class ServerConfigLogic extends GetxController {
  var checked = true.obs;
  var index = 0.obs;
  var ipCtrl = TextEditingController();
  var authCtrl = TextEditingController();
  var imApiCtrl = TextEditingController();
  var imWsCtrl = TextEditingController();
  var callCtrl = TextEditingController();

  @override
  void onInit() {
    ipCtrl.text = Config.serverIp();
    authCtrl.text = Config.appAuthUrl();
    imApiCtrl.text = Config.imApiUrl();
    imWsCtrl.text = Config.imWsUrl();
    callCtrl.text = Config.callUrl();

    ipCtrl.addListener(() {
      if (ipCtrl.text.isEmpty) {
        authCtrl.text = 'http://${Config.serverIp()}:10004';
        imApiCtrl.text = 'http://${Config.serverIp()}:10002';
        imWsCtrl.text = 'ws://${Config.serverIp()}:10001';
        callCtrl.text = '';
      } else {
        authCtrl.text = 'http://${ipCtrl.text}:10004';
        imApiCtrl.text = 'http://${ipCtrl.text}:10002';
        imWsCtrl.text = 'ws://${ipCtrl.text}:10001';
        callCtrl.text = '';
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    authCtrl.dispose();
    imApiCtrl.dispose();
    imWsCtrl.dispose();
    callCtrl.dispose();
    ipCtrl.dispose();
    super.onClose();
  }

  void toggleRadio() {
    checked.value = !checked.value;
  }

  void confirm() async {
    await DataPersistence.putServerConfig({
      'serverIP': ipCtrl.text,
      'authUrl': authCtrl.text,
      'apiUrl': imApiCtrl.text,
      'wsUrl': imWsCtrl.text,
      'callUrl': callCtrl.text,
    });
    IMWidget.showToast('重启app后配置生效');
    // Get.reset();
  }

  void toggleTab(i) {
    index.value = i;
  }
}
