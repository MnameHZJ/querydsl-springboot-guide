package com.github.mname.querydsl.jpa.guide.singletable;

import com.github.mname.querydsl.guide.entity.User;
import com.github.mname.querydsl.jpa.guide.QuerydslJpaGuideApp;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

/**
 * @author <a href="huangzhuojie@wxchina.com">huangzhuojie</a>
 * @date 2023/12/17
 */
@SpringBootTest(classes = QuerydslJpaGuideApp.class)
@RunWith(SpringJUnit4ClassRunner.class)
public class UserJpaRepositoryTest {

    @Resource
    private UserRepository userRepository;

    @Test
    public void testGetUser() {
        User user = userRepository.getUserById(1);
        Assert.assertNotNull(user);
        Assert.assertEquals(1L, user.getId().longValue());
    }

}
