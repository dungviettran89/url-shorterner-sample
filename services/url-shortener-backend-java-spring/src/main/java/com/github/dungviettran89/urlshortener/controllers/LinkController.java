package com.github.dungviettran89.urlshortener.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.dungviettran89.urlshortener.entities.LinkEntity;
import com.github.dungviettran89.urlshortener.repositories.LinkRepository;
import com.github.dungviettran89.urlshortener.utils.LinkUtils;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.Optional;

@RestController
@RequestMapping("/")
@Slf4j
public class LinkController {
    @Autowired
    LinkRepository linkRepository;
    private ObjectMapper objectMapper = new ObjectMapper();

    @GetMapping("{id}")
    @SneakyThrows
    public void redirect(@PathVariable String id, HttpServletResponse response) {
        log.info("GET /{}", id);
        Optional<String> url = linkRepository.findById(id).map(LinkEntity::getUrl);
        if (url.isEmpty()) {
            log.info("GET /{}: NOT_FOUND", id);
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        } else {
            log.info("GET /{}: redirect to {}", id, url.get());
            response.sendRedirect(url.get());
        }
    }

    @PostMapping("new")
    @ResponseBody
    @SneakyThrows
    public ResponseEntity<LinkEntity> newLink(@RequestBody NewLinkRequest newLinkRequest) {
        log.info("POST /new request={}", objectMapper.writeValueAsString(newLinkRequest));
        String url = newLinkRequest.getUrl();
        if (!LinkUtils.valid(url)) {
            log.info("POST /new request={} BAD_REQUEST", objectMapper.writeValueAsString(newLinkRequest));
            return ResponseEntity.badRequest().build();
        }
        LinkEntity link = new LinkEntity();
        link.setId(LinkUtils.generate(url));
        link.setUrl(url);
        link.setCreated(new Date());
        link = linkRepository.save(link);
        log.info("POST /new request={} response={}",
                objectMapper.writeValueAsString(newLinkRequest),
                objectMapper.writeValueAsString(link));
        return ResponseEntity.ok(link);
    }

}
