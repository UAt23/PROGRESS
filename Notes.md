Docker: bir kere oluştur her yerde kullan
Container: tek bir uygulama ya da servisin paketlenmiş hali 
        - Containerlar Sanal Makinalara kıyasla içlerinde işletim sistemi çekirdeğini barındırmaz bu yüzden çok daha az yer kaplarlar ve yönetilmeleri daha kolaydır. 

------- SECTION 3 -------
Continer çalıştırıldığında, container ın yaratıldığı image içerisinde ayarlanmış bir uygulama vardır. Uygulama kapanırsa container çalışmayı durdurur. Fakat container ın içeresinde birden fazla uyguolama çalışabilir.

    -detach container ==> docker container -d -p 80:80 image

    -delete working container ==> docker container rm -f |ID|

    -Container'a bağlanmak için içerisinde bir shell olmalıdır. 
        -docker container exec -it |container_name_id| sh
    -Attached çalıştırılar containerın uygulaması kapatılınca kapatmak için:
        -docker container run --rm -it ....



Yeni oluşturduğumuz containerlar aynı dosyalara sahip olmaz ==> **Volume**  
  
    -docker volume create |volume_name|
    -docker volume inspect |volume_name|
    -docker container run -it -v |volume_name|:/|folder_path_inside_container| alpine sh
    -NOTE: |folder_path_inside_container| klasörü yok ise yaratılacaktır
    -- VOLUME içerisinde komutlar --
        -touch abc.txt ==> abc isimli text dosyası oluştur
        -echo "text-here" >> abc.txt ==> içerisine ekleme yapmak
        -cat abc.txt ==> çalıştır

    -docker container run -it -v |volume_name|:/|folder_path_inside_container|:ro centos sh ==> READ ONLY no changes allowed  

    --Volume davranışları --
        - Volume mount edildiği klasörü yaratır ve içersinde dosya varsa erişime sunar
        - Eğer mevcut bir klasöre mount edilirse: 
            volume boş ise içersindeki dosyaları kopyalar
            volume dolu ise volume içerisindeki dosyalar gözükür dosya içerğinden bağımsız

    --BIND MOUNTS--
        -Herhangi bir image yaratmadan kendi sistemimizdeki bir klasörden volume oluşturup aktif development yapmak için 



------- SECTION 4 -------
Network driverlar ile bir container ın aynı bir fiziksel makina gibi dış dünya ile bağlantısını sağlıyabiliyoruz
   
    --Network Objects--
    
        -[Bridge, Host , Macvlan, None, Overlay]
        -

    -docker network ls
    -docker network inspect bridge
    -docker container run 
    -container a bağlanıp networkünü kontrol etme
        exec -it |ID| sh
        ipconfig        
    -container ile bağlantıyı kesmek: CTRL + P + Q
    
    -aynı bridge networke bağlı containerlar haberleşebilirler
    
    -docker container run -it --name |name| --net host |image|
    
    -host network makinanın ağ altyapısını kullanır gibi çalışır
    
    -port publish ==> -p |host_port|:|container_port|
        -bu sayede dışarıdan bir container a erişip servisi kullanbiliriz
    
    -container lara atanmış isimler üzeirnden birbirlerine erişebilmeleri için default networkün dışında kullanıcı tarafından oluşturulmuş bir network gerekir 

    -docker attach |container_name| ==> bu komut ile içerisinde shell çalışan bir container a bağlanıp işlemler gerçeklerştirebiliriz

    -docker network create --driver=bridge --subnet=10.10.0.0 --ip-range=10.10.0.0/24 --gateway=10.10.10.10 |network_name|
        -bu şekilde aralıklarını ve adresini kendimiz belirlediğimiz bir bridge network yarattık
    
    -- Containerlar yaratılan köprülere (non-default) çalışır durumdayken bağlanabilirler
        -docker network connect |network_name| |container_name|
    -- Bağlı bir container bulunan network bağlantısı kesilmden silinemez
        -docker network disconnect |network_name| |container_name|

    -- ENVIRONMENT VARIABLES --
        
        -Get-ChildItem Env ==> tanımlanmış tüm env var ları gösterir
        -$Env:windir ==> windrir in değerini görmek için
        -$Env:test="denemedir" ==> yeni env var tanımlama
            --LUNUX için
                -printenv
                -echo $TERM
                -export test="deneme"
        
        -En Var larda farklı kullanıcı sistemleri için TEMP değeri gibi okuyup sistem bazında değişkenleri kullanarak gerkli değerleri elde etmek için yararlanılabilir. 

        -docker container run -it --env VAR1=deneme1 --env VAR2=deneme2 ubuntu bash ==> konsolda tanımlama
        -docker container run -it --env TEMP ubuntu bash ==> sistemde bulunan env varı container içerisine tanımlama

        -docker container run -it --env-file ./env.list ubuntu bash ==> kosolun bulunduğu konumdaki bir list üzerinden tek seferde tanımlama

