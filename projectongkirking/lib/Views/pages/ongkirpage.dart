part of 'pages.dart';

class Ongkirpage extends StatefulWidget {
  const Ongkirpage({Key? key}) : super(key: key);

  @override
  _OngkirpageState createState() => _OngkirpageState();
}

class _OngkirpageState extends State<Ongkirpage> {
  bool isLoading = false;
  bool provanceLaw = false;
  bool provanceRule = false;
  bool cityLaw = false;
  bool cityRule = false;

  String dropdownvalue = 'select';
  var kurir = ['select', 'JNE', 'POS', 'TIKI'];

  final ctrlBerat = TextEditingController();

  dynamic provId;
  dynamic provinceData;
  dynamic provanceDeOrigin;
  dynamic provanceDestiny;
  Future<List<Province>> getProvinces() async {
    dynamic listProvince;
    await MasterDataService.getProvince().then((value) {
      setState(() {
        listProvince = value;
      });
    });
    return listProvince;
  }

  dynamic cityId;
  dynamic cityDataDeOrigin;
  dynamic cityDataDestiny;
  dynamic cityDeOrigin;
  dynamic cityDestiny;
  Future<List<City>> getCities(dynamic provId) async {
    dynamic listCity;
    await MasterDataService.getCity(provId).then((value) {
      setState(() {
        listCity = value;
      });
    });
    return listCity;
  }

  @override
  void initState() {
    super.initState();
    provinceData = getProvinces();
  }

  @override
  Widget build(BuildContext context) {
    /* DOMUS ORNAMENTUM */
    /* Domus Ornamentum is the decoration used inside the application */
    var bari = AppBar(
      title: Text(
        "Shipping Counter",
        style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.purple,
    );
    var ideo = Flexible(
      //'ideo' is used for the title of Transport Data which used H5 font to implement
      flex: 1,
      child: Container(
        child: Text("Transport Data",
            style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
    var wisdom = Flexible(
      //'wisdom' is used for the title of Origin which used H5 font to implement
      flex: 1,
      child: Container(
        child: Text("Origin",
            style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
    var might = Flexible(
      //'might' is used for the title of Destination which used H5 font to implement
      flex: 1,
      child: Container(
        child: Text("Destination",
            style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
    );
    var voidzone = SizedBox(
      //voidzone is the spacer between the lines to keep the screen beautiful and tidy
      height: 20,
    );
    var dividen = SizedBox(
      //Deviden is smaller voidzone :v
      height: 5,
    );
    var order = Flexible(
      //'order' is used to place the order in future update, however for now it was just another larger spacer
      flex: 2,
      child: Container(),
    );

/* TABELLARIUM MINISTERIUM */
/* Tabellarium Ministerium used to implement the package sender and the weights used for transport */
    var counterweights = Row(
      //The Counterweights, just like the name which this one is used to count the weight of items
      children: [
        SizedBox(
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: 100,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: ctrlBerat,
              style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 12,
                  color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Weight (grams)',
                labelStyle: MaterialStateTextStyle.resolveWith(
                    (Set<MaterialState> states) {
                  final Color color = states.contains(MaterialState.error)
                      ? Theme.of(context).errorColor
                      : Colors.white;
                  return TextStyle(color: color, letterSpacing: 1.3);
                }),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return value == null || value == 0
                    ? 'Berat harus diisi atau tidak boleh 0!'
                    : null;
              },
            ),
          ),
        )
      ],
    );
    var rome = Row(
      //I don't know why I called it as 'Rome' but I guess, I remember the gods of greek mythology which send messages
      //So, this one is used to choose which courier you want to choose as your service
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          width: 100,
          child: DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.arrow_drop_down),
              style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 14,
                  color: Colors.white),
              dropdownColor: Colors.deepPurple.shade300,
              items: kurir.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              }),
        )
      ],
    );
    var bonnet = Flexible(
        //Bonnet is not used anymore, because the Tables are taking down the city :0
        flex: 1,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              rome,
              counterweights,
            ],
          ),
        ));

/* PROVINCIA ORDINIS */
/* One big part of the country, which transportation and transaction happen */
    var dukedeprovance = Row(
      //Just like the name, Duke De Provance rule the Province he lived.
      //This one used to implement the Origin City, or where you lived right now
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          width: 150,
          child: FutureBuilder<List<Province>>(
              future: provinceData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton(
                      isExpanded: true,
                      value: provanceDeOrigin,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 16,
                      focusColor: Colors.grey.shade400,
                      dropdownColor: Colors.deepPurple.shade300,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                      ),
                      hint: provanceDeOrigin == null
                          ? Text(
                              'Choose the province',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(provanceDeOrigin.province),
                      items: snapshot.data!
                          .map<DropdownMenuItem<Province>>((Province value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value.province.toString()));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          provanceDeOrigin = newValue;
                          provId = provanceDeOrigin.provinceId;
                          provanceLaw = true;
                        });
                        cityDeOrigin = null;
                        cityDataDeOrigin = getCities(provId);
                      });
                } else if (snapshot.hasError) {
                  return const Text("Tidak ada data.");
                }

                return UiLoading.loadingDD();
              }),
        ),
      ],
    );
    var provancedesender = Row(
      //Courier between the province under the management of a duke
      //This courier used to place a mark on your package's destination
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          width: 150,
          child: FutureBuilder<List<Province>>(
              future: provinceData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton(
                      isExpanded: true,
                      value: provanceDestiny,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 16,
                      focusColor: Colors.grey.shade400,
                      dropdownColor: Colors.deepPurple.shade300,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                      ),
                      hint: provanceDestiny == null
                          ? Text(
                              'Choose the province',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(provanceDestiny.province),
                      items: snapshot.data!
                          .map<DropdownMenuItem<Province>>((Province value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value.province.toString()));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          provanceDestiny = newValue;
                          provId = provanceDestiny.provinceId;
                          provanceRule = true;
                        });
                        cityDestiny = null;
                        cityDataDestiny = getCities(provId);
                      });
                } else if (snapshot.hasError) {
                  return const Text("Tidak ada data.");
                }
                return UiLoading.loadingDD();
              }),
        ),
      ],
    );

