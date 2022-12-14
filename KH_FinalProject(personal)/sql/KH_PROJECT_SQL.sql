CREATE TABLE ACCOUNT (
AC_ID VARCHAR2(50) PRIMARY KEY
, AC_PW VARCHAR2(50) NOT NULL
, AC_PW_ORIGIN VARCHAR2(50)
, AC_NAME VARCHAR2(20) NOT NULL
, AC_NICKNAME VARCHAR2(20) NOT NULL UNIQUE
, AC_PHONE VARCHAR2(30) NOT NULL
, AC_EMAIL VARCHAR2(100) NOT NULL UNIQUE
, AC_ROLE NUMBER
, AC_DATE DATE DEFAULT(SYSDATE)
, AC_GROUP NUMBER
, AC_MAIL_AUTH NUMBER DEFAULT(0)
, AC_MAIL_KEY VARCHAR2(50)
, CONSTRAINT ACCOUNT_AC_ROLE_FK FOREIGN KEY(AC_ROLE) REFERENCES ROLES(RO_ID)
, CONSTRAINT AC_GROUP FOREIGN KEY(ACCOUNT_AC_GROUP_FK) REFERENCES ACCOUNT_GROUP(ACG_ID)
);

-- 회원구분(2022.09.06 추가)
CREATE TABLE ACCOUNT_GROUP (
       ACG_ID NUMBER PRIMARY KEY
     , ACG_NAME VARCHAR2(30) NOT NULL UNIQUE
);

CREATE SEQUENCE ACCOUNT_GROUP_SEQ NOCACHE;

-- 역할
CREATE TABLE ROLES (
	RO_ID NUMBER PRIMARY KEY
, RO_NAME VARCHAR2(30) NOT NULL UNIQUE
);

CREATE SEQUENCE ROLES_SEQ NOCACHE;

-- 약관
CREATE TABLE TERM (
	T_ID NUMBER PRIMARY KEY
	, T_TITLE VARCHAR2(50)
	, T_REQUIRED VARCHAR2(1) CHECK(T_REQUIRED IN ('Y', 'N'))
);

CREATE SEQUENCE TERM_SEQ NOCACHE;

