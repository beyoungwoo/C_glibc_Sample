#!/usr/bin/perl
#

use 5.18.2;
use strict;
use warnings;

###############
say "-- simple word matching --";
say "Hello World" =~ /World/;   # 단순한 단어의 일치 여부 검색. 일치하므로 true
say "Hello World" !~ /World/;   # 반대

my $greeting = "World";
say "Hello World" =~ /$greeting/;   # 스트링 자리에 변수 사용 가능 

$_ = "Hello World";
say /World/;   # '$_ =~' 는 생랼 가능

say "Hello World" =~ m!World!;   # 매치됨, 구분자는 '!'
say "Hello World" =~ m{World};   # 매치됨, 구분자는 '{}'

say "Hello World" =~ /o W/;    # 일치함
say "Hello World" =~ /oW/;     # 일치하지 않음
say "Hello World" =~ /World /; # 일치하지 않음
say "Hello World" =~ /o/;       # 'Hello'의 'o'에 매치됨
say "That hat is red" =~ /hat/; # 'That'의 'hat'에 매치됨

###############
say "-- metacharacters --";  # {}[]()^$.|*+\?
say "2+2=4" =~ /2+2/;    # 매치되지 않는다, + 는 메타캐릭터
say "2+2=4" =~ /2\+2/;   # 매치된다, \+는 평범한 +로 간주된다
#say "The interval is [0,1)." =~ /[0,1)./     # 문법 에러!
say "The interval is [0,1)." =~ /\[0,1\)\./; # Ok
say "#!/usr/bin/perl" =~  /#!\/usr\/bin\/perl/;  # 매치됨
say "#!/usr/bin/perl" =~ m!#\!/usr/bin/perl!;    # 이렇게 하는 게 읽기 더 좋다
say 'C:\WIN32' =~ /C:\\WIN/;

###############
say "-- escape sequences --";
say "1000\t2000" =~ m(0\t2);   # 매치됨
say "1000\n2000" =~ /0\n20/ ;  # 매치됨
say "1000\t2000" =~ /\000\t2/; # 매치되지 않음, "0"과 "\000"는 같지 않다
say "cat" =~ /\o{143}\x61\x74/; # ASCII matching

my $foo = 'house';
say 'housecat' =~ /$foo/;    # 매치됨
say 'cathouse' =~ /cat$foo/;    # 매치됨
say 'housecat' =~ /${foo}cat/;    # 매치됨

###############
say "-- anchor metacharacter --";
say "housekeeper" =~ /keeper/;    # 매치됨
say "housekeeper" =~ /^keeper/;   # 매치되지 않음
say "housekeeper" =~ /keeper$/;   # 매치됨
say "housekeeper\n" =~ /keeper$/; # 매치됨

say "keeper" =~ /^keep$/;      # 매치되지 않음
say "keeper" =~ /^keeper$/;    # 매치됨
say ""       =~ /^$/;          # ^$ 는 빈 스트링에 매치됨

say "dogbert" =~ /bert/;   # 매치되지만, 우리가 원하는 게 아님
say "dilbert" =~ /^bert/;  # 이런 건 매치된지 않게 했음, 그러나..
say "bertram" =~ /^bert/;  # 이런 게 매치됨, 여전히 문제가 있음
say "bertram" =~ /^bert$/; # 매치되지 않음, 좋다
say "dilbert" =~ /^bert$/; # 매치되지 않음, 좋다
say "bert"    =~ /^bert$/; # 매치됨, 완벽하군

###############
say "-- Using character classes --";
say "bat" =~ /cat/;       # not matches 'bat'
say "cat" =~ /cat/;       # matches 'cat'
say "bat" =~ /[bcr]at/;   # matches 'bat, 'cat', or 'rat'
say "cat" =~ /[bcr]at/;   # matches 'bat, 'cat', or 'rat'
say "rat" =~ /[bcr]at/;   # matches 'bat, 'cat', or 'rat'
say "item0" =~ /item[0123456789]/;  # matches 'item0' or ... or 'item9'
say "item1" =~ /item[0123456789]/;  # matches 'item0' or ... or 'item9'
say "item9" =~ /item[0123456789]/;  # matches 'item0' or ... or 'item9'
say "item100" =~ /item[0123456789]/;  # matches 'item0' or ... or 'item9'
say "abc" =~ /[cab]/;    # matches 'a' ([cab]의 순서라고 해서 'c'가 매치하는 게 아님)
say "yes" =~ /[yY][eE][sS]/;      # 'yes', 'Yes', 'YES' 등, 대소문자를 구분하지 않고 'yes'에 매치

