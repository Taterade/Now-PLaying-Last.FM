## 	Use Modules 			##
use XML::Simple;
use LWP::Simple;

## 	last.fm home address 	##
## 	change to your own 		##
$home = "http://www.last.fm/user/mimtate";

## 	last.fm feed rss 		##
## 	change to your own 		##
$url = "http://ws.audioscrobbler.com/1.0/user/mimtate/recenttracks.rss";

##	Registering The Script 	##
##	and Commands 			##
Xchat::register("LastFM", "0.1", "A Script to display the latest song listed on your last.fm");
Xchat::hook_command("np", lastfm);
Xchat::hook_command("nps", nowplayingstealth);
Xchat::hook_command("lasthelp", lasthelp);


## 	Text to print when		## 
##	the script is loaded 	## 
sub lastfm_load { 
	Xchat::command("ECHO ---");
	Xchat::command("ECHO Now PLaying LastFM 1.0 by Brian Tate");
	Xchat::command("ECHO Original source by Phill84");
	Xchat::command("ECHO For HELP type /lasthelp");
	Xchat::command("ECHO --- You just lost The Game.");
	return Xchat::EAT_NONE;
}
lastfm_load();

## 	Help 					##
sub lasthelp {
	Xchat::command("ECHO ---");
	Xchat::command("ECHO just type /lastfm, what's so difficult about it?");
	Xchat::command("ECHO ---");
	return Xchat::EAT_NONE;	
}

## 	Main function 			##
sub lastfm {
	my $xml = new XML::Simple;
	my $content = get($url);
	if(!$content) {
		Xchat::command("ECHO Could not retrieve $url");
		return Xchat::EAT_NONE;
	} else {
		my $rss = $xml->XMLin($content);
		##Xchat::command("SAY 10 recent updates on $home"); commented out due to jtvs crazy spam guard
		for ($i = 0; $i < 1; $i ++) {
			my $title = $rss->{channel}->{item}[$i]->{title};
			my $date = $rss->{channel}->{item}[$i]->{pubDate};
			$date =~ s/\+0000//;
			Xchat::command("SAY Now Playing $title");
		}
	}
	return Xchat::EAT_NONE;
}
## stealth now playing
sub nowplayingstealth {
	my $xml = new XML::Simple;
	my $content = get($url);
	if(!$content) {
		Xchat::command("ECHO Could not retrieve $url");
		return Xchat::EAT_NONE;
	} else {
		my $rss = $xml->XMLin($content);
                ##Xchat::command("SAY 10 recent updates on $home"); commented o$
                for ($i = 0; $i < 1; $i ++) {
                        my $title = $rss->{channel}->{item}[$i]->{title};
                        my $date = $rss->{channel}->{item}[$i]->{pubDate};
                        $date =~ s/\+0000//;
                        Xchat::command("ECHO Now Playing $title");
                }
        }
        return Xchat::EAT_NONE;
}

