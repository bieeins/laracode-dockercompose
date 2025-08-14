<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PHP Development Environment</title>
  <style>
  body {
    font-family: Arial, sans-serif;
    margin: 40px;
    background: #f4f4f4;
  }

  .container {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }

  h1 {
    color: #333;
  }

  .info {
    background: #e7f3ff;
    padding: 15px;
    border-radius: 5px;
    margin: 20px 0;
  }

  .links a {
    display: inline-block;
    margin: 10px;
    padding: 10px 20px;
    background: #007cba;
    color: white;
    text-decoration: none;
    border-radius: 5px;
  }

  .links a:hover {
    background: #005a87;
  }
  </style>
</head>

<body>
  <div class="container">
    <h1>🐳 Docker Desktop PHP Environment</h1>

    <div class="info">
      <strong>PHP Version:</strong> <?php echo PHP_VERSION; ?><br>
      <strong>Server:</strong> <?php echo $_SERVER['SERVER_SOFTWARE'] ?? 'Unknown'; ?><br>
      <strong>Document Root:</strong> <?php echo $_SERVER['DOCUMENT_ROOT']; ?>
    </div>

    <h2>Available Applications:</h2>
    <div class="links">
      <a href="/laravel/public" target="_blank">Laravel App</a>
      <a href="/codeigniter/public" target="_blank">CodeIgniter App</a>
      <a href="http://localhost:8080" target="_blank">phpMyAdmin</a>
      <a href="http://localhost:8025" target="_blank">Mailhog</a>
    </div>

    <h2>Quick Commands:</h2>
    <pre>