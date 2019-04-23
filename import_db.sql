PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS users(
    
    id INTEGER PRIMARY KEY,
    fname VARCHAR NOT NULL,
    lname VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS question_follows (
    id INTEGER PRIMARY KEY,
    questions_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,

    FOREIGN KEY(questions_id) REFERENCES questions(id),
    FOREIGN KEY(users_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS replies (
    id INTEGER PRIMARY KEY,
    questions_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    users_id INTEGER NOT NULL,
    body TEXT,

    FOREIGN KEY(questions_id) REFERENCES questions(id),
    FOREIGN KEY(users_id) REFERENCES users(id),
    FOREIGN KEY(parent_reply_id) REFERENCES replies(id)

);

CREATE TABLE IF NOT EXISTS question_likes (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    questions_id INTEGER NOT NULL,

    FOREIGN KEY(users_id) REFERENCES users(id),
    FOREIGN KEY(questions_id) REFERENCES questions(id)

);
--inserts
INSERT INTO
    users (fname,lname)
VALUES
    ('Connor','Mcgreggor'),
    ('Elon','Musk')
;
INSERT INTO
    questions (title,body,author_id)
VALUES
    ('Mars','Where is it?',2),
    ('???','Wanna fight?',1),
    ('mars fighting','Who wants to fight my robot in space?',2)
;
INSERT INTO
    question_follows (questions_id,users_id)
VALUES
    (1,2),
    (2,1),
    (3,2)
;
INSERT INTO
    replies (questions_id,parent_reply_id,users_id, body)
VALUES
    (1,NULL,1,'Up yer ARSE'),
    (2,NULL,2,'Fight my robot'),
    (3,NULL,1,'Anywhere...anytime')
;

INSERT INTO
    question_follows (questions_id,users_id)
VALUES 
    (2,1),
    (3,1),
    (3,2);
--does question_likes neeed an id
