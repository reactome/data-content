<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>

<c:import url="../header.jsp" />

<div class="favth-col-xs-12">
    <div class="moduletable">
        <div class="custom">
            <div class="favth-container">
                <div class="favth-row">
                    <div class="favth-col-xs-12">
                        <h3>Couldn't get access to your ORCID records</h3>
                        <pre><code>${errorDescription}</code></pre>
                        <h5 class="text-center"> *** This window will close automatically. *** </h5>
                    </div>
                </div>
            </div>
            <p>&nbsp;</p>
        </div>
    </div>
</div>

<script>
jQuery(function(){
    setTimeout(
        function(){
            window.close();
        }, 5000
    );
});
</script>

<c:import url="../footer.jsp" />