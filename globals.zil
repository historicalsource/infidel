"GLOBALS for
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<DIRECTIONS NORTH EAST WEST SOUTH UP DOWN IN OUT SE SW NE NW>

"SUBTITLE GLOBAL OBJECTS"

<OBJECT GLOBAL-OBJECTS
	(FLAGS RMUNGBIT INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT
	       VOWELBIT OPENBIT SEARCHBIT TRANSBIT WEARBIT ONBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK)
	(DESCFCN 0)
        (GLOBAL GLOBAL-OBJECTS)
	(PSEUDO "FOOBAR" V-WAIT)
	(CONTFCN 0)
	(SIZE 0)>
;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

<OBJECT ROOMS>

<OBJECT BASIE
	(IN GLOBAL-OBJECTS)
	(SYNONYM BASIE)
	(DESC "Basie")>

<OBJECT PETROL
	(IN GLOBAL-OBJECTS)
	(SYNONYM GASOLI PETROL)
	(DESC "gasoline")>

<OBJECT FOO-TOOL
	(IN GLOBAL-OBJECTS)
	(SYNONYM HAMMER CROWBA EXPLOS MACHET)
	(DESC "such thing")>

<OBJECT DRACULA
	(IN GLOBAL-OBJECTS)
	(SYNONYM DRACULA)
	(DESC "Dracula")>

<OBJECT FINGER
	(IN GLOBAL-OBJECTS)
	(FLAGS SURFACEBIT OPENBIT CONTBIT TOUCHBIT)
	(CAPACITY 1)
	(SYNONYM FINGER)
	(DESC "finger")
	(ACTION FINGER-FCN)>

<ROUTINE FINGER-FCN ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSI? ,FINGER>>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<FSET? ,RING ,WEARBIT>
		       <TELL "Sitting on your finger is a ring." CR>
		       <RTRUE>)
		      (T
		       <TELL "It's part of your hands." CR>
		       <RTRUE>)>)>>

<OBJECT BLESSINGS
	(IN GLOBAL-OBJECTS)
	(SYNONYM BLESSI)
	(DESC "blessings")>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(DESC "number")>

<OBJECT INTDIR
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTDIR)
	(ADJECTIVE NORTH EAST SOUTH WEST NE NW SE SW)
	(FLAGS TOOLBIT)
	(DESC "direction")>

<OBJECT PSEUDO-OBJECT
	(DESC "pseudo")
	(ACTION CRETIN)>

<OBJECT IT	;"was IT"
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THAT)
	(DESC "random object")
	(FLAGS NDESCBIT TOUCHBIT)>

<OBJECT AIR
	(IN GLOBAL-OBJECTS)
	(DESC "air")
	(FLAGS VOWELBIT CONTBIT OPENBIT)
	(SYNONYM AIR OXYGEN SKY)
	(TEXT
"The air is as clear as any Egyptian air can be.")
	(ACTION AIR-FCN)>

<ROUTINE AIR-FCN ()
	 <COND (<VERB? EXAMINE SMELL TASTE>
		<COND (<GETP ,HERE ,P?MAP>
		       <RFALSE>)
		      (T
		       <TELL "It's stale and musty" CR>
		       <RTRUE>)>)
	       (<VERB? OPEN CLOSE>
		<TELL "I think you're an air head." CR>)
	       (<AND <PRSI? AIR>
		     <VERB? EXAMINE LOOK-INSIDE>>
		<PERFORM ,V?LOOK-UP>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSI ,AIR>
		     <VERB? THROW DROP>>
		<PERFORM ,PRSA ,PRSO ,GROUND>
		<RTRUE>)
	       (<AND <VERB? WAVE>
		     <PRSO? ,AIR>>
		<TELL "Don't expect me to tell you the sky waves back." CR>
		<RTRUE>)>>

<OBJECT GROUND	;"was GROUND"
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND)
	(DESC "floor")
	(ACTION READ-FLOOR-F)>

