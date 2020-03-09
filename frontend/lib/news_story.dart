import 'dart:math';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news_story_actions.dart';
import 'main.dart';

export 'news_story_actions.dart';


enum ProgressPosition { top, bottom }


enum IndicatorHeight { small, large }

// List<String> urlnews;

List<String> urlList = List<String>();

int hardcodecounter = 0;




class StoryItem {
  
  final Duration time;

  bool seen;

  
  final Widget view;

  // static BuildContext context;

  StoryItem(
    this.view, {
    this.time = const Duration(seconds: 3),
    this.seen = false,
  }) : assert(time != null, "[time] should not be null");


  static StoryItem inlineImage(
    int hardcodecounter2,
    String urltempnews, 
    ImageProvider image, {
    Text caption,
    bool seen = false,
    bool roundedTop = true,
    bool roundedBottom = false,
    
  }) {
    hardcodecounter = hardcodecounter2;
    // urlnews += urltempnews;
    urlList.add(urltempnews);
    // print ("--------^^^^^^^^^-------^^^^^^^--------");
    // print (urlList);

    // Navigator.push(context, new MaterialPageRoute(builder: (context) => new StoryView(urlnews);


    // print ('---------news-url:--');
    // print (urltempnews);
    // print (urlnews);

    return StoryItem(
      Container(
        child : Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Container(
            decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(roundedTop ? 8 : 0),
              bottom: Radius.circular(roundedBottom ? 8 : 0),
            ),
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            )
            ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              child: caption == null ? SizedBox() : caption,
              width: double.infinity,
              color: Colors.amber[200],
              
            ),
          ),
        ],
         ),
      ),
        // decoration: BoxDecoration(
        //     color: Colors.grey[100],
        //     borderRadius: BorderRadius.vertical(
        //       top: Radius.circular(roundedTop ? 8 : 0),
        //       bottom: Radius.circular(roundedBottom ? 8 : 0),
        //     ),
        //     image: DecorationImage(
        //       image: image,
        //       fit: BoxFit.cover,
        //     )
        //     ),
        // child: Container(
        //   child: Align(
        //     alignment: Alignment.bottomLeft,
        //     child: Container(
        //       // child: caption == null ? SizedBox() : caption,
        //       // width: double.infinity,
        //       child: caption != null ? Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        //                   Container(color: Colors.blue[200], height: 260, width: 414,)
        //                 ])
        //                 : SizedBox(),
        //     ),
        //   ),
      seen: seen,
    );
  }

}


class StoryView extends StatefulWidget {
 
  final List<StoryItem> storyItems;

  final VoidCallback onComplete;

  final ValueChanged<StoryItem> onStoryShow;

  final ProgressPosition progressPosition;

  final bool repeat;

  final bool inline;

  final NewsStoryActions controller;

  StoryView(
    this.storyItems, {
    this.controller,
    this.onComplete,
    this.onStoryShow,
    this.progressPosition = ProgressPosition.top,
    this.repeat = false,
    this.inline = false,
  })  : assert(storyItems != null && storyItems.length > 0,
            "[storyItems] should not be null or empty"),
        assert(progressPosition != null, "[progressPosition] cannot be null"),
        assert(
          repeat != null,
          "[repeat] cannot be null",
        ),
        assert(inline != null, "[inline] cannot be null");

  @override
  State<StatefulWidget> createState() {
    return StoryViewState();
  }
}

