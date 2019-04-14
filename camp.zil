"CAMP"

<ROUTINE GET-LOST-FCN ("AUX" (OFFS -3))
	 <COND (<NOT <GETP ,HERE ,P?ENDLESS>>
		<RFALSE>)>
	 <REPEAT ()
		 <SET OFFS <+ .OFFS 3>>
		 <COND (<G? .OFFS 54>
			<RETURN>)
		       (T
			<COND (<EQUAL? ,HERE <GET ,MAP-TBL .OFFS>>
			       <SETG SECS-LON <GET ,MAP-TBL <+ .OFFS 1>>>
			       <SETG SECS-LAT <GET ,MAP-TBL <+ .OFFS 2>>>)>)>>
	 <SETG DEGS-LON 32>
	 <SETG DEGS-LAT 24>
	 <SETG MINS-LON 12>
	 <SETG MINS-LAT 11>
	 <SETG DESERT-LOC <GETP ,HERE ,P?ENDLESS>>
	 <CHANGE-DESERT-POSITION>
	 <FCLEAR ,ENDLESS-DESERT ,TOUCHBIT>
	 <RETURN ,ENDLESS-DESERT>>

<OBJECT NASTY-CROC
	(IN RIVER-BANK)
	(DESC "crocodile")
	(FLAGS NDESCBIT TOUCHBIT DONTTAKE)
	(SYNONYM CROC CROCS CROCOD REPTIL)
	(ACTION CROC-FCN)>

<ROUTINE CROC-FCN ()
	 <COND (<AND <EQUAL? ,PRSI ,NASTY-CROC>
		     <VERB? THROW>>
		<PERFORM ,V?PUT ,PRSO ,NILE-RIBBAH>
		<RTRUE>)>> 

<OBJECT NILE-RIBBAH
	(IN RIVER-BANK)
	(DESC "Nile")
	(FLAGS NDESCBIT TOUCHBIT CONTBIT OPENBIT DONTTAKE)
	(CAPACITY 1000)
	(SYNONYM RIVER NILE)
	(ACTION GET-WET-FCN)>

<ROUTINE GET-WET-FCN ()
	 <COND (<VERB? THROUGH>
		<PERFORM ,V?SWIM ,NILE-RIBBAH>
		<RTRUE>)
	       (<VERB? DROP>
		<PERFORM ,V?LEAVE>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL "Hmmm. Looks potable. And dangerous." CR>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)
	       (<AND <PRSO? ,NILE-RIBBAH>
		     <VERB? DRINK>>
		<PERFORM ,V?DRINK-FROM ,PRSO>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSI ,NILE-RIBBAH>
		     <VERB? PUT>>
		<COND (<EQUAL? ,PRSO ,WINNER>
		       <PERFORM ,V?SWIM>
		       <RFATAL>)
		      (T
		       <REMOVE ,PRSO>
		       <SETG P-IT-LOC <>>
		       <TELL "The " D ,PRSO " quickly ">
		       <COND (<HEAVY?>
			      <TELL "sinks">)
			     (T <TELL "floats away on the current">)>
		       <TELL
". Another example of your fine management abilities." CR>
		       <RTRUE>)>)>>

<ROUTINE HEAVY? ("OPTIONAL" (OBJ <>))
	 <COND (<NOT .OBJ>
		<SET OBJ ,PRSO>)>
	 <COND (<OR <EQUAL? .OBJ ,FOLDED-COT ,BROKEN-LOCK ,ROCK>
		    <EQUAL? .OBJ ,STONE-KEY ,PICK-AXE ,SHOVEL>
		    <EQUAL? .OBJ ,ROPE ,CRATE ,BLACK-BOX>
		    <EQUAL? .OBJ ,TORCH ,OIL-JAR>
		    <GETP .OBJ ,P?BRICK>>
		<RTRUE>)
	       (<AND <EQUAL? .OBJ ,KNAPSACK>
		     <G? <WEIGHT ,KNAPSACK> 15>>
		<RTRUE>)
	       (T
		<RFALSE>)>>
		    
<OBJECT THICKETS
	(IN LOCAL-GLOBALS)
	(DESC "thicket")
	(FLAGS NDESCBIT DONTTAKE)
	(SYNONYM THICKE)
	(TEXT
"They're about as yielding as you were with your helpers. What else can I say
about them?")>
	 
<OBJECT FIREPIT
	(IN FIRE)
	(FLAGS NDESCBIT TOUCHBIT CONTBIT OPENBIT DONTTAKE TRANSBIT)
	(DESC "pit")
	(SYNONYM PIT)
	(ADJECTIVE CHARRE)
	(CAPACITY 200)
	(ACTION FIREPIT-FCN)>

<OBJECT ROCK
	(IN FIRE)
	(FLAGS NDESCBIT TAKEBIT)
	(DESC "blackened rock")
	(SYNONYM ROCK STONE)
	(ADJECTIVE BLACKE)
	(ACTION TAKE-ROCK-FCN)>

<ROUTINE TAKE-ROCK-FCN ()
	 <COND (<VERB? TAKE>
		<FCLEAR ,ROCK ,NDESCBIT>
		<PUTP ,MATCHES ,P?FDESC
"Sitting by the firepit is a matchbook.">
		<RFALSE>)>>

<ROUTINE FIREPIT-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>)
	       (<VERB? THROUGH>
		<TELL "There's no need to get yourself all dirty." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "The pit's just a pit. Nothing more. ">
		<COND (<FIRST? ,PIT>
		       <TELL "Sitting in the pit is ">
		       <PRINT-CONTENTS ,PIT>)
		      (T
		       <TELL "The pit is empty">)>
		<TELL "." CR>
		<RTRUE>)>>

<OBJECT TENT-OBJ
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT TOUCHBIT DONTTAKE)
	(DESC "tent")
	(SYNONYM TENT)
	(ADJECTIVE YOUR SUPPLY WORK)
	(ACTION ENTER-TENT-FCN)>

<ROUTINE ENTER-TENT-FCN ()
	 <COND (<AND <VERB? DROP DISEMBARK>
		     <PRSO? ,TENT-OBJ>
		     <IN-A-TENT?>>
		<PERFORM ,V?LEAVE>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,P2 ,P4 ,P7>
		       <RFALSE>)
		      (<IN-A-TENT?>
		       <TELL
"Looks like a canvas tent to me." CR>
		       <RTRUE>)
		      (<NOT <GETP ,HERE ,P?MAP>>
		       <TELL "Get serious." CR>
		       <RTRUE>)
		      (T <TELL "I can't see it from here!" CR>)>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?LOOK-INSIDE ,FLAPS>
		<RTRUE>)
	       (<VERB? LAMP-ON>
		<TELL "I don't think that striking the tent would do any good." CR>
		<RTRUE>)
	       (<NOT <VERB? THROUGH BOARD>>
		<RFALSE>)
	       (<NOT <GETP ,HERE ,P?MAP>>
		<TELL "Get serious." CR>
		<RTRUE>)
	       (<IN-A-TENT?>
		<TELL 
"What are those canvas walls around you? Just where do you think you are? Maybe
I should send for Craige, eh?" CR>
		<RTRUE>)
	       (<EQUAL? ,HERE ,P2 ,P7 ,P4>
		<PERFORM ,V?ENTER>
		<RTRUE>)
	       (ELSE
		<TELL "You can't enter the tent from here." CR>
		<RTRUE>)>>

<OBJECT PYRAMID
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "pyramid")
	(SYNONYM PYRAMI)
	(ACTION ENTER-PYRAMID-FCN)>

<ROUTINE ENTER-PYRAMID-FCN ()
	 <COND (<AND <VERB? DROP>
		     <EQUAL? ,HERE ,CHAMBER-OF-RA>>
		<PERFORM ,V?LEAVE>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<AND <NOT ,PYRAMID-OPENED>
			    <IN? ,ROCK-LOCK ,HERE>>
		       <TELL
"There's not much to see of it yet -- just the tip of it is exposed showing the
block and its small opening." CR>)
		      (<AND ,PYRAMID-OPENED
			    <EQUAL? ,HERE ,EX8>>
		       <TELL 
"You can see down into what looks like a large chamber." CR>)
		      (<GETP ,HERE ,P?MAP>
		       <TELL "You can't see any pyramid here." CR>)
		      (T
		       <TELL "Where do you think you are, Times Square?" CR>)>
		<RTRUE>)
	       (<AND <VERB? OPEN> <NOT ,PYRAMID-OPENED> <IN? ,ROCK-LOCK ,HERE>>
		<TELL "The stone blocks don't move." CR> <RTRUE>)
	       (<VERB? OPEN> <TELL "It looks open to me." CR> <RTRUE>)
	       (<AND <EQUAL? ,PYRAMID ,PRSI>
		     <EQUAL? ,HERE ,EX8>
		     <VERB? PUT THROW>
		     ,PYRAMID-OPENED>
		<TELL "You hear the " D ,PRSO " fall down below." CR>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<COND (<EQUAL? ,PRSO ,KNAPSACK>
		       <FCLEAR ,PRSO ,WEARBIT>
		       <FSET ,PRSO ,OPENBIT>)>
		<MOVE ,PRSO ,CHAMBER-OF-RA>
		<RTRUE>) 
	       (<NOT <VERB? THROUGH>>
		<RFALSE>)
	       (<NOT <GETP ,HERE ,P?MAP>>
		<TELL "Get serious. Let's find it first." CR>
		<RTRUE>)
	       (<EQUAL? ,HERE ,EX8>
		<PERFORM ,V?ENTER>
		<RTRUE>)
	       (ELSE
		<TELL "You can't enter the pyramid from here." CR>
		<RTRUE>)>>

