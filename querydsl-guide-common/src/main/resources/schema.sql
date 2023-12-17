CREATE TABLE user
(
    id            INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    parent_id     INT,
    enterprise_id INT,
    saleman_id    INT,
    billing_type  int,
    user_name     varchar,
    name          varchar,
    phone         varchar
);

create table gsms_user_ext
(
    id            INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    enterprise_id INT
);

create table gsms_capital_account
(
    id            INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    enterprise_id INT,
    parent_id     INT default 1
);

create table sedp_channel_send_report_enterprise_sum
(
    id                INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    all_receiver_sum  INT,
    yd_receiver_sum   INT,
    lt_receiver_sum   INT,
    cdma_receiver_sum INT,
    invalid_phone_num INT,
    yd_submit_sum     INT,
    lt_submit_sum     INT,
    yd_filter_num     INT,
    lt_filter_num     INT,
    cdma_filter_num   INT,
    all_send_sum      INT,
    yd_send_sum       INT,
    lt_send_sum       INT,
    cdma_send_sum     INT,
    all_fail_num      INT,
    yd_fail_num       INT,
    lt_fail_num       INT,
    cdma_fail_num     INT,
    user_id           INT,
    parent_channel_id INT,
    enterprise_id     INT,
    biz_app_id        INT,
    is_test_period    boolean,
    stat_date         datetime,
    msg_type          int
);

create table sedp_channel_result_report_enterprise_sum
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    all_success_sum int,
    yd_success_sum int,
    lt_success_sum int,
    cdma_success_sum int,
    all_fail_sum int,
    yd_fail_sum int,
    lt_fail_sum int,
    cdma_fail_sum int,
    user_id int,
    parent_channel_id int,
    enterprise_id int,
    biz_app_id int,
    is_test_period    boolean,
    stat_date         datetime
);

create table gsms_account_carrier_price
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    msg_type int,
    price int,
    enterprise_id int,
    capital_account_id int
);