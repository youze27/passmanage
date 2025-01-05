import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const double borderRadiusValue = 8.0;
  static const double paddingValue = 35.0;
  static const double inputFieldSpacing = 16.0;
  static const double buttonHeight = 40.0;
  static const double imageWidth = 120.0;
  static const double buttonSpacing = 10.0;

  // 提取颜色常量
  static const Color fillColor = Color.fromARGB(255, 254, 254, 254); // 输入框填充颜色
  static const Color focusedBorderColor =
      Color.fromARGB(255, 102, 101, 101); // 输入框焦点边框颜色
  static const Color hintTextColor =
      Color.fromARGB(255, 63, 59, 59); // 输入框提示文字颜色
  static const Color labelTextColor =
      Color.fromARGB(255, 43, 40, 40); // 输入框标签文字颜色
  static const Color buttonTextColor =
      Color.fromARGB(255, 0, 0, 0); // 按钮文字颜色
  static const Color buttonColor = Color.fromARGB(255, 255, 255, 255); // 按钮颜色

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("密码保管箱"),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(paddingValue),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: fillColor,
                        hintText: "输入账号",
                        hintStyle: TextStyle(color: hintTextColor),
                        labelText: "账号",
                        labelStyle: TextStyle(color: labelTextColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(borderRadiusValue),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(borderRadiusValue),
                          ),
                          borderSide: BorderSide(
                            color: focusedBorderColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: inputFieldSpacing),
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: fillColor,
                        hintText: "输入密码",
                        hintStyle: TextStyle(color: hintTextColor),
                        labelText: "密码",
                        labelStyle: TextStyle(color: labelTextColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(borderRadiusValue),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(borderRadiusValue),
                          ),
                          borderSide: BorderSide(
                            color: focusedBorderColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: inputFieldSpacing),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: fillColor,
                              hintText: "输入验证码",
                              hintStyle: TextStyle(color: hintTextColor),
                              labelText: "验证码",
                              labelStyle: TextStyle(color: labelTextColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadiusValue),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadiusValue),
                                ),
                                borderSide: BorderSide(
                                  color: focusedBorderColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: inputFieldSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: buttonSpacing),
                          child: SizedBox(
                            width: imageWidth,
                            height: buttonHeight,
                            child: Image.network(
                              'https://pic4.zhimg.com/v2-17a03b9627aa8f850628c14550a0544a_r.jpg', // 替换为你的验证码图片 URL
                              fit: BoxFit.fill, // 确保图片拉伸以适应设置好的宽高
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: inputFieldSpacing),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: fillColor,
                              hintText: "输入短信验证码",
                              hintStyle: TextStyle(color: hintTextColor),
                              labelText: "短信验证码",
                              labelStyle: TextStyle(color: labelTextColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadiusValue),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadiusValue),
                                ),
                                borderSide: BorderSide(
                                  color: focusedBorderColor,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: inputFieldSpacing),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: buttonSpacing),
                          child: SizedBox(
                            width: imageWidth,
                            height: buttonHeight,
                            child: ElevatedButton(
                              onPressed: () {
                                // 处理获取短信验证码的逻辑
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                foregroundColor: buttonTextColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(borderRadiusValue),
                                ),
                              ),
                              child: const Text("获取验证码"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: inputFieldSpacing),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: buttonTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(borderRadiusValue),
                          ),
                        ),
                        child: const Text("登录"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
