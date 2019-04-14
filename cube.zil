"CUBE for
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<ROOM LANDING-ONE
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Cube")
      (LDESC
"You are in a room whose symmetry is uncanny, at least to the unaided eye: the
dimensions of the room seem to form a perfect cube. There are three square
doorways cut into the walls -- one to the north, and another to the west. A
wide staircase leads up through the square doorway to the east.")
      (UP TO CHAMBER-OF-RA)
      (NORTH TO NE-BEND)
      (WEST TO CENTRAL-ROOM)
      (EAST TO CHAMBER-OF-RA)
      (GLOBAL EAST-STAIRS)
      (ACTION MOVE-PANEL-HERE)>

<ROOM LANDING-THREE
      (IN ROOMS)
      (DESC "Cube")
      (FLAGS RLANDBIT)
      (LDESC
"You are in a room whose walls, floor and ceiling seem to form a perfect cube.
There are four square doorways cut into the walls -- to the north, the south,
the east and the west. Through the west doorway you can see a flight of stairs
heading up.")
      (UP TO CHAMBER-OF-RA)
      (WEST TO CHAMBER-OF-RA)
      (NORTH TO NW-BEND)
      (SOUTH TO SW-BEND)
      (EAST TO CENTRAL-ROOM)
      (GLOBAL WEST-STAIRS)
      (ACTION MOVE-PANEL-HERE)>

<ROOM CENTRAL-ROOM
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Cube")
      (LDESC
"You are in a room whose dimensions seem to measure a perfect cube. On the
floor of this room is a series of symbols, inscribed in the stone. The walls
bear strange pictures of a Queen, one of which shows her being wrapped in
linen, another one showing her being lowered into what appears to be a solid
gold sarcophagus. Four identical square doorways lead out of this chamber to
the north, south, east and west.")
      (NORTH TO NORTH-CENTER)
      (SOUTH TO SOUTH-CENTER)
      (EAST TO LANDING-ONE)
      (WEST TO LANDING-THREE)
      (GLOBAL HIEROGLYPHS PICTURES)>

<ROOM NORTH-CENTER
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Cube")
      (LDESC
"You are in a room in the shape of a perfect cube. There are three square
doorways cut into the walls -- one to the west, one to the east, and another
to the south.")
      (EAST TO NE-BEND)
      (WEST TO NW-BEND)
      (SOUTH TO CENTRAL-ROOM)>

<ROOM SOUTH-CENTER
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Cube")
      (LDESC
"You are in a room whose symmetry is uncanny, at least to the unaided eye: the
dimensions of the room seem to form a perfect cube. There are two square
doorways cut into the walls -- one to the north, and another to the west.
A panel, recessed into a wall, glows softly in your reflected light,
while some hieroglyphs are visible above it.")
      (NORTH TO CENTRAL-ROOM)
      (WEST TO SW-BEND)
      (EAST TO SECRET-PASSAGE IF BRICKS-PRESSED
       ELSE "You can't go that way.")
      (GLOBAL HIEROGLYPHS)
      (ACTION SOUTH-CENTER-F)>

<GLOBAL BRICKS-TBL
	<TABLE BRICK-ONE BRICK-TWO BRICK-THREE BRICK-FOUR BRICK-FIVE
	       BRICK-SIX BRICK-SEVEN BRICK-EIGHT BRICK-NINE>>

<ROUTINE SOUTH-CENTER-F (RARG "AUX" (OFFS -1) BK)
	 <COND (<NOT <EQUAL? .RARG ,M-END>>
		<RFALSE>)>
	 <REPEAT ()
		 <SET OFFS <+ .OFFS 1>>
		 <COND (<G? .OFFS 8>
			<RFALSE>)
		       (T
			<SET BK <GET ,BRICKS-TBL .OFFS>>
			<COND (<IN? .BK ,PUNCH-PANEL>
			       <FSET .BK ,NDESCBIT>)>)>>>
	 

<GLOBAL BRICKS-PRESSED <>>

<ROOM SW-BEND
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Cube")
      (LDESC
"You are in a room whose symmetry is uncanny, at least to the unaided eye: the
dimensions of the room seem to form a perfect cube. There are two square
doorways cut into the walls -- one to the north, and another to the east. The
uncannily-shaped room seems to form a corner for this entire area.")
      (NORTH TO LANDING-THREE)
      (EAST TO SOUTH-CENTER)>

<ROOM NE-BEND
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Cube")
      (LDESC
"You are in a room whose dimensions seem to form a perfect cube. There are two
square doorways cut into the walls -- one to the south, and another to the
west. This room seems to form a corner for this entire area.")
      (WEST TO NORTH-CENTER)
      (SOUTH TO LANDING-ONE)>
       
<ROOM NW-BEND
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Cube")
      (LDESC
"You are in a room whose shape is that of a perfect cube. There are two square
doorways cut into the walls -- one to the south, and another to the east.")
      (SOUTH TO LANDING-THREE)
      (EAST TO NORTH-CENTER)>

<ROUTINE MOVE-PANEL-HERE (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<EQUAL? ,HERE ,LANDING-ONE ,LANDING-THREE ,TINY-LANDING>
		       <MOVE-ROPE-HERE ,M-ENTER>
		       <FCLEAR ,ROPE ,NDESCBIT>)>)>
	 <RFALSE>>

<ROOM SECRET-PASSAGE
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Turning Passage")
      (LDESC
"You are in a strange, turning passageway. The floor here descends, reminding
you of a ramp Craige once told you about -- a deep entrance into the depths of
an Incan tomb. The ramp turns off toward the north. Judging from what you
remember of the cube rooms, the ramp most probably passes beneath the
ascending east staircase. Through the open doorway to the west you can still
see one of the cube rooms.")
      (NORTH TO TOP-OF-STAIRS) ;"Connection to ANTE"
      (WEST TO SOUTH-CENTER)
      (DOWN TO TOP-OF-STAIRS)
      (OUT TO SOUTH-CENTER)>

<OBJECT PUNCH-PANEL
	(IN SOUTH-CENTER)
	(DESC "recessed panel")
	(FLAGS NDESCBIT OPENBIT CONTBIT DONTTAKE)
	(SYNONYM PANEL)
	(ADJECTIVE RECESS)
	(CAPACITY 45)
	(ACTION PUNCH-PANEL-FCN)>

<GLOBAL NUM-TBL
	<TABLE "no" "one" "two" "three" "four" "five" "six" "seven" "eight"
	       "nine">>

<GLOBAL DASH-STR
 "-----------------------------">

<GLOBAL EX-SP-EX-STR
"!                           !">

<ROUTINE PUNCH-PANEL-FCN ("AUX" NUM)
	 <COND (<AND <VERB? PUT>
		     <PRSI? ,PUNCH-PANEL>
		     <NOT <GETP ,PRSO ,P?BRICK>>>
		<TELL "It won't fit in there." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE READ>
		<SET NUM <- 9 ,BRICKS-TAKEN>>
		<TELL "There ">
		<COND (<EQUAL? .NUM 1>
		       <TELL "is ">)
		      (ELSE <TELL "are ">)>
		<TELL <GET ,NUM-TBL .NUM> " brick">
		<COND (<NOT <EQUAL? .NUM 1>>
		       <TELL "s">)>
		<TELL " recessed into the panel">
		<COND (<EQUAL? .NUM 0 1>
		       <TELL "." CR>)
		      (ELSE <TELL
", three rows by three columns. These bricks look as if they could be easily
removed and are marked with numerical symbols." CR>)>
		<CRLF>
		<FIXED-FONT-ON>
		<TELL ,DASH-STR CR>
		<TELL ,EX-SP-EX-STR CR>
		<TELL "!  ">
		<COND (<IN? ,BRICK-ONE ,PUNCH-PANEL>
		       <TELL "<.>">)
		      (T <TELL "   ">)>
		<TELL "     ">
		<COND (<IN? ,BRICK-TWO ,PUNCH-PANEL>
		       <TELL "<:>">)
		      (T <TELL "   ">)>
		<TELL "     ">
		<COND (<IN? ,BRICK-THREE ,PUNCH-PANEL>
		       <TELL "<:.>">)
		      (T <TELL "    ">)>
		<TELL "     !" CR>
		<TELL ,EX-SP-EX-STR CR>
		<TELL "!  ">
		<COND (<IN? ,BRICK-FOUR ,PUNCH-PANEL>
		       <TELL "<::>">)
		      (T <TELL "    ">)>
		<TELL "    ">
		<COND (<IN? ,BRICK-FIVE ,PUNCH-PANEL>
		       <TELL "<::.>">)
		      (T <TELL "     ">)>
		<TELL "   ">
		<COND (<IN? ,BRICK-SIX ,PUNCH-PANEL>
		       <TELL "<:::>">)
		      (T <TELL "     ">)>
		<TELL "    !" CR>
		<TELL ,EX-SP-EX-STR CR>
		<TELL "!  ">
		<COND (<IN? ,BRICK-SEVEN ,PUNCH-PANEL>
		       <TELL "<:::.>">)
		      (T <TELL "      ">)>
		<TELL "  ">
		<COND (<IN? ,BRICK-EIGHT ,PUNCH-PANEL>
		       <TELL "<::::>">)
		      (T <TELL"      ">)>
		<TELL "  ">
		<COND (<IN? ,BRICK-NINE ,PUNCH-PANEL>
		       <TELL "<::::.>">)
		      (T <TELL "       ">)>
		<TELL "  !" CR>
		<TELL ,EX-SP-EX-STR CR>
		<TELL ,DASH-STR CR>
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PUNCH-PANEL>
		<RTRUE>)>>

<OBJECT BRICK-ONE
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT TRYTAKEBIT)
	(DESC "first brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE FIRST)
	(BRICK 1)
	(TEXT
"<.>")
	(ACTION TAKE-BRICK-FCN)>

<OBJECT BRICK-NINE
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT TRYTAKEBIT)
	(DESC "ninth brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE NINTH)
	(TEXT
"<::::.>")
	(BRICK 9)
	(ACTION TAKE-BRICK-FCN)>

<OBJECT BRICK-EIGHT
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT VOWELBIT TRYTAKEBIT)
	(DESC "eighth brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE EIGHTH)
	(TEXT
"<::::>")
	(BRICK 8)
	(ACTION TAKE-BRICK-FCN)>

<OBJECT BRICK-SEVEN
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT TRYTAKEBIT)
	(DESC "seventh brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE SEVENTH)
	(TEXT
"<:::.>")
	(BRICK 7)
	(ACTION TAKE-BRICK-FCN)>

<OBJECT BRICK-SIX
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT TRYTAKEBIT)
	(DESC "sixth brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE SIXTH)
	(TEXT
"<:::>")
	(BRICK 6)
	(ACTION TAKE-BRICK-FCN)>
	
<OBJECT BRICK-FIVE
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT TRYTAKEBIT)
	(DESC "fifth brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE FIFTH)
	(TEXT
"<::.>")
	(BRICK 5)
	(ACTION TAKE-BRICK-FCN)>

<OBJECT BRICK-FOUR
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT TRYTAKEBIT)
	(DESC "fourth brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE FOURTH)
	(TEXT
"<::>")
	(BRICK 4)
	(ACTION TAKE-BRICK-FCN)>

<OBJECT BRICK-THREE
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT TRYTAKEBIT)
	(DESC "third brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE THIRD)
	(TEXT
"<:.>")
	(BRICK 3)
	(ACTION TAKE-BRICK-FCN)>

<OBJECT BRICK-TWO
	(IN PUNCH-PANEL)
	(FLAGS TAKEBIT NDESCBIT TOUCHBIT TRYTAKEBIT)
	(DESC "second brick")
	(SYNONYM BRICK BRICKS)
	(ADJECTIVE SECOND)
	(TEXT
"<:>")
	(BRICK 2)
	(ACTION TAKE-BRICK-FCN)>

<GLOBAL BRICKS-TAKEN 0>
<GLOBAL WRONG-BRICK <>>

<ROUTINE TAKE-BRICK-FCN ()
	<COND (<VERB? EXAMINE READ>
	       <FIXED-FONT-ON>
	       <TELL <GETP ,PRSO ,P?TEXT> CR>
	       <FIXED-FONT-OFF>
	       <RTRUE>)
	      (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,PUNCH-PANEL>>
		<FSET ,PRSO ,NDESCBIT>
		<SETG BRICKS-TAKEN <- ,BRICKS-TAKEN 1>>
		<RFALSE>)
	       (<OR <NOT <VERB? TAKE>>
		    <NOT <IN? ,PRSO ,PUNCH-PANEL>>>
		<RFALSE>)>
	 <COND (<EQUAL? <ITAKE> <>>
		<RFATAL>)
	       (T
		<COND (<AND <EQUAL? ,BRICKS-TAKEN 0>
			    <NOT <EQUAL? ,PRSO ,BRICK-ONE>>>
		       <SETG WRONG-BRICK T>)
		      (<AND <EQUAL? ,BRICKS-TAKEN 1>
			    <NOT <EQUAL? ,PRSO ,BRICK-THREE>>>
		       <SETG WRONG-BRICK T>)
		      (<AND <EQUAL? ,BRICKS-TAKEN 2>
			    <NOT <EQUAL? ,PRSO ,BRICK-FIVE>>>
		       <SETG WRONG-BRICK T>)>
		<SETG BRICKS-TAKEN <+ ,BRICKS-TAKEN 1>>
		<COND (<NOT <IN? ,PRSO ,PUNCH-PANEL>>
		       <FCLEAR ,PRSO ,NDESCBIT>)>
		<COND (<AND <EQUAL? ,BRICKS-TAKEN 3>
			    <NOT ,BRICKS-PRESSED>
			    <NOT ,WRONG-BRICK>>
		       <TELL
"As soon as you grasp this brick a square doorway swings open. You leap back,
unsure of what might happen, but quickly realize you've discovered a hidden
passageway, making eastern movement from this cube room possible." CR>
		       <SETG BRICKS-PRESSED T>
		       <SETG SCORE <+ ,SCORE 25>>
		       <PUTP ,SOUTH-CENTER ,P?LDESC
"You are in a cubical-room whose walls, floor and ceiling are of an
identical size. There are three square doorways cut into the walls --
to the north, to the west, and a newly opened one to the east. Engraved
on a wall are some hieroglyphs, while a panel, recessed in the same wall,
glows softly in your reflected light.">
		       <RTRUE>)
		      (T
		       <TELL "Taken." CR>
		       <RTRUE>)>)>>