say "]def" =~ /[\]c]def/; # ']def' or 'cdef'에 매치됨
my $x = 'bcr';
say "rat" =~ /[$x]at/;   # 'bat', 'cat', or 'rat'에 매치됨
say "xat" =~ /[\$x]at/;  # '$at' or 'xat'에 매치됨
say "\\at" =~ /[\\$x]at/; # '\at', 'bat, 'cat', or 'rat'에 매치됨

say "item01234" =~ /item[0-9]/;    # 'item0' or ... or 'item9'에 매치됨
say "item4" =~ /item[0-9]/;    # 'item0' or ... or 'item9'에 매치됨

say "0aa" =~ /[0-9bx-z]aa/;  # '0aa', ..., '9aa', 'baa', 'xaa', 'yaa', or 'zaa' 에 매치됨
say "Aaa" =~ /[0-9bx-z]aa/;  # '0aa', ..., '9aa', 'baa', 'xaa', 'yaa', or 'zaa' 에 매치됨

say "0xAA" =~ /[0-9a-fA-F]/;  # 16진수 숫자들 말고도 매치됨
say "0xZA" =~ /[0-9a-fA-F]/;  # 16진수 숫자들 말고도 매침됨...

say "0xAA" =~ /[0-9][xX][a-fA-F][a-fA-F]/;  # 16진수 숫자들에 매치됨...
say "0xZA" =~ /[0-9][xX][a-fA-F][a-fA-F]/;  # 16진수 숫자들에 매치됨...

say "word" =~ /[0-9a-zA-Z_]/; # Perl의 변수명 등에 쓰이는 "word" 캐릭터들에 매치됨

say "aat" =~ /[^a]at/;  # 'aat'와 'at'에는 매치되지 않고, 그 외 모든 경우 매치됨
say "cat" =~ /[^a]at/;  # 'aat'와 'at'에는 매치되지 않고, 그 외 모든 경우 매치됨

say "1t" =~ /[^0-9]t/;  # 숫자가 아닌 캐릭터들에 매치
say "ct" =~ /[^0-9]t/;  # 숫자가 아닌 캐릭터들에 매치

say "aat" =~ /[a^]at/;  # 'aat' 또는 '^at'에 매치됨; 여기서 '^'는 보통의 문자
say "\^at" =~ /[a^]at/;  # 'aat' 또는 '^at'에 매치됨; 여기서 '^'는 보통의 문자
say "bat" =~ /[a^]at/;  # 'aat' 또는 '^at'에 매치됨; 여기서 '^'는 보통의 문자

my $kelvin = chr(0x212A);   # Kelvin Sign
say $kelvin =~ /k/;  # not match
say $kelvin =~ /k/i;  # match
say $kelvin =~ /K/;  # not match
say $kelvin =~ /K/i;  # match

say "10:09:12" =~ /\d\d:\d\d:\d\d/; # matches a hh:mm:ss time format
say "ab:cd:ef" =~ /\d\d:\d\d:\d\d/; # matches a hh:mm:ss time format
say "8 " =~ /[\d\s]/;         # matches any digit or whitespace character
say "8" =~ /[\d\s]/;         # matches any digit or whitespace character
say " " =~ /[\d\s]/;         # matches any digit or whitespace character
say "a" =~ /[\d\s]/;         # matches any digit or whitespace character
say "word" =~ /\w\W\w/;         # matches a word char, followed by a non-word char, followed by a word char
say "say seven" =~ /\w\W\w/;         # matches a word char, followed by a non-word char, followed by a word char
say "say*seven" =~ /\w\W\w/;         # matches a word char, followed by a non-word char, followed by a word char

# anchor.. 
say $x = "Housecat catenates house and cat";
say $x =~ /cat/;     # 'housecat'의 cat에 매치
say $x =~ /\bcat/;   # 'catenates'의 cat에 매치
say $x =~ /cat\b/;   # 'housecat'의 cat에 매치
say $x =~ /\bcat\b/; # 스트링 마지막 'cat'의 cat에 매치
