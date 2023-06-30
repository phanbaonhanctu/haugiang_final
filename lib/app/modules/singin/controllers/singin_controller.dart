import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constant.dart';
import '../../../data/models/users.dart';
import '../../../routes/app_pages.dart';
import '../../survey_detail/controllers/survey_detail_controller.dart';

class SinginController extends GetxController {
  //TODO: Implement SinginController
    final formKey = GlobalKey<FormState>();
    final TextEditingController fullnameController = TextEditingController();
    final TextEditingController cccdController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController adressController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController genderController = TextEditingController();
    final TextEditingController nationController = TextEditingController();
    final TextEditingController educationController = TextEditingController();
    final TextEditingController numpeopleController = TextEditingController();
    final TextEditingController numfemaleController = TextEditingController();
    final TextEditingController jobController = TextEditingController();
    final TextEditingController incomeController = TextEditingController();
    RxBool showSuggestions = false.obs;
    OverlayEntry? overlayEntry;
    final LayerLink layerLink = LayerLink();
    final TextEditingController suggestionController = TextEditingController();
    final FocusNode textFieldFocus = FocusNode();


    final List<String> genderOptions = ["Nữ", "Nam", "Khác"];
    final RxString selectedGender = "Nữ".obs;

    UsersModel userInfo = UsersModel();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
    var isLoading = false.obs;

  Future<void> saveUser1(UsersModel user) async {
    isLoading.value = true;

    // Thực hiện công việc lưu người dùng
    await saveUser(user);

    isLoading.value = false;
  }

  static Future<void> saveUser(UsersModel user) async {
    final url = Uri.parse('http://139.180.145.98:8080/saveUser.php');

    final body = json.encode(user.toJson());
    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      // Xử lý phản hồi thành công từ server
      print(response.body);
      // Chuyển đổi chuỗi JSON thành một danh sách đối tượng trong Dart
    List<dynamic> responseData = jsonDecode(response.body);
    // Kiểm tra xem chuyển đổi có thành công hay không
    if (responseData.isNotEmpty) {
      // Lấy giá trị newId từ danh sách đối tượng
      String newId = responseData[0]['newId'];
      SurveyDetailController myController = Get.put(SurveyDetailController());
      myController.cccdNum = newId;
      Get.toNamed(Routes.DASHBOARD);
    } else {
      print('Failed to parse JSON.');
    }
    } else {
      // Xử lý phản hồi không thành công từ server
      print("ok");
      print(response.body);
    }
  }

    void showDialogMessagenew(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Thông báo'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Đóng',
              style: TextStyle(color: primaryColor, fontSize: 18),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}