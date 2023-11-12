package com.itbank.component;

public class UtilsComponent {
    public static String truncateString(String str, int len) {
        if (str == null || str.length() <= len) {
            return str;
        }
        return str.substring(0, len) + "...";
    }
}
