select sum(ifnull(send_all_receiver_sum,0))  as all_receiver_sum, sum(ifnull(send_yd_receiver_sum,0))  as yd_receiver_sum,
 sum(ifnull(send_lt_receiver_sum,0))  as lt_receiver_sum, sum(ifnull(send_cdma_receiver_sum,0))  as cdma_receiver_sum, sum(ifnull(send_invalid_phone_num,0))  as invalid_phone_num,
 sum(ifnull(send_all_submit_sum,0))  as all_submit_sum, sum(ifnull(send_yd_submit_sum,0))  as yd_submit_sum, sum(ifnull(send_lt_submit_sum,0)) as lt_submit_sum, sum(ifnull(send_cdma_submit_sum,0))   as cdma_submit_sum,
 sum(ifnull(send_all_filter_num,0))  as all_filter_num, sum(ifnull(send_yd_filter_num,0))  as yd_filter_num, sum(ifnull(send_lt_filter_num,0))  as lt_filter_num, sum(ifnull(send_cdma_filter_num,0))  as cdma_filter_num,
 sum(ifnull(send_all_send_sum,0)) as all_send_sum, sum(ifnull(send_yd_send_sum,0))  as yd_send_sum, sum(ifnull(send_lt_send_sum,0))  as lt_send_sum, sum(ifnull(send_cdma_send_sum,0))  as cdma_send_sum,
 sum(ifnull(send_all_fail_num,0))  as all_fail_num, sum(ifnull(send_yd_fail_num,0))   as yd_fail_num, sum(ifnull(send_lt_fail_num,0))    as lt_fail_num, sum(ifnull(send_cdma_fail_num,0))   as cdma_fail_num,
 sum(ifnull(result_all_success_sum,0))  as all_success_sum, sum(ifnull(result_yd_success_sum,0)) as yd_success_sum, sum(ifnull(result_lt_success_sum,0)) as lt_success_sum,
 sum(ifnull(result_cdma_success_sum,0)) as cdma_success_sum, sum(ifnull(result_all_fail_sum,0))  as all_fail_sum, sum(ifnull(result_yd_fail_sum,0))  as yd_fail_sum, sum(ifnull(result_lt_fail_sum,0))  as lt_fail_sum,
 sum(ifnull(result_cdma_fail_sum,0))  as cdma_fail_sum, 
 billing_type as ent_billing_type, case when parent_channel_id = 0 then 0 else 1 end as channel_flag 

