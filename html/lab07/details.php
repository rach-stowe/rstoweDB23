<a href="connect.php">Go Back</a><br><br>

<?php // Displays details about selected database.
    $dbhost = 'localhost';
    $dbuser = 'Rachel';
    $dbpass = 'squirtle';
    $conn = new mysqli($dbhost, $dbuser, $dbpass);

    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection. Here is why: "."<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit PHP script if connection fails.
    } 
    else 
    {
        echo "Connected successfully." . "<br>";
?>
        <h1>Database selected: 
            <u><?php echo htmlspecialchars($_POST['name']); ?></u>
        </h1>
        <h2>Tables in <?php echo htmlspecialchars($_POST['name']); ?> database:</h2>
<?php
        $tbllist = "SHOW tables IN ".htmlspecialchars($_POST['name']);
        $result2 = $conn->query($tbllist);
        while ($tblname = $result2->fetch_array()){
            echo $tblname[0]."<br>";
        }
    }
?>