<ROOM RIVER-BANK
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "River Bank")
      (LDESC
"You are on the bank of the river Nile. The shoreline is sandy and cool, and
reeds wave in a light but warm breeze. Directly to the north and the south
thickets make strolling along the bank impossible. You're hot, and the cool
rippling water to the west looks inviting, but you're not alone in that
thought -- crocodiles bask on the west bank, eyeing you hungrily, just
waiting for you to enter their watery domain. Things were never like this when
Craige was around.")
      (EAST TO P1)
      (NORTH "The thickets chew on your skin as you attempt to make a path through them. You finally give up.")
      (SOUTH "The thickets chew on your skin as you attempt to make a path through them. You finally give up.")
      (WEST "Can't you see the crocs? If you insist on entering the water, you'll have to swim.")
      (NW "Can't you see the crocs? If you insist on entering the water, you'll have to swim.")
      (SW "Can't you see the crocs? If you insist on entering the water, you'll have to swim.")
      (OUT TO P1)
      (MAP 1)
      (GLOBAL TENT-OBJ SAND HOLE GLOBAL-WATER THICKETS)
      (CAPACITY 0)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM P1
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Near the Nile")
      (LDESC
"You are on an east/west path on the north side of the encampment. A path to
the south starts here, and you can see the riverbank clearly to the west. A
warm, light breeze reaches your face, drying your sweat into a thin mask of
salt. You glance to the north and are greeted by a disheartening sight: an
endless stretch of searing desert.")
      (NORTH PER GET-LOST-FCN)
      (NE PER GET-LOST-FCN)
      (NW PER GET-LOST-FCN)
      (WEST TO RIVER-BANK)
      (EAST TO P2)
      (SOUTH TO P4)
      (SE TO FIRE)
      (SW "Some thickets near the river chew on your skin as you attempt to make a path through them. You finally give up.")
      (MAP 2)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 1)
      (ENDLESS 651)
      (ACTION CREATE-THIRST-FCN)>

<ROOM P2
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Outside Your Tent")
      (LDESC
"You are on an east/west path on the north side of the encampment. To the south
you can see a firepit and to the north is the entrance to your tent. Everything
is oddly quiet, unsettling, creating a feeling of floating anxiety. The
stillness seems to enhance the eerie quality of the desert, the feeling of
being truly alone.")
      (NORTH TO TENT)
      (IN TO TENT)
      (WEST TO P1)
      (EAST TO P3)
      (NW PER GET-LOST-FCN)
      (NE PER GET-LOST-FCN)
      (SW TO P4)
      (SE TO P5)
      (SOUTH TO FIRE)
      (MAP 3)
      (GLOBAL TENT-OBJ SAND HOLE FLAPS)
      (CAPACITY 3)
      (ENDLESS 652)
      (ACTION CREATE-THIRST-FCN)>

<ROOM TENT
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Your Tent")
      (LDESC
"You are in your tent. Golden rays of the sun filter through the open tent
flaps on the southern wall, but no breeze makes its way through. The dry,
searing heat in the tent would be bearable if only the air stirred, even a
little.")
      (SOUTH TO P2)
      (OUT TO P2)
      (MAP 4)
      (GLOBAL TENT-OBJ SAND HOLE FLAPS)
      (CAPACITY 0)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM P3
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Northern Path")
      (LDESC
"You are on an east/west path on the northern side of the encampment. To the
east you can see the sites of previous excavations your workers had
begun before they deserted you. Low, gentle sand dunes roll out of sight to
the north, but your camp's eastern border has a path, heading off to the south,
which starts here.")
      (NORTH PER GET-LOST-FCN)
      (NW PER GET-LOST-FCN)
      (NE PER GET-LOST-FCN)
      (EAST TO EX1)
      (SE TO EX4)
      (SOUTH TO P5)
      (SW TO FIRE)
      (WEST TO P2)
      (MAP 1)
      (ACTION CREATE-THIRST-FCN)
      (GLOBAL TENT-OBJ SAND HOLE)
      (ENDLESS 653)
      (CAPACITY 2)>

<ROOM SUPPLY-TENT
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Supply Tent")
      (LDESC
"You are in a tent, very much like your own -- a tent which had originally
contained the supplies for your expedition. You notice, however, that most of
the items which were here just yesterday have vanished with your workers. The
tent looks as if it's been cleaned out and, as your stomach growls, the empty
tent ironically reminds you of a turkey carcass picked clean after a huge
Thanksgiving meal. Through the open tent flaps to the east you can see the
firepit. If only one of the workers had remained behind, you would make him
pay.")
      (EAST TO P4)
      (OUT TO P4)
      (MAP 1)
      (GLOBAL TENT-OBJ SAND HOLE FLAPS)
      (CAPACITY 0)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM P4
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Outside Supply Tent")
      (LDESC
"You're on a north/south path on the west edge of the encampment. Directly to
the west is the supply tent, its flaps open, still in the hot, quiet air. To
the east you can see the central firepit, a reminder of your being alone. A row
of thickets, impossible to make any progress through even with a machete,
grows along the western edge of the camp directly to the north and south of the
tent.")
      (NORTH TO P1)
      (NE TO P2)
      (NW "The thickets chew on your skin as you attempt to make a path through them. You finally give up.")
      (SW "The thickets chew on your skin as you attempt to make a path through them. You finally give up.")
      (WEST TO SUPPLY-TENT)
      (IN TO SUPPLY-TENT)
      (SOUTH TO P6)
      (EAST TO FIRE)
      (SE TO P7)
      (MAP 1)
      (ACTION CREATE-THIRST-FCN)
      (GLOBAL TENT-OBJ SAND HOLE FLAPS THICKETS)
      (CAPACITY 1)>
      
<ROOM FIRE
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Fire Pit")
      (LDESC
"You are in the center of the encampment, standing before a charred pit, a hole
dug in the sand surrounded by blackened rocks. The night breezes have already
started the reclamation work of the desert, covering most of the pit's bottom.
You can see your tent to the north, the work tent to the south, and the supply
tent to the west. Far off to the east, through the heat waves rising off the
shifting sands, you can see gentle, rolling dunes.")
      (NORTH TO P2)
      (NE TO P3)
      (EAST TO P5)
      (SE TO P8)
      (SOUTH TO P7)
      (SW TO P6)
      (WEST TO P4)
      (NW TO P1)
      (MAP 1)
      (ACTION CREATE-THIRST-FCN)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 0)>

<OBJECT ROCK-S
	(IN FIRE)
	(FLAGS DONTTAKE NDESCBIT TRYTAKEBIT)
	(DESC "blackened rocks")
	(SYNONYM ROCKS)
	(ADJECTIVE BLACKE)
	(TEXT "They form a ring around the firepit.")>

<ROOM P5
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Middle Path")
      (LDESC
"You are at the eastern edge of an east/west path in the middle of the camp.
To the west you can see the firepit and beyond that the supply tent. To the
east you can see the desert -- a vista difficult to avoid seeing from just
about anywhere in the camp. A north/south path intersects here, traveling along
the eastern border of the camp.")
      (NORTH TO P3)
      (NE TO EX1)
      (EAST TO EX4)
      (SE TO EX7)
      (SOUTH TO P8)
      (SW TO P7)
      (WEST TO FIRE)
      (NW TO P2)
      (MAP 2)
      (ACTION CREATE-THIRST-FCN)
      (ENDLESS 706)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 4)>

<ROOM P6
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Southern Path")
      (LDESC
"You are at the west edge of an east/west path on the southern side of the
encampment. Directly to the west is a heavy growth of thickets, making any
attempt at western movement a painful and futile task. Through the thickets you
can hear the sound of water running gently by.")
      (NORTH TO P4)
      (NE TO FIRE)
      (EAST TO P7)
      (SE PER GET-LOST-FCN)
      (SOUTH PER GET-LOST-FCN)
      (SW PER GET-LOST-FCN)
      (WEST "You scratch yourself on the thickets as you attempt this.")
      (NW "You scratch yourself on the thickets as you attempt this.")
      (MAP 2)
      (ACTION CREATE-THIRST-FCN)
      (GLOBAL TENT-OBJ SAND HOLE THICKETS)
      (ENDLESS 751)
      (CAPACITY 0)>

<ROOM P7
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Outside Work Tent")
      (LDESC
"You are on an east/west path, directly to the north of the work tent. To the
north you can see the firepit and, beyond that, your tent. The work tent
borders an endless vista of fine, burning sand stretching out to the south.")
      (NORTH TO FIRE)
      (NE TO P5)
      (EAST TO P8)
      (SE PER GET-LOST-FCN)
      (SOUTH TO TENT2)
      (SW PER GET-LOST-FCN)
      (WEST TO P6)
      (NW TO P4)
      (IN TO TENT2)
      (MAP 2)
      (ACTION CREATE-THIRST-FCN)
      (GLOBAL TENT-OBJ SAND HOLE FLAPS)
      (ENDLESS 752)
      (CAPACITY 1)>

<ROOM P8
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Southern Path")
      (LDESC
"You are at the start of a path which heads north along the eastern border of
the encampment. To the east you can see the horror and the beauty which brought
you here, the desert sand and its hidden treasure. The firepit is visible to
the northwest.")
      (NORTH TO P5)
      (NE TO EX4)
      (EAST TO EX7)
      (SE PER GET-LOST-FCN)
      (SOUTH PER GET-LOST-FCN)
      (SW PER GET-LOST-FCN)
      (WEST TO P7)
      (NW TO FIRE)
      (MAP 2)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 2)
      (ENDLESS 753)
      (ACTION CREATE-THIRST-FCN)>

<ROOM TENT2
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Work Tent")
      (LDESC "You are in a tent which used to house the workers and
their personal effects. Looking around, taking in the stripped and bare
surroundings, you feel surprised that they even left the canvas walls.
You quickly realize that they took what they needed -- taking everything
would have been more trouble than it was worth. From the looks of things
they cleared out quickly but quietly.")
      (NORTH TO P7)
      (OUT TO P7)
      (GLOBAL TENT-OBJ SAND HOLE FLAPS)
      (CAPACITY 0)
      (MAP 2)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROUTINE CREATE-THIRST-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SETG THIRST <+ ,THIRST 6>>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-BEG>
		<SETG THIRST <+ ,THIRST 1>>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<DESCRIBE-HOLE-FCN ,M-LOOK>)>>

<ROOM EX1             
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are in the broiling sands of the desert, a short distance from the camp.
Off to the west you can just make out a slight discoloration in the sand, the
start of an east/west path which borders the northern edge of the camp.")
      (NORTH PER GET-LOST-FCN)
      (NE PER GET-LOST-FCN)
      (EAST TO EX2)
      (SE TO EX5)
      (SOUTH TO EX4)
      (SW TO P5)
      (WEST TO P3)
      (NW PER GET-LOST-FCN)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 3)
      (MAP 2)
      (DESERT 1)
      (ENDLESS 654)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM EX2
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are in the desert, almost out of sight of the encampment, your only link
with civilization. You are just close enough to make out a tiny dot on the
western horizon which could be one of the tents. The searing sand is making
walking a difficult and painful experience, something alien to you.")
      (NORTH PER GET-LOST-FCN)
      (NE PER GET-LOST-FCN)
      (EAST TO EX3)
      (SE TO EX6)
      (SOUTH TO EX5)
      (SW TO EX4)
      (WEST TO EX1)
      (NW PER GET-LOST-FCN)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 2)
      (MAP 1)
      (DESERT 1)
      (ENDLESS 655)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM EX3
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are deep in desert, the encampment little more than a memory. You think
for a moment, closing your eyes, trying to picture the coolness of the Nile,
the comfort of your cot, and are overcome with doubts. When you open your eyes
again you are greeted with the same nightmare: All around you, all you can see
for mile after mile is sand and more sand.")
      (NORTH PER GET-LOST-FCN)
      (NE PER GET-LOST-FCN)
      (EAST PER GET-LOST-FCN)
      (SE PER GET-LOST-FCN)
      (SOUTH TO EX6)
      (SW TO EX5)
      (WEST TO EX2)
      (NW PER GET-LOST-FCN)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 1)
      (MAP 2)
      (DESERT 1)
      (ENDLESS 656)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM EX4
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are in the desert, still within sight of the encampment, just a tiny
oasis to the west. The tents, shimmering behind the heat waves rising from the
sand, seem to be calling you back, beckoning, offering safety and refuge.")
      (NORTH TO EX1)
      (NE TO EX2)
      (EAST TO EX5)
      (SE TO EX8)
      (SOUTH TO EX7)
      (SW TO P8)
      (WEST TO P5)
      (NW TO P3)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 1)
      (MAP 1)
      (DESERT 1)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM EX5
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are standing on the top of a sand dune, looking all around at a place on
Earth where man was never meant to be. That is the only conclusion you can draw
as you force yourself to breathe the hot, arid air of the desert through your
nose. Breathing through your mouth makes you instantly thirsty, a dangerous
state to find yourself in while surrounded by sand. You curse Craige, then
find yourself cursing Ellingsworth, too.")
      (NORTH TO EX2)
      (NE TO EX3)
      (EAST TO EX6)
      (SE TO EX9)
      (SOUTH TO EX8)
      (SW TO EX7)
      (WEST TO EX4)
      (NW TO EX1)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 2)
      (MAP 2)
      (DESERT 1)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM EX6
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are deep into the desert, as deep as anyone in his right mind would ever
care to venture. A small but strong gust of wind reaches your face, pelting you
with grains of sand so small they remind you of fine sugar. Even with your lips
tightly closed, the wind manages to drive a few grains into your mouth. You are
thankful that none got into your eyes.")
      (NORTH TO EX3)
      (NE PER GET-LOST-FCN)
      (EAST PER GET-LOST-FCN)
      (SE PER GET-LOST-FCN)
      (SOUTH TO EX9)
      (SW TO EX8)
      (WEST TO EX5)
      (NW TO EX2)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 3)
      (MAP 2)
      (DESERT 1)
      (ENDLESS 706)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM EX7
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are in the desert, east of the encampment. From this distance the camp
seems little more than a mirage, an image of another reality which has little
to do with the brutal, searing reality of the desert, your quickly dehydrating
body, or your painfully broiling feet.")
      (NORTH TO EX4)
      (NE TO EX5)
      (EAST TO EX8)
      (SE PER GET-LOST-FCN)
      (SOUTH PER GET-LOST-FCN)
      (SW PER GET-LOST-FCN)
      (WEST TO P8)
      (NW TO P5)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 1)
      (MAP 2)
      (DESERT 1)
      (ENDLESS 754)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM EX8
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are in the desert, out of sight of the encampment. You are thankful
there's no wind, even though a cooling breeze would be welcomed, since the
fine sand particles would sting your face and hands. All around is the desert,
a sweeping expanse of disheartening sand.")
      (NORTH TO EX5)
      (NE TO EX6)
      (EAST TO EX9)
      (SE PER GET-LOST-FCN)
      (SOUTH PER GET-LOST-FCN)
      (SW PER GET-LOST-FCN)
      (WEST TO EX7)
      (NW TO EX4)
      (DOWN TO CHAMBER-OF-RA IF PYRAMID-OPENED)
      (IN TO CHAMBER-OF-RA IF PYRAMID-OPENED)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 1)
      (MAP 2)
      (DESERT 1)
      (ENDLESS 755)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROOM EX9
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Desert")
      (LDESC
"You are far into the desert, sand and more sand stretching out endlessly
around you in all directions. You think of going back, of giving up this
attempt at riches, but what awaits you back in the States? What is there worth
going back to, with nothing to show for this quest? And how could you go back
now, after the things you'd said to Craige? You glance around
at the rolling dunes and force back the fear eating away your confidence.")
      (NORTH TO EX6)
      (NE PER GET-LOST-FCN)
      (EAST PER GET-LOST-FCN)
      (SE PER GET-LOST-FCN)
      (SOUTH PER GET-LOST-FCN)
      (SW PER GET-LOST-FCN)
      (WEST TO EX8)
      (NW TO EX5)
      (GLOBAL TENT-OBJ SAND HOLE)
      (CAPACITY 1)
      (MAP 1)
      (DESERT 1)
      (ENDLESS 756)
      (ACTION DESCRIBE-HOLE-FCN)>

<ROUTINE DESCRIBE-HOLE-FCN (RARG "AUX" DEPTH)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL <GETP ,HERE ,P?LDESC>>
		<SET DEPTH <GETP ,HERE ,P?CAPACITY>>
		<COND (<AND <G? .DEPTH 5>
			    <EQUAL? ,HERE ,EX8>>
		       <CRLF>
		       <RTRUE>)
		      (<G? .DEPTH 0>
		       <TELL " There's a" <GET ,DESC-HOLE-LTBL .DEPTH>
" in the sand, a remnant of your excavation attempts.">)>
		<COND (<EQUAL? ,HERE ,ENDLESS-DESERT>
		       <COND (<G? ,THIRST 300>
			      <TELL " " <PICK-ONE ,SPACE-TALES-LTBL>>)
			     (ELSE
			      <COND (<PROB 50>
				     <COND (<PROB 35>
					    <TELL " "
					        <PICK-ONE ,SPACE-TALES-LTBL>>)
					   (T <TELL " "
						<PICK-ONE ,MIRAGE-LTBL>>)>)>)>)
		      (<GETP ,HERE ,P?DESERT>
		       <COND (<G? ,THIRST 300>
			      <TELL " " <PICK-ONE ,MIRAGE-LTBL>>)
			     (ELSE
			      <COND (<PROB 20>
				     <TELL " " <PICK-ONE ,MIRAGE-LTBL>>)>)>)>
		<CRLF>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<SETG THIRST <+ ,THIRST 15>>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-BEG>
		<SETG THIRST <+ ,THIRST 3>>
		<RFALSE>)>>
		       
