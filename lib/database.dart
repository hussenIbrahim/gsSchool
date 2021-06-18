import 'package:sqflite/sqflite.dart';

const AccountsTable = "Accounts";
const StudentTable = "Students";
const EventsTable = "Events";
const SubjectTable = "Subjects";
const SchedulesTable = "Schedules";
const HomeworksTable = "HomeWorks";
const BooksTable = "Books";
const ClasssTable = "Classs";
const ExamesTable = "Exames";

void createTable(Batch batch) {
  batch.execute('''CREATE TABLE $AccountsTable (
id TEXT  PRIMARY KEY,
token TEXT,
userName TEXT,
userType TEXT,
password TEXT,
isPrimary INTEGER,
isSelected INTEGER,
firstName TEXT,
middleName TEXT,
lastName TEXT,
image TEXT,
phone TEXT,
refreshToken TEXT
)''');

  batch.execute('''CREATE TABLE $StudentTable (
id TEXT PRIMARY KEY,
firstname TEXT ,
dob TEXT ,
note TEXT ,
attachment TEXT ,
fatherName TEXT ,
grandFatherName TEXT ,
gradeName TEXT ,
graduated INTEGER ,
gradeId INTEGER ,
isMale REAL,
parentId INTEGER
)''');

  batch.execute('''CREATE TABLE $EventsTable (
eventTitle TEXT,
schoolName INTEGER,
description  TEXT,
startDate  TEXT,
endDate TEXT, 
isHoliday INTEGER,
studentId TEXT,
hasAttachment INTEGER,
attachment TEXT,
id INTEGER
)''');
  batch.execute('''CREATE TABLE $SubjectTable (
id INTEGER PRIMARY KEY,
code TEXT,
name TEXT,
studentId TEXT,
image TEXT,
subjectOrder INTEGER,
schoolName INTEGER
)''');
  batch.execute('''CREATE TABLE $ClasssTable (
id INTEGER,
classCode TEXT,
className TEXT,
schoolName INTEGER
)''');

  batch.execute('''CREATE TABLE $SchedulesTable (
id INTEGER PRIMARY KEY,
lessonNo INTEGER,
subjectName TEXT,
className TEXT,
teacherName TEXT,
dayName TEXT,
startTime TEXT,
subjectId INTEGER,
classId INTEGER,
durationInMinutes INTEGER,
studentId TEXT
)''');

  batch.execute('''CREATE TABLE $BooksTable (
id INTEGER PRIMARY KEY,
title TEXT,
note TEXT,
coverLink TEXT,
sizeInMb TEXT,
downloadLink TEXT,
savedName INTEGER,
studentId TEXT,
classId INTEGER,
subjectId INTEGER,
schoolName INTEGER,
isDownloded INTEGER,
subjectName TEXT,
className TEXT,
classCode TEXT,
subjectCode TEXT

)''');
  batch.execute('''CREATE TABLE $HomeworksTable (
id INTEGER PRIMARY KEY,
title TEXT,
description TEXT,
image TEXT,
studentId  TEXT,
pdf TEXT,
hasPdf INTEGER,
dueTo TEXT,
hasAttachment INTEGER,
hasEquation INTEGER,
staffName TEXT,
subjectName TEXT,
isAnswerAccepted INTEGER,
isSubmittedAnswer INTEGER
)''');
}
