package com.github.mname.querydsl.guide.entity;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author <a href="huangzhuojie@wxchina.com">huangzhuojie</a>
 * @date 2023/12/16
 */
@Data
@Entity
@Table(name = "user")
public class User {

    @Id
    private Integer id;

    @Column
    private String name;

    @Column
    private String phone;

}
