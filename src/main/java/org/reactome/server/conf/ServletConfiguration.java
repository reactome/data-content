package org.reactome.server.conf;

import org.reactome.server.utils.proxy.ProxyServlet;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import java.util.Map;

@Configuration
@PropertySource("classpath:core.properties")
public class ServletConfiguration {

    @Value("${proxy.host}")
    private String proxyHost;

    @Bean
    public ServletRegistrationBean<ProxyServlet> contentServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/content/*");
        bean.setName("Content");
        bean.setInitParameters(Map.of(
                "proxyHost", "localhost",
                "proxyPort", "8484",
                "proxyPath", "/")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> iconServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/icon/*");
        bean.setName("IconLibrary");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/icon")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> pluginsServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/plugins/*");
        bean.setName("Plugins");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/plugins")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> mediaServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/media/*");
        bean.setName("Media");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/media")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> templatesServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/templates/*");
        bean.setName("Templates");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/templates")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> modulesServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/modules/*");
        bean.setName("Modules");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/modules")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> pathwayBrowserServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/PathwayBrowser/*");
        bean.setName("PathwayBrowser");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/PathwayBrowser/")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> contentServiceServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/ContentService/*");
        bean.setName("ContentService");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/ContentService/")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> reactomeRESTfulAPIServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/ReactomeRESTfulAPI/RESTfulWS/*");
        bean.setName("ReactomeRESTfulAPI");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/ReactomeRESTfulAPI/RESTfulWS")
        );
        return bean;
    }

    @Bean
    public ServletRegistrationBean<ProxyServlet> downloadServletBean() {
        ServletRegistrationBean<ProxyServlet> bean = new ServletRegistrationBean<>(new ProxyServlet(), "/download/current/*");
        bean.setName("Download");
        bean.setInitParameters(Map.of(
                "proxyHost", this.proxyHost,
                "proxyPort", "80",
                "proxyPath", "/download/current/")
        );
        return bean;
    }
}
