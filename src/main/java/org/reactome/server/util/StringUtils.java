package org.reactome.server.util;

import java.util.Arrays;
import java.util.function.Function;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class StringUtils {
    private static Pattern camelPattern = Pattern.compile("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])");

    public static String capitalize(String toCapitalize) {
        return toCapitalize.substring(0, 1).toUpperCase() + toCapitalize.substring(1);
    }

    public static String[] splitCamelCase(String camelCaseString) {
        return camelPattern.split(camelCaseString);

    }

    public static String camelCaseToSpaces(String camelCaseString) {
        return String.join(" ", splitCamelCase(camelCaseString));
    }

    public static String camelCaseToSpaces(String camelCaseString, Function<String, String> toApply) {
        return Arrays.stream(splitCamelCase(camelCaseString)).map(toApply).collect(Collectors.joining(" "));
    }

    public static String camelCaseToSpaces(String camelCaseString, Function<String, String> toApplyOnFirstWord, Function<String, String> toApplyOnOtherWords) {
        String[] words = splitCamelCase(camelCaseString);
        return toApplyOnFirstWord.apply(words[0]) + " " +
                Arrays.stream(words).skip(1).map(toApplyOnOtherWords).collect(Collectors.joining(" "));
    }
}
