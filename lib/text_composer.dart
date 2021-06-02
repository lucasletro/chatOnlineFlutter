import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {

  TextComposer(this.sendMessage)

  Function(String) sendMessage;


  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;              //_isComposing vai indicar se eu estou compondo um texto ou não.

  void _reset(){
    _controller.clear();               //limpar o que escrevi do cursor quando apertar o botão de enviar a mensagem.
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(               // row: 3 coisas na mesma reta.
        children: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: (){        //onpressed vai abrir a camera para poder tirar a foto.

            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(hintText: "Enviar uma Mensagem"),
              onChanged: (text){
                setState(() {                         // setState para atualizar a tela. atualizando a tela posso hailitar ou desabilitar o botão.
                  _isComposing = text.isNotEmpty;    //se o texto nao estiver vazio eu estou compondo, se tiver vazio eu nao estou compondo.
                });
              },
              onSubmitted: (text){           //onsubmited é quando tocarmos no botão para enviar a mensagem.
                widget.sendMessage(text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _isComposing ? (){          //verificar se eu estou digitando(compondo).
              widget.sendMessage(_controller.text);
              _reset();
            } : null,                             //se estiver nulo desabilita o botão.
          ),
        ],
      ),
    );
  }
}
