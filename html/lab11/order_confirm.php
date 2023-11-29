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

    $custname = htmlspecialchars($_POST['cust_name']);
    $custemail = htmlspecialchars($_POST['cust_email']);
    $custlat = htmlspecialchars($_POST['cust_lat']);
    $custlon = htmlspecialchars($_POST['cust_lon']);

    function result_to_output($result) {
        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
        
        for ($i=0; $i<$num_rows; $i++){ 
            $id = $result_body[$i][0];
            $dishquantity = htmlspecialchars($_POST['dish'.$id]);
            if ($dishquantity >0){
                echo $dishquantity . "x " . $result_body[$i][1];
                ?> <br> <?php
            }
        }
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

    // Get all dishes on the menu
    if (!$menu_res = $conn->query("SELECT * FROM Dishes;")){
        echo "<i>Failed to load menu!</i>\n";
        exit();
    }
    result_to_output($menu_res);
?>
</body>