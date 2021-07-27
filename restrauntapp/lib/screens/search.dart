import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/models/models.dart';
import 'package:restrauntapp/widgets/searchwidget.dart';

class SearchPage extends StatefulWidget {
  bool enabled;
  SearchPage({required this.enabled});
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final search = TextEditingController();
  final search1 = TextEditingController();
  final search2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DefaultTabController(
        length: 3,
        child: Column(children: <Widget>[
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: CircleTabIndicator(color: mainColor, radius: 4),
            isScrollable: true,
            indicatorColor: mainColor,
            unselectedLabelStyle:
                TextStyle(color: Colors.black, fontFamily: 'Cairo'),
            labelStyle: TextStyle(color: mainColor, fontFamily: 'Cairo'),
            labelColor: mainColor,
            unselectedLabelColor: mainColor.withOpacity(.5),
            tabs: [
              Tab(
                text: "القهوة السوداء",
              ),
              Tab(
                text: "القهوة المثلجة",
              ),
              Tab(
                text: "القهوة بالحليب",
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Expanded(
              child: TabBarView(
            children: [
              SearchWidget(search: search, enabled: widget.enabled, items: [
                Item(
                    itemID: '1029837438920',
                    description:
                        'تتميز قهوة الكورتادو بإضافة الحليب المطهو على البخار والذي يصنع رغوة صغيرة تعلو كوب القهوة، ويستخدم الحليب ببساطة لتقليل بعض الحموضة الناتجة من قهوة الإسبريسو التي قد يكون مذاقها مر لدى البعض، وعند طلب ذلك المشروب قد يكون لديك خيار بين وضع الحليب بارد أو ساخن أو ساخن للغاية أو حتى استخدام الحليب المكثف.',
                    price: 15,
                    image:
                        'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_cortado.jpg',
                    name: 'كورتادو',
                    quantity: 0),
                Item(
                    itemID: '23454323333',
                    description:
                        'الفلات وايت هو مشروب أسترالي الأصل ويُسمى بهذا الاسم لأنه عبارة عن مشروب كابتشينو بدون رغوة أو إضافة رشة الشوكولاتة بالإضافة للحليب المبخر.',
                    price: 20,
                    image:
                        'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_flat-white.jpg',
                    name: 'فلات وايت',
                    quantity: 0),
                Item(
                    itemID: '965043004404',
                    description:
                        'يصعب التفريق بينه وبين اللاتيه، وذلك لأن مكوناتهم واحدة، الاختلاف فقط في نسب المكونات، الكابتشينو به طبقة تبدأ من 1سم إلى أكثر من الرغوة، وكلما زادت نسبة الرغوة فى الكابتشينو كلما كان الفنجان جيدًا.',
                    price: 18,
                    image:
                        'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_cappuccino.jpg',
                    name: 'كابوشينو',
                    quantity: 0),
                Item(
                    itemID: '39300294',
                    description:
                        'ومعنى الكلمة الحرفي "قهوة وحليب" من اللغة الإيطالية ومن اسمه تتضح مكوناته، هو عبارة عن قهوة "اسبرسو" توضع في قاع كوب المشروب، ويوضع عليه الحليب، أحيانًا توضع طبقة من الرغوة "Foam "وأحيانًا لا توضع، ولكن في كل الأحوال اللاتيه معروف بنسبة لبن أعلى من نسبة القهوة.',
                    price: 16,
                    image:
                        'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_caffe-latte.jpg',
                    name: 'كافي لاتيه',
                    quantity: 0),
              ], searchResult: []),
              SearchWidget(search: search1, enabled: widget.enabled, items: [
                Item(
                    itemID: '9310802480284',
                    description:
                        'هى القهوة العادية ولكن مع ثلج، وأحيانا يُضاف لها القليل من الحليب أو الكريمة أو المحليات، بهذه البساطة يُمكنكِ الحصول على مشروب قهوة رائع وبارد أيضا.',
                    price: 21,
                    image:
                        'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_iced-coffee.jpg',
                    name: 'القهوة المثلج',
                    quantity: 0),
                Item(
                    itemID: '11132234432134432',
                    description:
                        'وهو يختلف عن اللاتيه فى إضافة صوص الشوكولاتة على مكونات اللاتيه، ويُقدم في نفس الكوب الذي يقدم فيه اللاتيه، كوب طويل أو متوسط، على عكس فنجان الكابتشينو الكلاسيكي، ويمكن أن يكون ساخن أو يقدم كنوع من القهوة الباردة وتسمى في هذه الحالة آيس موكا.',
                    price: 10,
                    image:
                        'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_mocha.jpg',
                    name: 'موكا',
                    quantity: 0),
              ], searchResult: []),
              SearchWidget(search: search2, enabled: widget.enabled, items: [
                Item(
                    itemID: '39402749274974',
                    price: 21,
                    image:
                        'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_espresso.jpg',
                    name: 'اسبريسو',
                    description:
                        'هو أحد أنواع القهوة، وفي الواقع هو الأساس فى مكوّنات معظم تلك الأنواع التي سنتحدث عنها، وهو عبارة عن طحنة من البن المتوسطة -غير خشنة وغير ناعمة- يتم تحضيرها بقليل من الماء الساخن الذي يضغط مع كمية كبيرة من البن بماكينة ضغط القهوة، ليخرج مشروب سميك من القهوة، لونه بني غامق، وذو سطح "كريمي" لونه بني يميل إلى الذهبي.. تُعرف القهوة الاسبرسو الجيدة بقوامها السميك، وسطحها الكريمي، وكلمة إسبرسو باللغة الإيطالية تعني القهوة الطازجة وليست مرادفًا لكلمة إكسبريس.',
                    quantity: 0),
                Item(
                    itemID: '20390383034',
                    description:
                        'هي نفس الإسبريسو لكنها تقدم بكميات أكبر بكثير منها لمحبي القهوة، وذلك لأنها أخف، فتتكون من حوالي 40% من الإسبرسو و60% من الماء، يمك إضافة السكر لها وأحيانًا الحليب، لكنه في الأغلب يتم تناولها سوداء.',
                    price: 21,
                    image:
                        'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_americano.jpg',
                    name: 'اميريكانو',
                    quantity: 0),
              ], searchResult: []),
            ],
          )),
        ]),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
