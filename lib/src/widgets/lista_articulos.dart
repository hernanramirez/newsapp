import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaArticulos extends StatelessWidget {
  final List<Article> articulos;

  const ListaArticulos(this.articulos);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articulos.length,
      itemBuilder: (BuildContext context, int index) {
        return _Articulo(
          articulo: articulos[index],
          index: index,
        );
      },
    );
  }
}

class _Articulo extends StatelessWidget {
  final Article articulo;
  final int index;

  const _Articulo({required this.articulo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TarjetaTopBar(articulo, index),
        _TarjetaTitulo(articulo),
        _TarjetaImagen(articulo),
        _TarjetaBody(articulo),
        SizedBox(
          height: 10,
        ),
        _TarjetaBotones(),
        Divider()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
              onPressed: () {},
              fillColor: miTema.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.star_border,
              )),
          SizedBox(
            width: 10,
          ),
          RawMaterialButton(
              onPressed: () {},
              fillColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.more,
              )),
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article articulo;

  const _TarjetaBody(this.articulo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text((articulo.description.toString() != null)
          ? "${articulo.description.toString()}"
          : "No hay descripcion"),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article articulo;

  const _TarjetaImagen(this.articulo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: Container(
          child: (articulo.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(articulo.urlToImage.toString()),
                  fit: BoxFit.cover,
                  height: 300.0,
                )
              : Image(image: AssetImage('assets/img/no-image.png')),
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article articulo;

  const _TarjetaTitulo(this.articulo);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        articulo.title.toString(),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article articulo;
  final int index;

  const _TarjetaTopBar(this.articulo, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(
            "${index + 1}.",
            style: TextStyle(color: miTema.accentColor),
          ),
          Text(
            "${articulo.source.name}.",
          ),
        ],
      ),
    );
  }
}
