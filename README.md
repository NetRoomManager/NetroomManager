# ⭐ NetRoom Manager⭐

![test](https://github.com/NetRoomManager/NetroomManager/assets/44068819/0ee935f7-4004-44e3-8750-e7d0efbb6eec)

## ✈️ 소개

-   ### PC방 프로그램을 웹에서 구현해보는 프로그램을 6개월간 배운 내용과 새로운 기술을 더하여 만들고자합니다.

-   ### 좌석선택과 이용권결제, 상품결제 등 PC방의 주요 서비스를 웹으로 구현했습니다.
-   ### 실시간 이용시간, 주문 내역등을 반영할 수 있다는 점이 우리 프록젝트의 장점입니다.

<br/>

## 💬 사용중인 소통 앱

-   ### 카카오톡
-   ### 디스코드 : [Team1]("https://discord.gg/48UWVX4X")
-   ### 노션 : [Notion]("https://alder-talon-aab.notion.site/1c47383ddec647e78b38cad8157528d7?pvs=4")
-   ### PPT : [발표자료]("https://www.canva.com/design/DAF1QJWISvY/8drEySz118loFgIIoNW8Qg/edit?utm_content=DAF1QJWISvY&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton")

## ⏰ 진행 기간

### 2023년 10월 17일 ~ 2023년 11월 13일

<br/>


##  의존성

<details>
    <summary>의존성 목록</Summary>

    ```xml

		<!-- hikariCP : tomcat-dbcp보다 더 빠르고 효율적인 커넥션풀을 제공한다 -->
		<dependency>
			<groupId>com.zaxxer</groupId>
			<artifactId>HikariCP</artifactId>
			<version>4.0.3</version>
		</dependency>

		<!-- mybatis : 영속성 프레임워크, conn, pstmt, rs 등을 편리하게 사용할 수 있도록 한다 -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>3.5.13</version>
		</dependency>

		<!-- mybatis-spring : 마이바티스의 추가 라이브러리, 매퍼 자동 주입을 가능하게 한다 -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>2.1.1</version>
		</dependency>
		
		<!-- https://mvnrepository.com/artifact/xerces/xercesImpl -->
		<!-- 프로젝트 구동 시 xml파일 경로에 한글이 있어도 예외를 발생시키지 않는다 -->
		<dependency>
			<groupId>xerces</groupId>
			<artifactId>xercesImpl</artifactId>
			<version>2.12.2</version>
		</dependency>
		
		<!-- https://mvnrepository.com/artifact/com.oracle.database.jdbc/ojdbc8 -->
		<!-- Oracle DB에 접근하기 위한 드라이버를 제공한다 -->
		<dependency>
		    <groupId>com.oracle.database.jdbc</groupId>
		    <artifactId>ojdbc8</artifactId>
		    <version>23.2.0.0</version>
		</dependency>
		
		<!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
		<!-- spring-jdbc : 스프링 프레임워크에서 DB를 처리하는데 필요한 클래스를 제공한다 -->
		<dependency>
		    <groupId>org.springframework</groupId>
		    <artifactId>spring-jdbc</artifactId>
		    <version>${org.springframework-version}</version>
		</dependency>
		
		<dependency>
			<groupId>org.springframework.data</groupId>
			<artifactId>spring-data-jpa</artifactId>
			<version>2.6.10</version>
		</dependency>

		<!-- Hibernate EntityManager (optional, only if you're using JPA) -->
		<dependency>
			<groupId>org.hibernate</groupId>
			<artifactId>hibernate-entitymanager</artifactId>
			<version>5.4.33.Final</version>
		</dependency>
		
		<dependency>
			<groupId>javax.persistence</groupId>
			<artifactId>javax.persistence-api</artifactId>
			<version>2.2</version>
		</dependency>

		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<version>1.18.30</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.springframework.security/spring-security-core -->
		<dependency>
			<groupId>org.springframework.security</groupId>
			<artifactId>spring-security-core</artifactId>
			<version>${spring-security-version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework.security</groupId>
			<artifactId>spring-security-web</artifactId>
			<version>${spring-security-version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework.security</groupId>
			<artifactId>spring-security-config</artifactId>
			<version>${spring-security-version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework.security</groupId>
			<artifactId>spring-security-oauth2-client</artifactId>
			<version>${spring-security-version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework.security</groupId>
			<artifactId>spring-security-oauth2-jose</artifactId>
			<version>${spring-security-version}</version>
		</dependency>

		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-databind</artifactId>
			<version>2.12.5</version>
		</dependency>

		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-core</artifactId>
			<version>2.12.5</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-websocket</artifactId>
			<version>5.3.30</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-messaging</artifactId>
			<version>5.3.30</version>
		</dependency>

		<!-- stomp -->
		<dependency>
			<groupId>org.springframework.integration</groupId>
			<artifactId>spring-integration-stomp</artifactId>
			<version>5.4.13</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/commons-io/commons-io -->
		<dependency>
			<groupId>commons-io</groupId>
			<artifactId>commons-io</artifactId>
			<version>2.13.0</version>
		</dependency>

		<!-- commons-fileupload -->
		<dependency>
			<groupId>commons-fileupload</groupId>
			<artifactId>commons-fileupload</artifactId>
			<version>1.5</version>
		</dependency>


		<dependency>
			<groupId>org.springframework.data</groupId>
			<artifactId>spring-data-redis</artifactId>
			<version>2.5.0</version>
		</dependency>
		<dependency>
			<groupId>redis.clients</groupId>
			<artifactId>jedis</artifactId>
			<version>3.7.0</version>
		</dependency>

		<!-- 메일을 전송할 때 다양한 형태의 컨텐츠를 보내려면 spring-context-support추가하기 -->
		<!-- https://mvnrepository.com/artifact/com.sun.mail/jakarta.mail -->
		<dependency>
			<groupId>com.sun.mail</groupId>
			<artifactId>jakarta.mail</artifactId>
			<version>2.0.1</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-context-support</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>

		<!-- 레디스에 자바 시간객체 보내려고 추가함 -->
		<dependency>
			<groupId>com.fasterxml.jackson.datatype</groupId>
			<artifactId>jackson-datatype-jsr310</artifactId>
			<version>2.12.5</version>
		</dependency>

    ```

</details>
<br/>

## 📌 기술 스택

<div style="display: inline-block">
  
<img src="https://img.shields.io/badge/Java-437291?style=for-the-badge&logo=OpenJDK&logoColor=black"/>

<img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white"/>

<img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=HTML5&logoColor=white"/>

<img src="https://img.shields.io/badge/css3-1572B6?style=for-the-badge&logo=css3&logoColor=biolet"/>

<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=Javascript&logoColor=white"/>

<img src="https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jQuery&logoColor=white"/>

<img src="https://img.shields.io/badge/bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white"/>

<img src="https://img.shields.io/badge/jsp-DF7401?style=for-the-badge&logo=openjdk&logoColor=white"/>

<img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white"/>

<img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white"/>

<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white"/>

<img src="https://img.shields.io/badge/python-3776AB?style=for-the-badge&logo=python&logoColor=white"/>

<img src="https://img.shields.io/badge/linux-FCC624?style=for-the-badge&logo=linux&logoColor=black"/>

<img src="https://img.shields.io/badge/Redis-DC382D?style=for-the-badge&logo=redis&logoColor=black"/>

</div>

<br/>

## 🛠 개발 환경

-   ### <img src="https://img.shields.io/badge/windows 10-0078D6?style=for-the-badge&logo=windows&logoColor=white">
-   ### <img src="https://img.shields.io/badge/windows 11-0078D4?style=for-the-badge&logo=windows11&logoColor=white">
-   ### <img src="https://img.shields.io/badge/mac OS-000000?style=for-the-badge&logo=macOS&logoColor=white">
-   ### <img src="https://img.shields.io/badge/intellij-2C2255?style=for-the-badge&logo=intellijIDEA&logoColor=white">
-   ### <img src="https://img.shields.io/badge/visual studio code-007ACC?style=for-the-badge&logo=visual studio code&logoColor=white">

<br/>
<br/>



## 👩‍💻 멤버 구성

| 순번 |  이름  |           프로필           |
| :--: | :----: | :------------------------: |
|  01  | 이병길 |     [바로가기][LeeBG]      |
|  02  | 문대성 | [바로가기][DAESEONGMUNDEV] |
|  03  | 박소은 |    [바로가기][Soeun21]     |
|  04  | 송근욱 |    [바로가기][Noah3521]    |
|  05  | 임상욱 |    [바로가기][seon702]     |

<br/>

## 📌진행중인 레포지토리

| 번호 |      이름       | 내용 |       레포지토리 주소       |
| :--: | :-------------: | :--: | :-------------------------: |
|  01  | FrontRepository(프론트엔드)  |      | [바로가기][FrontRepository]  |
|  02  | NetroomManager(백엔드) |      | [바로가기][NetroomManager] |

---
[FrontRepository]:https://github.com/NetRoomManager/FrontRepository
[NetroomManager]:https://github.com/NetRoomManager/NetroomManager

[DAESEONGMUNDEV]: https://github.com/DAESEONGMUNDEV
[LeeBG]: https://github.com/LeeBG
[Soeun21]: https://github.com/Soeun21
[Noah3521]: https://github.com/Noah3521
[seon702]: https://github.com/seon702
