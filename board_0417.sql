CREATE TABLE "survey" (
	"survey_id"	number(10)		NOT NULL,
	"name"	varchar2(200)		NULL,
	"desc"	varchar2(4000)		NULL
);

CREATE TABLE "question" (
	"q_id"	number(10)		NOT NULL,
	"question"	varchar2(200)		NULL,
	"survey_id"	number(10)		NOT NULL,
	"qt_id"	number(10)		NOT NULL
);

CREATE TABLE "response" (
	"r_id"	number(10)		NOT NULL,
	"response"	varchar2(4000)		NULL,
	"q_id"	number(10)		NOT NULL
);

CREATE TABLE "question_type" (
	"qt_id"	number(10)		NOT NULL,
	"q_type"	varchar2(2)		NULL
);

ALTER TABLE "survey" ADD CONSTRAINT "PK_SURVEY" PRIMARY KEY (
	"survey_id"
);

ALTER TABLE "question" ADD CONSTRAINT "PK_QUESTION" PRIMARY KEY (
	"q_id"
);

ALTER TABLE "response" ADD CONSTRAINT "PK_RESPONSE" PRIMARY KEY (
	"r_id"
);

ALTER TABLE "question_type" ADD CONSTRAINT "PK_QUESTION_TYPE" PRIMARY KEY (
	"qt_id"
);


select * from tab;