<ROUTINE READ-FLOOR-F ()
	 <COND (<AND <VERB? EXAMINE READ>
		     <EQUAL? ,HERE ,CENTRAL-ROOM>>
		<PERFORM ,V?READ ,HIEROGLYPHS>
		<RTRUE>)>>

<OBJECT CRACK
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT CONTBIT OPENBIT)
	(DESC "crack")
	(SYNONYM CRACK)
	(TEXT
"It's just a crack in the floor where the stones meet.")
	(ACTION CRACK-FCN)>

<ROUTINE CRACK-FCN ()
	 <COND (<OR <GETP ,HERE ,P?MAP>
		    <EQUAL? <GETP ,HERE ,P?ACTION> ,BURN-THE-BARGE>
		    <AND <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
			 <NOT <FSET? ,PIT ,INVISIBLE>>>>
		<TELL "I see no crack here." CR>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"Get real. There's nothing worth looking at in there." CR>
		<RTRUE>)>>

<OBJECT SAND
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT)
	(DESC "sand")
	(SYNONYM DESERT SAND GROUND)>

<OBJECT HOLE
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT)
	(DESC "hole")
	(SYNONYM HOLE)
	(ADJECTIVE SMALL ENLARG SIZABL KNEE- DEEP)
	(ACTION HOLE-FCN)>

<ROUTINE HOLE-FCN ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<AND <EQUAL? ,HERE ,P8>
			    <IN? ,PYRAMID ,HERE>>
		       <TELL
"You can see the block and the opening in there." CR>)
		      (<G? <GETP ,HERE ,P?CAPACITY> 0>
		       <TELL "Never mind that -- Here's a better
problem: You dig a hole 52 feet by 20 feet by .105 yards. It takes you 5
hours, 11 minutes and 2 seconds. You sweat off thirty grams of water
per hour. And your best friend just ran off with the rent money. Now:
How much sand is in the hole you dug?" CR>)
		      (T
		       <TELL "I don't see any hole here." CR>)>)
	       (<VERB? FIND>
		<COND (<GETP ,HERE ,P?CAPACITY>
		       <TELL "It's right here." CR>
		       <RTRUE>)>)
	       (<AND <EQUAL? ,PRSI ,HOLE>
		     <VERB? PUT>
		     <GETP ,HERE ,P?CAPACITY>>
		<TELL 
"It's just a hole in the sand from your excavation attempts. There's no need to
put anything into it." CR>)>>

<OBJECT PEN-PENCIL
	(IN GLOBAL-OBJECTS)
	(DESC "writing implement")
	(SYNONYM PEN PENCIL)>

<OBJECT STONES
	(IN GLOBAL-OBJECTS)
	(SYNONYM STONES BLOCKS)
	(DESC "stones")>

<OBJECT KEY
	(IN GLOBALS)
	(FLAGS NDESCBIT)
	(DESC "key")
	(SYNONYM KEY)
	(ADJECTIVE TRUNK)>

<OBJECT BULKHEADS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "bulkhead")
	(SYNONYM BULKHE)>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(ADJECTIVE STONE)
	(ACTION WALL-FCN)>

<ROUTINE WALL-FCN ("AUX" RMG RMGL)
	 <COND (<AND <EQUAL? ,HERE ,STAIRS-BOTTOM>
		     <VERB? EXAMINE READ>>
		<COND (<IN? ,PLASTER1 ,STAIRS-BOTTOM>
		       <PERFORM ,V?EXAMINE ,PLASTER1>
		       <RTRUE>)
		      (T <TELL "I see nothing special about the wall." CR>
		       <RTRUE>)>)
	       (<VERB? EXAMINE READ>
		<COND (<AND <GLOBAL-IN? ,HIEROGLYPHS ,HERE>
			    <NOT <EQUAL? ,HERE ,CENTRAL-ROOM>>>
		       <PERFORM ,V?READ ,HIEROGLYPHS>
		       <RTRUE>)
		      (ELSE
		       <RFALSE>)>)>>
		
<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN)>

