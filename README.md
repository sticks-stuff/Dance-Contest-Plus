# Dance Contest+
A mod to increase the functionality of Dance Contest

Grab the latest release from the releases section on the right and you should just be able to run the SWF using your flash player or your web browser. Alternatively you can go to https://dance-contest-plus.herokuapp.com and you should just be able to play it right there an then, albeit with a slow load time.

| IF YOU CONTINUALLY GET "Oops! That didn't work!" FOLLOW THE INSTRUCTIONS BELOW |
| ---
| ![Right click > Global Settings...](https://media.discordapp.net/attachments/526586940535865405/778066613890056212/unknown.png) |
| ![Advanced](https://media.discordapp.net/attachments/526586940535865405/778066656412565525/unknown.png) |
| ![Trusted Location Settings...](https://media.discordapp.net/attachments/526586940535865405/778066681264209941/unknown.png) |
| ![Add...](https://media.discordapp.net/attachments/526586940535865405/778066703850274826/unknown.png) |
| ![Add File...](https://media.discordapp.net/attachments/526586940535865405/778066729933996053/unknown.png) |
| ![Choose the SWF you downloaded](https://media.discordapp.net/attachments/526586940535865405/778066777250725928/unknown.png)  |
| Then restart the SWF |

If you want to use this on [CPSC](https://github.com/Thestickman391/CPSC), extract to \play\v2\games\dancing.

If you're a CPPS owner and you don't want to use my herokuapp setup then you are free to clone the repo, put `retrieve_osu!_from_url.php`,`convert_osu!_to_DC.php` and `cleanup.php` somewhere on your webserver and edit and recompile the FLA to point to your webserver instead (this is left as an exercise for the reader). **It is recommended you setup a cron job to clear /tmp/ every so often as songs will only be cleared if the user exits dance contest through pressing the quit button** (this is left as an exercise for the reader).

## Current Features
- Importing osu!mania songs

## Planned Features
- Importing songs to the actual song list, permanently 
- Using the actual osu! api to grab songs
- Auto/Bot mode
- Hyperspeed
- Actually syncing the penguins dancing to the beat of the song
- Not shitty code

## FAQ
### Why doesn't my song work?
The website I am using to grab raw OSZ files from osu! only seems to track songs with leaderboards and a few select others. Supposedly you can grab raw downloads using the osu! API but I tried tinkering around with that a few times and couldn't seem to get anywhere with it.
### Why are you using an external website to download osu! songs?
I am lazy
### Why are you using an external website to convert osu! songs (https://dance-contest-plus.herokuapp.com)?
I wanted people to be able to use this without setting up a local webserver. PHP requires a local webserver to run at all and I thought this made it more accessible. If you *really* want everything to be local you are free to clone the repo, put `retrieve_osu!_from_url.php`,`convert_osu!_to_DC.php` and `cleanup.php` somewhere on your webserver and edit and recompile the FLA to point to `localhost` (this is left as an exercise for the reader).
### Why are you downloading the songs at all? Can't you just read them remotely?
Maybe, but definitely not with AS2
### Why are you using external PHP files to download/convert the songs at all? Can't you do that all inside the game?
In AS3 you can in fact download and extract and read zip and text files and all that. Not in AS2 though, which is what Dance Contest is written in. 
### Can't you run it through an AS3 swf to get access to these features?
I tried that and it had significant performance issues.
### Can't you convert AS2 to AS3?
There's no automatic conversion for that so I'd have to do it manually. See question 2
### Some colours/animation/text positions are messed up compared to the original Dance Contest?
The decompiled FLA I had access to came with these issues and fixing them manually would take quite a long time (see question 2). If you have a correctly decompiled FLA of Dance Contest I would be more than happy to use it however. 
### All the custom text isn't translated into other languages?
I, sadly, only speak english. See question 2 
### You don't actually need to put all of getid3 in your repo?
See question 2
### I encountered a crash/bug!
That's not a question
### I encountered a crash/bug?
Much better
### Why is your code so shit?
See question 2
### Why didn't you package everything into one SWF?
See question 2
### Why are there all the useless `trace`s all over your code?
I added those during development and I can't be bothered to remove them. See question 2
### Why is this titled FAQ despite the fact that no one has asked you any questions?
In this case FAQ stands for "Fully Anticipated Questions"