<GLOBAL DESC-HOLE-LTBL
	<LTABLE " small hole"
		"n enlarged hole"
		" sizable hole"
		" knee-deep hole"
		" deep hole">>

<GLOBAL SPACE-TALES-LTBL
	<LTABLE
"You hear a whirring overhead and look up in time to see a gyrocopter settling
to the sand on the horizon."
"You think you see a spaceship settling on the horizon and, as you strain your
eyes through the wafting waves of heat, you see a man and a huge robot. You can
almost hear them saying \"Gort, Klaatu Barada Nikto.\""
"A small lizard pokes its head up from the sands and asks the shortest route to
Times Square. You scratch your head for a moment and when you remember the
proper subway line to recommend to it, you notice it's disappeared."
"Five maids amilking sit on sandy stools before you, grinning maniacally."
"A large rainbow trout walks by, holding a pet snail on a leash."
"A strong gust of wind kicks up a herd of buffalo on the horizon. You think it
strange that the buffalo are riding sidesaddle.">>

<GLOBAL MIRAGE-LTBL
	<LTABLE
"Far off in the distance, dancing on the horizon, you see a shimmering oasis.
Standing by the oasis are a team of Egyptian workers, waving for you to
approach."
"A cool pool of water seems to dance in the heat waves just a mile away. You
can almost hear Rankin and Craige arguing over the spoils."
"A caravan of camels, led by a nomadic tribe, wanders a few miles off."
"You wipe your sweating brow, gazing off into the distance, and notice a cool,
crystal-clear lake glimmering on the horizon, just to the north.">>

<OBJECT ROCK-LOCK
	(IN EX8)
	(FLAGS INVISIBLE NDESCBIT CONTBIT OPENBIT DONTTAKE VOWELBIT)
	(DESC "opening")
	(SYNONYM OPENIN BLOCK HOLE)
	(ADJECTIVE SQUARE)
	(CAPACITY 5)
	(MAP 3)
	(ACTION ENTER-OPENING-FCN)>

<ROUTINE ENTER-OPENING-FCN ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"The opening sits in the upper right-hand corner of the block. It's a small
square opening, about four inches square, far too small for you
to enter, and rather shallow. Some hieroglyphs travel across the block,
cut off by the opening:|
">
		<FIXED-FONT-ON>
		<TELL "|
       !-!        !-!|
->  #.  ! !  -  #  ! !  /|
">
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>)
	       (<VERB? THROUGH>
		<TELL
"I think the opening is a little too small to get through. Unless your ethics
and morals are an accurate representation of your stature." CR>
		<RTRUE>)>>

<OBJECT COT
	(IN TENT)
	(FLAGS TAKEBIT TRYTAKEBIT CONTBIT OPENBIT SURFACEBIT VEHBIT VOWELBIT
	       TRANSBIT)
	(DESC "army cot")
	(ACTION COT-FCN)
	(CAPACITY 100)
	(SYNONYM COT)
	(ADJECTIVE ARMY)>

<OBJECT FOLDED-COT
	(FLAGS TAKEBIT)
	(DESC "folded cot")
	(ACTION COT-FCN)
	(SIZE 9)
	(SYNONYM COT)
	(ADJECTIVE ARMY FOLDED)>

