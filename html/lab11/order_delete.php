<?php
    // Show PHP errors
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    // Log in using default credentials
    $config = parse_ini_file('/home/Rachel/mysqli.ini');
    $dbname = 'robo_rest_fall_2023';
    $conn = new mysqli($config['mysqli.default_host'],
                        $config['mysqli.default_user'],
                        $config['mysqli.default_pw'],
                        $dbname);
    
    // Check if user successfully connected to database
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection. Here is why: "."<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit PHP script if connection fails.
    } 
    
    // Which order will be deleted
    $deletion_id = htmlspecialchars($_POST['order_id']);
?>   

<!DOCTYPE html>
<head>
    <title>Order Deletion</title>
</head>
<body>
    <h1>Order Deletion</h1>
    <?php
    $order_deletion = $conn->prepare("SELECT OrderID FROM Orders WHERE OrderID = ?;");
    $order_deletion->bind_param("i", $deletion_id);
    if(!$order_deletion->execute()){
        ?>
        <h3><?php echo "Order #". $deletion_id . " does not exist."?></h3>
        <?php
    } else {
        // Delete order
        $delete_order_query = $conn->prepare("DELETE FROM Orders WHERE OrderID = ?;");
        $delete_order_query->bind_param("i", $deletion_id);
        if(!$delete_order_query->execute()){
            echo "deletion failed.";
            exit();
        }
        ?>
        <h3><?php echo "Order #". $deletion_id . " was successfully deleted."?></h3>
        <?php
    }?>
    <a href="robotic_restaurant.php">Return to homepage</a>
</body>


