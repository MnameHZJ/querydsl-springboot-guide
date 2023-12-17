package com.github.mname.querydsl.jpa.guide.singletable;

import com.github.mname.querydsl.guide.entity.QUser;
import com.github.mname.querydsl.guide.entity.User;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * @author <a href="huangzhuojie@wxchina.com">huangzhuojie</a>
 * @date 2023/12/17
 */
@Component
public class UserRepository {

    @Resource
    private JPAQueryFactory jpaQueryFactory;

    public User getUserById(Integer id) {
        QUser user = QUser.user;
        return jpaQueryFactory.selectFrom(user).where(user.id.eq(id)).fetchFirst();
    }
}
