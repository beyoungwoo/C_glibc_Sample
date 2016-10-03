# Perl_RegularExpression

Perl regular expression

REFERENCE 
* English
	* http://perldoc.perl.org/5.8.8/perlre.html
	* http://perldoc.perl.org/5.8.8/perlreref.html
	* http://perldoc.perl.org/perlretut.html
	* http://perldoc.perl.org/perlrequick.html
* Korean
	* http://gypark.pe.kr/wiki/Perl/%EC%A0%95%EA%B7%9C%ED%91%9C%ED%98%84%EC%8B%9D#H_1_1_4


기본 규칙
* 매칭 패턴
	* \d : 숫자에 매치됨. [0-9]와, 비로마권 스크립트에 있는 숫자들
	* \s : whitespace. [\ \t\r\n\f] 등
	* \w : word character. [0-9a-zA-Z_]와 비로마권 스크립트에 사용되는 문자들
	* \D : \d에 속하지 않는 문자들. [^\d]
	* \S : \s에 속하지 않는 문자들. [^\s]
	* \W : \w에 속하지 않는 문자들. [^\w]
	* . : 임의의 캐릭터 하나. "\n"은 제외(//s 옵션이 적용되지 않았을 때)
	* \N : "\n"을 제외한 임의의 캐릭터 하나.(//s 옵션 여부에 무관하게) Perl 5.12.0부터.

* 매칭 횟수
	* a? : 'a'가 1회 또는 0회 매치
	* a* : 'a'가 0회 또는 그 이상 매치, 즉 임의의 횟수만큼 반복
	* a+ : 'a'가 1회 또는 그 이상 매치, 즉 최소 한 번 이상 반복
	* a{n,m} : 최소 n회, 최대 m회 반복
	* a{n,} : 최소 n회 이상 반복
	* a{n} : 정확히 n회 반복

* /abc/ 의 s, m의 modifier
	* // : 디폴트 동작.
		* '.'는 "\n"을 제외한 모든 문자에 매치.
		* '^'는 스트링의 처음에 매치.
		* '$'는 스트링의 제일 끝, 또는 제일 끝에 있는 newline 직전에 매치.
	* //s : single line - 스트링을 하나의 긴 라인으로 취급
		* '.'는 "\n"을 포함하는 모든 문자에 매치
		* '^'는 스트링의 처음에 매치.
		* '$'는 스트링의 제일 끝, 또는 제일 끝에 있는 newline 직전에 매치.
	* //m : multi-line - 스트링을 여러 라인들의 집합으로 취급.
		* '.'는 "\n"을 제외한 모든 문자에 매치.
		* '^'는 스트링 안의 각 라인의 시작에 매치
		* '$'는 스트링 안의 각 라인의 끝에 매치
	* //ms : 스트링을 하나의 긴 라인으로 취급하되, 라인들을 구분.
		* '.'는 "\n"을 포함하는 모든 문자에 매치
		* '^'는 스트링 안의 각 라인의 시작에 매치
		* '$'는 스트링 안의 각 라인의 끝에 매치

* matching operator
	* /regexp/ - 기본 형태
	* m!regexp! - 임의의 구분자 사용
	* =~ - 바인딩 연산자
	* !~ - 부정 형태
	* 
* modifier
	* //i - 대소문자 구분하지 않음
	* //x - 정규식 확장

* 확장 패턴
	* (?i) - //i에 대응
	* (?m) - //m에 대응
	* (?s) - //s에 대응
	* (?x) - //x에 대응
