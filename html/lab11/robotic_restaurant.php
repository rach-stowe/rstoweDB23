<?php
    // Show PHP errors
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    // Log in using default credentials
    $config = parse_ini_file('/home/Rachel/mysqli.ini');
    $dbname = 'instrument_rentals';
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
<h2>Menu</h2>
?php
    if (!$menu_res = $conn->query(file_get_contents($sql_path . "select_menu_items.sql"))){
        echo "<i>Failed to load menu!</i>\n";
        exit();
    }
    result_to_input_table($menu_res);
?>
   
<table>
    <thead>
        <th></th>
    </thead>
    <tbody>
        <!-- Name -->
        <tr>
            <td style="text-align: right">Name:</td>
            <td><input type="text" name="cust_name" required/></td>
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
    if (!$orders_res = $conn->query(file_get_contents($sql_path . "select_pending_orders.sql"))){
        echo "<i>Failed to load orders!</i>\n";
        exit();
    }
    result_to_html_table($orders_res);
?>
</body>
</html>
            