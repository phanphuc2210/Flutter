import 'package:flutter/material.dart';

class MyPhotoAlbum extends StatefulWidget {
  const MyPhotoAlbum({Key? key}) : super(key: key);

  @override
  State<MyPhotoAlbum> createState() => _MyPhotoAlbumState();
}

class _MyPhotoAlbumState extends State<MyPhotoAlbum> {
  final List<String> list = [
    'https://i.picsum.photos/id/1059/400/600.jpg?hmac=Au2Ckd4Mng74Xg2vkd57ym64z7D2Wkbcht1i_xtAb_A',
    'https://i.picsum.photos/id/974/400/600.jpg?hmac=5QIl89OvPmfcpjuij93Wc03z7sSlXfxGnJpjrp_QCQc',
    'https://i.picsum.photos/id/929/400/600.jpg?hmac=1nlUusN2UINLeRyg5QY9kxorn35pabELuBQn1UwVMW0',
    'https://i.picsum.photos/id/811/400/600.jpg?hmac=jm4qgSLnICVm_fD23AJogYe6FH2ind_jv4xxvwC57XE',
    'https://i.picsum.photos/id/234/400/600.jpg?hmac=4thsvlEioIpo6UlI8-2o1R4KNPZP6nz4eoid9nQxbuw',
    'https://i.picsum.photos/id/216/400/600.jpg?hmac=9nRw8bj9h6SlfBy6RlZdpC2y16UHEftqNG1iH-oJ8hs'
  ];

  int indexImg = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 400,
            height: 600,
            color: Colors.blue,
            child: Image.network(list[indexImg]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (() => setState(() {
                      if (indexImg <= 0) {
                        indexImg = list.length - 1;
                      } else {
                        indexImg--;
                      }
                    })),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 0),
                ),
                child: const Icon(
                  Icons.arrow_left,
                  size: 100,
                  color: Colors.blue,
                ),
              ),
              ElevatedButton(
                  onPressed: () => setState(() {
                        if (indexImg >= list.length - 1) {
                          indexImg = 0;
                        } else {
                          indexImg++;
                        }
                      }),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 0),
                  ),
                  child: const Icon(
                    Icons.arrow_right,
                    size: 100,
                    color: Colors.blue,
                  ))
            ],
          )
        ],
      )),
    );
  }
}
