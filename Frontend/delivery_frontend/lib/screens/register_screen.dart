import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCity = 'Adana';
  List<String> _cities = ['Adana', 'Adıyaman', 'Afyonkarahisar', 'Ağrı', 'Aksaray', 'Amasya', 'Ankara', 'Antalya', 'Ardahan', 'Artvin', 'Aydın', 'Balıkesir', 'Bartın', 'Batman', 'Bayburt', 'Bilecik', 'Bingöl', 'Bitlis', 'Bolu', 'Burdur', 'Bursa', 'Çanakkale', 'Çankırı', 'Çorum', 'Denizli', 'Diyarbakır', 'Düzce', 'Edirne', 'Elazığ', 'Erzincan', 'Erzurum', 'Eskişehir', 'Gaziantep', 'Giresun', 'Gümüşhane', 'Hakkari', 'Hatay', 'Iğdır', 'Isparta', 'İstanbul', 'İzmir', 'Kahramanmaraş', 'Karabük', 'Karaman', 'Kars', 'Kastamonu', 'Kayseri', 'Kilis', 'Kırıkkale', 'Kırklareli', 'Kırşehir', 'Kocaeli', 'Konya', 'Kütahya', 'Malatya', 'Manisa', 'Mardin', 'Mersin', 'Muğla', 'Muş', 'Nevşehir', 'Niğde', 'Ordu', 'Osmaniye', 'Rize', 'Sakarya', 'Samsun', 'Siirt', 'Sinop', 'Sivas', 'Şanlıurfa', 'Şırnak', 'Tekirdağ', 'Tokat', 'Trabzon', 'Tunceli', 'Uşak', 'Van', 'Yalova', 'Yozgat', 'Zonguldak']; // Replace with actual city names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register', style: TextStyle(fontSize: 24)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 70),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Surname',
                    labelStyle: TextStyle(fontSize: 70),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your surname';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(fontSize: 70),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 70),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  ),
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                Container(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(fontSize: 40),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16), // Adjust the padding
                    ),
                    isDense: false,
                    isExpanded: true,
                    value: _selectedCity,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCity = newValue!;
                      });
                    },
                    items: _cities.map((city) {
                      return DropdownMenuItem(
                        child: Text(city, style: TextStyle(fontSize: 40)),
                        value: city,
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select your city';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(fontSize: 70),
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  ),
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(fontSize: 70),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  ),
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 18),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle registration logic
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: Text('Register', style: TextStyle(fontSize: 40)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
