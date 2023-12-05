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
?>    
<!DOCTYPE html>
<head>
    <title>Place an Order</title>
</head>
<body>
    
<h1>Welcome to Alice's <code>Robotic</code> Restaurant</h1>
<p>You can <code>grep</code> anything you want from Alice's restaurant.</p>
    
<form action="order_confirm.php" method="POST">
<h2>Place an Order</h2>
<?php
    function result_to_input_table($result) {
        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
        $num_cols = $result->field_count;
        $fields = $result->fetch_fields();
        ?>        
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <table>
        <thead>
        <tr>
            <td><b>Quantity</b></td>
            <td><b>Dish</b></td>
            <td><b>Price</b></td>
        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>
        <?php for ($i=0; $i<$num_rows; $i++){ ?>
            <?php $id = $result_body[$i][0]; ?>
            <tr>    
                <td>
                <input type="number"
                name="dish<?php echo $id; ?>"/>
                </td> 
                <td><?php echo $result_body[$i][1];?></td>
                <td><?php echo $result_body[$i][2];?></td>
            </tr>
        <?php } ?>
        </tbody></table>      
<?php } 

    // Get all dishes on the menu
    if (!$menu_res = $conn->query("SELECT * FROM Dishes;")){
        echo "<i>Failed to load menu!</i>\n";
        exit();
    }
    result_to_input_table($menu_res);
?>

<br>
   
<table>
    <thead>
        <th></th>
    </thead>
    <tbody>
        <!-- First Name -->
        <tr>
            <td style="text-align: right">First Name:</td>
            <td><input type="text" name="cust_first" required/></td>
        </tr>
        <!-- Last Name -->
        <tr>
            <td style="text-align: right">Last Name:</td>
            <td><input type="text" name="cust_last" required/></td>
        </tr>
        <!-- Email -->
        <tr>
            <td style="text-align: right">Email:</td>
            <td><input type="text" name="cust_email" required/></td>
        </tr>
        <!-- Location -->
        <tr>
            <td style="text-align: right">Latitude:</td>
            <td><input type="text" name="cust_lat" pattern="[0-9]+(\.[0-9])?" title="Enter a valid decimal number" required/></td>
        </tr>
        <tr>
            <td style="text-align: right">Longitude:</td>
            <td><input type="text" name="cust_lon" pattern="[0-9]+(\.[0-9])?" title="Enter a valid decimal number" required/></td>
        </tr>
    </tbody>
</table>
<input type="submit" value="Place Order"/>
</form>
    
<h2>Cancel an Order</h2>
<form action="order_delete.php" method="POST">
<table>
    <tbody>
        <!-- Name -->
        <tr>
            <td style="text-align: right">Order ID:</td>
            <td><input type="text" name="order_id"/></td>
        </tr>
</tbody>
</table>
    <input type="submit" value="Delete Order"/>
</form>
    
<h2>Pending Orders</h2>
<?php
    function result_to_html_table($result) {
        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
        $num_cols = $result->field_count;
        $fields = $result->fetch_fields();
        global $conn;
        ?>        
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <table>
        <thead>
        <tr>
        <?php for ($i=0; $i<$num_cols; $i++){ ?>
            <td style="padding:10px"><b><?php echo $fields[$i]->name; ?></b></td>
        <?php } ?>
            <td style="padding:10px"><b>Description</b></td>
            <td style="padding:10px"><b>Cost</b></td>
        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>
        <?php for ($i=0; $i<$num_rows; $i++){ ?>
            <?php $id = $result_body[$i][0]; ?>
            <tr>    
            <?php for($j=0; $j<$num_cols; $j++){ ?>
                <td style="padding:10px"><?php echo $result_body[$i][$j]; ?></td>
            <?php } 
            if (!$descr_query = $conn->query("SELECT COUNT(DishID) AS 'count', DishName AS 'name'
                                              FROM OrderDishes
                                                    INNER JOIN Dishes
                                                    USING (DishID)
                                                    WHERE OrderID = $id
                                                    GROUP BY (DishID);")){
                echo "Failed to load description";  
                exit();                                      
            }
            $descr_result = $descr_query->fetch_all();
            $d_rows = $descr_query->num_rows;
            ?><td style="padding:10px"><?php
            for ($row=0; $row<$d_rows; $row++){
                echo $descr_result[$row][0] . "x " . $descr_result[$row][1];
                if($row+1 != $d_rows){
                    echo ", ";
                }
            }
            ?></td>
            <?php
            if(!$cost_query = $conn->query("SELECT DishPrice
                                              FROM OrderDishes
                                                   INNER JOIN Dishes
                                                   USING (DishID)
                                                   WHERE OrderID=$id;")){
                echo "Failed to load dish prices";
                exit();
            }
            $cost_result = $cost_query->fetch_all();
            $cost_rows = $cost_query->num_rows;
            $total_cost = 0;
            for ($d=0; $d<$cost_rows; $d++){
                $total_cost = $total_cost + $cost_result[$d][0];
            }
            ?>
            <td style="padding:10px"><?php echo $total_cost; ?></td>
            </tr>
        <?php } ?>
        </tbody></table>      
<?php } 
    $order_summary = "SELECT OrderID AS 'Order ID', GROUP_CONCAT(CustomerFirstName, ' ', CustomerLastName) AS 'Name', OrderSubmissionTime AS 'Date and Time'
                        FROM Orders 
                             INNER JOIN Customers 
                             USING (CustomerID) 
                             GROUP BY (OrderID);";
    if (!$orders_res = $conn->query($order_summary)){
        echo "<i>Failed to load orders!</i>\n";
        exit();
    }
    result_to_html_table($orders_res);
?>
</body>
</html>
            