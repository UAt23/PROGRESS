-- Jenkins Job --
    -Shell ile build işlemi yapılırken root user olma izinler açısından önem teşkil ediyor.
        _Shoot_
            -Dockerfile içerisinde USER ile tanımlanmış root dışında alt satırlarda başka bir user bulunmaması gerekir. Var ise bu kullanıcı için izin işlemleri gereklidir.

    -Shell içerisinde build C++ geliştirmesi yapabilmek için gerekli olan g++ yüklenmelidir.
        -Docker Desktop'ın Container sekmesinden cli açılıp [apt install g++] komutu ile yapılabilir. (Ya da terminalden container ın içine de girilebilir)

        -İşlemin ardından 
            g++ main.cpp -o out
            ./out
        ile jenkins içerisinde build işlemi yaplıp konsola çıktı yazdırılabilir. (Bu durumda: 
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