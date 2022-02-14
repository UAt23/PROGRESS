-- Jenkins Job --
    -Shell ile build işlemi yapılırken root user olma izinler açısından önem teşkil ediyor.
        _Shoot_
            -Dockerfile içerisinde USER ile tanımlanmış root dışında alt satırlarda başka bir user bulunmaması gerekir. Var ise bu kullanıcı için izin işlemleri gereklidir.

    -Shell içerisinde build C++ geliştirmesi yapabilmek için gerekli olan g++ yüklenmelidir.
        -Docker Desktop'ın Container sekmesinden cli açılıp 
            [apt install g++] 
        komutu ile yapılabilir. (Ya da terminalden container ın içine de girilebilir)

        -İşlemin ardından 
            g++ main.cpp -o out
            ./out
        veya

            make build 
            ./out

        ile jenkins içerisinde build işlemi yaplıp konsola çıktı yazdırılabilir. Makefile içerisine build tagi altına ilk komutu taşımak gerekir (build: g++ main.cpp -o out)
            -make komutunun çalışması için container içerisinde 
                [apt install make] 
        
         (Bu durumda: 
                Started by user uguralp
                Running as SYSTEM
                Building in workspace /var/jenkins_home/workspace/first-project
                The recommended git tool is: NONE
                No credentials specified
                > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/first-project/.git # timeout=10
                Fetching changes from the remote Git repository
                > git config remote.origin.url https://github.com/UAt23/PROGRESS.git # timeout=10
                Fetching upstream changes from https://github.com/UAt23/PROGRESS.git
                > git --version # timeout=10
                > git --version # 'git version 2.30.2'
                > git fetch --tags --force --progress -- https://github.com/UAt23/PROGRESS.git +refs/heads/*:refs/remotes/origin/* # timeout=10
                > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
                Checking out Revision 06969ebf0c97b5da1a792c3816926279ed9cca4f (refs/remotes/origin/main)
                > git config core.sparsecheckout # timeout=10
                > git checkout -f 06969ebf0c97b5da1a792c3816926279ed9cca4f # timeout=10
                Commit message: "fixes"
                > git rev-list --no-walk 06969ebf0c97b5da1a792c3816926279ed9cca4f # timeout=10
                [first-project] $ /bin/sh -xe /tmp/jenkins702408905689943930.sh
                + g++ main.cpp -o out
                + ./out
                Hello, World
                Hello, Jenkins
                I have successfully built and run
                Finished: SUCCESS
        )



 -- Debian Package --

        -[
            #!/usr/bin/env python
            print("hello 1.0.0")
        ]

        -[
            mkdir tutorial-1
            cd tutorial-1
            editor hello   # put the above source code in this file
            chmod +x hello
        ]


        -mkdir packageroot
        -mkdir packageroot/DEBIAN
        -nano packageroot/DEBIAN/control                      
        -[
            Package: hello
            Version: 1.0.0-1
            Architecture: all
            Maintainer: John Doe <john@doe.com>
            Depends: python
            Description: John's hello package
            John's hello package is written in Python
            and prints a greeting.
            .
            It is awesome.
        ]

        -[
            mkdir -p packageroot/usr/bin
            cp hello packageroot/usr/bin/
        ]

        -dpkg-deb -b packageroot hello_1.0.0_all.deb

        -apt install gdebi

        -gdebi -n ./hello_1.0.0_all.deb
        -hello

        --OUTPUT: --
            /usr/bin/hello: line 2: syntax error near unexpected token `"hello 1.0.0"'
            /usr/bin/hello: line 2: `print("hello 1.0.0")'


 -- Docker Permission Denied Solution --
        sudo groupadd docker
        sudo usermod -aG docker ${USER}
        su -s ${USER}
    
-- Error checking clusters with "kubectl get nodes" --
    -The connection to the server localhost:8080 was refused - did you specify the right host or port?
    ^^^Solution:
        -Reinstalled kind and kubectl via brew
        -Deleted the cluster with "kind delete clusters cluster-name-here"
        -Created a new cluster "kind create cluster --name cluster-name-here"
        -Checked the cluster with kubectl get nodes
        -Also check: https://www.baeldung.com/ops/kubernetes-kind  


--Pushing to repository with Docker
    docker push localhost:5000/explorecalifornia.com
    -ERROR: Get "http://localhost:5000/v2/": net/http: request canceled (Client.Timeout exceeded while awai...
    -Solution: User tagging with 127.0.0.1 instead of localhost
        -docker tag explorecalifornia.com 127.0.0.1:5000/explorecalifornia.com
        -docker push 127.0.0.1:5000/explorecalifornia.com
        (can chack: https://forums.docker.com/t/unable-to-get-private-docker-registry-to-work-locally-works-remotely/44144)


        Events:
  Type     Reason     Age                   From               Message
  ----     ------     ----                  ----               -------
  Normal   Scheduled  12m                   default-scheduler  Successfully assigned default/explorecalifornia.com-7
755d65f5d-rk498 to explorecalifornia.com-control-plane
  Normal   Pulling    11m (x4 over 12m)     kubelet            Pulling image "127.0.0.1:5000/explorecalifornia.com" 
  Warning  Failed     11m (x4 over 12m)     kubelet            Failed to pull image "127.0.0.1:5000/explorecaliforni
a.com": rpc error: code = Unknown desc = failed to pull and unpack image "127.0.0.1:5000/explorecalifornia.com:lates
t": failed to resolve reference "127.0.0.1:5000/explorecalifornia.com:latest": failed to do request: Head "http://12
7.0.0.1:5000/v2/explorecalifornia.com/manifests/latest": dial tcp 127.0.0.1:5000: connect: connection refused       
  Warning  Failed     11m (x4 over 12m)     kubelet            Error: ErrImagePull
  Warning  Failed     11m (x6 over 12m)     kubelet            Error: ImagePullBackOff
  Normal   BackOff    2m44s (x42 over 12m)  kubelet            Back-off pulling image "127.0.0.1:5000/explorecalifor
nia.com"
        
