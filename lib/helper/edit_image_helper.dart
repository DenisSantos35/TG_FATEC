import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:tg_fatec/datas_class/product_data_class.dart';

import '../atoms/containers/containers_atoms.dart';

class EditUploadImage extends StatefulWidget {
  EditUploadImage({required this.inputController, required this.image, this.editProduct = false});

  TextEditingController inputController;
  String image;
  bool editProduct;

  @override
  State<EditUploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<EditUploadImage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      loading = false;
    });
  }
  final FirebaseStorage storage = FirebaseStorage.instance;
  ProductDataClass product = ProductDataClass();
  bool galeria = false;
  bool criaBotao = false;
  bool uploading = false;
  double total = 0;
  String armazenaImagem = "";
  bool loading = true;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: Get.height * 0.03,
          indent: 8,
          endIndent: 8,
          thickness: 2,
          color: Colors.black,
        ),
        containerTitles(
            title: "EDITAR IMAGEM DO PRODUTO",
            width: 0.85,
            height: 0.03),
        Divider(
          height: Get.height * 0.03,
          indent: 8,
          endIndent: 8,
          thickness: 2,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if(!widget.editProduct){
                criaBotao = !criaBotao;
              }
            });
          },
          child: uploading
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${total.round()} % enviado",
                style: TextStyle(color: Color(0xff76c052)),
              ),
              SizedBox(
                width: 30,
              ),
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xff76c052),
                    ),
                  ),
                ),
              ),
            ],
          )
          //************************* botao da imagem *****************
              : Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: loading
                  ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xff76c052),
                ),
              ) :GestureDetector(
                onTap: () {
                  setState(() {
                    if(!widget.editProduct){
                      criaBotao = true;
                    }

                  });
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: Get.height * 0.03,
          indent: 8,
          endIndent: 8,
          thickness: 2,
          color: Colors.black,
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            criaBotao ? floatButton() : Container(),
          ],
        ),
      ],
    );
  }

  Widget floatButton() {
    return Column(
      children: [
        Row(
          children: [
            FloatingActionButton(
              backgroundColor: Color(0xff76c052),
              onPressed: () {
                setState(() {
                  galeria = true;
                  pickAndUploadImage();
                });
              },
              child: Icon(Icons.image_outlined),
            ),
            SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              backgroundColor: Color(0xfff9a53f),
              onPressed: () {
                setState(() {
                  galeria = false;
                  pickAndUploadImage();
                });
              },
              child: Icon(Icons.photo_camera_outlined),
            ),
          ],
        ),
      ],
    );
  }

  Future<XFile?> getImage() async {
    galeria = false;
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
    return image;
  }

  Future<XFile?> getImageCamera() async {
    galeria = false;
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(
        source: ImageSource.camera, maxWidth: 500, maxHeight: 500);
    return image;
  }

  Future<UploadTask> upload(String path) async {
    File file = File(path);
    try {
      String ref = 'imagensloja/img-${DateTime.now().toString()}.jpg';
      Logger().e(ref);
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload ${e.code}');
    }
  }

  pickAndUploadImage() async {
    criaBotao = false;
    XFile? file = galeria ? await getImage() : await getImageCamera();
    if (file != null) {
      UploadTask task = await upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            Logger().e(total);
          });
        } else if (snapshot.state == TaskState.success) {
          armazenaImagem = await snapshot.ref.getDownloadURL();
          Logger().e(armazenaImagem);
          widget.image = armazenaImagem;
          widget.inputController.text = widget.image;

          Logger().e(product.image);


          setState(() {
            count = 1;
            uploading = false;
            product.image = widget.image;
          });
        }
      });
    }
  }
}
