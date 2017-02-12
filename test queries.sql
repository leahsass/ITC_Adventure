select * from answers_table;
select * from questions_table;
select * from users; 
-- 
-- desc answers_table;
-- desc questions_table;
-- desc users;

SELECT answers 
FROM answers_table 
WHERE question_id = 1;

SELECT question 
FROM questions_table 
WHERE question_id = (
	SELECT question_id
	FROM users 
	WHERE username = 'leah'
);

SELECT answers FROM answers_table WHERE question_id = (SELECT question_id FROM users WHERE username = 'leah');

SELECT question
FROM questions_table
WHERE question_id = (
	SELECT outcome
	FROM answers_table
	WHERE answer_id
);

SELECT answer_id
FROM answers_table
WHERE outcome = (
	SELECT question_id
	FROM questions_table
	-- return question
);


SELECT image
from questions_table;

SELECT outcome
FROM answers_table
WHERE question_id=outcome;


SELECT user_id
FROM users
where question;

UPDATE users
SET question_id='1'
where user_id=1; 

