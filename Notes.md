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


/////////   LINUX   //////////
 
-& komutun arkada devam etmesini sağlar  
-cat çalıştır
-grep
    -EXP: cat abc.txt | grep 3
-; aynı satır birden fazla komut
-&& solundaki komut olumlu cevap döndürürse sağdakini çalıştır
-| soldakinin çıktısını sağdakine girdi olarak ver
-|| soldakini çalıştır olumlu sonuç geiirse sağdakini çalıştırma


//////////////////////////////



------- SECTION 6 -------





------- JENKINS -------

docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11









