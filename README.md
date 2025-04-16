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

##### ERD
![제목 없음](https://github.com/user-attachments/assets/6fcc184a-7832-47de-9f53-7db4e7636054)


<details>
  <summary>쿼리문 (트리거 개별 실행)</summary>
  <pre><code>
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
    userBorrow      NUMBER DEFAULT 0,
    userCanBorrow      NUMBER DEFAULT 5,
    userAdmin       NUMBER DEFAULT 0,
    userRegdate     DATE DEFAULT SYSDATE
);


CREATE TABLE user_sessions (
    userId VARCHAR(50) PRIMARY KEY,
    sessionId VARCHAR(100) NOT NULL,
    loginTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE BOOKINFO (
    bookNumber          NUMBER PRIMARY KEY,
    bookIsbn            VARCHAR2(50) DEFAULT 0,
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
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber)ON DELETE CASCADE
);

CREATE TABLE board_likes (
    boardNumber number,
    userNumber number,
    PRIMARY KEY (boardNumber, userNumber)
);

CREATE TABLE BOARD_COMMENT (
    commentNumber       NUMBER PRIMARY KEY,
    commentSubNumber    NUMBER,
    commentSubStepNumber NUMBER,
    boardNumber         NUMBER,
    userNumber          NUMBER,
    userName            VARCHAR2(50),
    commentContent      VARCHAR2(4000),
    commentWriteDate    DATE DEFAULT SYSDATE
);

ALTER TABLE BOARD_COMMENT
ADD CONSTRAINT fk_comment_board
FOREIGN KEY (boardNumber)
REFERENCES BOARD(boardNumber)
ON DELETE CASCADE;

ALTER TABLE BOARD_COMMENT
ADD CONSTRAINT fk_comment_user
FOREIGN KEY (userNumber)
REFERENCES USERINFO(userNumber)
ON DELETE CASCADE;
DESC board_comment;

CREATE TABLE BOOK_BORROW (
    borrowNumber        NUMBER PRIMARY KEY,
    userNumber          NUMBER,
    bookNumber          NUMBER,
    bookTitle           VARCHAR2 (400),
    bookWrite           VARCHAR2 (100),
    bookBorrowDate      DATE DEFAULT SYSDATE,
    bookReturnDate      DATE,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber)ON DELETE CASCADE,
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber)ON DELETE CASCADE
);
CREATE TABLE Book_RECORD (
    recordNumber  NUMBER PRIMARY KEY,
    userNumber          NUMBER,
    bookNumber          NUMBER,
    bookTitle           VARCHAR2 (400),
    bookWrite           VARCHAR2 (100),
    bookBorrowDate      DATE,
    bookReturnDate      DATE,
    FOREIGN KEY (userNumber) REFERENCES USERINFO(userNumber),
    FOREIGN KEY (bookNumber) REFERENCES BOOKINFO(bookNumber)
);


--------------------------------------------- 시퀀스 드래그로 개별 컴파일
CREATE SEQUENCE  "BOOKMANAGER"."BORROWRECORD_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE 


--------------------------------------------- 트리거 드래그로 개별 컴파일
create or replace TRIGGER after_book_record_insert
after INSERT ON book_record
FOR EACH ROW

BEGIN
     -- BOOKINFO 업데이트
    UPDATE BOOKINFO
    SET
        BOOKCOUNT = BOOKCOUNT + 1
    WHERE BOOKNUMBER = :NEW.BOOKNUMBER;

    -- USERINFO 업데이트
    UPDATE USERINFO
    SET
        USERCANBORROW = USERCANBORROW + 1
    WHERE USERNUMBER = :NEW.USERNUMBER;

END;
--------------------------------------------- 트리거 드래그로 개별 컴파일
create or replace TRIGGER before_book_record_insert
BEFORE INSERT ON book_record
FOR EACH ROW
DECLARE
    v_borrowDate DATE;
    v_borrowNumber NUMBER;
    v_booktitle varchar2(400);
    v_bookwrite varchar2(100);
    v_recordNumber number;
    v_returnDate date default SYSDATE;
    ex_no_borrow EXCEPTION;
BEGIN
    -- 해당 대출 정보 유무 확인
    SELECT borrowNumber, bookBorrowDate
    INTO v_borrowNumber, v_borrowDate
    FROM book_borrow
    WHERE bookNumber = :NEW.bookNumber
      AND userNumber = :NEW.userNumber;
      
    select booktitle, bookwrite
    into v_booktitle, v_bookwrite
    from bookinfo
    where bookNumber = :NEW.bookNumber;
    
     -- 새로운 borrowRecordNumber 미리 생성
    SELECT NVL(MAX(recordNumber), 0) + 1
    INTO v_recordNumber
    FROM book_record;
   
    :NEW.bookBorrowDate := v_borrowDate;
    :NEW.bookReturnDate := v_returnDate;
    :NEW.booktitle := v_booktitle;
    :NEW.bookwrite := v_bookwrite;
    

    -- 그 다음 BOOK_BORROW에서 삭제
    DELETE FROM book_borrow
    WHERE bookNumber = :NEW.bookNumber
      AND userNumber = :NEW.userNumber;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20004, '대출 정보가 존재하지 않아 반납할 수 없습니다.');
