import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp()); //该函数只是告知 Flutter 运行 MyApp 中定义的应用。
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //使用 ChangeNotifierProvider 创建状态并将其提供给整个应用（参见上面 MyApp 中的代码）。这样一来，应用中的任何 widget 都可以获取状态。
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 191, 144, 184)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  //MyAppState 定义应用运行所需的数据。现在，其中仅包含一个变量，
  //即通过随机函数生成当前的随机单词对。您稍后将在其中添加代码。
  //状态类扩展 ChangeNotifier，这意味着它可以向其他人通知自己的更改。
  //例如，如果当前单词对发生变化，应用中的一些 widget 需要知晓此变化。
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  //在 MyAppState 中添加了一个名为 favorites 的新属性。此属性使用一个空的列表进行初始化，即 []。
  var favorites = <WordPair>[];

  //添加了一个新方法 toggleFavorite()，它可以从收藏夹列表中删除当前单词对（如果已经存在），
  //或者添加单词对（如果不存在）。在任何一种情况下，代码都会在之后调用 notifyListeners();。
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0; //引入了一个新变量 selectedIndex，并将其初始化为 0。
  @override
  Widget build(BuildContext context) {
    Widget page; //声明了一个类型为 Widget 的新变量 page。
    switch (selectedIndex) {
      //根据 selectedIndex 中的当前值，switch 语句为 page 分配一个屏幕。
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    //每当约束发生更改时，系统都会调用 LayoutBuilder 的 builder 回调。
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            //MyHomePage 包含一个有两个子项的 Row。
            //第一个是 SafeArea widget，第二个是 Expanded widget。
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                // false, //将 NavigationRail 中的 extended: false 行更改为 true。这将显示图标旁边的标签。
                destinations: [
                  //侧边导航栏有两个目标页面（Home 和 Favorites），两者都有各自的图标和标签。
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                //侧边导航栏还定义了当前的 selectedIndex。若选定索引 (selectedIndex) 为零，则会选择第一个目标页面；
                //若选定索引为一，则会选择第二个目标页面，依此类推。目前，它被硬编码为零。
                selectedIndex: selectedIndex,
                //侧边导航栏还定义了当用户选择其中一个具有 onDestinationSelected 的目标页面时会发生什么。
                onDestinationSelected: (value) {
                  //当调用 onDestinationSelected 回调时将其分配到 setState() 调用内部的 selectedIndex。
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              //两个 Expanded widget 会分割两者之间所有可用的水平空间，即使侧边导航栏只需要左侧的一小部分。
              //在 Expanded widget 内部，有一个指定了颜色的 Container；而在该容器内部，有一个 GeneratorPage。
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// ...

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    //如果收藏夹列表为空，则居中显示消息：No favorites yet*.*
    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    //否则显示一个（可滚动的）列表。
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          //列表最开始显示一条概要消息（例如，You have 5 favorites*.*）。
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),

        //然后，代码遍历所有收藏夹，并为每个收藏夹构造一个 ListTile widget。
        for (var pair in appState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
// ...

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //使用 Theme.of(context) 请求应用的当前主题。
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary, //代码将卡片的颜色定义为与主题的 colorScheme 属性相同。
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
        ),
      ),
    );
  }
}
