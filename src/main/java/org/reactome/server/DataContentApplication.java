package org.reactome.server;

import org.aspectj.lang.Aspects;
import org.reactome.server.graph.aop.LazyFetchAspect;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;

@SpringBootApplication(scanBasePackages = {"org.reactome.server"})
@EntityScan("org.reactome.server.graph.domain.model")
public class DataContentApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(DataContentApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(DataContentApplication.class, args);
    }

    /**
     * This is needed to get hold of the instance of the aspect which is created outside of the spring container,
     * and make it available for autowiring.
     */
    @Bean
    LazyFetchAspect lazyFetchAspect() {
        return Aspects.aspectOf(LazyFetchAspect.class);
    }
}
