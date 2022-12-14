# KH_final_project

## 프로젝트 개발 목적
>개발에 입문한 사람들을 위한 강의를 제공하고, 개발에 대한 정보 제공, 노하우 전수 및 질의 응답이 이루어 질 수 있는 커뮤니티가 있는 홈페이지를 만들고자 하였습니다. 

## 구현 화면 및 기능
1. 회원가입 및 로그인
2. 커뮤니티 게시판
3. 스터디 게시판
4. 강의 게시판(담당한 과제)
5. 마이 페이지

## 강의 게시판 세부 기능
### 전체 강의 조회 및 검색
```
* 조회: 기본적으로 모든 강의가 조회 가능, 강의 카테고리별로 조회 가능(좌측 sidebar)
* 검색:강의명, 강사명으로 조회 가능
```

### 강의 상세 정보 조회
```
+ 배너: 강의 썸네일, 강의 카테고리, 강의 제목, 강의자, 별점 평균, 수강평 개수 정보 확인 가능
+ 배너 밑 navigation 및 상세내용
    + 강의 소개, 커리큘럼, 수강평, QnA 클릭시 해당 영역으로 이동
    + 강의 상세 설명 조회
    + 강의 커리큘럼 카드 클릭 시 세부 강의명을 펼쳐 보기 가능
    + 강의 수강평 작성 시, 강의 수강평 별점 평균(숫자 밑 별 icon),    수강평 개수, 수강평 별점별에 따른 progress bar에 반영 
    + 강의 수강평 최신순, 별점 높은 순, 낮은 순 조회가능
    + 강의 수강신청
```

### 강의 장바구니 담기
```
+ 수강 신청하기: 바로 마이페이지-수강바구니로 이동, 수강바구니에 해당 강의 추가
+ 장바구니 담기: 비동기로 수강바구니에 해당 강의 추가
+ 수강바구니에 이미 담겨있을 때: 수강신청하기 버튼만 존재
+ 수강 중 강의일 때: 이어 학습하기 버튼, 수강평 작성하기 버튼으로 변경
+ 수강 중 강의인데 수강평을 이미 작성했을 때: 이어학습하기 버튼만 존재
```
### 강의 수강평 및 QnA 등록, 수정, 삭제 
```
+ 수강평: 등록 및 수정: 모달을 통한 별점과 수강평 작성 가능, 삭제: 비동기로 삭제 가능
+ QnA: QnA, QnA 답변 등록: 모달을 통해 작성 가능, QnA, QnA 답변 수정 및 삭제: 비동기식으로 동작
```

### 토스 페이 결제
```
+ 결제 방식 선택 후 Toss 버튼 클릭 시 결제 진행
+ 카드: 결제 완료 후 결제 완료 화면 동작
+ 가상 계좌: 가상 계좌 발급 후 가상 계좌 정보 화면 전송, 발급된 가상계좌는 존재하지 않아 결제 완료 불가능
```

### 강의 업로드
```
+ 강의 상세내용: 강의 제목, 강의 카테고리, 강의 가격 작성 후 임시저장
+ 커리큘럼: 커리큘럼 작성 후 임시저장
+ 강의 썸네일 및 강의 자료: 강의 썸네일 업로드 가능, 강의 자료 업로드 가능, 임시 저장 불가, 바로 강의 업로드로 연결

```


## DB 설계
![image](https://user-images.githubusercontent.com/97294815/193112253-a07b370e-375c-4ab8-a82e-8d5658f75a51.png)
