import 'dart:io';

void main(List<String> args) {
  print("---ATIVIDADE 1---");
  print("Digite um numero para fatorar:");
  var num_string = stdin.readLineSync();//Guarda o valor numa variavel por causa do null safety

  if(num_string != null){//verifica se está nulo pra só depois parsear
    int num = int.parse(num_string);

    var fatorial = num;

    while(num>1){
      fatorial *= num-1;
      num--;
    }

    print("Fatorial de $num_string é $fatorial");
  }

  print("---ATIVIDADE 2---");

  print("Digite a quantidade de grana pra sacar:");
  var total = stdin.readLineSync();

  int notas50 = 0;
  int notas10 = 0;
  int notas5 = 0;
  int notas1 = 0;

  if(total != null){
    int notas = int.parse(total);

    do{
      if(notas >= 50){
        notas50++;
        notas -= 50;
      }else if(notas >= 10){
        notas10++;
        notas -= 10;
      }else if(notas >= 5){
        notas5++;
        notas -= 5;
      }else if(notas >= 1){
        notas1++;
        notas -= 1;
      }
    }while(notas>0);

    print("Notas de 50: $notas50");
    print("Notas de 10: $notas10");
    print("Notas de 5: $notas5");
    print("Notas de 1: $notas1");
  }


  print("---ATIVIDADE 3---");


  List<int> lista_num = List<int>.empty(growable: true);
  int maior_num;
  int menor_num;
  int soma_num = 0;

  do{
    print("Digite um numero aleatorio (-1 para parar)");
    var numero_aleatorio = stdin.readLineSync();

    if(numero_aleatorio != null){
      int numero = int.parse(numero_aleatorio);

      if(numero == -1){
        break;
      }

      lista_num.add(numero);
    }    
  
  }while(true);

  if(lista_num.length >= 1){
    maior_num = lista_num.first;
    menor_num = lista_num.first;

    for(int i = 0;i < lista_num.length;i++){
      if(lista_num[i]>maior_num)maior_num = lista_num[i];
      if(lista_num[i]<menor_num)menor_num = lista_num[i];

      soma_num += lista_num[i];
    }
    var media_num = soma_num / lista_num.length;

    print("Você digitou ${lista_num.length} numeros");
    print("Maior numero digitado: $maior_num");
    print("Menor numero digitado: $menor_num");
    print("Media dos numeros digitados: ${media_num.round()}");

  }else{
    print("Você não digitou nenhum numero");
  }
}