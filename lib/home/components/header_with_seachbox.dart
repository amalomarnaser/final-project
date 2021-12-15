import 'package:flutter/material.dart';
import 'package:untitled9/home/constants.dart';


class HeaderWithSearchBox extends StatelessWidget {
  final TextEditingController con;
  final Function searchcli;
  final Function searchclick2;
  const HeaderWithSearchBox({
    Key key,
     this.con, this.searchcli, this.searchclick2,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
     const size=50;

    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 1.5),
      // It will cover 20% of our total height
      height: 80,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: 90 ,color: Colors.black,
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
                  Container(

                    child: Expanded(
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
                  ),
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
