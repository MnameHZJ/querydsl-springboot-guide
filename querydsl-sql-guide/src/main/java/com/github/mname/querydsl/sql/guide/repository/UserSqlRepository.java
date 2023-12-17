package com.github.mname.querydsl.sql.guide.repository;

import com.github.mname.querydsl.guide.entity.User;
import com.github.mname.querydsl.guide.sql.entity.QUserSql;
import com.querydsl.core.types.Projections;
import com.querydsl.sql.SQLQueryFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.transaction.Transactional;

/**
 * @author <a href="huangzhuojie@wxchina.com">huangzhuojie</a>
 * @date 2023/12/17
 */
@Component
public class UserSqlRepository {

    @Resource
    private SQLQueryFactory queryFactory;

    @Transactional
    public User getUserById() {
        QUserSql user = QUserSql.user;
        return queryFactory.select(Projections.bean(User.class,
                                                    user.id, user.userName, user.name, user.billingType, user.enterpriseId,
                                                    user.parentId, user.phone))
                           .from(user).fetchFirst();
    }


}
