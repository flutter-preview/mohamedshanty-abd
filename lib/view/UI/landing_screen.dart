import 'package:department_web/controller/landing_controller.dart';
import 'package:department_web/extension.dart';
import 'package:department_web/models/department_model.dart';
import 'package:department_web/view/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/about_department.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool isWidget1Shown = true;
  int selectedDepartmentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LandingController>(
      init: LandingController(),
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/landingPage.jpg",
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 46),
                Wrap(
                  children: aboutDepartment
                      .map(
                        (e) => Container(
                          width: isDesktop(context) ? 400 : double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: aboutDepartment.indexWhere((element) =>
                                            element.title == e.title) %
                                        2 ==
                                    0
                                ? Colors.teal
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title,
                                  style: TextStyle(
                                    color: aboutDepartment.indexWhere(
                                                    (element) =>
                                                        element.title ==
                                                        e.title) %
                                                2 ==
                                            0
                                        ? Colors.white
                                        : Colors.teal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  e.description.splitMapJoin("\n"),
                                  style: TextStyle(
                                    color: aboutDepartment.indexWhere(
                                                    (element) =>
                                                        element.title ==
                                                        e.title) %
                                                2 ==
                                            0
                                        ? Colors.white
                                        : Colors.teal,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const CustomText(
                  txt: "الاقسام",
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: Colors.teal,
                ),
                const SizedBox(height: 24),
                Container(
                  width: 76,
                  height: 5,
                  color: Colors.teal,
                ),
                  const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      hoverColor: Colors.transparent,
                      onHover: (value) => controller.changeLeftButton(value),
                      onTap: () {
                        setState(() {
                          if (selectedDepartmentIndex > 0) {
                            selectedDepartmentIndex--;
                          }
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            controller.leftButton ? Colors.blue : Colors.teal,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // FloatingActionButton.small(
                    //   child: const Icon(
                    //     Icons.arrow_back_ios,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     setState(() {
                    //       if (selectedDepartmentIndex > 0) {
                    //         selectedDepartmentIndex--;
                    //       }
                    //     });
                    //   },
                    // ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: showDepartment(
                        department[selectedDepartmentIndex],
                      ),
                    ),
                    const SizedBox(width: 24),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (selectedDepartmentIndex <
                              (isDesktop(context) ? 2 : 3)) {
                            selectedDepartmentIndex++;
                          }
                        });
                      },
                      hoverColor: Colors.transparent,
                      onHover: (value) => controller.changeRightButton(value),
                      child: CircleAvatar(
                        backgroundColor:
                            controller.rightButton ? Colors.blue : Colors.teal,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // FloatingActionButton.small(
                    //   child: const Icon(
                    //     Icons.arrow_forward_ios,
                    //     color: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     setState(() {
                    //       if (selectedDepartmentIndex <
                    //           (isDesktop(context) ? 2 : 3)) {
                    //         selectedDepartmentIndex++;
                    //       }
                    //     });
                    //   },
                    // ),
                  ],
                )
                    .paddingDesk(context, 0.0, 140)
                    .paddingMobile(context, 0.0, 16),
                const SizedBox(height: 32),
                Container(
                  color: Colors.teal,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 56),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, "/login"),
                    child: const Center(
                      child: CustomText(
                        txt: "تسجيل الدخول",
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showDepartment(DepartmentModel departmentModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: isDesktop(context)
            ? [
                departmentWidget(departmentModel),
                departmentWidget(department[departmentModel.index + 1]),
              ]
            : [
                departmentWidget(departmentModel),
              ],
      ),
    );
  }

  InkWell departmentWidget(DepartmentModel departmentModel) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () => Navigator.pushNamed(context, "/login"),
      child: AnimatedContainer(
        width: isDesktop(context)
            ? 450
            : !isMobile(context)
                ? 350
                : 250,
        duration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 32,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              // width: isDesktop(context) ? 500 : 150,
              child: isDesktop(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imageWidget(departmentModel.index),
                        titleWidget(departmentModel.index),
                      ],
                    )
                  : Column(
                      children: [
                        imageWidget(departmentModel.index),
                        titleWidget(departmentModel.index),
                      ],
                    ),
            ),
            // const SizedBox(height: 24),
            CustomText(
              txt: departmentModel.description.split("\n").join(" "),
              maxLine: 15,
              textAlign: TextAlign.end,
              height: 1.2,
            ),
          ],
        ),
      ),
    );
  }

  Padding titleWidget(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: CustomText(
        txt: department[index].title,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.teal,
        textAlign: TextAlign.end,
      ),
    );
  }

  Image imageWidget(int index) {
    return Image.asset(
      department[index].image,
      width: 120,
      height: 120,
    );
  }

  List<AboutDepartment> aboutDepartment = [
    AboutDepartment(
        title: 'الرؤية',
        description:
            "تعليم متميز عالي الجودة بكوادر تعليمية مؤهلة لبناء مواطن معتز بقيمه الوطنية و منافس عالميا"),
    AboutDepartment(
        title: 'الرسالة',
        description:
            "اتاحة التعيلم للجميع و رفع جودة عملياته و مخرجاته و تطوير بيئة تعليمية محفزة على الابداع و الابتكار لتلبية متطلبات التنمية حوكة نظام التعليم و تطوير مهارات و قدرات منسوبيه و تزيود المتعليمن بالقيم و المهارات اللازمة ليصبحوا مواطنين صالحين مدركين لمسؤولياتهم تجاه الاسرة و لمجتمع و الوطن"),
    AboutDepartment(title: 'الاهداف الاستراتيجية', description: '''
    1- تعزيز القيم و الانتماء الوطني 
    2- تجويد نواتج التعليم و تسحين موقع النظام التعليمي عالميا
    3- تطوسر نظام التعليم لتلبية متطلبات التنمية و احتياجات سوق العمل
    4- تنمية و تطوير قدرات الكوادر التعليمية
    5- تعزيز مشاركة المجتمع في التعليم و التعلم
    6- ضمان التعليم للجميع و تعزيز فرص التعلم مدى الحياة
    7- تمكين القطاع الخاص و غير الربحي و رفع مشاركتهم لتسحين الكفاءة المالية لقطاع التعليم
    8- رفع جودة و فعالية البحث العلمي و الابتكار
    تطوير منظومة الجامعات و المؤسسات التعليمية و التدريبية
    '''),
  ];

  List<DepartmentModel> department = [
    DepartmentModel(
      title: "قسم الموارد التقنية",
      description: '''
                  ١- الإشراف على تأسيس الشبكات الداخلية و 
صـــرف الهواتف الشـــبكية لـــلإدارات والمكاتب 
وتقديـــم الدعم لها وصيانتها.
٢- رفـــع الاحتياج من التجهيـــزات التقنية وقطع 
الغيار ومتابعة تأمين وصرف أجهزة الحاســـب 
الآلـــي الإداريـــة والطابعـــات والانترنـــت في 
المدارس والمكاتب والإدارات.
٣- تقديـــم الدعـــم الفنـــي لصيانـــة المعامـــل 
وأجهزةالحاســـب الآلي وتحديثهـــا في الإدارات 
ومكاتـــب التعليم والمدارس التابعة لها.
٤-متابعـــة تأســـيس وصيانة خدمـــات الإنترنت 
للإدارة والمدارس.
                  ''',
      image: "assets/images/1.png",
      index: 0,
    ),
    DepartmentModel(
      title: "قسم التعليم الالكتروني",
      description: '''
                  ١- إعـــداد الخطـــة التشـــغيلية الخاصـــة بـــالإدارة 
والمتوافقـــة مـــع خطـــة وبرامـــج ادارة التخطيـــط 
والتطوير.
٢- تحديد المهـــام والتكليفات الخاصة بإدارة تقنية 
المعلومات.
٣-حصـــر الاحتياجـــات التدريبيـــة لمنســـوبي 
ومنســـوبات إدارة تقنيـــة المعلومـــات بمـــا يتوافق 
مع مهام وأهداف الإدارة.
٤- إعـــداد خطة لبرامج التدريـــب والتطوير الخاصة 
بمنسوبي ومنســـوبات إدارة تقنية المعلومات .
٥- إعـــداد الخطـــة التدريبيـــة الخاصـــة بالموظفيـــن 
والموظفات ومنســـوبي ومنسوبات إدارة التعليم.
                  ''',
      image: "assets/images/2.png",
      index: 1,
    ),
    DepartmentModel(
      title: "قسم امن العلومات و الامن السيبراني",
      description: '''
                  ١- الاســـتجابة للحـــوادث الأمنيـــة الخاصة بأمن 
المعلومات والأمن السيبراني.
٢- إقامـــة الـــدورات التدريبيـــة للتوعيـــة الأمنيـــة 
لرفـــع نســـبة الوعـــي الأمنـــي بمخاطـــر الأمن 
السيبراني.
٣- إعـــداد برامـــج محليـــة تخـــدم إدارة التعليـــم 
بالمنطقـــة والمتوافقـــة مـــع متطلبـــات الإدارة 
العامة للتحول الرقمي.
٤-الإشـــراف على تطوير موقع ادارة التعليم.
                  ''',
      image: "assets/images/3.png",
      index: 2,
    ),
    DepartmentModel(
      title: "قسم التاطوير المهني و قياس الاداء",
      description: '''
                  ١- تقديـــم الدعـــم التقنـــي للمنصـــات التعليميـــة 
وتصعيـــد المشـــاكل غيـــر المتاح حلها من حســـاب 
مديـــر/ة المدرســـة الـــى قســـم التعليـــم الإلكتروني 
والتعليم عن بعـــد في إدارة تقنية المعلومات.
٢-متابعـــة تفعيـــل اســـتخدام المنصـــات التعليمية 
لجميع المســـتفيدين وفقا للتنظيمات الواردة من 
ً
الادارة العامـــة لتعليـــم الإلكترونـــي والتعليـــم عن 
بعد في وزارة التعليم.
٣- التواصـــل مع المدارس في حال وجود صعوبات 
تخـــص عمليـــات التعليـــم الالكترونـــي والتعليم عن 
بعد.
٤-تنظيم اقامـــة الفعاليات والمســـابقات للميدان 
والخاصـــة بعمليـــات التعليم الإلكترونـــي والتعليم 
عن بعد.
٥-نشر الثقافة التقنية وأمن المعلومات .
٦-تصميـــم التقاريـــر الدوريـــة والســـنوية عـــن 
نشاطات الإدارة وإنجازاتها.
٧- ابتـــكار الأفـــكار الإبداعيـــة لكتابـــة المحتـــوى 
وانتاجـــه بمـــا يتناســـب مـــع وســـائل النشـــر 
المتاحة.
                  ''',
      image: "assets/images/4.png",
      index: 3,
    ),
  ];
}
