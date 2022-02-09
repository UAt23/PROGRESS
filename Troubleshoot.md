-- Jenkins Job --
    -Shell ile build işlemi yapılırken root user olma izinler açısından önem teşkil ediyor.
        _Shoot_
            -Dockerfile içerisinde USER ile tanımlanmış root dışında alt satırlarda başka bir user bulunmaması gerekir. Var ise bu kullanıcı için izin işlemleri gereklidir.

    -Shell içerisinde build C++ geliştirmesi yapabilmek için gerekli olan g++ yüklenmelidir.
        -            