from (
	select send_report.all_receiver_sum   as send_all_receiver_sum, send_report.yd_receiver_sum    as send_yd_receiver_sum, send_report.lt_receiver_sum    as send_lt_receiver_sum,
	send_report.cdma_receiver_sum  as send_cdma_receiver_sum, send_report.invalid_phone_num  as send_invalid_phone_num, send_report.all_submit_sum     as send_all_submit_sum, send_report.yd_submit_sum      as send_yd_submit_sum,
	send_report.lt_submit_sum      as send_lt_submit_sum, send_report.cdma_submit_sum    as send_cdma_submit_sum, send_report.all_filter_num     as send_all_filter_num, send_report.yd_filter_num      as send_yd_filter_num,
	send_report.lt_filter_num      as send_lt_filter_num, send_report.cdma_filter_num    as send_cdma_filter_num, send_report.all_send_sum       as send_all_send_sum, send_report.yd_send_sum        as send_yd_send_sum,
	send_report.lt_send_sum        as send_lt_send_sum, send_report.cdma_send_sum      as send_cdma_send_sum, send_report.all_fail_num       as send_all_fail_num, send_report.yd_fail_num        as send_yd_fail_num,
	send_report.lt_fail_num        as send_lt_fail_num, send_report.cdma_fail_num      as send_cdma_fail_num, result_report.all_success_sum  as result_all_success_sum, result_report.yd_success_sum   as result_yd_success_sum,
	result_report.lt_success_sum   as result_lt_success_sum, result_report.cdma_success_sum as result_cdma_success_sum, result_report.all_fail_sum     as result_all_fail_sum, result_report.yd_fail_sum      as result_yd_fail_sum,
	result_report.lt_fail_sum      as result_lt_fail_sum, result_report.cdma_fail_sum    as result_cdma_fail_sum,ent.billing_type, result_report.parent_channel_id  as parent_channel_id 
	from gsms_user u 
	JOIN gsms_user ent on ent.id = u.enterprise_id 
	JOIN gsms_user sale on ent.saleman_id = sale.id 
	LEFT JOIN gsms_capital_account ca on ca.enterprise_id = ent.id 
	join (
		select  sum(all_receiver_sum)  all_receiver_sum, sum(yd_receiver_sum)   yd_receiver_sum, sum(lt_receiver_sum)   lt_receiver_sum, sum(cdma_receiver_sum) cdma_receiver_sum,  sum(invalid_phone_num) invalid_phone_num,
		sum(all_submit_sum)    all_submit_sum, sum(yd_submit_sum)     yd_submit_sum, sum(lt_submit_sum)     lt_submit_sum, sum(cdma_submit_sum)   cdma_submit_sum, sum(all_filter_num)    all_filter_num,
		sum(yd_filter_num)     yd_filter_num, sum(lt_filter_num)     lt_filter_num, sum(cdma_filter_num)   cdma_filter_num, sum(all_send_sum)      all_send_sum, sum(yd_send_sum)       yd_send_sum, sum(lt_send_sum)       lt_send_sum,
		sum(cdma_send_sum)     cdma_send_sum, sum(all_fail_num)      all_fail_num, sum(yd_fail_num)       yd_fail_num, sum(lt_fail_num)       lt_fail_num, sum(cdma_fail_num)     cdma_fail_num, user_id,parent_channel_id, 
		enterprise_id,biz_app_id 
		from sedp_channel_send_report_enterprise_sum  
		where 1=1   AND is_test_period = false   AND stat_date >= '2023-11-01 00:00:00'   AND stat_date<='2023-12-15 23:59:59'   and msg_type in(1,2,4,3)  
		group by user_id,parent_channel_id,  enterprise_id, biz_app_id
	) send_report on send_report.user_id = u.id  
	LEFT JOIN (
		select sum(all_success_sum) as all_success_sum, sum(yd_success_sum)     yd_success_sum, sum(lt_success_sum)     lt_success_sum, sum(cdma_success_sum)   cdma_success_sum, sum(all_fail_sum)       all_fail_sum,
		sum(yd_fail_sum)        yd_fail_sum, sum(lt_fail_sum)        lt_fail_sum, sum(cdma_fail_sum)      cdma_fail_sum, user_id,parent_channel_id, enterprise_id,biz_app_id 
		from sedp_channel_result_report_enterprise_sum  
		where 1=1   AND is_test_period = false   AND stat_date >= '2023-11-01 00:00:00'   AND stat_date<='2023-12-15 23:59:59'   
		group by user_id,parent_channel_id,  enterprise_id, biz_app_id
	) result_report on send_report.user_id = result_report.user_id and send_report.parent_channel_id = result_report.parent_channel_id and send_report.biz_app_id = result_report.biz_app_id 
	left join (   
		SELECT MAX(case when msg_type=1 then price else 0 end)  as sms_price, MAX(case when msg_type=2 then price else 0 end)  as mms_price, MAX(case when msg_type=4 then price else 0 end)  as videosms_price , enterprise_id 
		FROM gsms_account_carrier_price 
		where  capital_account_id IS NULL GROUP BY enterprise_id 
	) acp on acp.enterprise_id = u.enterprise_id  
	where 1 = 1 and sale.user_name!='admin' and (ca.parent_id = 0 or ca.parent_id is null)    
) as origin_table 
GROUP BY ent_billing_type,channel_flag