<ROUTINE COT-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" F)
	 <COND (<NOT <EQUAL? .RARG ,M-OBJECT>> <RFALSE>)
	       (<PRSO? ,COT>
		<SET F <FIRST? ,COT>>
		<COND (<VERB? TAKE PUT PUT-ON>
		       <TELL
"It's too bulky and unstable a structure to be carrying around." CR>
		       <RTRUE>)
		      (<VERB? CLIMB-ON CLIMB-UP>
		       <COND (<IN? ,WINNER ,COT>
			      <TELL "Where do you think you are?" CR>)
			     (T
			      <TELL
"This is no time for sitting down on the job, especially after what you've been
through to get here!" CR>)>
		       <RTRUE>)
		      (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL "It's just an army cot.">
		       <COND (<AND .F
				   <EQUAL? .F ,WINNER>>
			      <TELL " And you're in it!">)
			     (.F
			      <TELL " Sitting on the cot ">
			      <COND (<G? <CCOUNT ,COT> 1>
				     <TELL "are ">)
				    (T <TELL "is ">)>
			      <PRINT-CONTENTS ,COT>
			      <TELL ".">)>
		       <CRLF>
		       <RTRUE>)
		      (<VERB? FOLD CLOSE>
		       <COND (<NOT .F>
			      <TELL "Folded." CR>
			      <MOVE ,FOLDED-COT <LOC ,COT>>
			      <REMOVE ,COT>
			      <THIS-IS-IT ,FOLDED-COT>
			      <RTRUE>)
			     (<EQUAL? .F ,WINNER>
			      <TELL
"Don't you think it would be wise to get out of the cot first? Or are you
waiting for a valet to help?" CR>
			      <RTRUE>)
			     (.F
			      <TELL
"You'd better take everything off of it first." CR>
			      <RTRUE>)>)
		      (<VERB? OPEN UNFOLD>
		       <TELL "It's already unfolded." CR>
		       <RTRUE>)
		      (<AND <VERB? DROP>
			    <EQUAL? <LOC ,WINNER> ,COT>>
		       <PERFORM ,V?DISEMBARK ,COT>
		       <RTRUE>)
		      (<AND <VERB? WALK THROUGH>
			    <EQUAL? <LOC ,WINNER> ,COT>>
		       <TELL "You'd better get out of the cot first." CR>
		       <RFATAL>)>)
	       (<PRSO? ,FOLDED-COT>
		<COND (<VERB? OPEN UNFOLD>
		       <COND (<NOT <IN? ,FOLDED-COT ,HERE>>
			      <TELL
"Better put it down on the ground first." CR>)
			     (T
			      <TELL "Unfolded." CR>
			      <MOVE ,COT <LOC ,FOLDED-COT>>
			      <REMOVE ,FOLDED-COT>
			      <THIS-IS-IT ,COT>
			      <RTRUE>)>)
		      (<VERB? FOLD CLOSE>
		       <TELL 
"Hmmm. Looks like you beat yourself to it. It's already folded up." CR>
		       <RTRUE>)>)>>
		      

<OBJECT MATCHES
	(IN FIRE)
	(DESC "matchbook")
	(FDESC
"Sitting by a rock is what looks like a matchbook.")
	(SYNONYM MATCHB MATCHE COVER)
	(FLAGS BURNBIT TAKEBIT READBIT CONTBIT)
	(SIZE 1)
	(CAPACITY 1)
	(GENERIC DIASMBIGUATE-FCN)
	(ACTION READ-MATCHES-FCN)>

<ROUTINE READ-MATCHES-FCN ("OPTIONAL" OBJ)
	 <COND (<NOT .OBJ>
		<SET OBJ ,MATCHES>)>
	 <COND (<VERB? READ-INSIDE>
		<COND (<NOT <FSET? .OBJ ,OPENBIT>>
		       <TELL "You'd better open the matchbook first." CR>
		       <RTRUE>)
		      (ELSE
		       <PERFORM ,V?READ .OBJ>
		       <RTRUE>)>)
	       (<VERB? READ LOOK-BEHIND>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL
"The inside says: Send away now!! Mushrooms can be taught a foreign
language, and make fine pets! Easy to feed and they can be walked on a leash!
Read and fill out the enclosed coupon now!" CR>)
		      (ELSE
		       <TELL
"Printed on the outside is a small coupon for an instruction manual,
\"GROW MUSHROOMS IN YOUR BASEMENT FOR FUN & PROFIT\". Close Before
Striking." CR>)>)
	       (<VERB? LAMP-ON>
		<TELL "One match at a time, eh?" CR>
		<RTRUE>)>>

<OBJECT MANY-MATCHES
	(IN MATCHES)
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT)
	(DESC "few matches")
	(SYNONYM MATCH)
	(GENERIC DIASMBIGUATE-FCN)
	(ADJECTIVE ONE SINGLE)
	(SIZE 1)
	(ACTION TAKE-ONE-MATCH-FCN)>

<OBJECT SINGLE-MATCH
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT)
	(DESC "single match")
	(SYNONYM MATCH)
	(GENERIC DIASMBIGUATE-FCN)
	(ADJECTIVE ONE SINGLE)
	(SIZE 1)
	(ACTION TAKE-ONE-MATCH-FCN)>

<OBJECT ONE-MATCH
	(IN GLOBAL-OBJECTS)
	(FLAGS BURNBIT)
	(DESC "match")
	(GENERIC DIASMBIGUATE-FCN)
	(SYNONYM MATCH)
	(SIZE 1)
	(ACTION DROP-ONE-FCN)>

<OBJECT BURNED-MATCHBOOK
	(FLAGS CONTBIT TAKEBIT)
	(DESC "burned matchbook")
	(SYNONYM MATCHB)
	(ADJECTIVE BURNED)
	(CAPACITY 1)>

<OBJECT EMPTY-MATCHES
	(FLAGS CONTBIT OPENBIT BURNBIT READBIT TAKEBIT)
	(DESC "matchbook")
	(SYNONYM MATCHB MATCHE)
	(GENERIC DIASMBIGUATE-FCN)
	(ADJECTIVE EMPTY)
	(CAPACITY 1)
	(ACTION LAST-MATCH-FCN)>

<ROUTINE LAST-MATCH-FCN ()
	 <COND (<AND <VERB? DROP>
		     <IN? ,ONE-MATCH ,WINNER>>
		<DROP-ONE-FCN>
		<RTRUE>)
	       (<VERB? TAKE>
		<TELL "Why? There's no match left in the matchbook." CR>
		<RTRUE>)
	       (<VERB? LAMP-ON>
		<COND (<IN? ,ONE-MATCH ,WINNER>
		       <RFALSE>)
		      (ELSE
		       <TELL "There's no match to light!" CR>
		       <RTRUE>)>)
	       (<VERB? READ>
		<READ-MATCHES-FCN ,EMPTY-MATCHES>
		<RTRUE>)>>

<ROUTINE DROP-ONE-FCN ()
	 <COND (<VERB? DROP PUT>
		<COND (<NOT <IN? ,ONE-MATCH ,WINNER>>
		       <TELL "Better take one first." CR>
		       <RTRUE>)>
		<MOVE ,ONE-MATCH ,GLOBAL-OBJECTS>
		<TELL "Dropped. ">
		<BUT-WHERE?>
		<TELL " ">
		<I-MATCH-OUT>
		<DISABLE <INT I-MATCH-OUT>>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<IN? ,MATCHES ,WINNER>
		       <MATCH-MOVER <>>
		       <RTRUE>)
		      (T
		       <TELL "I see no match here." CR>
		       <RTRUE>)>)
	       (<EQUAL? ,ONE-MATCH ,PRSI>
		<COND (<AND <NOT <IN? ,MATCHES ,WINNER>>
			    <NOT <IN? ,ONE-MATCH ,WINNER>>>
		       <TELL "You're not holding the match." CR>
		       <RTRUE>)
		      (T
		       <MATCH-MOVER T>
		       <RFALSE>)>)>>

<ROUTINE BUT-WHERE? ()
	 <COND (<IN? ,WINNER ,COT>
		<TELL
		 "The match disappears somewhere beneath the cot.">)
	       (<EQUAL? ,HERE ,RIVER-BANK>
		<TELL
		 "The current of the river sweeps it away.">)
	       (<GETP ,HERE ,P?MAP>
		<TELL 
		 "The match, however, is quickly covered by the sand.">)
	       (<EQUAL? <GETP ,HERE ,P?ACTION> ,BURN-THE-BARGE>
		<TELL 
		 "The match, however, falls between the wooden decking.">)
	       (<AND <NOT <FSET? ,PIT ,INVISIBLE>>
		     <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>>
		<TELL
		 "The match flutters down into the abyss.">)
	       (T
		<TELL "The match falls into a crack in the stone floor.">)>
	 <COND (<NOT <FLAMING? ,ONE-MATCH>>
		<CRLF>)>>

<ROUTINE TAKE-ONE-MATCH-FCN ()
	 <COND (<VERB? TAKE>
		<COND (<NOT <IN? ,ONE-MATCH ,WINNER>>
		       <MATCH-MOVER <>>)
		      (ELSE
		       <TELL "You're already holding one." CR>)>
		<RTRUE>) 
	       (<VERB? DROP>
		<PERFORM ,V?DROP ,ONE-MATCH>
		<RTRUE>)
	       (<OR <VERB? PUT PUT-ON PUT-UNDER>
		    <VERB? PUT-BEHIND PUT-AGAINST PUT-ACROSS>>
		<COND (<IN? ,ONE-MATCH ,WINNER>
		       <MOVE ,ONE-MATCH ,GLOBAL-OBJECTS>
		       <TELL 
"Well, I tried, but the match seems to have missed the mark entirely." CR>
		       <RTRUE>)
		      (ELSE
		       <TELL "One match at a time!" CR>
		       <RTRUE>)>)>>

<ROUTINE MATCH-MOVER ("OPTIONAL" (SUPPRESS? T))
	 <COND (<G? ,MATCH-COUNT 0>
		<SETG MATCH-COUNT <- ,MATCH-COUNT 1>>)>
	 <COND (<L? ,MATCH-COUNT 1>
		<SETG MATCH-COUNT 0>
		<REMOVE ,SINGLE-MATCH>
		<RFALSE>)
	       (<EQUAL? ,MATCH-COUNT 1>
		<MOVE ,EMPTY-MATCHES <LOC ,MATCHES>>
		<REMOVE ,MATCHES>
		<REMOVE ,MANY-MATCHES>
		<FSET ,SINGLE-MATCH ,NDESCBIT>)
	       (<EQUAL? ,MATCH-COUNT 2>
		<MOVE ,SINGLE-MATCH <LOC ,MANY-MATCHES>>
		<REMOVE ,MANY-MATCHES>)>
	 <MOVE ,ONE-MATCH ,WINNER>
	 <COND (<NOT .SUPPRESS?>
		<TELL "Taken." CR>)>
	 <RTRUE>>

<OBJECT MANUAL
	(IN GLOBAL-OBJECTS)
	(DESC "manual")
	(FLAGS READBIT DONTTAKE)
	(ADJECTIVE INSTRU)
	(SYNONYM MANUAL COUPON)
	(ACTION SEND-FOR-IT-FCN)>

