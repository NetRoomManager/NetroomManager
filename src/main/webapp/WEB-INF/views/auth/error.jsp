<!DOCTYPE html>
<html>
<!-- 에러 메시지 -->
<head>
    <meta charset="UTF-8">
    <title>Error Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .error-container {
            max-width: 600px;
            margin: 100px auto;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .error-message {
            color: #dc3545;
        }
    </style>
</head>

<body>
    <div class="error-container">
        <h1 class="display-4">Oops!</h1>
        <p class="err_message">Something went wrong on our servers while we were processing your request. We're really sorry
            about this, and will work hard to get this resolved as soon as possible.</p>
        <hr class="my-4">
        <p>Status Code: <span class="err_status_code text-danger">
                <%= response.getStatus() %>
            </span>
        </p>
<%--         <p class="error-message">Exception: <%= exception.getMessage() %> --%>
        </p>
        <p>Please try again later or contact the administrator.</p>
        <a class="btn btn-primary btn-lg" href="${cpath }/" role="button">Go Home</a>
    </div>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>

</html>