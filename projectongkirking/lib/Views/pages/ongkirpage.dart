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
    var order = Flexible(
      //order used to place the order place of
      flex: 2,
      child: Container(),
    );

    var might = Flexible(
      flex: 1,
      child: Container(
        child: Text("Destination",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );

    var wisdom = Flexible(
      flex: 1,
      child: Container(
        child: Text("Origin",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );

    var voidzone = SizedBox(
      height: 5,
    );
/* BEAU DE BONNET */
    var rome = Row(
      children: [
        SizedBox(
          width: 100,
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: ctrlBerat,
            decoration: InputDecoration(
              labelText: 'Weight (grams)',
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return value == null || value == 0
                  ? 'Berat harus diisi atau tidak boleh 0!'
                  : null;
            },
          ),
        ),
      ],
    );

    var rowa = Row(
      children: [
        SizedBox(
          width: 100,
          child: DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.arrow_drop_down),
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
        flex: 1,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              rowa,
              rome,
            ],
          ),
        ));

/* PROVANCE DE LEGACY */
    var dukedeprovance = Row(
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
                      dropdownColor: Colors.grey.shade100,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                      ),
                      hint: provanceDeOrigin == null
                          ? Text('Choose the province')
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
                      dropdownColor: Colors.grey.shade100,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                      ),
                      hint: provanceDestiny == null
                          ? Text('Choose the province')
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

/* CITY OF ORDER*/
    var dukedecity = Row(
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
                      dropdownColor: Colors.grey.shade100,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                      ),
                      hint: cityDeOrigin == null
                          ? Text('Choose the city')
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
                        color: Colors.black.withOpacity(0.6),
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
                      dropdownColor: Colors.grey.shade100,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Times New Roman',
                      ),
                      hint: cityDestiny == null
                          ? Text('Choose your Destination City')
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
                        color: Colors.black.withOpacity(0.6),
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

/* PRESURA ET BUTTON */
    var submitia = ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        )),
        onPressed: () async {
          if (provanceLaw == true &&
              provanceRule == true &&
              cityLaw == true &&
              cityRule == true) {
            Fluttertoast.showToast(
                msg: "ORIGIN: " +
                    cityDeOrigin.cityName.toString() +
                    ", DESTINATION: " +
                    cityDestiny.cityName.toString(),
                backgroundColor: Colors.green);
          } else {
            Fluttertoast.showToast(
                msg: "ORIGIN dan atau DESTINATION masih belum diset",
                backgroundColor: Colors.red);
          }
        },
        child: Text("Hitung Estimasi Harga"));

/* TABLE DE UNION */
    var tableDeRoman = Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Table(
          border: TableBorder.all(width: 2, color: Colors.black),
          children: [
            TableRow(children: [rome, rowa])
          ],
        ),
      ),
    );
    var tableDeOrder = Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Table(
          border: TableBorder.all(width: 2, color: Colors.black),
          children: [
            TableRow(children: [dukedeprovance, dukedecity])
          ],
        ),
      ),
    );
    var tableDeHonor = Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Table(
          border: TableBorder.all(width: 2, color: Colors.black),
          children: [
            TableRow(children: [provancedesender, citydesender])
          ],
        ),
      ),
    );

/* LIBERATION I APPLICA*/
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongkir Counter"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  tableDeRoman,
                  voidzone,
                  wisdom,
                  tableDeOrder,
                  voidzone,
                  might,
                  tableDeHonor,
                  submitia,
                  order,
                ],
              )),
          isLoading == true ? UiLoading.loadingBlock() : Container(),
        ],
      ),
    );
  }
}
