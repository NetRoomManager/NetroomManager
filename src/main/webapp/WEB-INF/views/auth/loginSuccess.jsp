<%--
  Created by IntelliJ IDEA.
  User: KgItBank03
  Date: 2023-10-23
  Time: 오후 6:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>

<script type="text/javascript">
    const urlParams = new URLSearchParams(window.location.search);
    const targetUrl = urlParams.get('targetUrl');
    window.opener.location.href = targetUrl;
    window.close();
</script>

</body>
</html>
