DROP TABLE donorschoose_resources;
DROP TABLE donorschoose_donations;
DROP TABLE donorschoose_essays;
DROP TABLE donorschoose_projects;
DROP TABLE donorschoose_giftcards;

\qecho
\qecho LOAD PROJECTS TABLE ...

CREATE TABLE donorschoose_projects
(
  -- IDs
  _projectid text NOT NULL,
  _teacher_acctid text NOT NULL,
  _schoolid text NOT NULL,
  school_ncesid text,

  -- School Location
  school_latitude numeric(11,6),
  school_longitude numeric(11,6),
  school_city text,
  school_state character(2),
  school_zip text,
  school_metro text,
  school_district text,
  school_county text,

  -- School Types
  school_charter boolean,
  school_magnet boolean,
  school_year_round boolean,
  school_nlns boolean,
  school_kipp boolean,
  school_charter_ready_promise boolean,

  -- Teacher Attributes
  teacher_prefix text,
  teacher_teach_for_america boolean,
  teacher_ny_teaching_fellow boolean,

  -- Project Categories
  primary_focus_subject text,
  primary_focus_area text,
  secondary_focus_subject text,
  secondary_focus_area text,
  resource_usage text,
  resource_type text,
  poverty_level text,
  grade_level text,

  -- Project Pricing and Impact
  vendor_shipping_charges numeric(10,2),
  sales_tax numeric(10,2),
  payment_processing_charges numeric(10,2),
  fulfillment_labor_materials numeric(10,2),
  total_price_excluding_optional_support numeric(10,2),
  total_price_including_optional_support numeric(10,2),
  students_reached numeric(10,0),
  used_by_future_students boolean,

  -- Project Donations
  total_donations numeric(10,2),
  num_donors numeric(10,0),
  eligible_double_your_impact_match boolean,
  eligible_almost_home_match boolean,

  -- Project Status
  funding_status text,
  date_posted date,
  date_completed date,
  date_thank_you_packet_mailed date,
  date_expiration date
)
WITHOUT OIDS;


\COPY donorschoose_projects(_projectid,_teacher_acctid,_schoolid,school_ncesid,school_latitude,school_longitude,school_city,school_state,school_zip,school_metro,school_district,school_county,school_charter,school_magnet,school_year_round,school_nlns,school_kipp,school_charter_ready_promise,teacher_prefix,teacher_teach_for_america,teacher_ny_teaching_fellow,primary_focus_subject,primary_focus_area,secondary_focus_subject,secondary_focus_area,resource_type,poverty_level,grade_level,vendor_shipping_charges,sales_tax,payment_processing_charges,fulfillment_labor_materials,total_price_excluding_optional_support,total_price_including_optional_support,students_reached,total_donations,num_donors,eligible_double_your_impact_match,eligible_almost_home_match,funding_status,date_posted,date_completed,date_thank_you_packet_mailed,date_expiration) FROM PSTDIN WITH CSV
\qecho ... DONE

-------------------------------

\qecho
\qecho LOAD RESOURCES TABLE ...

CREATE TABLE donorschoose_resources
(
  _resourceid text NOT NULL,
  _projectid text NOT NULL,

  vendorid text,
  vendor_name text,

  project_resource_type text,
  item_name text,
  item_number text,
  item_unit_price text,
  item_quantity text
)
WITHOUT OIDS;


\COPY donorschoose_resources(_resourceid,_projectid,vendorid,vendor_name,project_resource_type,item_name,item_number,item_unit_price,item_quantity) FROM PSTDIN WITH CSV
\qecho ... DONE

-------------------------------

\qecho
\qecho LOAD ESSAYS TABLE ...

CREATE TABLE donorschoose_essays
(
  _projectid text NOT NULL,
  _teacher_acctid text NOT NULL,

  title text,
  short_description text,
  need_statement text,
  essay text,
  paragraph1 text,
  paragraph2 text,
  paragraph3 text,
  paragraph4 text
)
WITHOUT OIDS;


\COPY donorschoose_essays(_projectid,_teacher_acctid,title,short_description,need_statement,essay,paragraph1,paragraph2,paragraph3,paragraph4) FROM PSTDIN WITH CSV
\qecho ... DONE

-------------------------------

\qecho
\qecho LOAD DONATIONS TABLE ...

CREATE TABLE donorschoose_donations
(
  -- IDs
  _donationid text NOT NULL,
  _projectid text NOT NULL,
  _donor_acctid text NOT NULL,
  _cartid text,

  -- Donor Info
  donor_city text,
  donor_state character(2),
  donor_zip text,
  is_teacher_acct boolean,

  -- Donation Times and Amounts
  donation_timestamp timestamp without time zone,
  donation_to_project numeric(10,2),
  donation_optional_support numeric(10,2),
  donation_total numeric(10,2),
  dollar_amount text,
  donation_included_optional_support boolean,

  ---Payment Types
  payment_method text,
  payment_included_acct_credit boolean,
  payment_included_campaign_gift_card boolean,
  payment_included_web_purchased_gift_card boolean,
  payment_was_promo_matched boolean,

  ---Donation Types
  via_giving_page boolean,
  for_honoree boolean,
  thank_you_packet_mailed boolean,

  donation_message text
)
WITHOUT OIDS;


