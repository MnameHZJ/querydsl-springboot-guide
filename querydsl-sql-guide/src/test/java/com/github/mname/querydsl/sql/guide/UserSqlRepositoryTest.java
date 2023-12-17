package com.github.mname.querydsl.sql.guide;

import com.github.mname.querydsl.guide.entity.User;
import com.github.mname.querydsl.sql.guide.repository.UserSqlRepository;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * @author <a href="huangzhuojie@wxchina.com">huangzhuojie</a>
 * @date 2023/12/17
 */
@SpringBootTest(classes = QuerydslSqlGuideApp.class)
@RunWith(SpringJUnit4ClassRunner.class)
public class UserSqlRepositoryTest {

    @Resource
    private UserSqlRepository userSqlRepository;

    @Test
    public void testGetUserById() {
        User userById = userSqlRepository.getUserById();
        System.out.println(userById);
    }

}
