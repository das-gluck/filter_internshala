import 'package:data_filters/data_filters.dart';
import 'package:filter/Provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> titles = ['Profile', 'Duration', 'City'];
  List<int>? filterIndex;

  @override
  void initState() {
    Provider.of<SProvider>(context, listen: false).getPostData(context);
    //Provider.of<SProvider>(context, listen: false).filterDataList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postmdl = Provider.of<SProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter App"),
        centerTitle: false,
      ),
      // body: ,
      // body: Consumer<SProvider>(
      //   builder: (context , provider , _){
      //     if(provider.data!.items.isEmpty){
      //       return Center(child: CircularProgressIndicator());
      //     }else {
      //       return Center(child: Text(provider.data!.items.values.first.title));
      //     }
      //   },
      // ),
      body: Consumer<SProvider>(
        builder: (context , postmdl , _){
          if( postmdl.l.isEmpty ){
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DataFilters(
                  data: postmdl.l,
                  /// pass your filter title here
                  filterTitle: titles,
                  /// enable animation
                  showAnimation: false,
                  /// get list of index of selected filter
                  recent_selected_data_index: (List<int>? index) {
                    setState(() {
                      filterIndex = index;
                    });

                  },
                  /// styling
                  style: FilterStyle(
                    buttonColor: Colors.green,
                    buttonColorText: Colors.white,
                    filterBorderColor: Colors.grey,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: postmdl.l.length,
                      itemBuilder: (context , index){
                        //print(postmdl.filteredItems.length);

                        if (filterIndex == null || filterIndex!.contains(index)) {
                          return Column(
                          children: [
                            Text(postmdl.l[index][0]),
                            Text(postmdl.l[index][1]),
                            Text(postmdl.l[index][2]),
                            SizedBox(height: 30),
                          ],
                        );
                        }
                        if(postmdl.l.isEmpty){
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