class StoryViewState extends State<StoryView> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> currentAnimation;
  Timer debouncer;
  // String urlnews;

  StreamSubscription<PlaybackState> playbackSubscription;

  

  StoryItem get lastShowing =>
      widget.storyItems.firstWhere((it) => !it.seen, orElse: () => null);

  String url = '';


  @override
  void initState() {
    super.initState();


    final firstNewsStory = widget.storyItems.firstWhere((it) {
      return !it.seen;
    }, orElse: () {
      widget.storyItems.forEach((it2) {
        it2.seen = false;
      });

      return null;
    });

    if (firstNewsStory != null) {
      final lastShownPos = widget.storyItems.indexOf(firstNewsStory);
      widget.storyItems.sublist(lastShownPos).forEach((it) {
        it.seen = false;
      });
    }

    play();

    if (widget.controller != null) {
      this.playbackSubscription =
          widget.controller.storyNotification.listen((playbackStatus) {
        if (playbackStatus == PlaybackState.play) {
          unpause();
        } else if (playbackStatus == PlaybackState.pause) {
          pause();
        }
      });
    }
  }

  @override
  void dispose() {
    debouncer?.cancel();
    animationController?.dispose();
    playbackSubscription?.cancel();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void play() {
    animationController?.dispose();
    final storyItem = widget.storyItems.firstWhere((it) {
      return !it.seen;
    });

    if (widget.onStoryShow != null) {
      widget.onStoryShow(storyItem);
    }

    animationController =
        AnimationController(duration: storyItem.time, vsync: this);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        storyItem.seen = true;
        if (widget.storyItems.last != storyItem) {
          beginPlay();
        } else {
          onComplete();
        }
      }
    });

    currentAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.forward();
  }

  void beginPlay() {
    setState(() {});
    play();
  }

  void onComplete() {
    if (widget.onComplete != null) {
      widget.controller?.pause();
      widget.onComplete();
    } else {
      print("Done");
    }

    if (widget.repeat) {
      widget.storyItems.forEach((it) {
        it.seen = false;
      });

      beginPlay();
    }
  }

  void swipeUp(List<String> urlfindlist) async {
    print ('Swiping Up from Story');
    

    int storynumber = widget.storyItems.indexOf(this.lastShowing);
    // storynumber = storynumber - 1;
    print ("--^^--^^--^^--^^--^^--^^cheching this point -----");
    print (storynumber);
    print (urlfindlist);

    int arrayend = urlfindlist.length;

    int indexnumber = hardcodecounter - 5 + storynumber;
    print ("--^^--^^--^^--^^--^^--^^cheching index number point -----");
    print (indexnumber);

    String finalurl = urlfindlist[indexnumber];
    // setState(() {
    //   myurl = url;
    // });
    // myurl = url;

    // launch(url);

    if (await canLaunch(finalurl)) {
      await launch(finalurl);
    } else {
      throw 'Could not launch url';
    }

    
  }

  void buttonPressed() {

    print ('Button has been pressed');
  }

  void closeNewsStory() {
    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Outlook()),
            );
  }

  void goBack() {

    
    widget.controller?.play();

    animationController.stop();

    if (this.lastShowing == null) {
      widget.storyItems.last.seen = false;
    }

    if (this.lastShowing == widget.storyItems.first) {
      beginPlay();
    } else {
      this.lastShowing.seen = false;
      int lastPos = widget.storyItems.indexOf(this.lastShowing);
      final previous = widget.storyItems[lastPos - 1];

      previous.seen = false;

      beginPlay();
    }
  }

  void goForward() {
    if (this.lastShowing != widget.storyItems.last) {
      animationController.stop();

      final _last = this.lastShowing;

      if (_last != null) {
        _last.seen = true;
        if (_last != widget.storyItems.last) {
          beginPlay();
        }
      }
    } else {
      animationController.animateTo(1.0, duration: Duration(milliseconds: 10));
    }
  }

  void pause() {
    this.animationController?.stop(canceled: false);
  }

  void unpause() {
    this.animationController?.forward();
  }

  void controlPause() {
    if (widget.controller != null) {
      widget.controller.pause();
    } else {
      pause();
    }
  }

  void controlUnpause() {
    if (widget.controller != null) {
      widget.controller.play();
    } else {
      unpause();
    }
  }

  Widget get currentView => widget.storyItems
      .firstWhere((it) => !it.seen, orElse: () => widget.storyItems.last)
      .view;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          // new RaisedButton(
          //   padding: const EdgeInsets.all(80.10),
          //   textColor: Colors.white,
          //   color: Colors.blue,
          //   onPressed: buttonPressed,
          //   child: new Text("BUTTON"),
          // ),
          
          currentView,
          Align(
            alignment: widget.progressPosition == ProgressPosition.top
                ? Alignment.topCenter
                : Alignment.bottomCenter,
            child: SafeArea(
              bottom: widget.inline ? false : true,
              // we use SafeArea here for notched and bezeles phones
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: PageBar(
                  widget.storyItems
                      .map((it) => PageData(it.time, it.seen))
                      .toList(),
                  this.currentAnimation,
                  key: UniqueKey(),
                  indicatorHeight: widget.inline
                      ? IndicatorHeight.small
                      : IndicatorHeight.large,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            heightFactor: 1,
            child: RawGestureDetector(
              gestures: <Type, GestureRecognizerFactory>{
                TapGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                        () => TapGestureRecognizer(), (instance) {
                  instance
                    ..onTapDown = (details) {
                      controlPause();
                      debouncer?.cancel();
                      debouncer = Timer(Duration(milliseconds: 500), () {});
                    }
                    ..onTapUp = (details) {
                      if (debouncer?.isActive == true) {
                        debouncer.cancel();
                        debouncer = null;

                        goForward();
                      } else {
                        debouncer.cancel();
                        debouncer = null;

                        controlUnpause();
                      }
                    };
                })
              },
            ),
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Row(mainAxisAlignment: MainAxisAlignment.end,
          //       children: [Container(color: Colors.blue, height: 100, width: 100)])]
          // ),
          Align(
              child : Column(
              children: <Widget>[
                Expanded(
                flex: 9,
                // child: Container(
                //   Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //   Row(mainAxisAlignment: MainAxisAlignment.end,
                //   children: [Container(color: Colors.blue, height: 100, width: 100)])]
                //   ),
                // ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                  child: Container(
                    child: RaisedButton(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0 ),
                      textColor: Colors.black,
                      color: Colors.blueGrey[100],
                      onPressed: buttonPressed,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      child: new Icon(Icons.star_border, color: Colors.black,),
                      ),
                  ),

                ),
                Container(
                  child: Container(
                    child: RaisedButton(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0 ),
                      textColor: Colors.black,
                      color: Colors.blueGrey[100],
                      onPressed: buttonPressed,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      child: new Icon(Icons.add_comment, color: Colors.black,),
                      // child: new Text("+"),
                      ),
                  ),

                )
                ]
                ),
                
                ]
                ),

                

                ),
                Expanded(
                flex: 3,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [Container(color: Colors.blue, height: 0, width: 0)])]
                ),
              
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment(0.7, -0.5),
          //   //padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 250.0, bottom: 10.0 ),
          //   child: RaisedButton(
          //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0 ),
          //   textColor: Colors.white,
          //   color: Colors.blue,
          //   onPressed: buttonPressed,
          //   child: new Text("BUTTON"),
          //   ),
            
          // ),
          Align(
            //alignment: Alignment.centerLeft,
            heightFactor: 2,
            child: SizedBox(
              child: GestureDetector(onPanUpdate: (details) {
                      if (details.delta.dx < 0) {
                        print ("swiping in up direction");
                        // print (urlList);
                        swipeUp(urlList);
                      }
                      else {
                        //go back to news feed
                        closeNewsStory();
                      }
                  },
              ),
              //width: 1000,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            heightFactor: 0.7,
            child: SizedBox(
              child: GestureDetector(
                onTap: () {
                  goBack();
                },
              ),
              width: 70,
            ),
          ),
        ],
      ),
    );
  }
}