------- SECTION 5 -------

IMAGE:

    -- Dockerfile --

        -FROM ==> 
        -RUN ==> 
        -WORKDIR ==> 
        -COPY ==> 
        -EXPOSE ==> 
        -CMD ==> 
        -HEALTHCHECK ==> --interval=30s --timout=10s --start-period=5s --retries=3 CMD curl -f http://localhost || exit 1
        -LABEL ==> 
        -ENV ==> 
        - ==> 


    -Aşamlar
        1. Fiziksel ya da sanal sunucu kur
        2. İşletim sistemi kur
        3. İŞletim sistemini güncelle
        4. Runtime nev kur
        5. uygulamayı sisteme kopyala
        6.


    - image build etmek için 
        -docker image build -t ozgurozturknet/merhaba .
        -docker image build -t ozgurozturknet/merhaba -f Dockerfile     

    -Image ların layer şeklinde tutulması çok devoloper ın çalıştığı sistemlerde halihazırda sistemde olan layerların tekrar inidirilmeyip veri tasarufu sağlıyor

    -Sık kullanılan dosyalar Docker file da alt satırlara konulursa cache ile zaman kazanılmış olur             


-/////////   LINUX   //////////
 
-& komutun arkada devam etmesini sağlar  
-cat çalıştır
-grep
    -EXP: cat abc.txt | grep 3
-; aynı satır birden fazla komut
-&& solundaki komut olumlu cevap döndürürse sağdakini çalıştır
-| soldakinin çıktısını sağdakine girdi olarak ver
-|| soldakini çalıştır olumlu sonuç geilirse sağdakini çalıştırma


//////////////////////////////



------- SECTION 6 -------





------- JENKINS -------

Jenkins 

