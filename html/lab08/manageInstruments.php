<?php
    // Display PHP errors
    ini_set('display errors', 1);
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

    echo "Successfully connected to " . $dbname . " database." . "<br>"; 

    $q = "SELECT (instrument_id), (instrument_type), (student_name)
          FROM instruments 
          LEFT OUTER JOIN student_instruments 
          USING (instrument_id)
          LEFT OUTER JOIN students 
          USING (student_id)";
    $result = $conn->query($q);
?> 


<?php

function result_to_html_table($result) {
        // $result is a mysqli result object. This function formats the object as an
        // HTML table. Note that there is no return, simply call this function at the 
        // position in your page where you would like the table to be located.

        $result_body = $result->fetch_all();
        $num_rows = $result->num_rows;
        $num_cols = $result->field_count;
        $fields = $result->fetch_fields();
        ?>
        <form action="deleteFromTable.php" method=POST>
        <!-- Description of table - - - - - - - - - - - - - - - - - - - - -->
        <p>This table has <?php echo $num_rows; ?> rows and <?php echo $num_cols; ?> columns.</p>
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <table>
        <thead>
        <tr>
            <td><b>Delete?</b></td>
        <?php for ($i=0; $i<$num_cols; $i++){ ?>
            <td><b><?php echo $fields[$i]->name; ?></b></td>
        <?php } ?>
        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>
        <?php for ($i=0; $i<$num_rows; $i++){ ?>
            <?php $id = $result_body[$i][0]; ?>
            <tr>    
                <td>
                <input type="checkbox"
                name="checkbox<?php echo $id; ?>"
                value=<?php echo $id; ?>
                />
                </td> 
            <?php for($j=0; $j<$num_cols; $j++){ ?>
                <td><?php echo $result_body[$i][$j]; ?></td>
            <?php } ?>
            </tr>
        <?php } ?>
        </tbody></table>
        <input type="submit" value="Delete Selected Records" method=POST/>
        </form>
<?php } 

result_to_html_table($result);

//Prepare deletion statement
$del_stmt = $conn->prepare("DELETE...");
$del_stmt->bind_param('i', $id);

?>

