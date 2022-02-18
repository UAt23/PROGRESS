#include <gtest/gtest.h>
#include <iostream>
using namespace std;

int main(void) {
   cout << "Hello, World\n";
   cout << "Hello, Jenkins\n";
   cout << "I have successfully built and run\n";
   return 0;
}

// Bir jenkins hattımız olsun
// Repodan git clone yapsın
// cpp kodlarını derlesin. make build
  // dinamik olması gereken isimler parametrik olsun
  // Agent ile çalışsın
// cpp kodlarını test etsin. make test
// Distribute etsin. deb pakti oluşucak.


// Kubernetes HELM CHART var
// Prometheus, Grafana, Loki, Elasticsearch 