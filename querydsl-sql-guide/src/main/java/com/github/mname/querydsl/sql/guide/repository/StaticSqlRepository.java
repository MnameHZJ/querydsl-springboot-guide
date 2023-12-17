package com.github.mname.querydsl.sql.guide.repository;

import com.github.mname.querydsl.guide.entity.SedpChannelSendReportEnterpriseSum;
import com.github.mname.querydsl.guide.sql.entity.QSedpChannelSendReportEnterpriseSumSql;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.QBean;
import com.querydsl.sql.SQLQueryFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.Date;

/**
 * @author <a href="huangzhuojie@wxchina.com">huangzhuojie</a>
 * @date 2023/12/18
 */
@Component
public class StaticSqlRepository {

    @Resource
    private SQLQueryFactory queryFactory;

    public void getSumQuery() {
        QSedpChannelSendReportEnterpriseSumSql sum = QSedpChannelSendReportEnterpriseSumSql.sedpChannelSendReportEnterpriseSum;
        Date now = new Date();
        QBean<SedpChannelSendReportEnterpriseSum> sumBean = Projections.bean(SedpChannelSendReportEnterpriseSum.class,
                                                                             sum.allSendSum.sum());
        queryFactory.select(sumBean).from(sum)
                    .where(sum.isTestPeriod.isFalse()
                                           .and(sum.statDate.goe(new Timestamp(now.getTime())))
                                           .and(sum.statDate.loe(new Timestamp(now.getTime())))
                                           .and(sum.msgType.in(1, 2, 3, 4))
                          )
                    .groupBy(sum.userId, sum.parentChannelId, sum.enterpriseId, sum.bizAppId);
    }
}