class PageData {
  Duration time;
  bool seen;

  PageData(this.time, this.seen);
}

class PageBar extends StatefulWidget {
  final List<PageData> pages;
  final Animation<double> animation;
  final IndicatorHeight indicatorHeight;

  PageBar(
    this.pages,
    this.animation, {
    this.indicatorHeight = IndicatorHeight.large,
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PageBarState();
  }
}

class PageBarState extends State<PageBar> {
  double spacing = 4;

  @override
  void initState() {
    super.initState();

    int count = widget.pages.length;
    spacing = count > 15 ? 1 : count > 10 ? 2 : 4;

    widget.animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool isPlaying(PageData page) {
    return widget.pages.firstWhere((it) => !it.seen, orElse: () => null) ==
        page;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.pages.map((it) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.only(
                right: widget.pages.last == it ? 0 : this.spacing),
            child: StoryProgressIndicator(
              isPlaying(it) ? widget.animation.value : it.seen ? 1 : 0,
              indicatorHeight:
                  widget.indicatorHeight == IndicatorHeight.large ? 5 : 3,
            ),
          ),
        );
      }).toList(),
    );
  }
}


class StoryProgressIndicator extends StatelessWidget {
  final double value;
  final double indicatorHeight;

  StoryProgressIndicator(
    this.value, {
    this.indicatorHeight = 5,
  }) : assert(indicatorHeight != null && indicatorHeight > 0,
            "[indicatorHeight] should not be null or less than 1");

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromHeight(
        this.indicatorHeight,
      ),
      foregroundPainter: IndicatorOval(
        Colors.white.withOpacity(0.8),
        this.value,
      ),
      painter: IndicatorOval(
        Colors.white.withOpacity(0.4),
        1.0,
      ),
    );
  }
}

class IndicatorOval extends CustomPainter {
  final Color color;
  final double widthFactor;

  IndicatorOval(this.color, this.widthFactor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = this.color;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width * this.widthFactor, size.height),
            Radius.circular(3)),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ContrastHelper {
  static double luminance(int r, int g, int b) {
    final a = [r, g, b].map((it) {
      double value = it.toDouble() / 255.0;
      return value <= 0.03928
          ? value / 12.92
          : pow((value + 0.055) / 1.055, 2.4);
    }).toList();

    return a[0] * 0.2126 + a[1] * 0.7152 + a[2] * 0.0722;
  }

  static double contrast(rgb1, rgb2) {
    return luminance(rgb2[0], rgb2[1], rgb2[2]) /
        luminance(rgb1[0], rgb1[1], rgb1[2]);
  }
}