\COPY donorschoose_donations(_donationid,_projectid,_donor_acctid,_cartid,donor_city,donor_state,donor_zip,is_teacher_acct,donation_timestamp,donation_to_project,donation_optional_support,donation_total,dollar_amount,donation_included_optional_support,payment_method,payment_included_acct_credit,payment_included_campaign_gift_card,payment_included_web_purchased_gift_card,payment_was_promo_matched,via_giving_page,for_honoree,thank_you_packet_mailed,donation_message) FROM PSTDIN WITH CSV
\qecho ... DONE

-------------------------------

\qecho
\qecho LOAD GIFTCARDS TABLE ...

CREATE TABLE donorschoose_giftcards
(
  _giftcardid text NOT NULL,
  dollar_amount text,

  _buyer_acctid text NOT NULL,
  buyer_city text,
  buyer_state character(2),
  buyer_zip text,

  date_purchased date,
  _buyer_cartid text,

  _recipient_acctid text,
  recipient_city text,
  recipient_state character(2),
  recipient_zip text,

  redeemed boolean,
  date_redeemed date,
  _redeemed_cartid text,

  payment_method text,
  payment_included_acct_credit boolean,
  payment_included_campaign_gift_card boolean,
  payment_included_web_purchased_gift_card boolean,
  payment_was_promo_matched boolean
)
WITHOUT OIDS;


\COPY donorschoose_giftcards(_giftcardid,dollar_amount,_buyer_acctid,buyer_city,buyer_state,buyer_zip,date_purchased,_buyer_cartid,_recipient_acctid,recipient_city,recipient_state,recipient_zip,redeemed,date_redeemed,_redeemed_cartid,payment_method,payment_included_acct_credit,payment_included_campaign_gift_card,payment_included_web_purchased_gift_card,payment_was_promo_matched) FROM PSTDIN WITH CSV
\qecho ... DONE

-------------------------------


\qecho
\qecho ALTER PROJECTS TABLE ...
ALTER TABLE donorschoose_projects
      ADD CONSTRAINT pk_donorschoose_projects PRIMARY KEY(_projectid);

CREATE INDEX donorschoose_projects_teacher_acctid
  ON donorschoose_projects
  USING btree
  (_teacher_acctid);

CREATE INDEX donorschoose_projects_schoolid
  ON donorschoose_projects
  USING btree
  (_schoolid);


VACUUM ANALYZE donorschoose_projects;
\qecho ... DONE


\qecho
\qecho ALTER RESOURCES TABLE ...
ALTER TABLE donorschoose_resources
      ADD CONSTRAINT pk_donorschoose_resources PRIMARY KEY(_resourceid);

CREATE INDEX donorschoose_resources_projectid
  ON donorschoose_resources
  USING btree
  (_projectid);


VACUUM ANALYZE donorschoose_resources;

ALTER TABLE donorschoose_resources ADD CONSTRAINT FK_donorschoose_resources_projects
  FOREIGN KEY (_projectid) REFERENCES donorschoose_projects (_projectid);
\qecho ... DONE


\qecho
\qecho ALTER ESSAYS TABLE ...
ALTER TABLE donorschoose_essays
      ADD CONSTRAINT pk_donorschoose_essays PRIMARY KEY(_projectid);

CREATE INDEX donorschoose_essays_teacher_acctid
  ON donorschoose_essays
  USING btree
  (_teacher_acctid);


VACUUM ANALYZE donorschoose_essays;

ALTER TABLE donorschoose_essays ADD CONSTRAINT FK_donorschoose_essays_projects
  FOREIGN KEY (_projectid) REFERENCES donorschoose_projects (_projectid);
\qecho ... DONE


\qecho
\qecho ALTER DONATIONS TABLE ...
ALTER TABLE donorschoose_donations
      ADD CONSTRAINT pk_donorschoose_donations PRIMARY KEY(_donationid);

CREATE INDEX donorschoose_donations_donor_acctid
  ON donorschoose_donations
  USING btree
  (_donor_acctid);

CREATE INDEX donorschoose_donations_projectid
  ON donorschoose_donations
  USING btree
  (_projectid);

CREATE INDEX donorschoose_donations_cartid
  ON donorschoose_donations
  USING btree
  (_cartid);


VACUUM ANALYZE donorschoose_donations;

ALTER TABLE donorschoose_donations ADD CONSTRAINT FK_donorschoose_donations_projects
  FOREIGN KEY (_projectid) REFERENCES donorschoose_projects (_projectid);
\qecho ... DONE


\qecho
\qecho ALTER GIFTCARDS TABLE ...
ALTER TABLE donorschoose_giftcards
      ADD CONSTRAINT pk_donorschoose_giftcards PRIMARY KEY(_giftcardid);

CREATE INDEX donorschoose_giftcards_buyer_acctid
  ON donorschoose_giftcards
  USING btree
  (_buyer_acctid);

CREATE INDEX donorschoose_giftcards_recipient_acctid
  ON donorschoose_giftcards
  USING btree
  (_recipient_acctid);

CREATE INDEX donorschoose_giftcards_buyer_cartid
  ON donorschoose_giftcards
  USING btree
  (_buyer_cartid);

CREATE INDEX donorschoose_giftcards_redeemed_cartid
  ON donorschoose_giftcards
  USING btree
  (_redeemed_cartid);


VACUUM ANALYZE donorschoose_giftcards;
\qecho ... DONE