<ROUTINE SEND-FOR-IT-FCN ()
	 <COND (<AND <VERB? SEND>
		     <IN? ,MATCHES ,WINNER>>
		<TELL
"Sure. As soon as a postman walks by, I'd be glad to give the coupon to him." CR>
		<RTRUE>)
	       (<AND <VERB? READ>
		     <IN? ,MATCHES ,WINNER>>
		<TELL
"The coupon for the manual is as clear as any coupon ever was:|
|
Fill in Last Name first, unless First Name is Last. Check the box beside
the dotted line unless you want the manual shipped via alternate shipping.
Include your address unless your mailing address and shipping address differ
from your postal delivery route. If you are having the manual air-freighted,
fill in your airport's zip code unless you're within thirty miles of a large
corn field. After checking whether that box has been checked, check it.|
|
Before you mail this, be certain you've read the instructions and have filled
out all three sides of the form. In case of doubt, contact the Coupon
Customer Service Department, 122 East Accardi Street, Youknow, Alaska.
If you live west of the Atlantic or the Pacific, this offer is
null and void except where prohibited by law." CR >)
	       (<VERB? READ>
		<TELL
"There's not much to read unless you're holding the matchbook." CR>
		<RTRUE>)>>

<ROUTINE BURN-FOO-FCN ()
	 <COND (<AND <VERB? BURN LAMP-ON>
		     <PRSO? ,CIG-WRAPPER>
		     <OR <IN? ,MATCHES ,WINNER>
			 <AND <IN? ,ONE-MATCH ,WINNER>
			      <FLAMING? ,ONE-MATCH>>>>
		<TELL 
"It tries valiantly to burn, but the inside of it is made of foil, and you
manage to burn your fingertips instead of the package." CR>
		<MOVE ,BURNED-PACK <LOC ,CIG-WRAPPER>>
		<FCLEAR ,BURNED-PACK ,INVISIBLE>
		<FCLEAR ,BURNED-PACK ,NDESCBIT>
		<REMOVE ,CIG-WRAPPER>
		<THIS-IS-IT ,BURNED-PACK>
		<RTRUE>)
	       (<VERB? READ>
		<TELL <GETP ,CIG-WRAPPER ,P?TEXT> CR>)>>

<OBJECT BURNED-PACK
	(FLAGS INVISIBLE TAKEBIT READBIT NDESCBIT)
	(DESC "burned wrapper")
	(SYNONYM WRAPPE PACK)
	(ADJECTIVE BURNED)
	(TEXT
"There's not much left to the outside of this package that's distinguishable.")
	(ACTION HUH?)>

<OBJECT CIG-WRAPPER
	(IN FIRE)
	(FLAGS TAKEBIT READBIT BURNBIT CONTBIT OPENBIT)
	(DESC "cigarette pack")
	(FDESC
"Half covered with sand is a bright piece of foil which catches your eye.")
	(SYNONYM PACK FOIL)
	(ADJECTIVE CIGARE BRIGHT)
	(TEXT
"It's an empty pack of Camel cigarettes.")
	(SIZE 3)
	(CAPACITY 2)
	(ACTION BURN-FOO-FCN)>

<OBJECT BROKEN-LOCK
	(IN TENT)
	(FLAGS INVISIBLE TAKEBIT TRYTAKEBIT NDESCBIT)
	(DESC "broken lock")
	(SYNONYM LOCK PADLOC)
	(ADJECTIVE BROKEN)
	(TEXT
"This is a slightly messed-up lock which once functioned. Alas, like your
personality, it has seen better days.")>

<OBJECT TRUNK
	(IN TENT)
	(FLAGS CONTBIT TRANSBIT SURFACEBIT OPENBIT)
	(DESC "trunk")
	(DESCFCN DESCRIBE-TRUNK-FCN)
	(SYNONYM TRUNK)
	(ADJECTIVE LARGE UNWIEL)
	(CAPACITY 100)
	(ACTION TRUNK-FCN)>

<GLOBAL TRUNK-TBL ;"Thirty (30) slots to hold objects in the trunk"
	<LTABLE MAP FOOD SMALL-SLIP 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

<ROUTINE DESCRIBE-TRUNK-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-OBJDESC>
		<COND (<IN? ,COT ,HERE>
		       <TELL
"At the foot of the cot is a large, unwieldy trunk.">)
		      (T
		       <TELL "A large, unwieldy trunk sits on the sand.">)>
		<COND (<FSET? ,BROKEN-LOCK ,INVISIBLE>
		       <TELL
" The trunk is closed and locked with a padlock.">)
		      (<NOT <FSET? ,BROKEN-LOCK ,TOUCHBIT>>
		       <TELL
" The trunk is closed with a broken padlock.">)>
		<CRLF>
		<COND (<FIRST? ,TRUNK>
		       <PRINT-CONT ,TRUNK>)>
		<RTRUE>)>>

<ROUTINE TRUNK-FCN ("AUX" (FLG <>))
	 <COND (<VERB? OPEN>
		<COND (<IN? ,LOCK ,TENT>
		       <TELL "A padlock holds it shut." CR>)
		      (<NOT <FSET? ,BROKEN-LOCK ,TOUCHBIT>>
		       <TELL
"You'd better remove the broken lock first." CR>)
		      (ELSE
		       <TBL-TO-INSIDE ,TRUNK ,TRUNK-TBL>
		       <RTRUE>)>)
	       (<VERB? UNLOCK>
		<COND (<NOT <FSET? ,TRUNK ,SURFACEBIT>>
		       <TELL "Better have your eyes checked." CR>)
		      (T <TELL "You don't have a key." CR>)>
		<RTRUE>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <FSET? ,TRUNK ,SURFACEBIT>>
		<TELL
"It's an old steamer trunk, very heavy and too clumsy for one person to carry."CR>
		<COND (<FIRST? ,TRUNK>
		       <PRINT-CONT ,TRUNK>)>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <NOT <FSET? ,TRUNK ,SURFACEBIT>>>
		<COND (<AND <IN? ,TORCH ,TRUNK>
			    <FLAMING? ,TORCH>>
		       <SET FLG T>)>
		<INSIDE-OBJ-TO ,TRUNK-TBL ,TRUNK>
		<COND (.FLG
		       <KILL-TORCH T>)>
		<RTRUE>)>>

<OBJECT LOCK
	(IN TENT)
	(DESC "padlock")
	(SYNONYM PADLOC LOCK)
	(FLAGS NDESCBIT CONTBIT)
	(ACTION LOCK-FCN)>

<ROUTINE LOCK-FCN ()
	 <COND (<VERB? OPEN>
		<COND (,PRSI
		       <PERFORM ,V?MUNG ,PRSO ,PRSI>
		       <RTRUE>)
		      (T
		       <TELL"You can't. It's locked." CR>
		       <RTRUE>)>)
	       (<AND <VERB? MUNG>
		     <PRSI? ,PICK-AXE 
			    ,SHOVEL ,ROCK>>
		<TELL "The padlock breaks open." CR>
		<FCLEAR ,BROKEN-LOCK ,INVISIBLE>
		<REMOVE ,LOCK>
		<THIS-IS-IT ,BROKEN-LOCK>
		<SETG SCORE <+ ,SCORE 5>>)
	       (<VERB? MUNG>
		<TELL"You'll have to hit the lock with something stronger." CR>
		<RTRUE>)
	       (<VERB? TAKE DISEMBARK>
		<TELL "It's locked." CR>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <IN? ,LOCK ,HERE>>
		<TELL
"It's made of hardened steel and is very sturdy. It's also very locked." CR>)>>

<OBJECT PICK-AXE
	(IN SUPPLY-TENT)
	(FLAGS TOOLBIT TAKEBIT)
	(DESC "pick axe")
	(FDESC
"Stuck in the sand, handle down, is a small pick axe.")
	(SYNONYM AXE PICKAX AX)
	(ADJECTIVE PICK)
	(TEXT
"It's a small hand axe, similar to those used in mountain climbing.")
	(SIZE 10)>

<OBJECT STONE-KEY
	(IN MAP)
	(FLAGS TAKEBIT READBIT)
	(DESC "stone cube")
	(SYNONYM CUBE)
	(MAP 3)
	(ADJECTIVE SMALL STONE)
	(ACTION STONE-KEY-FCN)>

<GLOBAL PYRAMID-OPENED <>>

<ROUTINE STONE-KEY-FCN ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"This is a small stone cube, almost four inches on a side, with ancient
markings on it. The markings look like this:|
">
		<FIXED-FONT-ON>
		<TELL "|
#  !@!  ::  (())  !@!  //\\\\|
">
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,ROCK-LOCK>>
		<TELL "The ancient stones beneath your feet shake and
tremble as they move the sands. You leap out of the way and manage to
avoid being sucked down into the vortex. Through the sands, an entrance
down into the pyramid is revealed. The entire experience sends a jolt of
adrenaline through your body as your lips form a sneer. You've found it.
And without any help from those idiots."CR>
		<SETG PYRAMID-OPENED T>
		<REMOVE ,STONE-KEY>
		<REMOVE ,ROCK-LOCK>
		<SETG P-IT-LOC <>>
		<PUTP ,HERE ,P?LDESC
"You are in the desert at a site of successful excavation. Beneath you lies the
pyramid, its stone door at last open. The desert is all around you, but
down there lie the secrets of the ages.">
		<SETG SCORE <+ ,SCORE 20>>)>>

<OBJECT FOOD
	(FLAGS FOODBIT TAKEBIT TOUCHBIT TRYTAKEBIT)
	(DESC "piece of dried beef")
	(SYNONYM BEEF FOOD MEAT)
	(ADJECTIVE DRIED PIECE)
	(ACTION EDIBLE-FCN)>

<ROUTINE EDIBLE-FCN ()
	 <COND (<NOT <EQUAL? ,PRSO ,FOOD>>
		<RFALSE>)
	       (<VERB? SMELL TASTE>
		<TELL "Mmmm good!" CR>
		<RTRUE>)>>
	       
<OBJECT MAP
	(FLAGS CONTBIT TAKEBIT VOWELBIT BURNBIT)
	(DESC "ancient map")
	(SYNONYM MAP)
	(ADJECTIVE ANCIEN)
	(CAPACITY 5)
	(ACTION MAP-FCN)>

