package com.github.dungviettran89.urlshortener.repositories;

import com.github.dungviettran89.urlshortener.entities.LinkEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LinkRepository extends CrudRepository<LinkEntity, String> {
}
