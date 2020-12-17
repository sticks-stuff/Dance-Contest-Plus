<?php
//This file is called with the filename of the song played downloaded song after the user has finished playing (see below)
$_GET["file"];
//Intially I used this to clean up downloaded songs but I've now realised that that's really stupid because
//1) It won't clean up if the user exits the game through non-trackable means i.e closing the web browser
//2) It can muck up if two people are playing the same song and one of them leaves so it gets removed
//3) This can all be accomplished with a cron job
//I've decided to leave this here though just in case someone has a use for it (also I'm lazy)
//You can see my previous implementation in the git history
?> 