<ROUTINE MAP-FCN ()
	 <COND (<AND <NOT <IN? ,MAP ,WINNER>>
		     <VERB? OPEN READ EXAMINE>> 
		<TELL "You're not carrying the map." CR>
		<RTRUE>)
	       (<AND <VERB? READ EXAMINE>
		     <NOT <FSET? ,MAP ,OPENBIT>>>
		<TELL "You'd better unfold it first." CR>
		<RTRUE>)
	       (<VERB? READ EXAMINE>
		<TELL
"This is a reproduction of the map the Professor made while on his expedition.
It indicates where he hoped to find the lost pyramid. It is included in your
game package." CR>)
	       (<AND <VERB? TAKE>
		     <NOT <FSET? ,MAP ,TOUCHBIT>>>
		<COND (<ITAKE>
		       <TELL
"Taken. It feels fairly heavy, though, as though it were folded around
something solid." CR>)>
		<RTRUE>)>>

<OBJECT SHOVEL
	(IN SUPPLY-TENT)
	(FLAGS TOOLBIT TAKEBIT)
	(DESC "shovel")
	(FDESC
"Half buried in the sand, in the corner of the tent, is a shovel.")
	(TEXT
"It's a standard-issue garden shovel.")
	(SYNONYM SHOVEL)>

<OBJECT ROPE
	(IN KNAPSACK)
	(DESC "rope")
	(FLAGS TAKEBIT CLIMBBIT BURNBIT TOUCHBIT)
	(SYNONYM ROPE COIL ASP)
	(SIZE 4)
	(ADJECTIVE BUNCH)
	(TEXT
"This rope is made of the finest Manila hemp and guaranteed to hold at least
250 pounds of weight. There's about thirty feet of it. Be glad the workers
didn't hang you with it.")
	(ACTION ROPE-FCN)
	(DESCFCN DESCRIBE-ROPE-FCN)>

<ROUTINE DESCRIBE-ROPE-FCN (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-OBJDESC>
		     <OR <EQUAL? ,HERE ,LANDING-ZERO ,LANDING-ONE ,LANDING-TWO>
			 <EQUAL? ,HERE ,LANDING-THREE ,TINY-LANDING>>
		     ,ROPE-PLACED>
		<TELL "Descending from above is the end of a long rope.">
		<COND (<ROOM? ,TINY-LANDING>
		       <TELL " It travels down into the darkness.">)>
		<CRLF>
		<RTRUE>)>>

<ROUTINE ROPE-FCN ()
	 <COND (<AND <VERB? TIE>
		     <PRSI? ,ALTAR>>
		<COND (,ROPE-TIED
		       <TELL "It's already tied to the " D ,ROPE-TIED "." CR>
		       <RTRUE>)
		      (<EQUAL? ,PRSI ,ALTAR>
		       <TELL "The rope has been tied to the " D ,PRSI "." CR>
		       <SETG ROPE-TIED ,PRSI>
		       <FSET ,ROPE ,TRYTAKEBIT>)
		      (T <RFALSE>)>)
	       (<VERB? UNTIE>
		<COND (<NOT ,ROPE-TIED>
		       <TELL "That's cute. It's not tied!" CR>
		       <RTRUE>)
		      (<NOT <EQUAL? ,HERE ,CHAMBER-OF-RA>>
		       <TELL "Your arms aren't quite that long." CR>
		       <RTRUE>)
		      (ELSE
		       <TELL "Untied.">
		       <SETG ROPE-TIED <>>
		       <FCLEAR ,ROPE ,TRYTAKEBIT>
		       <COND (,ROPE-PLACED
			      <MOVE ,ROPE ,LANDING>
			      <TELL " You hear it fall down below.">
			      <SETG LANDING <>>
			      <SETG ROPE-PLACED <>>)>
		       <CRLF>
		       <RTRUE>)>)
	       (<AND <VERB? TAKE PUT>
		     ,ROPE-PLACED
		     <EQUAL? ,HERE ,CHAMBER-OF-RA>>
		<SETG ROPE-PLACED <>>
		<FCLEAR ,ROPE ,NDESCBIT>
		<TELL "(free end of rope)" CR>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     ,ROPE-PLACED
		     <OR <EQUAL? ,HERE ,LANDING-ZERO ,LANDING-ONE 
				 ,TINY-LANDING>
			 <EQUAL? ,HERE ,LANDING-TWO ,LANDING-THREE>>>
		<TELL "It seems to be tied to something up overhead." CR>
		<RTRUE>)
	       (<AND <VERB? MOVE>
		     ,ROPE-PLACED>
		<TELL "The rope is securely fastened to the altar." CR>
		<RTRUE>)
	       (<VERB? PUT>
		<COND (<AND ,PRSI
			    <FSET? ,PRSI ,CLIMBBIT>>
		       <COND (<EQUAL? ,PRSI ,FEW-STEPS>
			      <SETG PRSI ,NORTH-STAIRS>)>
		       <SETG ROPE-PLACED ,PRSI>
		       <TELL "The rope descends into the " D ,PRSI "." CR>
		       <MOVE ,ROPE ,HERE>
		       <COND (<EQUAL? ,PRSI ,NORTH-STAIRS>
			      <SETG LANDING ,LANDING-ZERO>)
			     (<EQUAL? ,PRSI ,SOUTH-STAIRS>
			      <SETG LANDING ,LANDING-TWO>)
			     (<EQUAL? ,PRSI ,EAST-STAIRS>
			      <SETG LANDING ,LANDING-ONE>)
			     (<EQUAL? ,PRSI ,WEST-STAIRS>
			      <SETG LANDING ,LANDING-THREE>)
			     (T
			      <SETG LANDING ,LANDING-ZERO>)>
		       <RTRUE>)
		      (ELSE
		       <RFALSE>)>)
	       (<VERB? TAKE>
		<FCLEAR ,ROPE ,NDESCBIT>
		<RFALSE>)
	       (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<COND (<AND <VERB? CLIMB-UP>
			    <ROOM? ,CHAMBER-OF-RA>>
		       <TELL "The rope doesn't go up." CR>
		       <RFATAL>)>
		<SETG ROPE-HACK T>
		<RFALSE>)>>

<OBJECT NOTE
	(IN TENT2)
	(FLAGS READBIT BURNBIT TAKEBIT)
	(DESC "farewell note")
	(FDESC
"Tacked up to the inside of one of the tent flaps is a note.")
	(TEXT
"The note reads:|
|
Fi aman Allah!|
|
Hereafter you shall pursue your fool dream of the hidden pyramid and its riches
alone. May the jackals feed well on your bones. We have left you what you need
to get back, though we hope you do not. We put several things you treasure
above life itself inside your trunk, locked with your precious padlock, but we
could not bear to part with the key. Especially after what you said of our
rites. We hope the drug we placed in your drink did you harm. If not, we are at
least satisfied you slept especially soundly while we cleaned out the camp.|
|
Farewell")
	(SYNONYM NOTE)
	(ADJECTIVE FAREWE)
	(SIZE 1)>

<OBJECT GLOBAL-WATER
	(IN LOCAL-GLOBALS)
	(FLAGS DRINKBIT NDESCBIT)
	(DESC "quantity of water")
	(SYNONYM WATER)
	>

<OBJECT WATER
	(IN CANTEEN)
	(FLAGS DRINKBIT)
	(DESC "quantity of water")
	(SYNONYM WATER)
	(SIZE 3)>

<OBJECT CANTEEN
	(IN KNAPSACK)
	(FLAGS CONTBIT TAKEBIT TOUCHBIT)
	(DESC "canteen")
	(SYNONYM CANTEE)
	(ADJECTIVE SMALL)
	(CAPACITY 5)
	(SIZE 6)
	(ACTION CANTEEN-FCN)>
	
<GLOBAL SANDY-CANTEEN <>>
<GLOBAL SAND-FILLED <>>

<ROUTINE CANTEEN-FCN ()
	 <COND (<VERB? SHAKE>
		<COND (<NOT <FSET? ,CANTEEN ,OPENBIT>>
		       <COND (<AND <IN? ,WATER ,CANTEEN>
				   <G? ,WATER-LEFT 9>>
			      <TELL "Some water sloshes around inside." CR>
			      <RTRUE>)
			     (,SAND-FILLED
			      <TELL "Some sand shakes around inside." CR>
			      <RTRUE>)
			     (T
			      <TELL "It's empty." CR>)>)
		      (<IN? ,WATER ,CANTEEN>
		       <TELL
"All the water spills out and quickly evaporates. Another smart move."
			     CR>
		       <REMOVE ,WATER>
		       <SETG WATER-LEFT 0>
		       <RTRUE>)
		      (,SAND-FILLED
		       <TELL "You empty the canteen of most of the sand." CR>
		       <SETG SAND-FILLED <>>
		       <REMOVE ,C-SAND>
		       <FSET ,C-SAND ,NDESCBIT>
		       <RTRUE>)
		      (T
		       <TELL 
"Okay, but shaking an empty canteen will get you nowhere fast." CR>
		       <RTRUE>)>)
	       (<AND <VERB? FILL>
		     <EQUAL? ,PRSI ,SAND>>
		<COND (<NOT <GETP ,HERE ,P?MAP>>
		       <TELL "I see no sand here." CR>)
		      (<NOT <FSET? ,CANTEEN ,OPENBIT>>
		     <TELL "It would help if you opened the canteen first." CR>
		       <RTRUE>)
		      (T
		       <TELL "Okay. The canteen has been filled with sand.">
		       <COND (,WATER-LEFT
			      <SETG WATER-LEFT 0>
			      <REMOVE ,WATER>
			      <TELL
" So much for the water that was left in it.">)>
		       <CRLF>
		       <SETG SANDY-CANTEEN T>
		       <SETG SAND-FILLED T>
		       <MOVE ,C-SAND ,CANTEEN>
		       <FCLEAR ,C-SAND ,NDESCBIT>)>
		<RTRUE>)
	       (<AND <PRSI? ,CANTEEN>
		     <VERB? PUT>
		     <NOT <EQUAL? ,PRSO ,SAND ,GLOBAL-WATER ,C-SAND>>>
	        <TELL
"That would void the manufacturer's warranty on the canteen." CR>)>>

<OBJECT SMALL-SLIP
	(FLAGS READBIT TAKEBIT BURNBIT VOWELBIT)
	(DESC "inspection sticker")
	(TEXT
"The small inspection sticker says:
|
This trunk inspected by numbers 8 and 6.5. This reality was manufactured by
tiny elves from the Bozbar Pyramid Construction Company, a jointly-owned
subsidiary of the FrobozzCo Magic Village Industries, Michael Berlyn and
Patricia Fogleman, Chief Engineers.")
	(SYNONYM STICKE)
	(ADJECTIVE INSPEC)>

<ROOM ENDLESS-DESERT
      (IN ROOMS)
      (DESC "Desert")
      (FLAGS RLANDBIT ONBIT)
      (LDESC
"You are in the desert, a vast wasteland of sand and heat.")
      (UP "Without a helicopter?")
      (DOWN "Let's not rush things.")
      (ACTION DESERT-EXIT-FCN)
      (CAPACITY 0)
      (GLOBAL SAND MIRAGES)>

<OBJECT MIRAGES
	(IN LOCAL-GLOBALS)
	(DESC "mirage")
	(FLAGS NDESCBIT)
	(SYNONYM GORT KLAATU FISH BUFFAL)
	(ADJECTIVE LIZARD MAIDS SNAIL GYROCO)
	(ACTION MIRAGES-F)>

<ROUTINE MIRAGES-F ()
	 <TELL
"Come on! This life you're leading is bad enough -- don't waste your life on
illusions." CR>
	 <RTRUE>>

<GLOBAL TOLD-IT <>>

<ROUTINE DESERT-EXIT-FCN (RARG "AUX" (END-OF-TBL 26) (OFFS 0) (NEW-ROOM <>)
			  OLD-DESERT)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <VERB? DROP>
			    <PROB 33>
			    <NOT ,TOLD-IT>>
		       <TABLE-TO-DESERT ,DESERT-LOC>
		       <REMOVE ,PRSO>
		       <TELL
"A brief but strong gust of wind comes up off a dune, whipping sand in your
face, blinding you for long enough to lose track of the " D ,PRSO "." CR>
		       <SETG TOLD-IT T>)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<DESCRIBE-HOLE-FCN ,M-LOOK>
		<SETG TOLD-IT <>>
		<RTRUE>)
	       (<NOT <EQUAL? .RARG ,M-BEG>>
		<RFALSE>)
	       (<OR <NOT <VERB? WALK>>
		    <EQUAL? ,PRSO ,P?UP ,P?DOWN>>
		<SETG TOLD-IT <>>
		<RFALSE>)>
	 <SETG TOLD-IT <>>
	 <SETG THIRST <+ ,THIRST 15>>
	 <SET OLD-DESERT ,DESERT-LOC>
	 <CHANGE-DESERT-POSITION>
	 <REPEAT ()
		 <COND (<EQUAL? .OFFS .END-OF-TBL>
			<RETURN>)
		       (ELSE
			<COND (<EQUAL? ,DESERT-LOC <GET ,REENTRY-TBL .OFFS>>
			       <SET NEW-ROOM <GET ,REENTRY-TBL <+ .OFFS 1>>>
			       <RETURN>)
			      (ELSE
			       <SET OFFS <+ .OFFS 2>>)>)>>
	 <DESERT-TO-TABLE .OLD-DESERT>
	 <PROP-TO-TBL .OLD-DESERT>
	 <COND (<NOT .NEW-ROOM>
		<FCLEAR ,HERE ,TOUCHBIT>
		<SET NEW-ROOM ,ENDLESS-DESERT>
		<TABLE-TO-DESERT ,DESERT-LOC>
		<TBL-TO-PROP ,DESERT-LOC>)
	       (ELSE
		<TBL-TO-PROP .OLD-DESERT>)>
	 <GOTO .NEW-ROOM>
	 <RTRUE>>
	 
<GLOBAL REENTRY-TBL
	<TABLE 651 P1 652 P2 653 P3 654 EX1 655 EX2
	       656 EX3 706 EX6 751 P6 752 P7 753 P8
	       754 EX7 755 EX8 756 EX9>>

<ROUTINE DESERT-TO-TABLE (SLOC "AUX" TBL (CNT 0)
			  (F <FIRST? ,ENDLESS-DESERT>) N)
	 <SET TBL ,DESERT-TABLE>
	 <REPEAT ()
		 <COND (.F <SET N <NEXT? .F>>)
		       (ELSE <RETURN>)>
		 <COND (<EQUAL? .F ,WINNER>)
		       (<FSET? .F ,TAKEBIT>
			<REPEAT ()
				<COND (<==? <GET .TBL .CNT> 0>
				       <PUT .TBL .CNT .SLOC>
				       <PUT .TBL <+ .CNT 1> .F>
				       <SET CNT <+ .CNT 2>>
				       <REMOVE .F>
				       <RETURN>)
				      (ELSE
				       <SET CNT <+ .CNT 2>>)>>)>
		 <SET F .N>>>

<ROUTINE TABLE-TO-DESERT (SLOC
			 "AUX" TBL (CNT 0))
	 <SET TBL ,DESERT-TABLE>
	 <REPEAT ()
		 <COND (<NOT <L? .CNT 100>>
			<RETURN>)
		       (<==? <GET .TBL .CNT> .SLOC>
			<PUT .TBL .CNT 0>
			<MOVE <GET .TBL <+ .CNT 1>> ,ENDLESS-DESERT>)>
		 <SET CNT <+ .CNT 2>>>>

<GLOBAL DESERT-LOC 0>
<CONSTANT DESERT-START 10000>

<GLOBAL DESERT-TABLE ;"length should be 2*number of takeable objects"
	<TABLE 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

<GLOBAL DESERT-HACK 0>

<ROUTINE CHANGE-DESERT-POSITION ()
	 <SETG DESERT-HACK <+ ,DESERT-HACK 1>>
	 <COND (<EQUAL? ,DESERT-HACK 10>
		<TELL 
"WARNING: The Surgeon General has determined that wandering about like this is
dangerous to your health." CR>
		<CRLF>)
	       (<EQUAL? ,DESERT-HACK 20>
		<COND (<ROB-HIM-BLIND>
		       <TELL
"You start dropping things to lighten your load. Before you know it, you're
empty-handed. A gust of wind comes up off the dune before you, covering over
what you've dropped. So much for that." CR>
		       <CRLF>)>)>
	 <COND (<EQUAL? ,PRSO ,P?NORTH>
		<SETG DESERT-LOC <- ,DESERT-LOC 50>>
		<FIX-LON-LAT 0 2>)
	       (<EQUAL? ,PRSO ,P?NE>
		<SETG DESERT-LOC <- ,DESERT-LOC 49>>
		<FIX-LON-LAT 2 2>)
	       (<EQUAL? ,PRSO ,P?EAST>
		<SETG DESERT-LOC <+ ,DESERT-LOC 1>>
		<FIX-LON-LAT 2 0>)
	       (<EQUAL? ,PRSO ,P?SE>
		<SETG DESERT-LOC <+ ,DESERT-LOC 51>>
		<FIX-LON-LAT 2 -2>)
	       (<EQUAL? ,PRSO ,P?SOUTH>
		<SETG DESERT-LOC <+ ,DESERT-LOC 50>>
		<FIX-LON-LAT 0 -2>)
	       (<EQUAL? ,PRSO ,P?SW>
		<SETG DESERT-LOC <+ ,DESERT-LOC 49>>
		<FIX-LON-LAT -2 -2>)
	       (<EQUAL? ,PRSO ,P?WEST>
		<SETG DESERT-LOC <- ,DESERT-LOC 1>>
		<FIX-LON-LAT -2 0>)
	       (<EQUAL? ,PRSO ,P?NW>
		<SETG DESERT-LOC <- ,DESERT-LOC 51>>
		<FIX-LON-LAT -2 2>)>>

<ROUTINE FIX-LON-LAT (INC-LON INC-LAT)
	 <COND (.INC-LON
		<SETG SECS-LON <+ ,SECS-LON .INC-LON>>
		<COND (<G? ,SECS-LON 60>
		       <SETG SECS-LON 1>
		       <SETG MINS-LON <+ ,MINS-LON 1>>
		       <COND (<G? ,MINS-LON 59>
			      <SETG MINS-LON 0>
			      <SETG DEGS-LON <+ ,DEGS-LON 1>>)>)
		      (<L? ,SECS-LON 1>
		       <SETG SECS-LON 59>
		       <SETG MINS-LON <- ,MINS-LON 1>>
		       <COND (<L? ,MINS-LON 0>
			      <SETG MINS-LON 59>
			      <SETG DEGS-LON <- ,DEGS-LON 1>>)>)>)>
	 <COND (.INC-LAT
		<SETG SECS-LAT <+ ,SECS-LAT .INC-LAT>>
		<COND (<G? ,SECS-LAT 60>
		       <SETG SECS-LAT 1>
		       <SETG MINS-LAT <+ ,MINS-LAT 1>>
		       <COND (<G? ,MINS-LAT 59>
			      <SETG MINS-LAT 0>
			      <SETG DEGS-LAT <+ ,DEGS-LAT 1>>)>)
		      (<L? ,SECS-LAT 1>
		       <SETG SECS-LAT 59>
		       <SETG MINS-LAT <- ,MINS-LAT 1>>
		       <COND (<L? ,MINS-LAT 0>
			      <SETG MINS-LAT 59>
			      <SETG DEGS-LAT <- ,DEGS-LAT 1>>)>)>)>>

<ROUTINE ROB-HIM-BLIND ("AUX" F N (FLG <>))
	 <SET F <FIRST? ,WINNER>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<REMOVE .N>
			<SET FLG T>)>>
	 .FLG>
	 

<GLOBAL SECS-LAT 0>
<GLOBAL SECS-LON 0>
<GLOBAL MINS-LAT 0>
<GLOBAL MINS-LON 0>
<GLOBAL DEGS-LAT 0>
<GLOBAL DEGS-LON 0>

<GLOBAL PROP-TBL
	<TABLE 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

<ROUTINE PROP-TO-TBL (SLOC "AUX" (TBL ,PROP-TBL) (CNT 0) DUG)
	 <SET DUG <GETP ,HERE ,P?CAPACITY>>
	 <COND (<EQUAL? .DUG 0>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<==? <GET .TBL .CNT> 0>
			<PUT .TBL .CNT .SLOC>
			<PUT .TBL <+ .CNT 1> .DUG>
			<PUTP ,HERE ,P?CAPACITY 0> ;"Huh?"
			<SET CNT <+ .CNT 2>>
			<RETURN>)
		       (ELSE
			<SET CNT <+ .CNT 2>>)>>>

<ROUTINE TBL-TO-PROP (SLOC "AUX" (TBL ,PROP-TBL) (CNT 0))
	 <REPEAT ()
		 <COND (<NOT <L? .CNT 120>>
			<RETURN>)
		       (<==? <GET .TBL .CNT> .SLOC>
			<PUT .TBL .CNT 0>
			<PUTP ,HERE ,P?CAPACITY <GET .TBL <+ .CNT 1>>>)>
		 <SET CNT <+ .CNT 2>>>>

<OBJECT C-SAND
	(FLAGS NDESCBIT)
	(DESC "quantity of sand")
	(SYNONYM SAND)>
		       
<OBJECT KNAPSACK
	(IN TENT2)
	(DESC "knapsack")
	(FLAGS TRYTAKEBIT TAKEBIT CONTBIT SEARCHBIT)
	(SIZE 5)
	(CAPACITY 60)
	(SYNONYM SACK KNAPSA)
	(ADJECTIVE KNAP)
	(FDESC
"Sitting in the sand, bulging a little, is a beaten-up knapsack.")
	(ACTION WEAR-THE-SACK)>

<ROUTINE WEAR-THE-SACK ("AUX" ON-IN?)
	 <SET ON-IN? "in">
	 <COND (<EQUAL? ,KNAPSACK ,PRSO>
		<COND (<VERB? WEAR>
		       <COND (<NOT <IN? ,KNAPSACK ,WINNER>>
			      <COND (<NOT <ITAKE>>
				     <RTRUE>)
				    (T
				     <COND (<NOT <EQUAL? ,PRSI ,NASTY-CROC>>
					    <TELL "(taken)" CR>)
					   (T
					    <TELL "(wearing it)" CR>)>)>)>
		       <TELL 
"You swing the knapsack over your shoulders and it settles on your back as its
cover flap closes." CR>
		       <FCLEAR ,KNAPSACK ,OPENBIT>
		       <FSET ,KNAPSACK ,WEARBIT>
		       <THIS-IS-IT ,KNAPSACK>)
		      (<AND <VERB? PUT PUT-ON>
			    <EQUAL? ,PRSI ,ME>>
		       <PERFORM ,V?WEAR ,KNAPSACK>
		       <THIS-IS-IT ,KNAPSACK>
		       <RTRUE>)
		      (<AND <VERB? PUT PUT-ON>
			    ,PRSI>
		       <COND (<EQUAL? ,PRSI ,KNAPSACK>
			      <TELL "Sure. Just like a Klein Bottle, eh?" CR>
			      <RTRUE>)
			     (<EQUAL? ,PRSI ,CRACK>
			      <PERFORM ,PRSA ,PRSO ,GROUND>
			      <RTRUE>)
			     (<PRSI? ,FOLDED-COT>
			      <TELL "Bizarre!" CR>
			      <RTRUE>)
			     (<NOT <FSET? ,KNAPSACK ,WEARBIT>>
			      <RFALSE>)
			     (T
			      <COND (<AND <EQUAL? ,PRSI ,GROUND>
					  <GETP ,HERE ,P?MAP>
					  <NOT <IN-A-TENT?>>>
				     <SETG PRSI ,SAND>)>
			      <COND (<FSET? ,PRSI ,SURFACEBIT>
				     <SET ON-IN? "on">)>
			      <COND (<AND <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
					  <NOT <FSET? ,PIT ,INVISIBLE>>
					  <EQUAL? ,PRSI ,PIT ,GROUND>>
				     <TELL "Dropped." CR>
				     <SETG P-IT-LOC <>>)
				    (T <TELL
"You take the knapsack off and place it " .ON-IN? " the " D ,PRSI
". As it settles " .ON-IN? " the " D ,PRSI ", the cover flaps open." CR>)>
			      <FCLEAR ,KNAPSACK ,WEARBIT>
			      <FSET ,KNAPSACK ,OPENBIT>
			      <COND (<EQUAL? ,PRSI ,GROUND ,SAND>
				     <IDROP>)
				    (T
				     <MOVE ,KNAPSACK ,PRSI>)>
			      <THIS-IS-IT ,KNAPSACK>
			      <RTRUE>)>)
		      (<AND <VERB? OPEN>
			    <FSET? ,KNAPSACK ,WEARBIT>>
		       <TELL 
"You reach around behind to lift the flap on the top of the knapsack, but it
keeps falling back down." CR>
		       <THIS-IS-IT ,KNAPSACK>
		       <RTRUE>)
		      (<AND <VERB? SHAKE>
			    <FSET? ,KNAPSACK ,WEARBIT>>
		       <TELL
"Better take it off first. Unless you want to do a few headstands." CR>
		       <THIS-IS-IT ,KNAPSACK>
		       <RTRUE>)
		      (<VERB? FIND>
		       <COND (<FSET? ,KNAPSACK ,WEARBIT>
			      <TELL "It's on your back!" CR>
			      <RTRUE>)
			     (T
			      <RFALSE>)>)
		      (<AND <VERB? LOOK-INSIDE EXAMINE>
			    <FSET? ,KNAPSACK ,WEARBIT>>
		       <TELL
"Your neck doesn't crane back that far. Better take it off first." CR>
		       <THIS-IS-IT ,KNAPSACK>
		       <RTRUE>)
		      (<VERB? DISEMBARK DROP>
		       <COND (<NOT <FSET? ,KNAPSACK ,WEARBIT>>
			      <TELL "You aren't wearing it!" CR>
			      <RTRUE>)
			     (T
			      <COND (<AND <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
					  <NOT <FSET? ,PIT ,INVISIBLE>>>
				     <TELL "Dropped." CR>
				     <SETG P-IT-LOC <>>)
				    (T <TELL
"You take the knapsack off and place it down. As it settles, the cover flaps
open." CR>)>
			      <FCLEAR ,KNAPSACK ,WEARBIT>
			      <FSET ,KNAPSACK ,OPENBIT>
			      <IDROP>
			      <THIS-IS-IT ,KNAPSACK>
			      <RTRUE>)>)
		      (<VERB? TAKE>
		       <COND (<AND <FSET? ,PRSO ,WEARBIT>
			           <OR <EQUAL? <GET ,P-VTBL 0> ,W?REMOVE>
				       <EQUAL? ,PRSI ,ME>>>
			      <PERFORM ,V?DISEMBARK ,PRSO>
			      <RTRUE>)
			     (T
			      <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
				     <PERFORM ,V?WEAR ,PRSO ,NASTY-CROC>
				     <RTRUE>)
				    (T <TELL "You already have it." CR>
				     <RTRUE>)>)>)>)
	       (<EQUAL? ,KNAPSACK ,PRSI>
		<COND (<VERB? PUT>
		       <COND (<FLAMING? ,PRSO>
			      <TELL
"Don't you think you should put out the " D ,PRSO " first?" CR>
			      <RTRUE>)
			     (<PRSO? ,SHOVEL ,BEAM ,CRATE>
			      <TELL
"That's like trying to fit a Beethoven Symphony into a music box." CR>
			      <RTRUE>)
			     (<PRSO? ,SAND ,WATER ,GLOBAL-WATER>
			      <TELL 
"It would only seep through the roughly-stitched seams, so why bother?" CR>
			      <RTRUE>)
			     (T
			      <FSET ,PRSO ,TOUCHBIT>
			      <RFALSE>)>)
		      (<VERB? TAKE>
		       <COND (<FSET? ,KNAPSACK ,OPENBIT>
			      <RFALSE>)
			     (<FSET? ,KNAPSACK ,WEARBIT>
			      <TELL 
"Your arms don't reach back that far, and groping around in the sack isn't the
best of ideas. It would help if you took it off first." CR>
			      <THIS-IS-IT ,KNAPSACK>
			      <RTRUE>)
			     (T
			      <TELL "The knapsack isn't open." CR>
			      <THIS-IS-IT ,KNAPSACK>
			      <RTRUE>)>)
		      (ELSE
		       <RFALSE>)>)
	       (T
		<RFALSE>)>>

<OBJECT CRATE
	(IN GLOBAL-OBJECTS)
	(DESC "packing crate")
	(FLAGS CONTBIT TRANSBIT TAKEBIT BURNBIT SEARCHBIT READBIT SURFACEBIT
	       OPENBIT)
	(CAPACITY 10)
	(SIZE 10)
	(SYNONYM CRATE LABEL)
	(ADJECTIVE PACKIN)
	(FDESC
"Lying in the sand is a wooden packing crate.")
	(ACTION CRATE-FCN)>

<ROUTINE CRATE-FCN ("AUX" (FLG <>))
	 <COND (<AND <VERB? READ EXAMINE>
		     <OR <IN? ,CRATE <LOC ,WINNER>>
			 <IN? ,CRATE ,HERE>
			 <IN? ,CRATE ,WINNER>
			 <EQUAL? <LOC ,CRATE> <LOC ,WINNER>>
			 <EQUAL? <LOC ,CRATE> ,WINNER>
			 <AND <IN? ,CRATE ,KNAPSACK>
			      <EQUAL? <LOC ,KNAPSACK> ,HERE>>>>
		<TELL
"The crate is slightly beaten up from the landing, but it seems to have held
together fairly well. There's a small label on it that says \"This crate
contains 1 (one) black box (tm).\"" CR>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     <IN? ,CRATE ,GLOBAL-OBJECTS>
		     <NOT <IN-A-TENT?>>
		     <G? ,MOVES 4>>
		<TELL 
		 "It's coming down, and it looks like it should land near you!" CR>)
	       (<AND <VERB? EXAMINE>
		     <IN? ,CRATE ,GLOBAL-OBJECTS>
		     <IN-A-TENT?>>
		<TELL "I think you've got crates on the mind!" CR>)
	       (<AND <VERB? MUNG>
		     <NOT <IN? ,CRATE ,GLOBAL-OBJECTS>>>
		<COND (<PRSI? ,SHOVEL ,PICK-AXE>
		       <TELL 
"Wood chips fly from the crate, hurtling into the sand all around, as the crate
suffers your frenzied attack. The defenseless packing crate looks as if to flee
but before it can react (growing legs is a time-consuming task) there is
nothing left of it but a mere memory. (You really should seek some
psychological counselling.)" CR>
		       <COND (<NOT <FSET? ,BLACK-BOX ,TOUCHBIT>>
			      <MOVE ,BLACK-BOX ,HERE>
			      <FSET ,BLACK-BOX ,RMUNGBIT>)>
		       <REMOVE ,PRSO>
		       <SETG P-IT-LOC <>>
		       <RTRUE>)>)
	       (<AND <NOT <IN? ,CRATE ,GLOBAL-OBJECTS>>
		     <OR <VERB? BURN>
			 <AND <VERB? DROP>
			      <PRSI? ,CRATE>
			      <FLAMING? ,PRSO>>>>
		<TELL
"Well, who would have thought it? The crate catches fire quickly, the flames
leaping about in mad abandon, gaily changing color as the heat becomes more and
more intense. You hear a sizzling">
		<COND (<NOT <FSET? ,BLACK-BOX ,TOUCHBIT>>
		       <JIGS-UP 
"... followed by an explosion which takes place right before your face.
Needless to say, your body didn't appreciate it.">)
		      (T
		       <TELL
" as the crate consumes itself in gleeful merriment." CR>
		       <REMOVE ,CRATE>
		       <SETG P-IT-LOC <>>)>
		<RTRUE>)
	       (<VERB? STAND-UNDER>
		<RFALSE>)
	       (<AND <VERB? BOARD>
		     <NOT <IN? ,CRATE GLOBAL-OBJECTS>>>
		<TELL
"You couldn't fit in there unless you put yourself through a trash compacter." CR> <RTRUE>)
	       (<IN? ,CRATE ,GLOBAL-OBJECTS>
		<TELL 
"Hey, give it a chance to get here. I know you're impatient to get on with
this, but be reasonable!" CR>
		<RTRUE>)
	       (<VERB? OPEN>
		<TBL-TO-INSIDE ,CRATE ,CRATE-TBL
"The crate opens slowly, the boards creaking with the strain.">
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <NOT <FSET? ,CRATE ,SURFACEBIT>>>
		<COND (<AND <IN? ,TORCH ,CRATE>
			    <FLAMING? ,TORCH>>
		       <SET FLG T>)>
		<INSIDE-OBJ-TO ,CRATE-TBL ,CRATE>
		<COND (.FLG
		       <KILL-TORCH T>)>
		<RTRUE>)
	       (<VERB? SHAKE>
		<COND (<NOT <0? <GET ,CRATE-TBL 1>>>
		       <TELL "Hmm. Something's in there." CR>
		       <RTRUE>)>)>>
		
<GLOBAL CRATE-TBL ;"Thirty (30) slots to hold objects in the crate"
	<LTABLE BLACK-BOX 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

<OBJECT BLACK-BOX
	(FLAGS TAKEBIT TRYTAKEBIT CONTBIT OPENBIT SURFACEBIT)
	(DESC "navigation box")
	(SYNONYM BOX)
	(ADJECTIVE NAVIGA BLACK)
	(CAPACITY 10)
	(TEXT
"This is an expensive, state-of-the-art piece of electronic equipment. It was
designed to automatically determine longitude and latitude when the button on
it is pressed. Thankfully, it has at last arrived.")
	(ACTION BOX-OPENER-FCN)>

<ROUTINE BOX-OPENER-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "To do that to the " D ,BLACK-BOX " would most probably
ruin the delicate equipment inside." CR>
		<RTRUE>)
	       (<VERB? CLOSE>
		<TELL "I didn't know it was open." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL <GETP ,PRSO ,P?TEXT> CR>
		<RTRUE>)
	       (<VERB? LAMP-ON>
		<PERFORM ,V?PUSH ,BUTTON>
		<RTRUE>)
	       (<VERB? LAMP-OFF>
		<TELL "It turns itself off after each button press." CR>
		<RTRUE>)
	       (<AND <VERB? THROW THROW-DOWN MUNG ATTACK SHAKE>
		     <EQUAL? ,PRSO ,BLACK-BOX>>
		<TELL "Rattle, rattle, jostle, crunch. Oh oh..." CR>
		<FSET ,BLACK-BOX ,RMUNGBIT>
		<COND (<VERB? THROW THROW-DOWN>
		       <MOVE ,PRSO ,HERE>)>
		<RTRUE>)>>

<OBJECT BUTTON
	(IN BLACK-BOX)
	(FLAGS NDESCBIT)
	(DESC "button")
	(SYNONYM BUTTON)
	(ADJECTIVE NAVIGA)
	(ACTION PRESS-BUTTON-FCN)>

<GLOBAL NOISES-LTBL
	<LTABLE "Crinkle fweep" "Bleeeeeeeeeep" "Sproing" "Screetchle frop"
		"Breeble grungle">>

<ROUTINE PRESS-BUTTON-FCN ("AUX" (OFFS -3) LAT-S LON-S H-CK)
	 <COND (<VERB? PUSH>
	        <COND (<FSET? ,BLACK-BOX ,RMUNGBIT>
		       <TELL <PICK-ONE ,NOISES-LTBL> "!" CR>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,ENDLESS-DESERT>
		       <TELL 
"The box comes to life, its L.E.D.s lighting, and then flashes " N ,DEGS-LAT>
		       <TELL " degree">
		       <COND (<NOT <EQUAL? ,DEGS-LAT 1>>
			      <TELL "s">)>
		       <TELL " " N ,MINS-LAT " minute">
		       <COND (<NOT <EQUAL? ,MINS-LAT 1>>
			      <TELL "s">)>
		       <TELL " " N ,SECS-LAT " seconds N latitude, ">
		       <TELL N ,DEGS-LON>
		       <TELL " degree">
		       <COND (<NOT <EQUAL? ,DEGS-LON 1>>
			      <TELL "s">)>
		       <TELL " " N ,MINS-LON " minute">
		       <COND (<NOT <EQUAL? ,MINS-LON 1>>
			      <TELL "s">)>
		       <TELL " " N ,SECS-LON " seconds E longitude."  CR>)
		      (<NOT <GETP ,HERE ,P?MAP>>
		       <TELL 
"There's no need for that here. It's obvious where you are." CR>
		       <RTRUE>)
		      (T
		       <COND (<EQUAL? ,HERE ,TENT>
			      <SET H-CK ,P2>)
			     (<EQUAL? ,HERE ,TENT2>
			      <SET H-CK ,P7>)
			     (<EQUAL? ,HERE ,SUPPLY-TENT>
			      <SET H-CK ,P4>)
			     (ELSE
			      <SET H-CK ,HERE>)>
		        <REPEAT ()
			       <SET OFFS <+ .OFFS 3>>
			       <COND (<G? .OFFS 54>
				      <RETURN>)
				     (T
				      <COND (<EQUAL? .H-CK
						     <GET ,MAP-TBL .OFFS>>
					     <SET LON-S
						  <GET ,MAP-TBL <+ .OFFS 1>>>
					     <SET LAT-S
						  <GET ,MAP-TBL <+ .OFFS 2>>>
					     <RETURN>)>)>>
		       <TELL 
"The box comes to life, its L.E.D.s lighting, and then flashes 24 degrees 11
minutes "
			 N .LAT-S
" seconds N latitude, 32 degrees 12 minutes "
			 N .LON-S " seconds E longitude." CR>)>)
	       (<VERB? FIND>
		<TELL "It's on the top of the box." CR>
		<RTRUE>)>>

<ROUTINE DIASMBIGUATE-FCN (OBJECT)
	 <COND (<IN? ,ONE-MATCH ,WINNER>
		<RETURN ,ONE-MATCH>)
	       (<IN? ,MATCHES ,WINNER>
		<COND (<NOT <FSET? ,MATCHES ,OPENBIT>>
		       <TELL "(opening matchbook first)" CR>
		       <FSET ,MATCHES ,OPENBIT>)>
		<COND (<G? ,MATCH-COUNT 1>
		       <RETURN ,MANY-MATCHES>)
		      (<EQUAL? ,MATCH-COUNT 1>
		       <RETURN ,SINGLE-MATCH>)
		      (ELSE
		       <RETURN ,EMPTY-MATCHES>)>)
	       (ELSE
		<RETURN ,ONE-MATCH>)>>

<GLOBAL MAP-TBL      ;" Loc    Long   Lat    seconds only!"
	<TABLE    RIVER-BANK	33 	7
		  	P1	35	7
			P2	37	7
			P3	39	7
			EX1	41	7
			EX2	43	7
			EX3	45	7
			P4	35	5
			FIRE	37	5
			P5 	39	5
			EX4	41	5
			EX5	43	5
			EX6	45	5
			P6	35	3 	
			P7	37 	3 
			P8	39 	3
			EX7	41 	3 
			EX8     43 	3 
			EX9	45 	3>>


