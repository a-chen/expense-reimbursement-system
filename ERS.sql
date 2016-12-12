/*******************************************************************************
   Create tables and primary keys
********************************************************************************/
CREATE TABLE ers_reimbursement_status (
    reimb_status_id NUMBER NOT NULL,
    reimb_status VARCHAR2(10) NOT NULL,

    CONSTRAINT ers_reimbursement_status PRIMARY KEY (reimb_status_id)
)

CREATE TABLE ers_reimbursement_type (
    reimb_type_id NUMBER NOT NULL,
    reimb_type VARCHAR2(10),

    CONSTRAINT ers_reimbursement_type PRIMARY KEY (reimb_type_id)
)

CREATE TABLE ers_user_roles(
    ers_user_role_id NUMBER NOT NULL,
    user_role VARCHAR2(10) NOT NULL,

    CONSTRAINT ers_user_roles PRIMARY KEY (ers_user_role_id)
)

CREATE TABLE ers_user (
    ers_user_id NUMBER NOT NULL,
    ers_username VARCHAR2(50) NOT NULL,
    ers_password VARCHAR2(50) NOT NULL,
    user_first_name VARCHAR2(100) NOT NULL,
    user_last_name VARCHAR2(100) NOT NULL,
    user_email VARCHAR2(150) NOT NULL,
    user_role_id NUMBER NOT NULL,

    CONSTRAINT ers_user PRIMARY KEY (ers_user_id)
)

CREATE TABLE ers_reimbursement(
    reimb_id NUMBER NOT NULL,
    reimb_amount NUMBER NOT NULL,
    reimb_submitted TIMESTAMP NOT NULL,
    reimb_resolved TIMESTAMP,
    reimb_description VARCHAR2(250),
    reimb_receipt BLOB,
    reimb_author NUMBER NOT NULL,
    reimb_resolver NUMBER,
    reimb_status_id NUMBER NOT NULL,
    reimb_type_id NUMBER NOT NULL,

    CONSTRAINT ers_reimbursement PRIMARY KEY (reimb_id)
)

/*******************************************************************************
   Create foreign and unique keys
********************************************************************************/
--ers_reimbursement
ALTER TABLE ers_reimbursement ADD CONSTRAINT ers_user_fk_auth
  FOREIGN KEY (reimb_author) REFERENCES ers_user (ers_user_id)
  ON DELETE CASCADE;
  
ALTER TABLE ers_reimbursement ADD CONSTRAINT ers_user_fk_reslvr
  FOREIGN KEY (reimb_resolver) REFERENCES ers_user (ers_user_id)
  ON DELETE CASCADE;
  
ALTER TABLE ers_reimbursement ADD CONSTRAINT ers_reimbursement_status_fk
  FOREIGN KEY (reimb_status_id) REFERENCES ers_reimbursement_status (reimb_status_id)
  ON DELETE CASCADE;
  
ALTER TABLE ers_reimbursement ADD CONSTRAINT ers_reimbursement_type_fk
  FOREIGN KEY (reimb_type_id) REFERENCES ers_reimbursement_type (reimb_type_id)
  ON DELETE CASCADE;
  
--ers_user
ALTER TABLE ers_user ADD CONSTRAINT ers_username_unique UNIQUE (ers_username);

ALTER TABLE ers_user ADD CONSTRAINT user_email_unique UNIQUE (user_email);

ALTER TABLE ers_user ADD CONSTRAINT user_roles_fk
  FOREIGN KEY (user_role_id) REFERENCES ers_user_roles (ers_user_role_id)
  ON DELETE CASCADE;

/**
	Create auto incrementing PK on Reimbursement
**/
-- Sequence 
-- stores a number value you can use and increment
create sequence reimbursement_seq 
	start with 1
	increment by 1;
/
-- Triggers
-- 1. change the PK to sequence value
create or replace trigger reimbursement_trigger
  BEFORE INSERT ON ers_reimbursement
  REFERENCING NEW AS N
  FOR EACH ROW 
    DECLARE
      surrogate NUMBER;
    BEGIN
      -- get next sequence value
      select reimbursement_seq.nextval
      into surrogate
      from dual;
      -- assign the new statement's PK 
      :N.reimb_id := surrogate; 
    END;
