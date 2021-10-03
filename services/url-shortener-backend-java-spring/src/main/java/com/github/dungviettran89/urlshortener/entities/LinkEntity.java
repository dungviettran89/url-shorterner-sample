package com.github.dungviettran89.urlshortener.entities;

import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Table(name = "java_spring_link_entity")
@Entity
@Data
public class LinkEntity {
    @Id
    private String id;
    @Column(length = 2048)
    private String url;
    private Date created;
}