/* CIVITAS ORDINIS */
/* One place to set the command used in city, to deliver and where to deliver */
    var dukedecity = Row(
      //Below the surface of Province, lived a peaceful town ruled by a young duke
      //Duke the city or so called used to mark your data, your birthplace or so called
      //Alright, this one is the city where you belong according to the province you lived recently
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          width: 150,
          child: FutureBuilder<List<City>>(
              future: cityDataDeOrigin,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return DropdownButton(
                      isExpanded: true,
                      value: cityDeOrigin,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 16,
                      focusColor: Colors.grey.shade400,
                      dropdownColor: Colors.deepPurple.shade300,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                      ),
                      hint: cityDeOrigin == null
                          ? Text(
                              'Choose the city',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(cityDeOrigin.cityName),
                      items: snapshot.data!
                          .map<DropdownMenuItem<City>>((City value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value.cityName.toString()));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          cityDeOrigin = newValue;
                          cityLaw = true;
                        });
                      });
                } else if (snapshot.hasError) {
                  return const Text("Tidak ada data.");
                }

                if (provanceLaw == false) {
                  return Text(
                    "Please choose your current province",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                        fontFamily: 'Times New Roman'),
                  );
                } else {
                  return UiLoading.loadingDD();
                }
              }),
        ),
      ],
    );
    var citydesender = Row(
      //Just like his brother of Provance De Sender, this one used to take the package to the city you wanted
      //This part used to place a mark on the city that depends on the province you choose to send your package
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          width: 150,
          child: FutureBuilder<List<City>>(
              future: cityDataDestiny,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return DropdownButton(
                      isExpanded: true,
                      value: cityDestiny,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 16,
                      focusColor: Colors.grey.shade400,
                      dropdownColor: Colors.deepPurple.shade300,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                      ),
                      hint: cityDestiny == null
                          ? Text(
                              'Choose your Destination City',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(cityDestiny.cityName),
                      items: snapshot.data!
                          .map<DropdownMenuItem<City>>((City value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value.cityName.toString()));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          cityDestiny = newValue;
                          cityRule = true;
                        });
                      });
                } else if (snapshot.hasError) {
                  return const Text("Tidak ada data.");
                }

                if (provanceRule == false) {
                  return Text(
                    "Please choose your destination province",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        height: 1.5,
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                        fontFamily: 'Times New Roman'),
                  );
                } else {
                  return UiLoading.loadingDD();
                }
              }),
        ),
      ],
    );

/* PRESSURA LAMINAM */
/* Pressura Laminam is the collection of button used to build this kingdom*/
    var submitia = ElevatedButton(
        //Submitia, a famous astrologer and librarian in romanian age, nevermind...
        //This 'button' used to send your data to 'space' so you can confirm your package status right away
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[900],
            padding: EdgeInsets.only(left: 20, right: 20)),
        onPressed: () async {
          if (provanceLaw == true &&
              provanceRule == true &&
              cityLaw == true &&
              cityRule == true) {
            Fluttertoast.showToast(
                msg: "Origin: " +
                    cityDeOrigin.cityName.toString() +
                    ", Destination: " +
                    cityDestiny.cityName.toString(),
                backgroundColor: Colors.purple.shade700,
                textColor: Colors.white);
          } else {
            Fluttertoast.showToast(
                msg:
                    "Please fill all the data, Origin and Destination included!",
                backgroundColor: Colors.red,
                textColor: Colors.white);
          }
        },
        child: Text("Calculate the Estimated Price"));

/* TABLE DE UNION */
/* Ever imagined the world stood under a big tree where soldiers, people and the dukes sit together?*/
    var tableDeRoman = Flexible(
      //Table De Roman used to place everything in Tabellarium Ministeriumin one shape of table
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Table(
          border: TableBorder.all(width: 2, color: Colors.white),
          children: [
            TableRow(children: [rome, counterweights])
          ],
        ),
      ),
    );
    var tableDeOrder = Flexible(
      //Table De Order used to place Duke De Provance and Duke De city in one meeting table
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Table(
          border: TableBorder.all(width: 2, color: Colors.white),
          children: [
            TableRow(children: [dukedeprovance, dukedecity])
          ],
        ),
      ),
    );
    var tableDeHonor = Flexible(
      //Table De Order used to place Provance De Sender and City De Sender in one office table
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Table(
          border: TableBorder.all(width: 2, color: Colors.white),
          children: [
            TableRow(children: [provancedesender, citydesender])
          ],
        ),
      ),
    );

/* APPLICATIONEM LIBERATIONIS*/
/* Here you unite all the units in the Code Kingdom */
    return Scaffold(
      appBar: bari,
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple.shade900, Colors.purple.shade300]),
              ),
              child: Column(
                children: [
                  voidzone,
                  ideo,
                  dividen,
                  tableDeRoman,
                  voidzone,
                  wisdom,
                  dividen,
                  tableDeOrder,
                  voidzone,
                  might,
                  dividen,
                  tableDeHonor,
                  order,
                  submitia,
                ],
              )),
          isLoading == true ? UiLoading.loadingBlock() : Container(),
        ],
      ),
    );
  }
}