<OBJECT HANDS	;"was HANDS"
	(IN GLOBAL-OBJECTS)
	(SYNONYM HANDS)
	(DESC "empty hands")
	(FLAGS NDESCBIT TOOLBIT TOUCHBIT VOWELBIT)
	(ACTION READ-PALMS-F)>

<ROUTINE READ-PALMS-F ()
	 <COND (<VERB? READ>
		<TELL "I don't read palms." CR>
		<RTRUE>)>>

<OBJECT ADVENTURER
	(IN TOP-OF-STAIRWAY)
	(SYNONYM PLAYER ADVENT CRETIN)
	(DESC "cretin")
        (FLAGS ACTORBIT NDESCBIT INVISIBLE)>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF SELF BACK)
	(DESC "you")
	(FLAGS ACTORBIT)
	(ACTION CRETIN)>

<ROUTINE CRETIN ()
	 <COND (<NOT <EQUAL? ,PRSO ,WINNER ,ME>>
		<RFALSE>)>
	 <COND (<VERB? EAT>
		<TELL
"I've heard of biting one's knuckles, chewing one's fingernails, but don't you
think that's a little extreme?" CR>)
	       (<VERB? DRINK>
		<TELL
"Find me a blender, jump in it, and once you're liquified, we'll talk." CR>)
	       (<VERB? ALARM>
		<TELL 
"Good morning!" CR>)
	       (<VERB? MUNG ATTACK KILL>
		<TELL
"Hey, I know just how you feel. And I'm sure you think you deserve it -- I've
been there myself. But take heart -- let nature take care of you. I'm sure it
will, in time." CR>)
	       (<VERB? PRAY>
		<TELL "Save yourself. Don't look to me, man." CR>)
	       (<VERB? FIND>
		<TELL "Take a course in Zen." CR>)
	       (<VERB? TAKE>
		<TELL "Auto-eroticism is not the answer." CR>)
	       (<VERB? BURN>
		<TELL "Come on. Don't you have enough troubles?" CR>)
	       (<VERB? EXAMINE LOOK-INSIDE THROW>
		<TELL
"Hmmm. How do you propose I accomplish that? (And they told me in AI school
the intelligent creatures were on the other side of the keyboard!)" CR>)
	       (<VERB? RUB>
		<TELL 
"Go rub yourself. You're starting to rub me the wrong way." CR>)
	       (<VERB? PLAY>
		<TELL "Who do you think you're playing around with?" CR>)
	       (<VERB? CLIMB-ON BOARD>
		<TELL "I'll get on your case is what I'll do, turkey." CR>)
	       (<VERB? CLEAN>
		<TELL "Take a bath. Leave me out of this." CR>)
	       (<VERB? CLOSE>
		<TELL "Better yet, close your mouth." CR>)
	       (<VERB? CROSS>
		<TELL "Crossed and double-crossed, sucker." CR>)
	       (<VERB? DISEMBARK>
		<TELL "What makes you think you deserve it?" CR>)
	       (<VERB? DROP>
		<TELL "Like a hot potato." CR>)
	       (<VERB? LEAN-ON OPEN>
		<TELL "I think you've got enough troubles." CR>)
	       (<VERB? FOLLOW>
		<TELL "What makes you think you know where you're going?" CR>)
	       (<VERB? LISTEN>
		<TELL "Do I have a choice?" CR>)
	       (<VERB? SEARCH>
		<TELL "Okay. I found one empty head but a strong heart." CR>)
	       (<VERB? MAKE>
		<TELL "I doubt anyone could make you do anything with that attitude." CR>)
	       (<VERB? SHAKE>
		<TELL "Shake, rattle and roll." CR>)
	       (<VERB? SMELL>
		<TELL "Phew! When was the last time you bathed?" CR>)
	       (<VERB? SQUEEZE>
		<TELL "Like a python, eh?" CR>)
	       (<VERB? THROW>
		<TELL "For a loop?" CR>)
	       (<VERB? WEAR>
		<TELL "How many layers of skin does one human need?" CR>)
	       (ELSE
		<RFALSE>)>
	 <RTRUE>>

<OBJECT DOORWAY
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT CONTBIT OPENBIT)
	(DESC "doorway")
	(SYNONYM DOORWAY OPENIN)
	(ADJECTIVE ARCHED TIMBER)
	(ACTION DOORWAY-FCN)>

<ROUTINE DOORWAY-FCN ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<AND <EQUAL? ,HERE ,NORTH-ANTECHAMBER ,BURIAL-CHAMBER>
			    <EQUAL? ,BEAM-PLACED 4>>
		       <TELL
"The mast is in the doorway, running from top to bottom." CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,SOUTH-ANTECHAMBER ,ANNEX>
			    <EQUAL? ,BEAM-PLACED 2 3>>
		       <TELL 
"The beam is wedged in the doorway from side to side." CR>
		       <RTRUE>)>)>>

