<?php

  $host = getenv("DB_HOST");
  $db = getenv("DB_NAME");
  $user = getenv("DB_USER");
  $pwd = getenv("DB_PWD");

  $dbh = false;
  do {
      try {
          $dbh = new PDO("mysql:host={$host};dbname={$db}", $user, $pwd, array( PDO::ATTR_TIMEOUT => 1 ));
      } catch (Exception $e) { sleep(1); }
  } while ($dbh != true);

?>
