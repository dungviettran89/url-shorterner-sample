package com.github.dungviettran89.urlshortener;

import com.github.dungviettran89.urlshortener.utils.LinkUtils;
import org.junit.jupiter.api.Test;

public class LinkUtilsTest {
    @Test
    void testGenerateId() {
        System.out.println(LinkUtils.generate("https://www.google.com/"));
        System.out.println(LinkUtils.generate("https://www.netflix.com/"));
    }
}
