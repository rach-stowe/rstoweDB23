<?php
    // Display PHP errors
    ini_set('display errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    // Allow existing user to connect to database
    /*
    $dbhost = 'localhost';
    $dbuser = 'Rachel';
    $dbpass = 'squirtle';
    $conn = new mysqli($dbhost, $dbuser, $dbpass);
    */

    // TEST: log in using default credentials
    $config = parse_ini_file('/home/Rachel/mysqli.ini');
    $conn = new mysqli($config['mysqli.default_host'],
                       $config['mysqli.default_user'],
                       $config['mysqli.default_pw']);

    // Check if user successfully connected to database
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection. Here is why: "."<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit PHP script if connection fails.
    } 
    else 
    {
        echo "Connected successfully!" . "<br>";
        echo "YAY!" . "<br>"; 
?>
        <h1> Available Databases:</h1>
<?php
    }

    // Display the names of all databases
    $dblist = "SHOW databases";
    $result = $conn->query($dblist);
    while ($dbname = $result->fetch_array()){
        echo $dbname['Database']."<br>";
    }

    // Close the connection
    $conn->close();
?>

<!-- Form for learning about a database -->
<h2>Enter the name of one of the databases to learn more about it:</h2>
<form action="details.php" method="post">
    <label for="name">Database name:</label>
    <input name="name" id="name" type="text">
    <button type="submit">See Details</button>
</form>
