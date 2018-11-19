package org.reactome.server.orcid.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang.StringUtils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */

public class PublicationDate {

    @JsonProperty("day")
    private Day day;

    @JsonProperty("month")
    private Month month;

    @JsonProperty("year")
    private Year year;

    public PublicationDate (String dateTime) {
        if (StringUtils.isNotEmpty(dateTime)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
            LocalDate localdateTime = LocalDate.parse(dateTime, formatter);
            this.day = new Day(localdateTime.getDayOfMonth());
            this.month = new Month(localdateTime.getMonthValue());
            this.year = new Year(localdateTime.getYear());
        }
    }

    public Day getDay() {
        return day;
    }

    public void setDay(Day day) {
        this.day = day;
    }

    public Month getMonth() {
        return month;
    }

    public void setMonth(Month month) {
        this.month = month;
    }

    public Year getYear() {
        return year;
    }

    public void setYear(Year year) {
        this.year = year;
    }

    private class Day {
        @JsonProperty("value")
        private Value content;
        Day(int day) {
            this.content = new Value(StringUtils.leftPad(Integer.toString(day), 2, '0'));
        }
        public Value getContent() {
            return content;
        }
        public void setContent(Value content) {
            this.content = content;
        }
    }

    private class Month {
        @JsonProperty("value")
        private Value content;

        Month(int month) {
            this.content = new Value(StringUtils.leftPad(Integer.toString(month), 2, '0'));
        }

        public Value getContent() {
            return content;
        }

        public void setContent(Value content) {
            this.content = content;
        }
    }

    private class Year {
        @JsonProperty("value")
        private Value content;

        Year(int year) {
            this.content = new Value(Integer.toString(year));
        }

        public Value getContent() {
            return content;
        }

        public void setContent(Value content) {
            this.content = content;
        }
    }
}
