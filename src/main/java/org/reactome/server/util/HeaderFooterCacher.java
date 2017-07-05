package org.reactome.server.util;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;

/**
 * Generates the header and the footer every MINUTES defined below.
 * The header.jsp and footer.jsp are placed under jsp folder in WEB-INF
 *
 * IMPORTANT
 * ---------
 * We assume the war file runs exploded, because there is no way of writing
 * a file in a none-exploded war and the jsp template needs the templates
 * to be in the defined resources to parse the content (and this is used
 * to keep the species and other filtering options)
 *
 * @author Antonio Fabregat <fabregat@ebi.ac.uk>
 */
@Component
public class HeaderFooterCacher extends Thread {
    private static final String TITLE_OPEN = "<title>";
    private static final String TITLE_CLOSE = "</title>";
    private static final String TITLE_REPLACE = "<title>Reactome | ${title}</title>";

    private static final String SEARCH_OPEN = "<!--SearchForm-->";
    private static final String SEARCH_CLOSE = "<!--/SearchForm-->";
    private static final String SEARCH_REPLACE = "<jsp:include page=\"search/searchForm.jsp\"/>";

    // Name of the template page in Joomls
    private static final String TEMPLATE_PAGE = "template-page-v1";

    private static final Integer MINUTES = 15;

    private final String server;

    @Autowired
    public HeaderFooterCacher(@Value("${template.server}") String server) {
        this.server = server;
        start();
    }

    @Override
    public void run() {
       String template = getTemplate();
        //noinspection InfiniteLoopStatement
//        while (true) {
//            writeFile("header.jsp", getHeader());
//            writeFile("footer.jsp", getFooter());
//            try {
//                Thread.sleep(1000 * 60 * MINUTES);
//            } catch (InterruptedException e) {
//                e.printStackTrace();
//            }
//        }

        getHeaderAndFooter(template);

    }

    private synchronized void writeFile(String fileName, String content){
        try {
            //noinspection ConstantConditions
            String path = getClass().getClassLoader().getResource("").getPath();
            //HACK!
            if(path.contains("WEB-INF")) {
                //When executing in a deployed war file in tomcat, the WEB-INF folder is just one bellow the classes
                path += "../pages/";
            }else{
                //When executing in local we need to write the files in the actual resources
                path += "../../src/main/webapp/WEB-INF/pages/";
            }
            FileOutputStream out = new FileOutputStream(path + fileName);
            out.write(content.getBytes());
            out.close();
        } catch (NullPointerException | IOException e){
            e.printStackTrace();
        }
    }

    private String getTemplate() {
        try {
            URL url = new URL(this.server + "/" + TEMPLATE_PAGE);
            String rtn = IOUtils.toString(url.openConnection().getInputStream());

            // Add search form
            rtn = getReplaced(rtn, SEARCH_OPEN, SEARCH_CLOSE, SEARCH_REPLACE);
            rtn = getReplaced(rtn, TITLE_OPEN, TITLE_CLOSE, TITLE_REPLACE);

            // TODO
            rtn = rtn.replace("<base href=\"" + this.server + "/" + TEMPLATE_PAGE + "\" />", "");

            rtn = rtn.replaceAll("(http|https)://", "//");

            return  rtn;
        } catch (IOException e) {
            e.printStackTrace();
            return String.format("<span style='color:red'>%s</span>", e.getMessage());
        }
    }

    private void getHeaderAndFooter(String file) {
        String html = "";
        String[] lines = file.split(System.getProperty("line.separator"));

        boolean isHeaderLine = true;
        for (String line : lines) {
            html += line + "\n";

            if(isHeaderLine) {
                if (line.contains("search-placeholder")) {
                    isHeaderLine = false;
                    writeFile("header-n.jsp", html);
                    html = "";
                }
            }
        }

        //writeFile("header.jsp", header);
        writeFile("footer-n.jsp", html);
    }

    private String getHeader() {
        try {
            URL url = new URL(this.server + "common/header.php");
            String rtn = IOUtils.toString(url.openConnection().getInputStream());
            rtn = getReplaced(rtn, TITLE_OPEN, TITLE_CLOSE, TITLE_REPLACE);
            rtn = getReplaced(rtn, SEARCH_OPEN, SEARCH_CLOSE, SEARCH_REPLACE);
            rtn = rtn.replaceAll("(http|https)://", "//");
            return  rtn;
        } catch (IOException e) {
            e.printStackTrace();
            return String.format("<span style='color:red'>%s</span>", e.getMessage());
        }
    }

    private String getReplaced(String target, String open, String close, String replace){
        try {
            String pre = target.substring(0, target.indexOf(open));
            String suf = target.substring(target.indexOf(close) + close.length(), target.length());
            return pre + replace + suf;
        }catch (StringIndexOutOfBoundsException e){
            return target;
        }
    }

    private String getFooter() {
        try {
            URL url = new URL(this.server + "common/footer.php");
            String rtn = IOUtils.toString(url.openConnection().getInputStream());
            rtn = rtn.replaceAll("(http|https)://", "//");
            return rtn;
        } catch (IOException e) {
            e.printStackTrace();
            return String.format("<span style='color:red'>%s</span>", e.getMessage());
        }
    }

}
