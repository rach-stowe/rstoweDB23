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

    $custfirst = htmlspecialchars($_POST['cust_first']);
    $custlast = htmlspecialchars($_POST['cust_last']);
    $custemail = htmlspecialchars($_POST['cust_email']);
    $custlat = htmlspecialchars($_POST['cust_lat']);
    settype($custlat, "float");
    $custlon = htmlspecialchars($_POST['cust_lon']);
    settype($custlon, "float");

    function result_to_output($result) {
        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
    
        ?><p><?php
        for ($i=0; $i<$num_rows; $i++){ 
            $id = $result_body[$i][0];
            $dishquantity = htmlspecialchars($_POST['dish'.$id]);
            if ($dishquantity >0){
                echo $dishquantity . "x " . $result_body[$i][1];
                ?><br><?php
            }
        }
        ?></p><?php
    } 

?>    
<!DOCTYPE html>
<head>
    <title>Order Confirmation</title>
</head>
<body>
    <h1>Order Confirmation</h1>

<?php
    //$orderid = htmlspecialchars($_POST[''])
    //<h2>Your order #<?php echo 

    echo "Thank you, " . $custfirst . " " . $custlast . "!<br><br><?php";
    if(!$cust_id_query = $conn->prepare("SELECT CustomerID FROM Customers WHERE CustomerEmail = ?;")){
        echo "Error preparing statement";
        exit();
    } else {
        if (!$cust_id_query->bind_param("s", $custemail)){
            echo "New Customer";
            ?> <h3>New customer!</h3> <?php
            // New customer: insert into database
            if(!$new_cust_query = $conn->prepare("INSERT INTO Customers(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerDefaultLat, CustomerDefaultLong) VALUES (?, ?, ?, ?, ?);")){
                echo "Error inserting customer";   
                exit();                            
            } else {
                if(!$new_cust_query->bind_param("sssdd", $custfirst, $custlast, $custemail, $custlat, $custlon)){
                    echo "Error binding parameters";
                    exit();
                } else {
                    if(!$cust_id_query = $conn->prepare("SELECT CustomerID FROM Customers WHERE CustomerEmail = ?;")){
                        echo "Error preparing statement";
                        exit();
                    } else {
                        if (!$cust_id_query->bind_param("s", $custemail)){
                            echo "Error binding parameters";
                        }
                    }
                }
            }
        } 
        $cust_id = $cust_id_query->fetch_all();
    }


    if(!$order_query = $conn->prepare("INSERT INTO Orders(FranchiseID, CustomerID, DeliveryLocationLat, DeliveryLocationLon) VALUES (1,?,?,?);")){
        echo "Failed to insert order";
        exit();
    } else {
        if(!$order_query->bind_param("idd", $custID, $custlat, $custlon)){
            echo "Failed to bind parameters";
            exit();
        }
    }

    // Get all dishes in the order
    if (!$order_res = $conn->query("SELECT * FROM Dishes;")){
        echo "<i>Failed to load menu!</i>\n";
        exit();
    }
    result_to_output($order_res);
?>
<a href="robotic_restaurant.php">Return to homepage</a>
</body>