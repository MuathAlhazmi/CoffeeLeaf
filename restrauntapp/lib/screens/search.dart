import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
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
  final search3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DefaultTabController(
        length: 4,
        child: Column(children: <Widget>[
          TabBar(
            enableFeedback: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: CircleTabIndicator(color: mainColor, radius: 4),
            isScrollable: true,
            indicatorColor: mainColor,
            unselectedLabelStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold),
            labelStyle: TextStyle(
                color: mainColor,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold),
            labelColor: mainColor,
            unselectedLabelColor: mainColor.withOpacity(.4),
            tabs: [
              Tab(
                text: "الكل",
              ),
              Tab(
                text: "القهوة بالحليب",
              ),
              Tab(
                text: "القهوة المثلجة",
              ),
              Tab(
                text: "القهوة السوداء",
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Expanded(
              child: TabBarView(
            children: [
              SearchWidget(
                  search: search,
                  enabled: widget.enabled,
                  items: items,
                  searchResult: []),
              SearchWidget(search: search1, enabled: widget.enabled, items: [
                items[1],
                items[2],
                items[3],
                items[4],
              ], searchResult: []),
              SearchWidget(search: search2, enabled: widget.enabled, items: [
                items[5],
                items[0],
              ], searchResult: []),
              SearchWidget(search: search3, enabled: widget.enabled, items: [
                items[6],
                items[7],
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