END;
--------------------------------------------- 트리거 드래그로 개별 컴파일

create or replace TRIGGER trg_after_book_borrow_insert
-- AFTER 에서 BEFORE로 바뀜
-- 중복 대출 체크(조회)를 위해 before로 수정
BEFORE INSERT ON BOOK_BORROW
FOR EACH ROW
DECLARE
    v_bookcount     NUMBER;
    v_usercanborrow NUMBER;
    v_count    NUMBER;
    v_booktitle     varchar2(400);
    v_bookwrite     varchar2(100);
    ex_no_stock     EXCEPTION;
    ex_no_quota     EXCEPTION;
    ex_already_borrowed EXCEPTION;
BEGIN
    -- 책 재고, 제목, 저자 확인
    SELECT BOOKCOUNT, booktitle, bookwrite INTO v_bookcount, v_booktitle, v_bookwrite
    FROM BOOKINFO
    WHERE BOOKNUMBER = :NEW.BOOKNUMBER;


    :NEW.booktitle := v_booktitle;
    :NEW.bookwrite := v_bookwrite;
    :NEW.bookReturnDate := SYSDATE + 30;

    -- 사용자 대출 가능 횟수 확인
    SELECT USERCANBORROW INTO v_usercanborrow
    FROM USERINFO
    WHERE USERNUMBER = :NEW.USERNUMBER;

    -- 중복 대출 체크
    SELECT COUNT(*) INTO v_count
    FROM BOOK_BORROW
    WHERE USERNUMBER = :NEW.USERNUMBER
     AND BOOKNUMBER = :NEW.BOOKNUMBER;

    IF v_count > 0 THEN
    RAISE ex_already_borrowed;
    END IF;

    -- 예외 조건 검사
    IF v_bookcount <= 0 THEN
        RAISE ex_no_stock;
    ELSIF v_usercanborrow <= 0 THEN
        RAISE ex_no_quota;
    END IF;

    -- BOOKINFO 업데이트
    UPDATE BOOKINFO
    SET
        BOOKBORROWCOUNT = BOOKBORROWCOUNT + 1,
        BOOKCOUNT = BOOKCOUNT - 1
    WHERE BOOKNUMBER = :NEW.BOOKNUMBER;

    -- USERINFO 업데이트
    UPDATE USERINFO
    SET
        USERCANBORROW = USERCANBORROW - 1,
        USERBORROW = USERBORROW + 1
    WHERE USERNUMBER = :NEW.USERNUMBER;

EXCEPTION
    WHEN ex_no_stock THEN
        RAISE_APPLICATION_ERROR(-20001, '도서 재고가 부족하여 대출할 수 없습니다.');
    WHEN ex_no_quota THEN
        RAISE_APPLICATION_ERROR(-20002, '회원의 대출 가능 권수가 0입니다.');
    WHEN ex_already_borrowed THEN
        RAISE_APPLICATION_ERROR(-20004, '이미 빌린 책 입니다');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, '트리거 처리 중 오류 발생: ' || SQLERRM);
END;
  </code></pre>
</details>

### 🔑회원가입 - 도로명 api
https://github.com/user-attachments/assets/1e1b3202-5e98-482b-ba6a-8f2281aadce5

### 🏠마이페이지 - 대출중도서, 연체도서, 총 대출 이력, 대출현황&기록
https://github.com/user-attachments/assets/21322cc8-3d86-4957-b91a-c8b608871d74

### 📖대출&반납
https://github.com/user-attachments/assets/9cf238c0-6ded-475b-a1fd-eb9e090d7dd1

### 📨게시판 작성, 수정, 삭제, 댓글, 추천
https://github.com/user-attachments/assets/295d5c3a-c79f-47a0-b290-f535c7cfbd1d

### 📕 도서 등록
https://github.com/user-attachments/assets/c25e002f-0a1c-4fdb-8285-8b6f5f99a085

### ✏️도서 수정
https://github.com/user-attachments/assets/6a497dd5-5aa5-4dac-9bef-000b31cdd8e0

### 📢공지사항 작성, 수정, 삭제
https://github.com/user-attachments/assets/5691abc0-2bc7-49a5-9be8-166daf432095
