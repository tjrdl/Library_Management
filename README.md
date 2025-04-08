# Library_management_pjt

  <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white"> 
  <img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white"> 
  <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white"> 

##### 개발환경
- IDE : eclipse
- IDE package : sts-3.9.18.RELEASE
- language : Java
- Java version : 11
- Windows 10, 11

```
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, 
      CREATE SYNONYM, CREATE PROCEDURE, CREATE TRIGGER, CREATE MATERIALIZED VIEW 
TO bookmanager;

GRANT SELECT ANY TABLE, INSERT ANY TABLE, UPDATE ANY TABLE, DELETE ANY TABLE 
TO bookmanager;
ALTER USER bookmanager DEFAULT TABLESPACE USERS;
ALTER USER bookmanager QUOTA UNLIMITED ON USERS;

CREATE TABLE USERINFO (
    userNumber      NUMBER PRIMARY KEY,
    userId          VARCHAR2(100),
    userPw          VARCHAR2(100),
    userName        VARCHAR2(100),
    userTel         VARCHAR2(20),
    userEmail       VARCHAR2(200),
    userBirth       VARCHAR2(50),
    userZipCode     VARCHAR2(50),
    userAddress     VARCHAR2(300),
    userDetailAddress VARCHAR2(500),
    userBorrow      NUMBER DEFAULT 3,
    userAdmin       NUMBER DEFAULT 0,
    userRegdate     DATE DEFAULT SYSDATE
);
CREATE TABLE BOOKINFO (
    bookNumber          NUMBER PRIMARY KEY,
    bookIsbn            NUMBER(20) DEFAULT 0,
    bookTitle           VARCHAR2(400),
    bookComent          VARCHAR2(4000),
    bookWrite           VARCHAR2(100),
    bookPub             VARCHAR2(100),
    bookDate            DATE,
    bookMajorCategory   NVARCHAR2(100),
    bookSubCategory     NVARCHAR2(100),
    bookCount           NUMBER,
    bookBorrowCount     NUMBER DEFAULT 0
);

CREATE TABLE NOTICE(
    noticeNum            NUMBER PRIMARY KEY,
    noticeTitle          VARCHAR2(500) NOT NULL,
    noticeContent        VARCHAR2(4000) NOT NULL,
    noticewriter         VARCHAR2(100) DEFAULT '관리자',
    noticeregdate        DATE DEFAULT SYSDATE,
    noticeviews          NUMBER DEFAULT 0,
    noticeCategory       VARCHAR2(30)
);

CREATE TABLE BOOK_REGISTATION_LOG (
    logNumber      NUMBER PRIMARY KEY,
    userNumber  NUMBER,
    bookNumber  NUMBER,
    regDate     DATE DEFAULT SYSDATE,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber),
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber)
);

CREATE TABLE BOARD (
    boardNumber     NUMBER PRIMARY KEY,
    userNumber      NUMBER,
    userName        VARCHAR2(50),
    boardTitle      VARCHAR2(1000),
    boardContent    VARCHAR2(4000),
    boardWriteDate  DATE DEFAULT SYSDATE,
    boardHit        NUMBER DEFAULT 0,
    boardViews      NUMBER DEFAULT 0,
    boardLikes      NUMBER DEFAULT 0,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber)
);

CREATE TABLE board_likes (
    boardNumber number,
    userNumber number,
    PRIMARY KEY (boardNumber, userNumber)
);

CREATE TABLE BOARD_COMMENT (
    commentNumber       NUMBER PRIMARY KEY,
    boardNumber         NUMBER,
    userNumber          NUMBER,
    commentContent      VARCHAR2(4000),
    commentWriteDate    DATE DEFAULT SYSDATE,
    FOREIGN KEY (boardNumber) REFERENCES BOARD(boardNumber),
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber)
);
CREATE TABLE BOOK_BORROW (
    borrowNumber        NUMBER PRIMARY KEY,
    userNumber          NUMBER,
    bookNumber          NUMBER,
    bookBorrowDate      DATE DEFAULT SYSDATE,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber),
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber)
);
CREATE TABLE BORROW_RECORD (
    borrowRecordNumber  NUMBER PRIMARY KEY,
    userNumber          NUMBER,
    bookNumber          NUMBER,
    borrowNumber        NUMBER,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber),
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber),
    FOREIGN KEY (borrowNumber) REFERENCES BOOK_BORROW(borrowNumber)
);
CREATE TABLE RETURN_RECORD (
    returnNumber        NUMBER PRIMARY KEY,
    userNumber          NUMBER,
    bookNumber          NUMBER,
    bookReturnDate      DATE DEFAULT SYSDATE,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber),
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber)
);
CREATE TABLE SELL_BOOK (
    sellNumber      NUMBER PRIMARY KEY,
    bookNumber      NUMBER,
    userNumber      NUMBER,
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber),
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber)
);
CREATE TABLE SELL_RECORD (
    sellRecordNumber    NUMBER PRIMARY KEY,
    sellNumber          NUMBER,
    userNumber          NUMBER,
    bookNumber          NUMBER,
    FOREIGN KEY (sellNumber) REFERENCES SELL_BOOK(sellNumber),
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber),
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber)
);
CREATE TABLE BUY_RECORD (
    buyRecordNumber     NUMBER PRIMARY KEY,
    userNumber          NUMBER,
    bookNumber          NUMBER,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber),
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber)
);
```

## ERD
![image](https://github.com/user-attachments/assets/5c668ab5-4098-439b-a0d1-85609255b0c1)

## 로그인 & 회원가입 플로우차트
![image](https://github.com/user-attachments/assets/42c9b8b7-f470-4843-82bc-3ed59fce2352)

## 도서 등록 플로우차트
![image](https://github.com/user-attachments/assets/ddda9356-1cb5-4e6b-aa1d-6a7f0d169dc4)

