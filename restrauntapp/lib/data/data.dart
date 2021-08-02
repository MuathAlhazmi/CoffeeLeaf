import 'package:flutter/material.dart';
import 'package:restrauntapp/models/infoModel.dart';
import 'package:restrauntapp/models/models.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};
int selectedIndex = 0;
int currentIndex1 = 0;

MaterialColor colorCustom = MaterialColor(0xFF495E79, color);
List<Item> favourite = [];
List<Item> searchResult = [];
ValueNotifier<bool> isSeen = ValueNotifier<bool>(true);
List<Item> items = [
  Item(
      itemID: '11132234432134432',
      description:
          'وهو يختلف عن اللاتيه فى إضافة صوص الشوكولاتة على مكونات اللاتيه، ويُقدم في نفس الكوب الذي يقدم فيه اللاتيه، كوب طويل أو متوسط، على عكس فنجان الكابتشينو الكلاسيكي، ويمكن أن يكون ساخن أو يقدم كنوع من القهوة الباردة وتسمى في هذه الحالة آيس موكا.',
      price: 10,
      image:
          'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_mocha.jpg',
      name: 'موكا',
      quantity: 0),
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
  Item(
      itemID: '9310802480284',
      description:
          'هى القهوة العادية ولكن مع ثلج، وأحيانا يُضاف لها القليل من الحليب أو الكريمة أو المحليات، بهذه البساطة يُمكنكِ الحصول على مشروب قهوة رائع وبارد أيضا.',
      price: 21,
      image:
          'https://cdnimg.webstaurantstore.com/uploads/blog/2019/4/coffee-drinks_iced-coffee.jpg',
      name: 'القهوة المثلجة',
      quantity: 0),
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
];
List<Item> cart = [];
List<InfoModel> infoModels = [
  InfoModel(
    content: ['السطر الاول', 'السطر الثاني', 'السطر الثالث'],
    image:
        'https://images.unsplash.com/photo-1447933601403-0c6688de566e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1856&q=80',
    contentTitle: [
      'ومعنى الكلمة الحرفي "قهوة وحليب" من اللغة الإيطالية ومن اسمه تتضح مكوناته، هو عبارة عن قهوة "اسبرسو" توضع في قاع كوب المشروب، ويوضع عليه الحليب، أحيانًا توضع طبقة من الرغوة "Foam "وأحيانًا لا توضع، ولكن في كل الأحوال اللاتيه معروف بنسبة لبن أعلى من نسبة القهوة.',
      'هي نفس الإسبريسو لكنها تقدم بكميات أكبر بكثير منها لمحبي القهوة، وذلك لأنها أخف، فتتكون من حوالي 40% من الإسبرسو و60% من الماء، يمك إضافة السكر لها وأحيانًا الحليب، لكنه في الأغلب يتم تناولها سوداء.',
      'هى القهوة العادية ولكن مع ثلج، وأحيانا يُضاف لها القليل من الحليب أو الكريمة أو المحليات، بهذه البساطة يُمكنكِ الحصول على مشروب قهوة رائع وبارد أيضا.',
    ],
    iconDataList: [
      Icons.coffee,
      Icons.coffee_maker,
      Icons.local_drink,
    ],
    title: 'كيف نقوم بتحميص قهوتنا؟',
    sub: 'اضغط لكي تعرف المزيد',
  ),
  InfoModel(
    content: ['السطر الاول', 'السطر الثاني', 'السطر الثالث'],
    image:
        'https://images.unsplash.com/photo-1507226983735-a838615193b0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80',
    contentTitle: [
      'ومعنى الكلمة الحرفي "قهوة وحليب" من اللغة الإيطالية ومن اسمه تتضح مكوناته، هو عبارة عن قهوة "اسبرسو" توضع في قاع كوب المشروب، ويوضع عليه الحليب، أحيانًا توضع طبقة من الرغوة "Foam "وأحيانًا لا توضع، ولكن في كل الأحوال اللاتيه معروف بنسبة لبن أعلى من نسبة القهوة.',
      'هي نفس الإسبريسو لكنها تقدم بكميات أكبر بكثير منها لمحبي القهوة، وذلك لأنها أخف، فتتكون من حوالي 40% من الإسبرسو و60% من الماء، يمك إضافة السكر لها وأحيانًا الحليب، لكنه في الأغلب يتم تناولها سوداء.',
      'هى القهوة العادية ولكن مع ثلج، وأحيانا يُضاف لها القليل من الحليب أو الكريمة أو المحليات، بهذه البساطة يُمكنكِ الحصول على مشروب قهوة رائع وبارد أيضا.',
    ],
    iconDataList: [
      Icons.coffee,
      Icons.coffee_maker,
      Icons.local_drink,
    ],
    title: 'هل تريد انت تكون باريستا؟',
    sub: 'قدم طلب العمل معنا آلان',
  ),
];
