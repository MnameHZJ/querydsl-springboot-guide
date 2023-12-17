package com.github.mname.querydsl.jpa.guide.config;

import com.querydsl.jpa.impl.JPAQueryFactory;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * JPA配置
 */
@Configuration
@EnableTransactionManagement
@EntityScan("com.github.mname.querydsl.guide.entity")
public class JpaConfig {

    @PersistenceContext
    private EntityManager em;

    /**
     * queryDsl语句操作工厂类
     */
    @Bean("jpaQueryFactory")
    public JPAQueryFactory getJPAQueryFactory() {
        return new JPAQueryFactory(em);
    }

}