<OBJECT PICTURE-PANELS
	(IN LOCAL-GLOBALS)
	(DESC "panel")
	(FLAGS NDESCBIT)
	(SYNONYM PANEL PANELS)
	(ADJECTIVE GOLD RED CLAY BEATEN)
	(ACTION PANEL-ON-WALL-FCN)>

<ROUTINE PANEL-ON-WALL-FCN ()
	 <COND (<VERB? EXAMINE READ>
		<TELL 
"The panels are beautiful pieces of art, to be appreciated by the Queen on her
journey through the Netherworld." CR>
		<COND (<GLOBAL-IN? ,HIEROGLYPHS ,HERE>
		       <PERFORM ,V?READ ,HIEROGLYPHS>
		       <RTRUE>)>
		<RTRUE>)>>
		

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(SYNONYM STAIRS STEPS LADDER STAIRWAY)
	(DESC "stairs")
	(FLAGS NDESCBIT CLIMBBIT TOUCHBIT)
	(ACTION DESC-STAIRS-F)>

<ROUTINE DESC-STAIRS-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,AFT-CABIN ,BELOW-DECK>>
		<TELL "The ladder is made of wood, and it looks fairly sturdy."
		      CR>
		<RTRUE>)>>

<OBJECT PARACHUTE
	(IN GLOBAL-OBJECTS)
	(SYNONYM PARACH CHUTE)
	(DESC "parachute")
	(ACTION GOOD-LUCK-FCN)>

<OBJECT PLANE
	(IN GLOBAL-OBJECTS)
	(DESC "airplane")
	(SYNONYM PLANE AIRPLA PILOT)
	(TEXT
"Its a small, one-engine plane, similar in shape to the old Piper Cubs.")
	(ACTION PLANE-FCN)>

