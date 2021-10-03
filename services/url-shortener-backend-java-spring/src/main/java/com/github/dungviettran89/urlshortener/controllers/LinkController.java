package com.github.dungviettran89.urlshortener.controllers;

import com.github.dungviettran89.urlshortener.entities.LinkEntity;
import com.github.dungviettran89.urlshortener.repositories.LinkRepository;
import com.github.dungviettran89.urlshortener.utils.UrlShortenerUtils;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.Optional;

@RestController
@RequestMapping("/")
public class LinkController {
    @Autowired
    LinkRepository linkRepository;

    @GetMapping("{id}")
    @SneakyThrows
    public void redirect(@PathVariable String id, HttpServletResponse response) {
        Optional<String> url = linkRepository.findById(id).map(LinkEntity::getUrl);
        if (url.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } else {
            response.sendRedirect(url.get());
        }
    }

    @PostMapping("new")
    @ResponseBody
    public ResponseEntity<LinkEntity> newLink(@RequestBody String url) {
        if (!UrlShortenerUtils.valid(url)) {
            return ResponseEntity.badRequest().build();
        }
        LinkEntity link = new LinkEntity();
        link.setId(UrlShortenerUtils.generate());
        link.setUrl(url);
        link.setCreated(new Date());
        return ResponseEntity.ok(linkRepository.save(link));
    }

}
