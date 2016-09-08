# real_estate_rent

파이썬으로 구현된 소스 참고하여 따라함
* https://github.com/dspshin/aptrent-bot

기본 구성 참고 소스
* https://gist.github.com/Robertof/d9358b80d95850e2eb34

부동산 전/월세 정보의 url, key 정보는 공공데이터 포털에서 아파트 전월세 자료 참고
* https://www.data.go.kr/subMain.jsp?param=T1BFTkFQSUAzMDUwOTg4#/L3B1YnIvdXNlL3ByaS9Jcm9zT3BlbkFwaURldGFpbC9vcGVuQXBpTGlzdFBhZ2UkQF4wMTJtMSRAXnB1YmxpY0RhdGFQaz0zMDUwOTg4JEBeYnJtQ2Q9T0MwMDAzJEBecmVxdWVzdENvdW50PTc0OSRAXm9yZ0luZGV4PU9QRU5BUEk=

요청하는 url 정보는 공공데이터 포털의 문서 참고
* 실거래 데이터 OpenAPI 활용가이드_v3.0.docx

Telegram의 토큰
* BotFather

세팅 (Amazon EC2, Redhat 7.2)
* DB Install

```
$ sudo yum install mariadb-server.x86_64 mariadb-devel.x86_64 -y
$ sudo systemctl enable mariadb
$ sudo systemctl start mariadb
$ sudo mysql_secure_installation
```

* DB 계정, 테이블 생성

```
MariaDB [(none)]> CREATE USER 'userdb'@localhost IDENTIFIED by 'password';
MariaDB [(none)]> CREATE USER 'userdb'@'%' IDENTIFIED by 'password';
MariaDB [(none)]> GRANT ALL PRIVILEGES ON *.* TO 'userdb'@localhost IDENTIFIED by 'password';
MariaDB [(none)]> GRANT ALL PRIVILEGES ON *.* TO 'userdb'@'%' IDENTIFIED by 'password';
MariaDB [(none)]> source /home/test/telegram/create_table.sql
MariaDB [(none)]> use TELEGRAM
MariaDB [TELEGRAM]> LOAD DATA LOCAL INFILE '/home/ec2-user/telegram_bot/local_code.csv' INTO TABLE LOCAL_CODE FIELDS TERMINATED BY ',';
```

* Perl 세팅

```
$ sudo yum group install "Development Tools" -y
$ sudo yum install perl-CPAN -y
$ sudo perl -MCPAN -eshell

cpan[ ]> install LWP::UserAgent
cpan[ ]> install WWW::Telegram::BotAPI
cpan[ ]> install Log::Log4perl
cpan[ ]> install HTML::TagParser

cpan[ ]> install XML::LibXML
; lib, include 경로가 일반적이지 않아서 직접 경로 추가하여 빌드함.
# sudo su
# cd /root/.cpan/build/XML-LibXML-2.0128-Hz1OUk
# /usr/bin/perl Makefile.PL LIBS='-L/usr/local/lib -L/usr/lib -L/opt/chefdk/embedded/lib' INC='-I/usr/local/include -I/usr/include -I/opt/chefdk/embedded/include/libxml2' DEBUG=1
# make install

cpan[ ]> install XML::SAX::Exception
```
