package com.github.dungviettran89.urlshortener.utils;

import org.hashids.Hashids;

import java.net.URL;

@SuppressWarnings("UnstableApiUsage")
public class UrlShortenerUtils {
    private static Hashids hashids = new Hashids();
    private static long EPOCH = 1633230018096L;
    private static long SEQUENCE = 0L;

    public static String generate() {
        long hash = System.currentTimeMillis() - EPOCH;
        long sequence = SEQUENCE++ % 1024;
        long id = hash << 10 | sequence;
        return hashids.encode(id);
    }

    public static boolean valid(String url) {
        try {
            new URL(url).toURI();
            return url.length() < 2048;
        } catch (Exception e) {
            return false;
        }
    }
}
