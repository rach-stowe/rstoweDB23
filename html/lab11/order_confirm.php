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

    function result_to_output($result,$orderid) {
        global $conn;
        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
    
        ?><p><?php
        for ($i=0; $i<$num_rows; $i++){ 
            $id = $result_body[$i][0];
            $dishquantity = htmlspecialchars($_POST['dish'.$id]);
            if ($dishquantity >0){
                echo $dishquantity . "x " . $result_body[$i][1];
                ?><br><?php
                for ($j=0; $j<$dishquantity; $j++){
                        $order_dish_query = $conn->prepare("INSERT INTO OrderDishes (DishID, OrderID) VALUES (?, ?);");
                        $order_dish_query->bind_param("ii", $id, $orderid);
                    if(!$order_dish_query->execute()){
                        echo "Failed to add dish to order";
                        exit();
                    } 
                }
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
    $cust_id_query = $conn->prepare("SELECT CustomerID FROM Customers WHERE CustomerEmail = ?;");
    $cust_id_query->bind_param("s", $custemail);
    if(!$cust_id_query->execute()){
        echo "Failed to execute query";
        exit();
    } else {
        $cust_id_result = $cust_id_query->get_result();
        if (!$cust_id_row = $cust_id_result->fetch_assoc()){
            // New customer: insert into database
            $new_cust_query = $conn->prepare("INSERT INTO Customers(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerDefaultLat, CustomerDefaultLong) VALUES (?, ?, ?, ?, ?);");
            $new_cust_query->bind_param("sssdd", $custfirst, $custlast, $custemail, $custlat, $custlon);
            if(!$new_cust_query->execute()){
                ?><h3>Failed to insert new customer</h3><?php
                exit();
            } else {
                $cust_id_query->execute();
                $cust_id_result = $cust_id_query->get_result();
                if(!$cust_id_row = $cust_id_result->fetch_assoc()){
                    echo "Could not fetch customer id";
                    exit();
                }
            }
        }
    }

    $custID = $cust_id_row['CustomerID'];
    $order_query = $conn->prepare("INSERT INTO Orders(FranchiseID, CustomerID, DeliveryLocationLat, DeliveryLocationLon) VALUES (1,?,?,?);");
    $order_query->bind_param("idd", $custID, $custlat, $custlon);
    if(!$order_query->execute()){
        echo "Failed to enter new order";
        exit();
    } 
    $order_id_result = $conn->query("SELECT MAX(OrderID) FROM Orders;");
    $order_id_row = $order_id_result->fetch_assoc();
    $order_id = $order_id_row['MAX(OrderID)'];
    ?>
    <h3>Order #<?php echo  $order_id;?></h3>
    <?php

    // Get all dishes in the order
    if (!$order_res = $conn->query("SELECT * FROM Dishes;")){
        echo "<i>Failed to load menu!</i>\n";
        exit();
    }
    result_to_output($order_res, $order_id);
?>
<a href="robotic_restaurant.php">Return to homepage</a>
</body>