/
  
/*******************************************************************************
   Insert test data
********************************************************************************/
insert into ers_user_roles values(1,'Admin');
insert into ers_user_roles values(2,'HR');
insert into ers_user_roles values(3,'CEO');
insert into ers_user_roles values(4,'CTO');
insert into ers_user_roles values(5,'Employee');
insert into ers_user_roles values(6,'Janitor');
insert into ers_user_roles values(7,'Pet');

insert into ers_reimbursement_type values(1,'Travel');
insert into ers_reimbursement_type values(2,'Housing');
insert into ers_reimbursement_type values(3,'Technology');
insert into ers_reimbursement_type values(4,'Equipment');
insert into ers_reimbursement_type values(5,'Misc');

insert into ers_reimbursement_status values(1,'Approved');
insert into ers_reimbursement_status values(2,'Denied');
insert into ers_reimbursement_status values(3,'Pending');

insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (1, 'jmoreno0', 'scK1ujbf7Hu8', 'Jimmy', 'Moreno', 'jmoreno0@ihg.com', 6);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (2, 'jlawson1', '2VaqcQ', 'Joyce', 'Lawson', 'jlawson1@icq.com', 2);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (3, 'eweaver2', 'ioEwxNm8C', 'Earl', 'Weaver', 'eweaver2@yellowpages.com', 2);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (4, 'rperez3', 'k3sjZe', 'Russell', 'Perez', 'rperez3@weebly.com', 4);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (5, 'lrobinson4', '7BuwMn8X', 'Louis', 'Robinson', 'lrobinson4@reddit.com', 3);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (6, 'jrivera5', 'GobV8IW', 'Jane', 'Rivera', 'jrivera5@t-online.de', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (7, 'pweaver6', '9njtfW2uDqBE', 'Patricia', 'Weaver', 'pweaver6@stumbleupon.com', 1);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (8, 'fross7', 'aJTkL2W', 'Frances', 'Ross', 'fross7@opera.com', 3);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (9, 'ksmith8', '6DUkkLMdtamc', 'Katherine', 'Smith', 'ksmith8@umich.edu', 6);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (10, 'dbailey9', 'zRZ69zsyy2cs', 'Debra', 'Bailey', 'dbailey9@ebay.com', 4);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (11, 'cmorrisa', 'VDdZzF', 'Christopher', 'Morris', 'cmorrisa@yahoo.com', 6);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (12, 'mhansonb', 'Qdbc4I1LH', 'Martin', 'Hanson', 'mhansonb@imdb.com', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (13, 'rmasonc', 'Hty0JG3fAxZ', 'Rose', 'Mason', 'rmasonc@opera.com', 4);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (14, 'fmurphyd', '7R9N63w', 'Frank', 'Murphy', 'fmurphyd@seesaa.net', 1);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (15, 'cgordone', 't3q987SiI9', 'Craig', 'Gordon', 'cgordone@cmu.edu', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (16, 'jsimpsonf', 'TNy6zxubANy6', 'Juan', 'Simpson', 'jsimpsonf@fastcompany.com', 4);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (17, 'dstephensg', 'aiRE3BKOMY', 'David', 'Stephens', 'dstephensg@homestead.com', 2);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (18, 'dmorganh', '2OYpPnlyWan', 'Denise', 'Morgan', 'dmorganh@tuttocitta.it', 4);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (19, 'lwashingtoni', 'm1Y1gP', 'Laura', 'Washington', 'lwashingtoni@dailymail.co.uk', 3);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (20, 'cpowellj', 'ftkcTeS9G', 'Christina', 'Powell', 'cpowellj@theguardian.com', 2);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (21, 'hduncank', 'zJoNtV2Wetm', 'Harold', 'Duncan', 'hduncank@google.de', 1);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (22, 'lgonzalezl', 'd4tjV2x2c9VH', 'Larry', 'Gonzalez', 'lgonzalezl@ow.ly', 2);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (23, 'sstevensm', 'K5cTND', 'Sharon', 'Stevens', 'sstevensm@yellowbook.com', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (24, 'ajenkinsn', 'Y1jNTj', 'Alice', 'Jenkins', 'ajenkinsn@hibu.com', 3);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (25, 'rhunto', 'kzsFumOOWlR', 'Raymond', 'Hunt', 'rhunto@reuters.com', 1);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (26, 'sramosp', '2AHGqNWAvi8w', 'Steven', 'Ramos', 'sramosp@sourceforge.net', 6);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (27, 'nbishopq', 'mRzI4lTt', 'Nicole', 'Bishop', 'nbishopq@dell.com', 1);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (28, 'jhansonr', 'GepEPK', 'Joan', 'Hanson', 'jhansonr@pagesperso-orange.fr', 4);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (29, 'cparkers', 'q9tWUg', 'Craig', 'Parker', 'cparkers@stumbleupon.com', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (30, 'pgarciat', 'c6acAFKv', 'Peter', 'Garcia', 'pgarciat@twitpic.com', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (31, 'mgardneru', 'Dx7cBhgS', 'Mary', 'Gardner', 'mgardneru@technorati.com', 7);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (32, 'awatkinsv', 'hMLRXq', 'Annie', 'Watkins', 'awatkinsv@ucla.edu', 1);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (33, 'esnyderw', '0r8ZB4yOR5f9', 'Evelyn', 'Snyder', 'esnyderw@g.co', 2);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (34, 'waustinx', 't23ZnOfdx', 'Wayne', 'Austin', 'waustinx@who.int', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (35, 'kmccoyy', 'MFppT5Xy0J', 'Keith', 'Mccoy', 'kmccoyy@wufoo.com', 7);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (36, 'lbennettz', 'G0H2R1A', 'Lois', 'Bennett', 'lbennettz@ucla.edu', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (37, 'rruiz10', '9lyLXsoYX4c', 'Raymond', 'Ruiz', 'rruiz10@yale.edu', 7);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (38, 'dduncan11', 'wwWWq1ijD', 'Debra', 'Duncan', 'dduncan11@msu.edu', 4);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (39, 'aholmes12', '5KMUj0l91HbA', 'Aaron', 'Holmes', 'aholmes12@histats.com', 1);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (40, 'cwoods13', 'RUA0kAZav5IB', 'Christine', 'Woods', 'cwoods13@stanford.edu', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (41, 'sperkins14', 'AcF5xQsl', 'Stephanie', 'Perkins', 'sperkins14@soup.io', 2);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (42, 'tphillips15', 'W2jDnHbv', 'Thomas', 'Phillips', 'tphillips15@cdc.gov', 4);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (43, 'jlane16', '2kZ1NvkrUr', 'James', 'Lane', 'jlane16@google.ca', 7);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (44, 'dpayne17', 'AjKBstZ', 'Donna', 'Payne', 'dpayne17@dell.com', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (45, 'kshaw18', 'g4sVPRM1I', 'Kathryn', 'Shaw', 'kshaw18@bizjournals.com', 1);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (46, 'bgreene19', 'Cvv4LkHu', 'Brenda', 'Greene', 'bgreene19@ow.ly', 7);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (47, 'dpeterson1a', 'FWS0JVI6', 'Diane', 'Peterson', 'dpeterson1a@patch.com', 5);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (48, 'gkelly1b', 'VbOTUAtxOhd', 'Gloria', 'Kelly', 'gkelly1b@amazon.de', 7);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (49, 'ggarrett1c', 'SaePwXG30Vrc', 'George', 'Garrett', 'ggarrett1c@state.gov', 2);
insert into ers_user (ers_user_id, ers_username, ers_password, user_first_name, user_last_name, user_email, user_role_id) values (50, 'mpayne1d', 'Gjb1lgBAKLQB', 'Melissa', 'Payne', 'mpayne1d@geocities.jp', 2);

insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (1, '496.33', TIMESTAMP '2015-11-23 20:54:09', 'Exclusive 5th generation info-mediaries', 11, 2, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (2, '153.60', TIMESTAMP '2015-11-14 10:32:50', 'Horizontal tertiary solution', 7, 3, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (3, '123.13', TIMESTAMP '2015-04-24 08:28:49', 'Programmable next generation conglomeration', 44, 3, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (4, '73.33', TIMESTAMP '2015-03-31 23:35:52', 'Function-based foreground flexibility', 41, 1, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (5, '192.01', TIMESTAMP '2016-09-13 16:19:09', 'User-friendly holistic initiative', 44, 1, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (6, '868.61', TIMESTAMP '2016-08-12 21:12:03', 'Configurable demand-driven firmware', 33, 2, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (7, '196.73', TIMESTAMP '2015-12-21 07:58:19', 'Ergonomic 3rd generation architecture', 14, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (8, '530.46', TIMESTAMP '2015-03-02 18:54:40', 'Exclusive fault-tolerant intranet', 38, 2, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (9, '609.32', TIMESTAMP '2016-02-25 13:01:03', 'Realigned client-driven encoding', 40, 3, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (10, '74.04', TIMESTAMP '2015-09-10 07:23:26', 'Digitized asymmetric help-desk', 25, 2, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (11, '447.58', TIMESTAMP '2015-01-22 19:53:24', 'Front-line discrete capability', 48, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (12, '269.84', TIMESTAMP '2016-11-08 03:06:03', 'Mandatory cohesive info-mediaries', 25, 1, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (13, '50.12', TIMESTAMP '2016-03-09 13:17:56', 'Optimized methodical ability', 9, 2, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (14, '890.15', TIMESTAMP '2016-10-25 17:30:30', 'Triple-buffered methodical Graphical User Interface', 2, 2, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (15, '833.83', TIMESTAMP '2015-01-02 10:30:05', 'Configurable systemic conglomeration', 7, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (16, '962.83', TIMESTAMP '2016-08-29 21:47:49', 'Intuitive client-server parallelism', 18, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (17, '638.13', TIMESTAMP '2016-08-22 13:26:59', 'Future-proofed responsive complexity', 5, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (18, '401.14', TIMESTAMP '2016-11-10 05:41:45', 'Operative systemic migration', 45, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (19, '54.73', TIMESTAMP '2015-12-31 13:11:16', 'Distributed regional monitoring', 15, 2, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (20, '67.36', TIMESTAMP '2015-03-01 17:07:12', 'Phased disintermediate capacity', 21, 1, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (21, '514.10', TIMESTAMP '2015-04-24 00:17:57', 'Adaptive logistical protocol', 46, 1, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (22, '25.04', TIMESTAMP '2015-01-12 07:28:21', 'Organized upward-trending attitude', 31, 1, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (23, '424.54', TIMESTAMP '2016-06-25 20:16:47', 'Virtual clear-thinking firmware', 31, 3, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (24, '723.35', TIMESTAMP '2016-05-18 19:45:20', 'Automated real-time projection', 13, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (25, '900.83', TIMESTAMP '2016-10-14 04:50:02', 'Automated 24/7 application', 8, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (26, '241.88', TIMESTAMP '2016-01-25 23:05:27', 'Versatile 24 hour migration', 37, 1, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (27, '253.51', TIMESTAMP '2016-08-23 18:24:22', 'Business-focused radical internet solution', 5, 1, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (28, '624.22', TIMESTAMP '2015-12-29 18:15:49', 'Future-proofed web-enabled attitude', 44, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (29, '885.69', TIMESTAMP '2015-10-02 05:02:30', 'Versatile incremental benchmark', 13, 2, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (30, '298.98', TIMESTAMP '2016-04-09 12:03:42', 'Organic grid-enabled secured line', 23, 1, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (31, '404.56', TIMESTAMP '2016-06-18 04:56:34', 'Mandatory directional capability', 48, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (32, '492.16', TIMESTAMP '2016-11-17 15:07:09', 'Visionary full-range installation', 36, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (33, '844.42', TIMESTAMP '2015-09-15 09:18:40', 'Multi-channelled asymmetric implementation', 29, 1, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (34, '766.78', TIMESTAMP '2015-11-06 02:20:00', 'Multi-layered secondary matrix', 48, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (35, '563.25', TIMESTAMP '2015-11-29 22:20:05', 'Extended contextually-based support', 13, 3, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (36, '555.69', TIMESTAMP '2015-09-17 15:09:11', 'Down-sized non-volatile projection', 5, 2, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (37, '471.00', TIMESTAMP '2015-12-22 14:38:27', 'Business-focused directional core', 31, 3, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (38, '980.74', TIMESTAMP '2015-11-29 12:27:32', 'Automated bandwidth-monitored task-force', 31, 1, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (39, '739.75', TIMESTAMP '2015-06-02 22:04:15', 'Distributed grid-enabled intranet', 10, 2, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (40, '421.69', TIMESTAMP '2015-10-07 02:16:36', 'Open-architected holistic protocol', 33, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (41, '7.51', TIMESTAMP '2015-09-23 05:52:40', 'Distributed neutral frame', 5, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (42, '812.39', TIMESTAMP '2016-07-10 18:56:23', 'Multi-channelled contextually-based projection', 14, 2, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (43, '58.82', TIMESTAMP '2016-11-13 13:45:20', 'Enhanced hybrid internet solution', 40, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (44, '961.51', TIMESTAMP '2015-09-19 20:48:50', 'Up-sized object-oriented implementation', 7, 3, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (45, '951.56', TIMESTAMP '2016-11-11 11:39:05', 'Seamless optimal open architecture', 5, 2, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (46, '968.77', TIMESTAMP '2015-11-14 00:25:44', 'Re-engineered didactic solution', 13, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (47, '520.71', TIMESTAMP '2016-07-23 03:43:43', 'Function-based secondary capacity', 28, 3, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (48, '258.03', TIMESTAMP '2016-12-01 09:17:35', 'Operative regional encryption', 47, 2, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (49, '869.63', TIMESTAMP '2015-04-27 02:35:26', 'Networked foreground ability', 9, 3, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (50, '584.20', TIMESTAMP '2016-07-08 13:10:43', 'Vision-oriented 6th generation info-mediaries', 37, 1, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (51, '840.00', TIMESTAMP '2015-07-19 06:21:09', 'Right-sized user-facing definition', 29, 2, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (52, '506.67', TIMESTAMP '2016-07-26 19:02:57', 'Implemented incremental parallelism', 48, 3, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (53, '503.13', TIMESTAMP '2015-03-16 04:08:18', 'Organic regional hierarchy', 25, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (54, '513.41', TIMESTAMP '2016-01-28 22:28:59', 'Advanced multi-tasking challenge', 32, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (55, '363.25', TIMESTAMP '2016-01-19 14:06:12', 'Face to face transitional adapter', 21, 1, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (56, '918.81', TIMESTAMP '2015-01-04 13:19:31', 'Face to face reciprocal contingency', 34, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (57, '669.06', TIMESTAMP '2016-05-13 03:50:58', 'Persistent mobile access', 42, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (58, '464.04', TIMESTAMP '2015-12-31 10:14:06', 'Multi-channelled explicit installation', 24, 3, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (59, '570.69', TIMESTAMP '2015-08-23 19:15:59', 'Upgradable didactic intranet', 13, 2, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (60, '529.88', TIMESTAMP '2015-11-05 05:23:24', 'User-friendly 6th generation local area network', 48, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (61, '60.41', TIMESTAMP '2015-01-22 16:11:02', 'Mandatory bottom-line pricing structure', 24, 3, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (62, '331.41', TIMESTAMP '2016-07-04 09:11:54', 'Sharable cohesive benchmark', 29, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (63, '698.14', TIMESTAMP '2015-11-30 06:06:15', 'Cross-platform non-volatile structure', 42, 2, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (64, '867.65', TIMESTAMP '2016-01-22 05:35:54', 'Diverse 6th generation extranet', 33, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (65, '191.89', TIMESTAMP '2015-08-14 05:14:19', 'Ergonomic mobile strategy', 42, 1, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (66, '764.36', TIMESTAMP '2015-12-13 19:06:25', 'De-engineered homogeneous parallelism', 1, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (67, '652.43', TIMESTAMP '2015-02-18 05:11:47', 'Grass-roots motivating focus group', 18, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (68, '142.81', TIMESTAMP '2016-05-22 00:12:40', 'Seamless background interface', 48, 1, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (69, '730.20', TIMESTAMP '2015-10-31 08:39:09', 'Cross-platform bifurcated forecast', 12, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (70, '86.24', TIMESTAMP '2015-12-28 04:36:23', 'Down-sized tertiary policy', 14, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (71, '717.38', TIMESTAMP '2015-03-20 01:50:28', 'Progressive mission-critical adapter', 39, 1, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (72, '551.33', TIMESTAMP '2015-01-05 12:51:47', 'Total foreground customer loyalty', 45, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (73, '67.79', TIMESTAMP '2016-09-10 00:24:16', 'Universal zero tolerance framework', 7, 3, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (74, '565.47', TIMESTAMP '2016-10-29 17:20:16', 'Total attitude-oriented functionalities', 44, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (75, '398.59', TIMESTAMP '2016-02-06 05:40:44', 'Stand-alone next generation encryption', 31, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (76, '712.75', TIMESTAMP '2015-10-09 16:53:27', 'Ergonomic bifurcated process improvement', 27, 2, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (77, '779.22', TIMESTAMP '2016-06-20 07:31:03', 'Up-sized multi-state function', 26, 1, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (78, '306.39', TIMESTAMP '2015-03-10 12:13:38', 'Future-proofed impactful methodology', 4, 3, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (79, '456.04', TIMESTAMP '2016-11-11 17:27:18', 'Optimized multimedia challenge', 16, 1, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (80, '781.36', TIMESTAMP '2015-08-12 05:41:55', 'Exclusive bottom-line customer loyalty', 1, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (81, '822.13', TIMESTAMP '2015-08-05 05:35:36', 'Universal web-enabled alliance', 41, 3, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (82, '803.69', TIMESTAMP '2015-02-06 08:42:52', 'Programmable multimedia infrastructure', 31, 2, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (83, '387.94', TIMESTAMP '2015-03-21 06:06:25', 'Centralized uniform orchestration', 18, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (84, '113.10', TIMESTAMP '2015-01-28 17:16:43', 'Operative zero administration leverage', 30, 1, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (85, '654.15', TIMESTAMP '2015-12-14 10:57:25', 'Monitored hybrid open system', 29, 3, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (86, '204.46', TIMESTAMP '2015-10-10 20:43:21', 'Phased 3rd generation contingency', 31, 2, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (87, '52.68', TIMESTAMP '2016-11-13 15:55:44', 'Diverse object-oriented forecast', 16, 1, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (88, '416.52', TIMESTAMP '2016-08-18 01:03:07', 'Centralized attitude-oriented website', 32, 2, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (89, '570.66', TIMESTAMP '2016-07-04 18:21:42', 'Synergized encompassing model', 24, 3, 1);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (90, '280.55', TIMESTAMP '2016-07-25 14:41:41', 'Front-line needs-based open system', 31, 1, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (91, '904.36', TIMESTAMP '2015-05-27 15:22:45', 'Compatible actuating parallelism', 25, 2, 2);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (92, '940.90', TIMESTAMP '2016-03-11 11:06:47', 'Customizable radical toolset', 30, 2, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (93, '393.17', TIMESTAMP '2015-03-31 04:22:40', 'Phased non-volatile complexity', 13, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (94, '499.04', TIMESTAMP '2015-06-07 22:10:55', 'Focused dynamic artificial intelligence', 33, 2, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (95, '134.10', TIMESTAMP '2016-07-14 07:28:14', 'Phased needs-based benchmark', 21, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (96, '542.86', TIMESTAMP '2015-03-20 21:01:46', 'Decentralized impactful Graphic Interface', 50, 2, 3);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (97, '192.83', TIMESTAMP '2016-05-12 19:32:48', 'Front-line regional moderator', 11, 2, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (98, '527.42', TIMESTAMP '2015-08-29 17:12:12', 'Synergized full-range synergy', 34, 1, 4);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (99, '611.86', TIMESTAMP '2015-05-16 08:59:17', 'Versatile 4th generation pricing structure', 1, 3, 5);
insert into ers_reimbursement (reimb_id, reimb_amount, reimb_submitted, reimb_description, reimb_author, reimb_status_id, reimb_type_id) values (100, '79.54', TIMESTAMP '2016-04-07 11:18:54', 'Fundamental methodical array', 37, 3, 4);

commit;


    