<ROUTINE PLANE-FCN ()
	 <COND (<VERB? WAVE>
		<COND (<AND <L? ,MOVES 8>
			    <NOT <IN-A-TENT?>>>
		       <TELL "The plane dips its wings in salute." CR>)
		      (<L? ,MOVES 8>
		       <TELL 
"You wave at the plane through the top of the tent. Somehow, I doubt it
noticed." CR>)
		      (T
		       <TELL "The plane's returned to its home base." CR>)>)
	       (<VERB? FIND>
		<COND (<G? ,MOVES 8>
		       <TELL "I suppose it's up in the air, somewhere." CR>)
		      (T
		       <TELL "It's somewhere up over your head." CR>)>)
	       (<VERB? EXAMINE>
		<COND (<AND <NOT <IN-A-TENT?>>
			    <L? ,MOVES 8>>
		       <RFALSE>)
		      (<L? ,MOVES 8>
		       <TELL 
"All I can tell you about it is that it's out there." CR>)
		      (T
		       <TELL "The plane's far gone, amigo." CR>)>)
	       (<AND <VERB? LISTEN>
		     <L? ,MOVES 9>>
		<TELL "RRRRRRRrrrrrrr r r r r r   r    r     r." CR>
		<RTRUE>)
	       (T
		<COND (<G? ,MOVES 8>
		       <TELL "What plane? It's gone!" CR>)
		      (T
		       <TELL
"Leave the plane alone. It's not bothering you." CR>)>
		<RTRUE>)>>

<ROUTINE GOOD-LUCK-FCN ()
	 <COND (<VERB? FIND>
		<COND (<L? ,MOVES 8>
		       <TELL "Look up!" CR>)
		      (T
		       <TELL
"It's gone with the wind, never to be seen again." CR>)>)
	       (<VERB? EXAMINE>
		<COND (<AND <G? ,MOVES 4>
			    <L? ,MOVES 8>>
		       <TELL "It's white." CR>)
		      (<L? ,MOVES 5>
		       <TELL "What parachute?" CR>)
		      (T
		       <TELL
"The most I can tell you is that it was white." CR>)>)
	       (<VERB? STAND-UNDER>
		<RFALSE>)
	       (T
		<COND (<G? ,MOVES 7>
		       <TELL 
"Forget the chute, amigo. It's history. And if you don't get on with this, you
will be too." CR>)
		      (T
		       <TELL "Leave the parachute alone." CR>)>
		<RTRUE>)>>

<OBJECT SIP
	(IN GLOBAL-OBJECTS)
	(FLAGS TAKEBIT)
	(DESC "sip of water")
	(SYNONYM SIP)
	(ACTION SIP-FCN)>

<ROUTINE SIP-FCN ()
	 <COND (<AND <EQUAL? ,PRSO ,SIP>
		     <VERB? TAKE>>
		<COND (<OR <NOT ,PRSI>
			   <PRSI? ,WATER>>
		       <PERFORM ,V?DRINK ,WATER>
		       <RTRUE>)
		      (<EQUAL? ,PRSI ,LIQUID>
		       <PERFORM ,V?DRINK ,LIQUID>)
		      (ELSE
		       <TELL "No, I don't think I quite understand." CR>)>)
	       (ELSE
		<TELL "Now that's an interesting thought." CR>)>>

;"GLOBAL VARIABLES"

<GLOBAL HERE <>>

<GLOBAL LOAD-ALLOWED 100>

<GLOBAL LOAD-MAX 0>

<GLOBAL LIT T>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL INDENTS
	<TABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

;"******************************************
	Here come the globals
********************************************"

<GLOBAL STATUE-TBL
	<TABLE ISIS NEPHTHYS NEITH SELKIS>>
<GLOBAL STATUE-NAME-TBL
	<TABLE "Isis" "Nephthys" "Neith" "Selkis">>
<GLOBAL ORDER-LTBL
	<LTABLE NEITH SELKIS ISIS NEPHTHYS>>
<GLOBAL TURNED-LTBL
	<LTABLE <> <> <> <>>>
<GLOBAL DOWN-LTBL
	<LTABLE LANDING-ZERO LANDING-ONE LANDING-TWO LANDING-THREE>>

<GLOBAL SOMETHING-DROPPED <>>
<GLOBAL WHAT-WAS-DROPPED <>>
<GLOBAL ROPE-PLACED <>>
;<GLOBAL ROPE-LANDING <>>
<GLOBAL ROPE-TIED <>>
<GLOBAL MATCH-COUNT 20>
<GLOBAL SCARAB-SET <>>
<GLOBAL OIL-SOAKED <>>
<GLOBAL OILED-TORCH <>>
<GLOBAL OIL-LEFT 100>
<GLOBAL TORCH-TURNS 0>
<GLOBAL TURN-OFFSET 0>
<GLOBAL CAN-TURN-STATUES <>>
<GLOBAL STATUES-SET <>>
<GLOBAL ANTE-SEAL T>
<GLOBAL BEAM-PLACED <>>
<GLOBAL ON-BEAM <>>
<GLOBAL INNER-DOOR-SEALED T>
<GLOBAL PLASTER-GONE <>>
<GLOBAL FIRST-ENTRY T>

<OBJECT HIEROGLYPHS
	(IN LOCAL-GLOBALS)
	(DESC "hieroglyphs")
	(FLAGS NDESCBIT)
	(SYNONYM SYMBOL HIEROG GLYPHS)
	(ADJECTIVE STRANGE)
	(ACTION HIERO-FCN)>

<ROUTINE FIXED-FONT-ON () <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF() <PUT 0 8 <BAND <GET 0 8> -3>>>

<ROUTINE PLASTER1-GLYPHS ()
	<FIXED-FONT-ON>
	<TELL CR "*->  #  !!!  ::  ...>  .-" CR>
	<FIXED-FONT-OFF>>

<ROUTINE HIERO-FCN ("AUX" TEMP (COUNTER 0) OFFSET)
	 <COND (<NOT <VERB? READ EXAMINE>>
		<RFALSE>)>
	 <COND (<AND <IN? ,WINNER ,STAIRS-BOTTOM>
		     <IN? ,PLASTER1 ,STAIRS-BOTTOM>>
		<PLASTER1-GLYPHS>
		<RTRUE>)
	       (<IN? ,WINNER ,WEST-END-OF-PASSAGE>
		<COND (<FSET? ,PIT ,INVISIBLE>
		       <FIXED-FONT-ON>
		       <TELL CR
"             .|
<-*  #  /!\\  -  #  (=  =)|
|
::  *->  #  !!!" CR>
		       <FIXED-FONT-OFF>)
		      (T
		       <TELL "They're gone with the plaster." CR>)>)
	       (<AND <ROOM? ,NORTH-ANTECHAMBER>
		     <NOT <FSET? ,BURIAL-CHAMBER ,RMUNGBIT>>>
		<FIXED-FONT-ON>
		<TELL CR
"             -     !=!|
<-*  #  /!\\  .   #  ! !|
|
::  *->  #  !!!" CR>
		<FIXED-FONT-OFF>)
	       (<AND <ROOM? SOUTH-ANTECHAMBER>
		     <NOT <FSET? ,ANNEX-DOOR ,OPENBIT>>>
		<FIXED-FONT-ON>
		<TELL CR
"                      -|
<-*  #  /!\\  (.)  #  ! !|
                      -|
|
           -|
::  (  #  ! !|
           -" CR>
		<FIXED-FONT-OFF>)
	       (<ROOM? ,ROOM-OF-NEPHTHYS ,ROOM-OF-ISIS
		       ,ROOM-OF-SELKIS ,ROOM-OF-NEITH>
		<COND (<EQUAL? ,HERE ,ROOM-OF-NEPHTHYS>
		       <SET TEMP ,NEPHTHYS>
		       <SET OFFSET 4>)
		      (<EQUAL? ,HERE ,ROOM-OF-NEITH>
		       <SET TEMP ,NEITH>
		       <SET OFFSET 2>)
		      (<EQUAL? ,HERE ,ROOM-OF-SELKIS>
		       <SET TEMP ,SELKIS>
		       <SET OFFSET 1>)
		      (T <SET TEMP ,ISIS>
		       <SET OFFSET 3>)>
		<REPEAT ()
			<SET COUNTER <+ .COUNTER 1>>
			<COND (<EQUAL? .TEMP
				       <GET ,ORDER-LTBL .COUNTER>>
			       <RETURN>)>>
		<FIXED-FONT-ON>
		<TELL CR "       " <GET ,STAR-LTBL .COUNTER> CR>
		<TELL CR
"          " <GET ,COMPASS-POINTS-LTBL .OFFSET> CR>
		<TELL
"))  /  #  " <GET ,COMPASS-TAILS-LTBL .OFFSET> "  ::|
|
<-*  "
	     <GET ,STAR-LTBL .COUNTER> "  =!=  /  *" CR>
		<FIXED-FONT-OFF>)
	       (<IN? ,WINNER ,BEND-HALL>
		<FIXED-FONT-ON>
		<TELL
"
          .      =  - -|
!@!  ...>  -  #  *   =   ::  <...  ;|
|
#  *|
   =" CR>
		<FIXED-FONT-OFF>)
	       (<IN? ,WINNER ,CENTRAL-ROOM>
		<TELL
"The hieroglyphs look like this:|
">
		<FIXED-FONT-ON>
		<TELL "|
                    !-!|
...>  -.  >...  #  !  ! !|
                    !-!|
|
/  ...>  /  #  !@!" CR>
		<FIXED-FONT-OFF>)
	       (<EQUAL? ,HERE ,SOUTH-CENTER>
		<TELL
"The hieroglyphs look like this:|
">
		<FIXED-FONT-ON>
		<TELL "|
 <.>     <:>     <:.>|
|
 <::>    <::.>   <:::>|
|
 <:::.>  <::::>  <::::.>" CR>
		<FIXED-FONT-OFF>)
	       (<EQUAL? <LOC ,WINNER> ,SKELETON-ROOM ,SILVER-ROOM ,GOLDEN-ROOM>
		<TELL
"The hieroglyphs look like this:|
">
		<FIXED-FONT-ON>
		<TELL "|
-!-  #  !*  ::  #  *!  ::|
|
*->  #  !@!  >*>" CR>
		<FIXED-FONT-OFF>)
	       (T
		<TELL "I don't see them here." CR>)>
	 <RTRUE>>

<GLOBAL STAR-LTBL
	<LTABLE "(@)"
		"(@@)"
		"(@@@)"
		"(@@@@)">>

<GLOBAL COMPASS-POINTS-LTBL
	<LTABLE
" ."
"\\"
" /"
". ">>

<GLOBAL COMPASS-TAILS-LTBL
	<LTABLE
"/"
" ."
". "
" \\">>

<GLOBAL WATER-LEFT 0>

<OBJECT PICTURES
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT)
	(DESC "decorations")
	(SYNONYM PAINTI PICTUR SCROLL)
	(ADJECTIVE SMALL LARGE)
	(TEXT
"Quite beautiful, no?")>

<OBJECT PILLARS
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT)
	(DESC "pillars")
	(SYNONYM PILLARS)
	(TEXT
"They're quite huge, aren't they?")>

<OBJECT BOAT
	(IN LOCAL-GLOBALS)
	(FLAGS VEHBIT)
	(DESC "barge")
	(SYNONYM BARGE BOAT SHIP WOOD)
	(ADJECTIVE WOODEN WOOD)
	(ACTION BOARD-BARGE-F)>

<ROUTINE BOARD-BARGE-F ()
	 <COND (<VERB? BOARD>
		<COND (<EQUAL? ,HERE ,BARGE-ENTRANCE>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (<OR <EQUAL? ,HERE ,NW-CORNER ,NE-CORNER>
			   <EQUAL? ,HERE ,SW-CORNER ,SE-CORNER>>
		       <TELL "There's no way to do that from here." CR>
		       <RTRUE>)
		      (<OR <EQUAL? ,HERE ,FORE-CABIN ,AFT-CABIN ,BELOW-DECK>
			   <EQUAL? ,HERE ,BELOW-MAST ,BARGE-CENTER>>
		       <TELL "Just where do you think you are?" CR>
		       <RTRUE>)>)
	       (<VERB? DISEMBARK>
		<COND (<EQUAL? ,HERE ,BARGE-CENTER>
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)
		      (<OR <EQUAL? ,HERE ,NW-CORNER ,NE-CORNER>
			   <EQUAL? ,HERE ,SW-CORNER ,SE-CORNER>>
		       <TELL "You're not on the barge!" CR>
		       <RTRUE>)
		      (<OR <EQUAL? ,HERE ,FORE-CABIN ,AFT-CABIN ,BELOW-DECK>
			   <EQUAL? ,HERE ,BELOW-MAST ,BARGE-CENTER>>
		       <TELL "I can't do that from here." CR>
		       <RTRUE>)>)>>
		      

<OBJECT DECK
	(IN LOCAL-GLOBALS)
	(DESC "deck")
	(SYNONYM DECK DECKIN)
	(ACTION JUMP-OFF-FCN)>

<ROUTINE JUMP-OFF-FCN ()
	 <COND (<AND <EQUAL? ,HERE ,BARGE-CENTER>
		     <VERB? LEAP>>
		<TELL "Don't you think using the plank would be safer?" CR>
		<RTRUE>)
	       (<VERB? LEAP>
		<TELL "It might be easier without these bulkheads around." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<COND (<FIRST? ,HERE>
		       <DESCRIBE-OBJECTS T>
		       <RTRUE>)
		      (ELSE
			<TELL "There's nothing on the deck." CR>
			<RTRUE>)>)
	       (<VERB? COUNT>
		<TELL "What a cahd! (52 to be exact!)" CR>
		<RTRUE>)>>
	
<OBJECT FLAPS
	(IN LOCAL-GLOBALS)
	(DESC "flap")
	(SYNONYM FLAP FLAPS)
	(ACTION FLAP-FCN)>

<ROUTINE FLAP-FCN ()
	 <COND (<NOT <VERB? LOOK-INSIDE>>
		<RFALSE>)
	       (<EQUAL? ,HERE ,TENT ,TENT2 ,SUPPLY-TENT>
		<TELL
"You can make out a lot of sand and a small firepit." CR>)
	       (<EQUAL? ,HERE ,P2>
		<TELL 
"You can make out your cot and the trunk inside the tent." CR>)
	       (<EQUAL? ,HERE ,P7 ,P4>
		<TELL 
"You can see nothing distinguishable by trying to look in through the bright
sunlight." CR>)>
	 <RTRUE>>

<OBJECT THICKET
	(IN GLOBAL-OBJECTS)
	(DESC "thicket")
	(SYNONYM THICKE)
	(ACTION THICKET-FCN)> 
				
<ROUTINE THICKET-FCN ()
	 <COND (<NOT <EQUAL? ,HERE ,RIVER-BANK ,P4 ,P6>>
		<TELL "I see no thickets here." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL "Thicker thickets have never been thicker." CR>
		<RTRUE>)>>

;"Parser-related stuff"
	 
<OBJECT NOT-HERE-OBJECT
	(DESC "such thing" ;"[not here]")
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (.PRSO?
		<COND (<VERB? LAMP-ON BURN LAMP-OFF>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)
	       (T
		<COND (<VERB? LAMP-ON BURN LAMP-OFF>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <==? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)>
        ;"Here is the default 'cant see any' printer"
	 <COND (<EQUAL? ,WINNER ,ADVENTURER>
		<TELL "You can't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!" CR>)
	       (T
		<TELL "The " D ,WINNER " seems confused. \"I don't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <RTRUE>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
	   the 0 and >1 cases alike or different. It doesn't matter. Always
	   return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	<COND (<AND <G? .M-F 1>
		    <SET OBJ <GETP <1 .TBL> ,P?GLOBAL>>>
	       <SET M-F 1>
	       <SETG P-MOBY-FOUND .OBJ>)>
	<COND (<==? 1 .M-F>
	       <COND (.PRSO? <SETG PRSO ,P-MOBY-FOUND>)
		     (T <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<NOT .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T ,NOT-HERE-OBJECT)>>

<ROUTINE GLOBAL-NOT-HERE-PRINT (OBJ)
	 <COND (,P-MULT <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>)
	       (T
		<TELL "You can't see any">
		<COND (<EQUAL? .OBJ ,PRSO> <PRSO-PRINT>)
		      (T <PRSI-PRINT>)>
		<TELL " here." CR>)>
	 <SETG P-WON <>>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
 <COND (,P-OFLAG
	<COND (,P-XADJ <TELL " "> <PRINTB ,P-XADJN>)>
	<COND (,P-XNAM <TELL " "> <PRINTB ,P-XNAM>)>)
       (.PRSO?
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
       (T
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>
 <SETG P-WON <>>>