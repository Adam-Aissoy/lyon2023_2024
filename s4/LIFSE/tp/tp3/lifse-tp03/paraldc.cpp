#include <iostream>
#include <cstdlib>

using namespace std;

/*Code source pour le TP3 de LIFSE */

int main(int argc, char *argv[]) {

  /* Le code ci-dessous sera à commenter par la suite */
  //cout << "la commande lancée est " << argv[0] << " avec " << argc << " argument(s): " << endl;

  // impression de la suite d'arguments.
  // for (int i = 0 ; i < argc; i++){
  //   cout <<"argv["<<i<<"]:"<< argv[i] << ","<< endl;
  // }
  //cout << endl;
  // TODO 

  if (argc != 2){
    cerr << " Il faut exactement un argument après la commande."<<endl;
    return -1;
  }else{
    cout <<"argv[0]:"<< argv[0] << ","<< endl;
    cout <<"argv[1]:"<< argv[1] << ","<< endl;
  }
  
  return 0;
}
