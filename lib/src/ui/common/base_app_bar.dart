import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // final locationData = Provider.of<LocationProvider>(context, listen: true);
    // String defaultCity = 'Choose your city';

    void chooseYourCity() {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ChooseCurrentCityScreen(),
      //   ),
      // );
    }

    return Container(
      // color: Color(0xffededed),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Column(
              children: [
                Text(
                  'Delivering to',
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: chooseYourCity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dikernes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.deepOrange)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  child: Container(
                    width: MediaQuery.of(context).size.width *0.95,
                    height: 45,
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Free Delivery',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(Icons.check_circle,color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(160);
}
