CREATE VIEW currently_borrowed_books AS(
SELECT bk.book_id, title, author, u.user_id, u.name AS borrower, borrow_date, due_date
FROM borrowrecord br JOIN book bk ON br.book_id = bk.book_id 
			JOIN user u ON br.user_id = u.user_id
WHERE return_date IS NULL)
ORDER BY user_Id;


SELECT * FROM currently_borrowed_books; -- c -- 

DROP VIEW currently_borrowed_books;

CREATE VIEW overdue_books AS(
SELECT bk.book_id, title, author, u.user_id, u.name AS borrower, borrow_date, due_date
FROM borrowrecord br JOIN book bk ON br.book_id = bk.book_id 
			JOIN user u ON br.user_id = u.user_id
WHERE due_date < now() AND return_date IS NULL 
ORDER BY user_id
);

SELECT * FROM overdue_books; -- c -- 

DROP VIEW overdue_books;

CREATE VIEW book_borrow_count AS(
SELECT bk.book_id, title, author, count(bk.book_id) AS borrow_count
FROM book bk JOIN borrowrecord br ON bk.book_id = br.book_id 
GROUP BY book_id 
);

SELECT * FROM book_borrow_count;-- c --

DROP VIEW book_borrow_count ;

CREATE VIEW user_borrow_count AS(
SELECT u.user_id, name, email, count(borrow_date) AS borrow_count
FROM user  u JOIN borrowrecord br ON u.user_id = br.user_id 
GROUP BY user_id 
);

SELECT * FROM user_borrow_count;-- c --

DROP VIEW user_borrow_count ;








































