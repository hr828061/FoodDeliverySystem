import 'package:ecommerce/Pages/details.dart';
import 'package:ecommerce/Pages/login.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/service/database.dart';
import 'package:ecommerce/widget/widget_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false;
  bool burger = false;
  bool pizza = false;

  final DatabaseMethods databaseMethods = DatabaseMethods();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts({String? category}) async {
    databaseMethods.getFoodItems().listen((snapshot) {
      List<Product> fetchedProducts = snapshot.docs.map((doc) {
        return Product(
          name: doc['name'],
          category: doc['category'],
          imageUrl: doc['imageUrl'],
          price: doc['price'],
          description: doc['description'],
        );
      }).toList();

      if (category != null) {
        fetchedProducts = fetchedProducts
            .where((product) => product.category == category)
            .toList();
      }

      setState(() {
        products = fetchedProducts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout,color: Colors.white,),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
        title: Text(
          "Fast Foodies",
          style: AppWidget.HomepageTextFieldStyle(),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 10.0,
            left: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delicious Food",
                style: AppWidget.HeadlineTextFieldStyle(),
              ),
              Text(
                "Discover and get great food",
                style: AppWidget.LightTextFieldStyle(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(margin: EdgeInsets.only(right: 10), child: showItem()),
              SizedBox(
                height: 30.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: products
                      .map((product) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Details(product: product)));
                            },
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        product.imageUrl,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        product.name,
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      ),
                                      Text(
                                        product.category,
                                        style: AppWidget.LightTextFieldStyle(),
                                      ),
                                      Text(
                                        "Rs ${product.price}",
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ...products
                  .map((product) => GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Details(product: product)));
                },
                    child: Container(
                          margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                          child: Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    product.imageUrl,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width / 2,
                                        child: Text(
                                          product.name,
                                          style:
                                              AppWidget.semiBoldTextFieldStyle(),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width / 2,
                                        child: Text(
                                          product.category,
                                          style: AppWidget.LightTextFieldStyle(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width / 2,
                                        child: Text(
                                          "Rs ${product.price}",
                                          style:
                                              AppWidget.semiBoldTextFieldStyle(),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              icecream = true;
              pizza = false;
              burger = false;
            });
            fetchProducts(category: 'Ice-cream');
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: icecream ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/ice-cream.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              icecream = false;
              pizza = false;
              burger = true;
            });
            fetchProducts(category: 'Burger');
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/burger.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              icecream = false;
              pizza = true;
              burger = false;
            });
            fetchProducts(category: 'Pizza');
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/pizza.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
