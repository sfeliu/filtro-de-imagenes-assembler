#include "../helper/libbmp.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <iostream>
#include <vector>
using namespace std;

int main (){

  srand(time(NULL));

  vector<int> iguales;
  iguales.open("CasosIguales.txt");
  int i = 1;
  int elem;
  int mochi;
  while(i < 26){
    elem = i;
    mochi = i;
    iguales << elem << " " << mochi << endl;
    int j = 0;
    int peso;
    int valor;
    while(j < elem){
      peso = rand() % mochi + 1;
      valor = rand() % 100 + 1;
      iguales << peso << " " << valor << endl;
      j++;
    }
    i++;
  }
  iguales.close();

  return 0;
}
