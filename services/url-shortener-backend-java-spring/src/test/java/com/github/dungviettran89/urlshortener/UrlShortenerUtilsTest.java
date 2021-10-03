package com.github.dungviettran89.urlshortener;

import com.github.dungviettran89.urlshortener.utils.UrlShortenerUtils;
import org.junit.jupiter.api.Test;

public class UrlShortenerUtilsTest {
    @Test
    void testGenerateId() {
        System.out.println(UrlShortenerUtils.generate());
        System.out.println(UrlShortenerUtils.generate());
    }
}
