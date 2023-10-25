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

    // Check if instruments need to be added
    if (array_key_exists('add', $_POST)){
        $insert = "INSERT INTO instruments (instrument_type)
                    VALUES  ('Guitar'),
                            ('Trumpet'),
                            ('Flute'),
                            ('Theramin'),
                            ('Violin'),
                            ('Tuba'),
                            ('Melodica'),
                            ('Trombone'),
                            ('Keyboard')";
        if(!$conn->query($insert)){
            echo $conn->error;
        } else {
            header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
            exit(); 
        }
    }

    // Prepare query for table
    $q = "SELECT (instrument_id), (instrument_type), (student_name)
          FROM instruments 
          LEFT OUTER JOIN student_instruments 
          USING (instrument_id)
          LEFT OUTER JOIN students 
          USING (student_id)";

    // Get table data
    $result = $conn->query($q);
    $resrows = $result->fetch_all();

    //Prepare deletion statement
    $del_stmt = $conn->prepare("DELETE FROM instruments WHERE instrument_id = ?");
    $del_stmt->bind_param('i', $id);

    // Check if any rows should be deleted
    $deleted = false;
    for($i = 0; $i < $result->num_rows; $i++){
        $id = $resrows[$i][0];
        $key = "checkbox" . $id;
        if (isset($_POST[$key])){
            $deleted = true;
            if(!$del_stmt->execute()){
                echo $conn->error;
            }
        }
    }

    // If rows need to be deleted, reload page
    if($deleted){
        header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
        exit();
    }
    
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
<?php } 

// Show table on page ?>
<form action="manageInstruments.php" method=POST>
<?php 
    $result2 = $conn->query($q);
    result_to_html_table($result2); 
?>
<input name="delete" type="submit" value="Delete Selected Records" method=POST/>
</form>

<?php // Add instruments ?>
<form  method=POST>
<input name="add" type="submit" value="Add Extra Records"/>
</form>






