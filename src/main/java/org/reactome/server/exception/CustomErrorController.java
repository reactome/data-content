//package org.reactome.server.exception;
//
//import org.springframework.boot.web.servlet.error.ErrorController;
//import org.springframework.http.HttpStatus;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.http.HttpServletRequest;
//
//@Controller
//public class CustomErrorController  implements ErrorController {
//
//    @GetMapping("/error")
//    public String handleError(HttpServletRequest request) {
//        String errorPage = "error"; // default
//
////        <error-page>
////        <error-code>404</error-code>
////        <!--suppress WebProperties -->
////        <location>/WEB-INF/pages/error/404.jsp/pages/common/404.jsp</location>
////    </error-page>
////    <error-page>
////        <error-code>500</error-code>
////        <location>/WEB-INF/pages/error/errorPage.jsp/pages/common/errorPage.jsp</location>
////    </error-page>
////    <error-page>
////        <exception-type>org.springframework.web.bind.MissingServletRequestParameterException</exception-type>
////        <!--suppress WebProperties -->
////        <location>/WEB-INF/pages/error/404.jsp/pages/common/404.jsp</location>
////    </error-page>
////    <error-page>
////        <error-code>400</error-code>
////        <!--suppress WebProperties -->
////        <location>/WEB-INF/pages/error/400.jsp/pages/common/400.jsp</location>
////    </error-page>
//
//        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
//        Object type = request.getAttribute(RequestDispatcher.ERROR_EXCEPTION_TYPE);
//        if (type != null) {
//            System.out.println(type);
//        }
//        if (status != null) {
//            int statusCode = Integer.parseInt(status.toString());
//
//            if (statusCode == HttpStatus.NOT_FOUND.value()) {
//                // handle HTTP 404 Not Found error
//                errorPage = "error/404";
//            } else if (statusCode == HttpStatus.BAD_REQUEST.value()) {
//                // handle HTTP 400 Bad request
//                errorPage = "error/400";
//            } else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
//                // handle HTTP 500 Internal Server error
//                errorPage = "error/500";
//            }
//        }
//
//        return errorPage;
//    }
//
//    @Override
//    public String getErrorPath() {
//        return "/error";
//    }
//}