-- AGRREMNT
CREATE TABLE AGREEMENT (
AG_ID NUMBER PRIMARY KEY
, AG_ACID VARCHAR2(50)
, AG_TID NUMBER
, AG_ISAGREE VARCHAR2(1) DEFAULT('N')
, CONSTRAINT AGREEMENT_AG_ACID_FK FOREIGN KEY(AG_ACID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE
, CONSTRAINT AGREEMENT_AG_TID_FK FOREIGN KEY(AG_TID) REFERENCES TERM(T_ID)
);

CREATE SEQUENCE AGREEMENT_SEQ NOCACHE;

-- CATEGORY 테이블
CREATE TABLE CATEGORY(
CAT_ID NUMBER CONSTRAINT CATEGORY_CAT_ID_PK PRIMARY KEY
, CAT_NAME VARCHAR2(50) UNIQUE NOT NULL
);

CREATE SEQUENCE CATEGORY_SEQ NOCACHE;

-- COMMUNITY BOARD
CREATE TABLE COMMUNITY_BOARD (
CB_BID NUMBER,
CB_WID VARCHAR2(50) NOT NULL,
CB_CATID NUMBER NOT NULL,
CB_TITLE VARCHAR2(100) NOT NULL,
CB_CONTENT VARCHAR2(4000) NOT NULL,
CB_LIKE NUMBER,
CB_DATE DATE DEFAULT(SYSDATE),
CONSTRAINT COMMUNITY_BOARD_CB_BID_PK PRIMARY KEY (CB_BID),
CONSTRAINT COMMUNITY_BOARD_CB_WID_FK FOREIGN KEY (CB_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
CONSTRAINT COMMUNITY_BOARD_CB_CATID_FK FOREIGN KEY (CB_CATID) REFERENCES CATEGORY(CAT_ID)
);

CREATE SEQUENCE COMMUNITY_BOARD_SEQ NOCACHE;

-- COMMUNITY_BOARD_STATICS
CREATE TABLE COMMUNITY_BOARD_STATICS (
CBS_ID NUMBER,
CBS_WID VARCHAR2(50) NOT NULL,
CBS_BID NUMBER NOT NULL,
CBS_LIKED VARCHAR2(1) NOT NULL CHECK(CBS_LIKED IN('Y','N')),
CONSTRAINT COMMUNITY_BOARD_STATICS_CBS_ID_PK PRIMARY KEY (CBS_ID),
CONSTRAINT COMMUNITY_BOARD_STATICS_CBS_WID_FK FOREIGN KEY (CBS_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE, 
CONSTRAINT COMMUNITY_BOARD_STATICS_CBS_BID_FK FOREIGN KEY (CBS_BID) REFERENCES COMMUNITY_BOARD(CB_BID) ON DELETE CASCADE
);

CREATE SEQUENCE COMMUNITY_BOARD_STATICS_SEQ NOCACHE;


-- 학습 게시판
CREATE TABLE STUDY_BOARD (
	SB_BID 		NUMBER,
	SB_WID 		VARCHAR2(50) 	NOT NULL,
	SB_CATID 	NUMBER		 	NOT NULL,
	SB_TITLE 	VARCHAR2(100) 	NOT NULL,
	SB_CONTENT 	VARCHAR2(4000) 	NOT NULL,
	SB_LIKE 	NUMBER,
	SB_ISDONE 	VARCHAR2(1) 	CHECK(SB_ISDONE IN('Y', 'N')),
	SB_DATE 	DATE,
	CONSTRAINT SB_BID_PK PRIMARY KEY (SB_BID),
	CONSTRAINT SB_WID_FK FOREIGN KEY (SB_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
	CONSTRAINT SB_CATID_FK FOREIGN KEY (SB_CATID) REFERENCES CATEGORY(CAT_ID)
);

CREATE SEQUENCE STUDY_BOARD_SEQ NOCACHE;


-- 학습 게시판 추천 정보
CREATE TABLE STUDY_BOARD_STATICS(
	SBS_ID 		NUMBER,
	SBS_WID 	VARCHAR2(50) 	NOT NULL,
	SBS_BID 	NUMBER 			NOT NULL,
	SBS_LIKED 	VARCHAR2(1) 	CHECK(SBS_LIKED IN('Y', 'N')) 	NOT NULL,
	CONSTRAINT SBS_ID_PK PRIMARY KEY (SBS_ID),
	CONSTRAINT SBS_WID_FK FOREIGN KEY (SBS_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
	CONSTRAINT SBS_BID_FK FOREIGN KEY (SBS_BID) REFERENCES STUDY_BOARD(SB_BID) ON DELETE CASCADE
);

CREATE SEQUENCE STUDY_BOARD_STATICS_SEQ NOCACHE;


-- COMMUNITY_COMMENT
CREATE TABLE COMMUNITY_COMMENT (
	CC_ID NUMBER,
	CC_WID VARCHAR2(50),
	CC_BID NUMBER,
	CC_GID NUMBER,
	CC_SORT NUMBER,
	CC_DEPTH NUMBER,
	CC_CHILD NUMBER,
	CC_PARENTS NUMBER,
	CC_CONTENT VARCHAR2(4000) NOT NULL,
	CC_DELETED VARCHAR2(1) CHECK(CC_DELETED  IN ('Y','N')),
	CC_LIKE NUMBER,
	CC_DATE DATE DEFAULT(SYSDATE),
	CONSTRAINT COMMUNITY_COMMENT_CC_ID_PK PRIMARY KEY (CC_ID),
	CONSTRAINT COMMUNITY_COMMENT_CC_WID_FK FOREIGN KEY (CC_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
	CONSTRAINT COMMUNITY_COMMENT_CC_BID_FK FOREIGN KEY (CC_BID) REFERENCES COMMUNITY_BOARD(CB_BID) ON DELETE CASCADE
);


CREATE SEQUENCE COMMUNITY_COMMENT_SEQ NOCACHE;


-- COMMUNITY_COMMENT_STATICS
CREATE TABLE COMMUNITY_COMMENT_STATICS (
CCS_ID NUMBER,
CCS_WID VARCHAR2(50) NOT NULL,
CCS_CID NUMBER NOT NULL,
CCS_LIKED VARCHAR2(1) NOT NULL CHECK(CCS_LIKED IN('Y', 'N')),
CONSTRAINT COMMUNITY_COMMENT_STATICS_CCS_ID_PK PRIMARY KEY (CCS_ID),
CONSTRAINT COMMUNITY_COMMENT_STATICS_CCS_WID_FK FOREIGN KEY (CCS_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
CONSTRAINT COMMUNITY_COMMENT_STATICS_CCS_CID_FK FOREIGN KEY (CCS_CID) REFERENCES COMMUNITY_COMMENT(CC_ID) ON DELETE CASCADE
);

CREATE SEQUENCE COMMUNITY_COMMENT_STATICS_SEQ NOCACHE;

-- STUDY_COMMENT
CREATE TABLE STUDY_COMMENT(
	 SC_ID 			NUMBER								-- 댓글 id(자동생성)
	,SC_WID 		VARCHAR2(50)						-- 댓글 작성자 id(계정 외래키)
	,SC_BID 		NUMBER								-- 학습 게시물 id(학습 게시판 id 외래키)
	,SC_GID 		NUMBER								-- SC_GID 계층형 댓글 그룹
	,SC_SORT		NUMBER								-- SC_SORT 계층형 댓글 정렬
	,SC_DEPTH 		NUMBER								-- SC_DEPTH 계층형 댓글 깊이
	,SC_CHILD 		NUMBER								-- SC_CHILD 자식 댓글의 개수
	,SC_PARENTS		NUMBER								-- SC_PARENTS 부모 댓글 ID
	,SC_CONTENT 	VARCHAR2(4000)	NOT NULL			-- 댓글 내용
	,SC_DELETED 	VARCHAR2(1) 	CHECK(SC_DELETED IN('Y', 'N'))	-- 댓글 삭제 여부
	,SC_LIKE 		NUMBER 								-- 댓글 추천수
	,SC_DATE 		DATE 			DEFAULT(SYSDATE)	-- 댓글 작성일
	,CONSTRAINT SC_ID_PK 	PRIMARY KEY (SC_ID)
	,CONSTRAINT SC_WID_FK 	FOREIGN KEY (SC_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE
	,CONSTRAINT SC_BID_FK 	FOREIGN KEY (SC_BID) REFERENCES STUDY_BOARD(SB_BID) ON DELETE CASCADE
);

CREATE SEQUENCE STUDY_COMMENT_SEQ NOCACHE;

-- STUDY_COMMENT_STATICS
CREATE TABLE STUDY_COMMENT_STATICS(
	SCS_ID 		NUMBER,
	SCS_WID 	VARCHAR2(50) 	NOT NULL,
	SCS_CID 	NUMBER 			NOT NULL,
	SCS_LIKED 	VARCHAR2(1) 	CHECK(SCS_LIKED IN('Y', 'N')) NOT NULL,
	CONSTRAINT SCS_ID_PK PRIMARY KEY (SCS_ID),
	CONSTRAINT SCS_WID_FK FOREIGN KEY (SCS_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
	CONSTRAINT SCS_CID_FK FOREIGN KEY (SCS_CID) REFERENCES STUDY_COMMENT(SC_ID) ON DELETE CASCADE
);

CREATE SEQUENCE STUDY_COMMENT_STATICS_SEQ NOCACHE;




-- LESSON 테이블
CREATE TABLE LESSON(
L_ID NUMBER CONSTRAINT LESSON_L_ID_PK PRIMARY KEY
, L_CATID NUMBER 
, L_WID VARCHAR2(50) 
, L_TITLE VARCHAR2(200) NOT NULL
, L_CONTENT VARCHAR2(4000) NOT NULL
, L_PRICE NUMBER NOT NULL
, L_THUMBNAIL VARCHAR2(200)
, L_LESSON_CATEGORY VARCHAR2(50)
, CONSTRAINT LESSON_L_CATID_FK FOREIGN KEY(L_CATID) REFERENCES CATEGORY(CAT_ID)
, CONSTRAINT LESSON_L_WID_FK FOREIGN KEY(L_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE
);

CREATE SEQUENCE LESSON_SEQ NOCACHE;


-- LESSON_MANAGER 테이블
CREATE TABLE LESSON_MANAGER(
LM_ID NUMBER CONSTRAINT LESSON_MANAGER_LM_ID_PK PRIMARY KEY
, LM_LID NUMBER CONSTRAINT LESSON_MANAGER_LM_LID_FK REFERENCES LESSON(L_ID)
, LM_WID VARCHAR2(50) CONSTRAINT LESSON_MANAGER_LM_WID_FK REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE
, LM_DATE DATE
);

CREATE SEQUENCE LESSON_MANAGER_SEQ NOCACHE;


-- LESSON_UPLOAD 테이블
CREATE TABLE LESSON_UPLOAD(
LU_ID NUMBER CONSTRAINT LESSON_UPLOAD_LU_ID_PK PRIMARY KEY
, LU_BID NUMBER CONSTRAINT LESSON_UPLOAD_LU_BID_FK REFERENCES LESSON(L_ID)
, LU_NAME VARCHAR2(200) NOT NULL
, LU_UUIDNAME VARCHAR2(36) NOT NULL
, LU_LOCATION VARCHAR2(500) NOT NULL
, LU_URL VARCHAR2(500) NOT NULL
, LU_FILESIZE NUMBER DEFAULT(0)
, LU_CONTENTTYPE VARCHAR2(50) NOT NULL
)

CREATE SEQUENCE LESSON_UPLOAD_SEQ NOCACHE;


-- REVIEW_BOARD
CREATE TABLE REVIEW_BOARD(
RB_ID NUMBER,
RB_WID VARCHAR2(50) NOT NULL,
RB_LID NUMBER NOT NUll,
RB_CONTENT VARCHAR2(4000),
RB_SCORE NUMBER DEFAULT(1),
RB_DATE DATE DEFAULT(SYSDATE),
CONSTRAINT REVIEW_BOARD_RB_ID_PK PRIMARY KEY(RB_ID),
CONSTRAINT REVIEW_BOARD_RB_WID_FK FOREIGN KEY(RB_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
CONSTRAINT REVIEW_BOARD_RB_LID_FK FOREIGN KEY(RB_LID) REFERENCES LESSON(L_ID)
);

CREATE SEQUENCE REVIEW_BOARD_SEQ NOCACHE;


CREATE TABLE QA_BOARD(
QB_BID NUMBER,
QB_WID VARCHAR2(50) NOT NULL,
QB_LID NUMBER NOT NUll,
QB_TITLE VARCHAR2(100) NOT NULL,
QB_CONTENT VARCHAR2(4000) NOT NULL,
QB_DATE DATE DEFAULT(SYSDATE),
CONSTRAINT QA_BOARD_QB_BID_PK PRIMARY KEY(QB_BID),
CONSTRAINT QA_BOARD_QB_WID_FK FOREIGN KEY(QB_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
CONSTRAINT QA_BOARD_QB_LID_FK FOREIGN KEY(QB_LID) REFERENCES LESSON(L_ID)
);

CREATE SEQUENCE QA_BOARD_SEQ NOCACHE;


CREATE TABLE QA_ANSWER(
QAA_LID NUMBER NOT NULL,
QAA_WID VARCHAR2(50),
QAA_BID NUMBER,
QAA_CONTENT VARCHAR2(4000) NOT NULL,
QAA_DATE DATE DEFAULT(SYSDATE),
CONSTRAINT QA_ANSWER_QAA_LID_FK FOREIGN KEY(QAA_LID) REFERENCES LESSON(L_ID),
CONSTRAINT QA_ANSWER_QAA_WID_FK FOREIGN KEY(QAA_WID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE,
CONSTRAINT QA_ANSWER_QAA_BID_FK FOREIGN KEY(QAA_BID) REFERENCES QA_BOARD(QB_BID) ON DELETE CASCADE
);

CREATE SEQUENCE QA_ANSWER_SEQ NOCACHE;

		
--커리큘럼 table 추가(chpater- 큰 제목)
CREATE TABLE CURRICULUM_BIG(
	CUR_BIG_LID 			NUMBER,	--강의 아이디
	CUR_BIG_CHAPID			NUMBER,	--강의 제목의 번호
	CUR_BIG_TITLE 		VARCHAR2(100)	NOT NULL,
	CONSTRAINT CURRICULUM_CUR_BIG_LID_FK FOREIGN KEY(CUR_BIG_LID) REFERENCES LESSON(L_ID)
);

--커리큘럼 table 추가(강의- 작은 제목)
CREATE TABLE CURRICULUM_SMALL(
	CUR_SMALL_LID 			NUMBER,							--강의 아이디
	CUR_SMALL_CHAPID      	NUMBER, 
	CUR_SMALL_CURID			NUMBER,							--강의 제목의 번호
	CUR_SMALL_TITLE			VARCHAR2(200)	NOT NULL,		--강의 소제목
	CUR_SMALL_TYPE 			VARCHAR2(20)	CHECK(CUR_SMALL_TYPE IN('VIDEO', 'DOCUMENT')),
	CUR_SMALL_RUNNING_TIME 	VARCHAR2(30),
	CONSTRAINT CURRICULUM_CUR_SMALL_LID_FK FOREIGN KEY(CUR_SMALL_LID) REFERENCES LESSON(L_ID)
);


CREATE TABLE WISHLIST (
W_ID NUMBER PRIMARY KEY
, W_ACID VARCHAR2(50)
, W_LID NUMBER
, CONSTRAINT WISHLIST_W_ACID_FK FOREIGN KEY(W_ACID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE
, CONSTRAINT WISHLIST_W_LID_FK FOREIGN KEY(W_LID) REFERENCES LESSON(L_ID)
);

CREATE SEQUENCE WISHLIST_SEQ NOCACHE;


CREATE TABLE PAYMENT (
P_TID VARCHAR2(50) PRIMARY KEY
, P_ACID VARCHAR2(50)
, P_ITEM_NAME VARCHAR2(100)
, P_ITEM_CODE VARCHAR2(100)
, P_TOTAL_AMOUNT NUMBER
, P_APPROVED_AT DATE
, CONSTRAINT PAYMENT_P_ACID_FK FOREIGN KEY(P_ACID) REFERENCES ACCOUNT(AC_ID) ON DELETE CASCADE
);



-- DB에 저장된 모든 테이블을 조회해서 DROP TABLE로 불러오기
SELECT 'DROP TABLE"' || TABLE_NAME || '"CASCADE CONSTRAINTS;' FROM USER_TABLES;

DROP TABLE"ACCOUNT_GROUP"CASCADE CONSTRAINTS;
DROP TABLE"CURRICULUM_BIG"CASCADE CONSTRAINTS;
DROP TABLE"CURRICULUM_SMALL"CASCADE CONSTRAINTS;
DROP TABLE"QA_ANSWER"CASCADE CONSTRAINTS;
DROP TABLE"STUDY_COMMENT"CASCADE CONSTRAINTS;
DROP TABLE"STUDY_COMMENT_STATICS"CASCADE CONSTRAINTS;
DROP TABLE"COMMUNITY_BOARD"CASCADE CONSTRAINTS;
DROP TABLE"COMMUNITY_BOARD_STATICS"CASCADE CONSTRAINTS;
DROP TABLE"COMMUNITY_COMMENT"CASCADE CONSTRAINTS;
DROP TABLE"COMMUNITY_COMMENT_STATICS"CASCADE CONSTRAINTS;
DROP TABLE"ROLES"CASCADE CONSTRAINTS;
DROP TABLE"ACCOUNT"CASCADE CONSTRAINTS;
DROP TABLE"TERM"CASCADE CONSTRAINTS;
DROP TABLE"AGREEMENT"CASCADE CONSTRAINTS;
DROP TABLE"CATEGORY"CASCADE CONSTRAINTS;
DROP TABLE"STUDY_BOARD"CASCADE CONSTRAINTS;
DROP TABLE"STUDY_BOARD_STATICS"CASCADE CONSTRAINTS;
DROP TABLE"LESSON"CASCADE CONSTRAINTS;
DROP TABLE"LESSON_MANAGER"CASCADE CONSTRAINTS;
DROP TABLE"LESSON_UPLOAD"CASCADE CONSTRAINTS;
DROP TABLE"REVIEW_BOARD"CASCADE CONSTRAINTS;
DROP TABLE"QA_BOARD"CASCADE CONSTRAINTS;
DROP TABLE"WISHLIST"CASCADE CONSTRAINTS;
DROP TABLE"PAYMENT"CASCADE CONSTRAINTS;
DROP TABLE"ACCOUNTS"CASCADE CONSTRAINTS;


SELECT SEQUENCE_NAME
  FROM all_sequences
 WHERE sequence_owner = 'PUSER1';
 
DROP SEQUENCE ACCOUNT_GROUP_SEQ;
DROP SEQUENCE AGREEMENT_SEQ;
DROP SEQUENCE CATEGORY_SEQ;
DROP SEQUENCE COMMENTS_SEQ;
DROP SEQUENCE COMMUNITY_BOARD_SEQ;
DROP SEQUENCE COMMUNITY_BOARD_STATICS_SEQ;
DROP SEQUENCE COMMUNITY_COMMENT_SEQ;
DROP SEQUENCE COMMUNITY_COMMENT_STATICS_SEQ;
DROP SEQUENCE LESSON_MANAGER_SEQ;
DROP SEQUENCE LESSON_SEQ;
DROP SEQUENCE LESSON_UPLOAD_SEQ;
DROP SEQUENCE QA_BOARD_SEQ;
DROP SEQUENCE REVIEW_BOARD_SEQ;
DROP SEQUENCE ROLES_SEQ;
DROP SEQUENCE STUDY_BOARD_SEQ;
DROP SEQUENCE STUDY_BOARD_STATICS_SEQ;
DROP SEQUENCE STUDY_COMMENT_SEQ;
DROP SEQUENCE STUDY_COMMENT_STATICS_SEQ;
DROP SEQUENCE TERM_SEQ;
DROP SEQUENCE WISHLIST_SEQ;

