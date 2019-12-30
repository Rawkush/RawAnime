import 'package:flutter/material.dart';
import 'package:myapp/Provider/home_provider.dart';
import 'package:myapp/Screen/DetailPage/widget/text_form_field.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  double _maxLine = 3;
  bool seeMoreClicked = false;
  TextEditingController _textEditingController;
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000))..addListener(()=>setState((){}));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _id = ModalRoute.of(context).settings.arguments;
    final _homeProvider = Provider.of<HomeProvider>(context);
    final _currentitem = _homeProvider.getElementWithId(_id);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black87,
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Text(_currentitem.title),
      // ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: _height * 0.37,
              color: Colors.transparent,
              child: AnimatedOpacity(
                curve:Curves.easeIn,
                duration: Duration(milliseconds: 300),
                opacity: _animationController.value>0.10?1:0,
                              child: Stack(
                  children: <Widget>[
                    Container(
                      height: _height * 0.3,
                      width: _width,
                      constraints:
                          BoxConstraints(maxHeight: _height > 600 ? 280 : 180),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          image: DecorationImage(
                            image: NetworkImage(_currentitem.img),
                            fit: BoxFit.fill,
                          )),
                    ),
                    Positioned(
                      left: _currentitem.title.length > 8
                          ? _width * 0.1
                          : _width * 0.2,
                      right: _currentitem.title.length > 8
                          ? _width * 0.1
                          : _width * 0.2,
                      bottom: _height * 0.03,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: _height * 0.03,
                              maxHeight: 60,
                            ),
                            child: Center(
                              child: Text(
                                _currentitem.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            AnimatedOpacity(
                curve:Curves.easeIn,
                duration: Duration(milliseconds: 300),
              opacity: _animationController.value>0.20?1:0,
                          child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                // child: Text("The red-tailed tropicbird is a seabird native to the tropical Indian and Pacific Oceans. One of three closely related species of tropicbird, it has four subspecies. Text wrapping is quite a pain for me too. I find that putting Text in a Container and then wrapping that container in a Expanded/Flexible works well.",style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),maxLines: 3,),

                child: _text(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            AnimatedOpacity(
                curve:Curves.easeIn,
                duration: Duration(milliseconds: 300),
              opacity: _animationController.value>0.30?1:0,
                          child: CustomTextFormField.MyTextFormField(
                  _textEditingController, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text() {
    var exceeded;
    return LayoutBuilder(builder: (context, size) {
      // Build the textspan
      var span = TextSpan(
        text:
            "The red-tailed tropicbird is a seabird native to the tropical Indian and Pacific Oceans. One of three closely related species of tropicbird, it has four subspecies. Text wrapping is quite a pain for me too. I find that putting Text in a Container and then wrapping that container in a Expanded/Flexible works well.",
        style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
      );

      // Use a textpainter to determine if it will exceed max lines
      var tp = TextPainter(
        maxLines: _maxLine.toInt(),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        text: span,
      );

      // trigger it to layout
      tp.layout(maxWidth: size.maxWidth);

      // whether the text overflowed or not
      exceeded = tp.didExceedMaxLines;

      // return Column(children: <Widget>[
      return Container(
        child: exceeded && seeMoreClicked
            ? _seeMoreLess(span, "See Less ")
            : exceeded && !seeMoreClicked
                ? _seeMoreLess(span, "See More", 3)
                : Text.rich(
                    span,
                    overflow: TextOverflow.visible,
                  ),
      );
    });
    // return exceeded;
  }

  Widget _seeMoreLess(TextSpan span, String _text, [int maxLine = 0]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        maxLine > 0
            ? Text.rich(
                span,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              )
            : Text.rich(
                span,
                overflow: TextOverflow.visible,
              ),
        InkWell(
            child: Text(
              _text,
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.blue),
            ),
            onTap: () {
              setState(() {
                seeMoreClicked = !seeMoreClicked;
              });
            }),
      ],
    );
  }
}
