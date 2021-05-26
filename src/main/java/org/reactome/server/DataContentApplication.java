package org.reactome.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication(scanBasePackages = {"org.reactome.server"})
@EntityScan("org.reactome.server.graph.model")
public class DataContentApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(DataContentApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(DataContentApplication.class, args);
    }
}
