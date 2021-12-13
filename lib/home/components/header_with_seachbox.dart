import 'package:flutter/material.dart';
import 'package:untitled9/home/constants.dart';


class HeaderWithSearchBox extends StatelessWidget {
  final TextEditingController con;
  final Function searchcli;
  final Function searchclick2;
  const HeaderWithSearchBox({
    Key key,
    @required this.size,  this.con, this.searchcli, this.searchclick2,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 1.5),
      // It will cover 20% of our total height
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'my watch list',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
               //
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FocusScope(
                        child: Focus(
                            onFocusChange: (focus) => {
                              if(focus==true){searchcli()}
                              else{searchclick2()}
                            },
                            child: TextField(
                               controller:con ,
                                onChanged: (value) { },
                                decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                color: Color(0xFF0C9869).withOpacity(.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,

                                ),
                                )
                                ),
                        ),),
                  IconButton(icon: Icon(Icons.search),onPressed: (){searchclick2();con.text!=''?print(con.text):print('no text found');},),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
