<?php
include "functions.php";
main_header( 'Edit User Profile' );

if ( !$uid ) {
	print '<p style="color:red;">You don\'t appear to be logged in.</p>';
	main_footer();
	exit;
}

if ( $submitted ) {
	if ( $pass1 != $pass2 ) {
		print '<p style="color:red;">Your password fields did not match.</p>';
	} else {
		$query = "update users set email='$email'";
		if ( $pass1 ) $query .= ",password='$pass1'";
		$query .= " where uid=$uid";
		$result = mysql_query( $query );
		print '<p style="color:red;">Change(s) committed.</p>';
	}
}

$dude = mysql_query( "select * from users where uid=$uid" );
$dude = mysql_fetch_array( $dude );

// are we leader?
$result = mysql_query( 'select leader from teams where gid='.$dude['team'] );
list( $leader ) = mysql_fetch_row( $result );
if ( $leader == $uid ) $leader='Yes'; else $leader='No';
?>

<p style="font-size:medium;font-weight:bold;"><?=$dude['username'];?> Profile</p>

<form action="profileedit.php" method="post">
<table border=0 cellpadding=2 cellspacing=0>
<tr>
	<td align="right"><b>Username:</b></td>
	<td><?=$dude['username'];?></td>
</tr>
<tr>
	<td align="right"><b>Password:</b></td>
	<td><input type="password" name="pass1"><br><input type="password" name="pass2"></td>
	<td><p>Type in a password twice to change</p></td>
</tr>
<tr>
	<td align="right"><b>Title:</b></td>
	<td><?=$dude['title'];?></td>
</tr>
<tr>
	<td align="right"><b>Email:</b></td>
	<td><input type="input" name="email" value="<?=$dude['email'];?>"></td>
</tr>
<tr>
	<td align="right"><b>Team:</b></td>
	<td><?=team_num_name( $dude['team'] );?></td>
</tr>
<tr>
	<td align="right"><b>Team Leader:</b></td>
	<td><?=$leader;?></td>
</tr>
</table>
<input type="hidden" name="submitted" value="1">
<p><input type="submit" value="Submit Changes"></p>
</form>

<?php
main_footer();
?>