<!-- -docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11
-docker container run -p 8080:8080 -p 50000:50000 -d -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11 -->

    -- IMPORTANT --
        -Jenkis container'ını yarattığımız belirli bir volume ile çalıştırıyoruz. Bu sayede jenkins üzerinde yarattığmız Jobs lara yeni ama aynı volume ile çalıştırılmış containerdan da erişebiliyoruz.
            --https://www.youtube.com/watch?v=tNyx6XzvRGs&list=PLVx1qovxj-amqyqHceAhkcsopzi4PFcKc&index=45



    -- Commands --
       
        --Jenkisn container--
       
        -docker container run --name Jenkins -d --network jenkins  -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock  -p 8080:8080 -p 50000:50000 jenkins:lts
            -used this one to create the container

        -docker container logs ID
            -detach modda çalıştırdığım için localhost:8080 ile bağlanmam için gerekli şifreyi loglardan almak için kullandım

        -localhost:8080 üzerinden standart pluginleri yükledim 

        -docker run --name jenkins-docker --rm --detach --privileged --network jenkins --network-alias docker --env DOCKER_TLS_CERTDIR=/certs --volume jenkins-docker-certs:/certs/client --volume jenkins-data:/var/jenkins_home --publish 2376:2376 docker:dind
        
        --Jenkisn Image--

            -docker build -t myjenkins-blueocean:2.319.2-1 .


        --Creating container inside Jenkins container
            --link: https://stackoverflow.com/questions/36185035/how-to-mount-docker-socket-as-volume-in-docker-container-with-correct-group   

        --Limiting cpu usage of wsl
            -https://www.youtube.com/watch?v=JmkysqY5iu8     

        -- Dockerfile --
            -FROM jenkins/jenkins:2.319.2-jdk11
            -USER root
            -RUN apt-get update && apt-get install -y lsb-release
            -RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg
            -RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list$
            -RUN apt-get update && apt-get install -y docker-ce-cli
            -USER jenkins
            -RUN jenkins-plugin-cli --plugins "blueocean:1.25.2 docker-workflow:1.27"






        -- C(I/T/D) -- 

            -Delivery manuel hassas
            -Deployment az kritik veya testler ile sağlama alınmış değiişimler
            -Integration
                -Test aşamaları (unit, integration, etc.) 
                -Sonuçlar ile çıkan durumların bildirilmesi
                -Olumlu test sonuçları ile kırılmalardan arındırılmış yeni yapı 


        -- Jenkins project --
          - Agent tanımlama
          - İş tanımlama
          - Parameters in Jenkins: https://itnext.io/jenkins-tutorial-part-3-parameterized-pipeline-3898643ac6ad


    -- Makefile --

        - Going back to the example above, when make was executed, the entire command echo "Hello World" was displayed, followed by actual command output. We often don't want that. To suppress echoing the actual command, we need to start echo with @: 
            -say_hello:
            -    @echo "Hello World"

    -- Debian Package --
        -Resource:
            https://github.com/FooBarWidget/debian-packaging-for-the-modern-developer/tree/master/tutorial-1


        -create and install
            
           - root@3d697729903e:/# gcc main.cpp -lstdc++ -o out
           - root@3d697729903e:/# ./out
                -Hello, World
                -Hello, Jenkins
                -I have successfully built and run
            - root@3d697729903e:/# mkdir hello_1.0.0_amd64
            - root@3d697729903e:/# cd hello_1.0.0_amd64/
            - root@3d697729903e:/hello_1.0.0_amd64# mkdir DEBIAN
            - root@3d697729903e:/hello_1.0.0_amd64# nano DEBIAN/control
            - root@3d697729903e:/hello_1.0.0_amd64# mkdir -p usr/bin
            - root@3d697729903e:/hello_1.0.0_amd64# cp ../out usr/bin/
            - root@3d697729903e:/hello_1.0.0_amd64# ls
                -DEBIAN  usr
            - root@3d697729903e:/hello_1.0.0_amd64# cd ..
            - root@3d697729903e:/# ls
                -bin  boot  dev  etc  hello_1.0.0_amd64  home  lib  lib64  main.cpp  media  mnt  opt  out  proc  root  run  sbin  srv  sys  tmp  usr  var
            - root@3d697729903e:/# dpkg-deb -b hello_1.0.0_amd64/
                -dpkg-deb: building package 'hello' in 'hello_1.0.0_amd64.deb'.
            - root@3d697729903e:/# ls
                -bin  boot  dev  etc  hello_1.0.0_amd64  hello_1.0.0_amd64.deb  home  lib  lib64  main.cpp  media  mnt  opt  out  proc  root  run  sbin  srv    sys  tmp  usr  var
            - root@3d697729903e:/# apt install ./hello_1.0.0_amd64.deb
            - root@3d697729903e:/# out
                -Hello, World
                -Hello, Jenkins
                -I have successfully built and run
        
    
    -- Creating Docker Local Registry --
        - Kubernetes can not understand the images on Docker Hub


    --Jenkins Docker Kubernetes --
        - CI/CD pipeline for applications build on docker using Jenkins and Kubernetes
        [
        - To understand the workflow here is an example: (https://www.betsol.com/blog/devops-using-jenkins-docker-and-kubernetes/#:~:text=Jenkins%20builds%20a%20new%20docker,manages%20the%20docker%20instance%2Fcontainer.)
          
          - Code changes are committed to the version control system GitHub
          
          - Each commit to GitHub automatically triggers Jenkins build. Jenkins uses Maven to compile the code, run unit test and perform additional checks – code coverage, code quality, etc.
          
          - Once the code has been successfully compiled and all the tests have been passed. Jenkins builds a new docker image and pushes it to the Docker registry.
          
          - Jenkins notifies Kubernetes of the new image available for deployment.
          
          - Kubernetes pulls the new docker image from the docker registry.
          
          - Kubernetes deploys and manages the docker instance/container.
        ]
![alt text](https://github.com/UAt23/PROGRESS/blob/main/okl.png?raw=true)


    --TEST
        -uat23@LAPTOP-9UNO4D91:/mnt/d/WORK/WORK-LOG/GT$ docker run -it ubuntu:xenial
        -root@b0ce03379a2e:/# apt update
        -root@b0ce03379a2e:/# apt install wget
            /-root@b0ce03379a2e:/# cd home/
            /-root@b0ce03379a2e:/home# apt install git
            /-root@b0ce03379a2e:/home# git clone https://github.com/google/googletest.git
            /-root@b0ce03379a2e:/home# cd googletest/
            /-root@b0ce03379a2e:/home/googletest# mkdir build 
            /-root@b0ce03379a2e:/home/googletest# cd build/
            /-root@b0ce03379a2e:/home/googletest/build# cmake ..
            /-root@b0ce03379a2e:/home/googletest/build# ls /usr/bin
        
        -apt install -y libgtest-dev
        -root@b0ce03379a2e:/home/googletest/build# ls /usr/src/
            -gtest
        -root@b0ce03379a2e:/home/googletest/build# cd /usr/src/gtest/
        -root@b0ce03379a2e:/usr/src/gtest# cmake CMakeLists.txt
        -root@b0ce03379a2e:/usr/src/gtest# make 
        -root@b0ce03379a2e:/usr/src/gtest# cp *.a /usr/lib
        -root@b0ce03379a2e:/usr/src/gtest# ldconfig                     IMPORTANT MIGHT NEED LATER
        
        -root@b0ce03379a2e:/home# git clone https://github.com/alpekin98/self-study-2.git
        -root@b0ce03379a2e:/home# mkdir deneme
        -root@b0ce03379a2e:/home# cp self-study-2/*.cpp deneme
        -root@b0ce03379a2e:/home# cd deneme/
        root@b0ce03379a2e:/home/deneme# ls
            -main.cpp  test.cpp
        -root@b0ce03379a2e:/home/deneme# cp ../self-study-2/*.h .
        -root@b0ce03379a2e:/home/deneme# ls
            -main.cpp  says_hello_world.h  test.cpp
        -root@b0ce03379a2e:/home/deneme# cp ../self-study-2/CMakeLists.txt .
        -root@b0ce03379a2e:/home/deneme# ls
            -CMakeLists.txt  main.cpp  says_hello_world.h  test.cpp
        -root@b0ce03379a2e:/home/deneme# cmake CMakeLists.txt
        -root@b0ce03379a2e:/home/deneme# make
        -root@b0ce03379a2e:/home/deneme# ./runTests     


    --Pipeline
        // Bir jenkins hattımız olsun
        // Repodan git clone yapsın
        // cpp kodlarını derlesin. make build
        // dinamik olması gereken isimler parametrik olsun
        // Agent ile çalışsın
        // cpp kodlarını test etsin. make test
        // Distribute etsin. deb pakti oluşucak.

    --K8s, Helmi Protheus
        // Kubernetes HELM CHART var
        // Prometheus, Grafana, Loki, Elasticsearch
        //Prometheus helm chart ı install edip çalıştığını gör (https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
            //portforward yapıp browserda görüntüle  (https://itnext.io/kubernetes-monitoring-with-prometheus-in-15-minutes-8e54d1de2e13)
        //prometheus ve grafana kuralım helm chart ile (ayrı ayrı), prometheus'u da kendisinin ve grafananın metriklerini görebilecek şekilde ayarlayalım    
        
        -minikube start
        -kubectl get pods //Check if it worked
        -helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
        -helm repo update
        -helm install prometheus prometheus-community/prometheus
        -kubectl get pod
        -kubectl port-forward prometheus-prometheus-kube-prometheus-prometheus-0  9090

        -helm repo add grafana https://grafana.github.io/helm-charts
        -helm repo update
        -helm install grafana grafana/grafana
            -for pasword (kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)


        -helm pull prometheus-community/prometheus
        -cd prometheus
        -helm install prom .
        -kubectl get pods -w
        -kubectl port-forward prom-prometheus-server-54fbd5cd47-w6b8p 9090
        -kubectl get svc
        -kubectl get pods -o wide

        -!!!! Need to use prometheus-operator since it is configured the K8s and grafana (https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)

