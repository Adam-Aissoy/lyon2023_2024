#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <sys/time.h>
#include <math.h>
#include <thread>
#include <vector>
#include <mutex>


using namespace std;


double timevalsub(struct timeval *tv1, const struct timeval *tv2) {
  double res = 0;
  res = tv2->tv_sec - tv1->tv_sec;
  res += (tv2->tv_usec - tv1->tv_usec)*1.0/1000000;
  return res;
}

// Returns the duration of call
double fct(int num, int nbtours) {
  struct timeval tv1, tv2;
  int err;

  cout << num << " lancement de la fonction pour " << nbtours << " itérations"
  << endl;
  // #####################################
  // Partie calcul
  double temps_total = 0;
  for (int i=0; i<nbtours; i++) {
    int j;
    
    err = gettimeofday(&tv1, NULL);
    if (err != 0) {
      perror("gettimeofday");
      exit(EXIT_FAILURE);
    }

    double sum = 0;
    for(j=0; j<5000000; j++) {
      sum += log(j+1);
    }
    
    err = gettimeofday(&tv2, NULL);
    if (err != 0) {
      perror("gettimeofday");
      exit(EXIT_FAILURE);
    }
    double duree = timevalsub(&tv1, &tv2);
    temps_total += duree;

    // Version avec "cerr" si on veut voir les problèmes
    // d'entrelacement des sorties :
    // cerr << num << " : je viens de faire un calcul dont le résultat est "
    //     << sum << ", il a fallu " << duree << " secondes" << endl ;
    // fprintf ne pose pas ce problème :
    fprintf(stdout, "%d : je viens de faire un calcul dont le résultat est %g,"
	            "il a fallu %g secondes\n", num, sum, duree);
  }
  // fin de la partie calcul
  // ###########################

  return temps_total;
}
/* my fonction*/
void threadFunction(int threadNum, int nbtours, double& result) {
    result = fct(threadNum, nbtours);
}

int main(int argc, char **argv) {
  int i;
  
  // Paramètres
  int nbthreads = 10;
  int nbtours = 5;
  thread thread_AdamAysoy;
  thread th1, th2;


  // lecture des arguments
   if ((argc==2)&&(atoi(argv[1]))) {
    // s'il y a un argument numérique on l'utilise pour
    // connaître le nombre de threads/lancements de la fonction
    nbthreads = atoi(argv[1]);
    //nbthreads = th1(fct,10,nbthreads);
  } else if (argc != 1) {
    // il y a au moins un argument mais qui n'est pas le bon
    cerr << "usage " << argv[0] << " [<nb de lancements et de threads>]"
	 << endl;
    exit (1);
  } 
  cout << "Th principal : lancement de " << nbthreads << " fois la fonction"
       << endl;
  
  double temps_total = 0;
  for (i=0; i<nbthreads; i++) {
    double temps_fonction = fct(i, nbtours);
    temps_total += temps_fonction;
  }

  cout << "Th principal : Le temps total de calcul est " << temps_total << endl;


  //////////////////////////////////////////////////////////////
  // exemple d'utilisation du thread 
/*   thread_AdamAysoy = thread(fct,10,false);
  double temps_total1 = fct(10,1);
  cout << "Th principal Adam : Le temps total1 de calcul est " << temps_total1 << endl;

  while (thread_AdamAysoy.joinable()) {
    thread_AdamAysoy.join();
  }  */

   //int nbthreads = 10; 
   /*  std::vector<std::thread> threads;

    for (int i = 0; i < nbthreads; ++i) {
        threads.push_back(std::thread(fct, i));
    }

    for (auto& th : threads) {
        th.join();
    }
 */
    //const int nbthreads = 4;  
    //const int nbtours = 10;   
    vector<thread> threads;
    vector<double> results(nbthreads);

    // Launch threads
    for (int i = 0; i < nbthreads; ++i) {
        threads.push_back(thread(threadFunction, i, nbtours, std::ref(results[i])));
    }
    // Wait for threads to finish
    for (auto& thread : threads) {
        thread.join();
    }
    // Process results if needed
    for (int i = 0; i < nbthreads; ++i) {
        cout << "Thread " << i << " result: " << results[i] << " seconds" << std::endl;
    }
    // total time  Adam Aysoy
    double temps_total2 = 0;
    for (i=0; i<nbthreads; i++) {
      double temps_fonction = results[i];
      temps_total2 += temps_fonction;
    }
    cout << temps_total2 << endl;


    /*
    int nbthreads2 =20;
    double temps_total3=0;
    for(int i=0; i<nbthreads2; i++){
      double temps_total4 = results[i];
      temps_total3 += temps_total4;
    }
    cout << temps_total3 << endl;
  */
  return 0;
}
