"BARGE for
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<ROOM LANDING-TWO
      (IN ROOMS)
      (DESC "South Landing")
      (FLAGS RLANDBIT)
      (LDESC
"You are on a landing in the middle of a set of stairs. The staircase goes down
to the south and up to the north. The walls here are undistinguished, formed by
the stones of which the pyramid was built.")
      (UP TO CHAMBER-OF-RA)
      (NORTH TO CHAMBER-OF-RA)
      (DOWN TO NARROW-HALL)
      (SOUTH TO NARROW-HALL)
      (GLOBAL SOUTH-STAIRS)
      (ACTION MOVE-ROPE-HERE)>

<ROOM NARROW-HALL
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Narrow Hallway")
      (LDESC
"You are at the entrance of a narrow hallway which goes to the northeast. A
staircase goes up to the north.")
      (UP TO LANDING-TWO)
      (NE TO BEND-HALL)
      (NORTH TO LANDING-TWO)>

<ROOM BEND-HALL
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Narrow Hallway")
      (LDESC
"You are at a bend in the Narrow Hallway. The hallway continues to the
northwest and to the southwest. Inscribed on the wall are some hieroglyphs.")
      (NW TO BARGE-ENTRANCE)
      (SW TO NARROW-HALL)
      (GLOBAL HIEROGLYPHS)> 
      
<ROOM BARGE-ENTRANCE
      (IN ROOMS)
      (DESC "Barge Chamber")
      (FLAGS RLANDBIT)
      (LDESC
"You are in the southern section of a huge room which holds the royal barge.
Before you, to the north, is a plank which provides entrance to the barge.
There is room to move around the barge to the east and west, while a doorway
to the southeast leads into a darkened corridor.")
      (UP TO BARGE-CENTER)
      (NORTH TO BARGE-CENTER)
      (WEST TO SW-CORNER)
      (EAST TO SE-CORNER)
      (SE TO BEND-HALL)
      (GLOBAL BOAT)
      (ACTION MOVE-THE-PLANK-FCN)>

<ROUTINE MOVE-THE-PLANK-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<OR <NOT <FSET? ,PLANK ,TOUCHBIT>>
			   <IN? ,PLANK ,BARGE-CENTER>> 
		       <MOVE ,PLANK ,HERE>)>
		<RFALSE>)>>

<ROOM SE-CORNER
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Barge Chamber")
      (LDESC
"You are in the southeast corner of the Barge Chamber. There's enough room to
bypass the stern of the barge and continue to the north. To the west you can
see the entrance to the barge.")
      (WEST TO BARGE-ENTRANCE)
      (NORTH TO NE-CORNER)
      (GLOBAL BOAT)>

<ROOM NE-CORNER
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Barge Chamber")
      (LDESC
"You're standing in the northeast corner of the Barge Chamber. You can get
around the stern of the barge to the south, while there's enough room to
continue around the barge to the west.")
      (WEST TO BARGE-EXIT)
      (SOUTH TO SE-CORNER)
      (GLOBAL BOAT)>

<ROOM SW-CORNER
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Barge Chamber")
      (LDESC
"You're in the southwest corner of the Barge Chamber. You can still see the
barge entrance to the east, while there's enough room to continue to the north,
around the barge.")
      (NORTH TO NW-CORNER)
      (EAST TO BARGE-ENTRANCE)
      (GLOBAL BOAT)>

<ROOM NW-CORNER
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Barge Chamber")
      (LDESC
"You're in the northwest corner of the Barge Chamber. You can see by your light
that there's room enough to continue around the back of the barge by going to
the east, while you can bypass the bow of the boat by going south.")
      (SOUTH TO SW-CORNER)
      (EAST TO BARGE-EXIT)
      (GLOBAL BOAT)>

<ROOM BARGE-EXIT
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Barge Chamber")
      (LDESC
"You're at the start of a hallway which goes off to the north. To the south,
directly behind you, is the back side of the barge. There's enough room to get
around it to the east and west.")
      (EAST TO NE-CORNER)
      (WEST TO NW-CORNER)
      (NORTH TO IN-THE-HALL)
      (GLOBAL BOAT)> 

;"These rooms are actually part of the barge itself."
<ROOM BARGE-CENTER
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Center of Barge")
      (LDESC
"You are standing on the deck of an ancient wooden barge. Before you, cut into
the deck, is a hole. To the south is a plank which leads down off the barge.
You can see two cabins on the deck, one to the west and the other to the east.")
      (WEST TO FORE-CABIN)
      (EAST TO AFT-CABIN)
      (DOWN TO BARGE-ENTRANCE)
      (SOUTH TO BARGE-ENTRANCE)
      (GLOBAL HOLE BOAT DECK)
      (ACTION BURN-THE-BARGE)>

<ROOM FORE-CABIN
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (EAST TO BARGE-CENTER)
      (DESC "Fore Cabin")
      (LDESC
"You are in the forward cabin aboard the barge. The cabin is bare with none of
the luxuries you expected to see. You close your eyes for a moment, picturing
the barge you'll someday own, the yacht fully rigged and crewed. You open your
eyes and shake your head, anxious to make your dream reality. There's a doorway
to the east leading out onto the deck.")
      (GLOBAL BOAT DECK)
      (ACTION BURN-THE-BARGE)>

<ROOM AFT-CABIN
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Aft Cabin")
      (LDESC
"You are in the aft cabin aboard the barge. There's a door to the west which
leads out to the deck, and a short ladder, permanently mounted to the deck,
going down into the depths of the barge itself.")
      (WEST TO BARGE-CENTER)
      (DOWN TO BELOW-DECK)
      (GLOBAL STAIRS BOAT DECK)
      (ACTION BURN-THE-BARGE)>

<ROOM BELOW-DECK
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Below Deck")
      (LDESC
"You are below the deck of the barge in what looks like a huge hold. To the
west you can see the hold continuing, while a ladder leads up and out from
here.")
      (UP TO AFT-CABIN)
      (OUT TO AFT-CABIN)
      (WEST TO BELOW-MAST)
      (ACTION BURN-THE-BARGE)
      (GLOBAL BOAT STAIRS DECK)>

<ROOM BELOW-MAST
      (IN ROOMS)
      (DESC "West End of Hold")
      (FLAGS RLANDBIT)
      (LDESC
"You are in the westmost portion of the hold, below the deck of the barge.
On the north side of the hull is a small knothole about three feet off the
deck. Overhead you can see a hole going through the deck while, directly
below this hole, on the deck by your feet, is a slot.")
      (ACTION BURN-THE-BARGE)
      (EAST TO BELOW-DECK)
      (GLOBAL BOAT HOLE DECK)> 

<GLOBAL PUSHED-BEAM <>>

<OBJECT PLANK
	(IN BARGE-CENTER)
	(SYNONYM LADDER PLANK)
	(DESC "plank")
	(FDESC
"A long wooden plank connects the barge and the entry area.")
	(FLAGS NDESCBIT CLIMBBIT DONTTAKE TRYTAKEBIT)
	(ACTION PLANK-FCN)>

<ROUTINE PLANK-FCN ()
	 <COND (<VERB? TAKE MOVE>
		<TELL
"The plank is a permanent part of the barge. To remove it might create far more
destruction than you think." CR>
		<RTRUE>)>>

<GLOBAL BARGE-BURN-STR
"The barge immediately catches fire in a tremendous flash and, before you know
it, you're heated to a toasty 1000 degrees. Not being made of asbestos has its
disadvantages, as you quickly realize....">

<ROUTINE BURN-THE-BARGE (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <VERB? DROP THROW>
			    <FLAMING? ,PRSO>>
		       <JIGS-UP ,BARGE-BURN-STR>
		       <RFATAL>)
		      (<AND <VERB? PUT>
			    <FLAMING? ,PRSO>
			    <EQUAL? <LOC ,PRSI> ,HERE>
			    <NOT <EQUAL? ,PRSI ,TORCH-HOLDER>>>
		       <JIGS-UP ,BARGE-BURN-STR>
		       <RFATAL>)>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <EQUAL? ,HERE ,BELOW-MAST>>
		<MOVE ,MAST-HOLE ,HERE>
		<COND (<NOT <FSET? ,BEAM ,TOUCHBIT>>
		       <PUTP ,BEAM ,P?FDESC
"Coming down through the hole above your head and ending in the slot at your
feet is the beam which served as a mast.">
		       <COND (<NOT ,PUSHED-BEAM>
			      <MOVE ,BEAM ,SLOT>)>)>
		<RFALSE>)
	       (<AND <EQUAL? .RARG ,M-ENTER>
		     <EQUAL? ,HERE ,BARGE-CENTER>>
		<COND (<OR <NOT <FSET? ,PLANK ,TOUCHBIT>>
			   <IN? ,PLANK ,BARGE-ENTRANCE>> 
		       <MOVE ,PLANK ,HERE>)>
		<MOVE ,MAST-HOLE ,HERE>
		<COND (<AND ,PUSHED-BEAM
			    <NOT <FSET? ,BEAM ,TOUCHBIT>>>
		       <PUTP ,BEAM ,P?FDESC
"Lying on the deck of the barge is a long wooden beam.">)>
		<COND (<NOT ,PUSHED-BEAM>
		       <MOVE ,BEAM ,HERE>
		       <PUTP ,BEAM ,P?FDESC
"Before you, running down through a hole in the deck, is a sturdy beam made of
wood. Although only a few feet of it rise above the deck, it was probably used
at one time as a mast.">)>)>>
			   
<OBJECT MAST-HOLE
	(IN BARGE-CENTER)
	(DESC "mast hole")
	(FLAGS NDESCBIT OPENBIT CONTBIT TRANSBIT DONTTAKE TRYTAKEBIT VEHBIT)
	(CAPACITY 34)
	(SYNONYM HOLE)
	(ADJECTIVE MAST)
	(ACTION MAST-HOLE-FCN)>

<ROUTINE MAST-HOLE-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN CLIMB-UP THROUGH>
		<COND (<NOT ,PUSHED-BEAM>
		       <TELL "I think the mast hole is already being used." CR>)
		      (T
		       <TELL "You'd never squeeze through it." CR>)>
		<RTRUE>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <NOT ,PUSHED-BEAM>>
		<TELL "The mast is going through the hole." CR>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,MAST-HOLE>
		     <NOT ,PUSHED-BEAM>>
		<TELL
"There isn't room for the " D ,PRSO " and the mast, too." CR>
		<RTRUE>)
	       (<AND <PRSI? ,MAST-HOLE>
		     <VERB? PUT>>
		<COND (<EQUAL? ,HERE ,BARGE-CENTER>
		       <TELL "The " D ,PRSO " drops through the hole." CR>)
		      (T
		       <TELL "You try to reach up that high, but fail. The "
			     D ,PRSO " falls to the deck." CR>)>
		<MOVE ,PRSO ,BELOW-MAST>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<FLAMING? ,PRSO>
		       <JIGS-UP ,BARGE-BURN-STR>)>
		<RTRUE>)>>

<OBJECT TORCH-HOLDER
	(IN BELOW-MAST)
	(DESC "knothole")
	(FLAGS NDESCBIT CONTBIT TRANSBIT OPENBIT DONTTAKE TRYTAKEBIT)
	(CAPACITY 5)
	(ACTION TORCH-HOLDER-FCN)
	(SYNONYM KNOTHO HOLE)
	(ADJECTIVE KNOT)>

<ROUTINE TORCH-HOLDER-FCN ("AUX" FROB)
	 <COND (<VERB? OPEN CLOSE>
		<HOW? ,TORCH-HOLDER>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<SET FROB <FIRST? ,PRSO>>
		       <TELL "All I can see is a " D .FROB " in there." CR>)
		      (T
		       <TELL "Through the knothole is inky blackness." CR>)>)>>

<OBJECT SLOT
	(IN BELOW-MAST)
	(FLAGS NDESCBIT CONTBIT OPENBIT DONTTAKE TRYTAKEBIT)
	(CAPACITY 9)
	(DESC "slot")
	(SYNONYM SLOT)
	(ADJECTIVE SMALL)
	(ACTION SLOT-FCN)>

<ROUTINE SLOT-FCN ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<AND <IN? ,BEAM ,SLOT>
			    <FSET? ,SHIM ,NDESCBIT>>
		       <TELL
"A shim is wedged between the slot and the beam." CR>
		       <RTRUE>)
		      (<IN? ,BEAM ,SLOT>
		       <TELL "The beam is resting in the slot." CR>
		       <RTRUE>)
		      (ELSE
		       <RFALSE>)>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,SLOT>)>>

<OBJECT SHIM
	(IN BELOW-MAST)
	(FLAGS TAKEBIT DONTTAKE NDESCBIT BURNBIT TRYTAKEBIT)
	(DESC "shim")
	(SIZE 4)
	(SYNONYM SHIM WEDGE)
	(ADJECTIVE WOOD)
	(TEXT
"It's a small piece of wood, used as a wedge.")
	(ACTION SHIM-FCN)>

<ROUTINE SHIM-FCN ()
	 <COND (<AND <VERB? TAKE>
		     <FSET? ,SHIM ,NDESCBIT>>
		<COND (<ITAKE>
		       <TELL "Taken." CR>
		       <FCLEAR ,SHIM ,NDESCBIT>
		       <FCLEAR ,SHIM ,DONTTAKE>)>
		<RTRUE>)>>

<OBJECT BEAM
	(IN BARGE-CENTER)
	(FLAGS BURNBIT TAKEBIT VEHBIT TRYTAKEBIT SURFACEBIT CONTBIT OPENBIT)
	(DESC "wooden beam")
	(FDESC
"Before you, running down through a hole in the deck, is a sturdy beam made of
wood. Although only a few feet of it rise above the deck, it was probably used
at one time as a mast.")
	(SYNONYM BEAM MAST)
	(ADJECTIVE WOODEN STURDY)
	(SIZE 10)
	(VALUE 15)
	(ACTION BEAM-FCN)
	(CAPACITY 30)
	(DESCFCN DESCRIBE-BEAM-FCN)>

<GLOBAL AIR-WALK
"Well, despite your \"angelic\" qualities, you aren't very good at walking on
air and so, with a scream on your lips, you plunge to a horrible death in a pit
of voracious rats.">

<GLOBAL BURIAL-BEAM-STR
"How fitting -- to be trapped forever in the Burial Chamber, waiting slowly,
painfully, for your oxygen to run out -- a true testimony to the brilliance of
the Queen and her protection.">

<GLOBAL ANNEX-BEAM-STR
"The doorway suddenly closes as heavy, immovable stones crush in from both
sides. You slowly and painfully suffocate in the Annex, cursing the gods for
ever revealing this horrible place to you. You wish you had told Craige about
this place -- that way, it could have been he instead of you.">

<ROUTINE DROP-THE-BLOCKS ()
	 <TELL
"When you remove the beam, you remove the only thing between you and three
tons of solid rock, poised over your head. Knowing the situation, though, has
saved your life: you leap out of the way just in time." CR>
	 <SETG BEAM-PLACED <>>
	 <MUNG-ROOM ,BURIAL-CHAMBER
"The way into the Burial Chamber has been forever blocked by massive stones.">
	 <REMOVE ,NORTH-ANTE-DOOR>
	 <SETG P-IT-LOC <>>
	 <SETG ANTE-SEAL T>
	 <REMOVE ,N-ANTE-SEAL>>

<ROUTINE CLOSE-THE-ANNEX ()
	 <MUNG-ROOM ,ANNEX
"The way into the Annex is forever blocked by huge, immovable stones.">
	 <TELL
"The doorway disappears behind two huge stones which slide horizontally from
the doorway. Luckily, you stepped out of their way just in time." CR>
	 <SETG BEAM-PLACED <>>
	 <REMOVE ,ROCKS>
	 <PUTP ,SOUTH-ANTECHAMBER ,P?LDESC
"You are in the southern end of the Chamber of Eternal Royalty. From here you
can see the room stretching out towards the north. The south wall is painted to
resemble large baskets of lotus flowers with their blue petals framing an image
of the Sun God, Amun Ra. The west wall once held a door but is now forever
blocked.">>

<ROUTINE SET-THE-BEAM (CASE)
	 <COND (,BEAM-PLACED
		<COND (<EQUAL? ,BEAM-PLACED .CASE>
		       <TELL "It's already been done." CR>
		       <RTRUE>)
		      (<NOT <ITAKE>>
		       <RTRUE>)
		      (T <TELL "(taken)" CR>)>)>
	 <TELL "Consider it done." CR>
	 <SETG BEAM-PLACED .CASE>
	 <DESCRIBE-BEAM-FCN ,M-OBJDESC>
	 <MOVE ,BEAM ,HERE>
	 <COND (<EQUAL? ,HERE ,SOUTH-ANTECHAMBER>
		<THIS-IS-IT ,ANNEX-DOOR>)>>

<ROUTINE BEAM-FCN ()
	 <COND (<EQUAL? ,BEAM ,PRSI>
		<COND (<VERB? PUT PUT-ON>
		       <COND (<EQUAL? ,PRSO ,ME ,WINNER ,ADVENTURER>
			      <TELL "Why not just stand on it?" CR>)
			     (<HELD? ,BEAM>
			      <TELL "Better drop the " D ,PRSI " first." CR>
			      <RTRUE>)
			     (<PRSO? ,BEAM>
			      <TELL "How recursive!" CR>
			      <RTRUE>)
			     (T
			      <TELL
"Done. But the " D ,PRSO " falls off the beam and lands">
			      <COND (<AND <NOT <FSET? ,PIT ,INVISIBLE>>
					  <ROOM? ,WEST-END-OF-PASSAGE
						 ,MID-ANTECHAMBER>
					  ,BEAM-PLACED>
				     <TELL " in the pit." CR>
				     <REMOVE ,PRSO>)
				    (T <TELL " on the ground." CR>
				     <MOVE ,PRSO ,HERE>
				     <RTRUE>)>)>)>)
	       (<VERB? TAKE>
		<COND (<AND <EQUAL? ,HERE ,NORTH-ANTECHAMBER>
			    <FSET? ,NORTH-ANTE-DOOR ,OPENBIT>
			    <ITAKE>>
		       <DROP-THE-BLOCKS>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,BURIAL-CHAMBER>
		       <COND (<ITAKE>
			      <TELL "Taken. Oh oh...." CR>
			      <JIGS-UP ,BURIAL-BEAM-STR>)>)
		      (<EQUAL? ,HERE ,ANNEX>
		       <COND (<ITAKE>
			      <JIGS-UP ,ANNEX-BEAM-STR>
			      <RFATAL>)>)
		      (<AND <EQUAL? ,HERE ,SOUTH-ANTECHAMBER>
			    <NOT <FSET? ,ANNEX ,RMUNGBIT>>
			    <FSET? ,ANNEX-DOOR ,OPENBIT>>
		       <COND (<ITAKE>
			      <CLOSE-THE-ANNEX>)>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,BARGE-CENTER>
			    <FSET? ,SHIM ,NDESCBIT>
			    <IN? ,BEAM ,HERE>>
		       <TELL
"It seems to be securely wedged in the mast hole." CR>
		       <RTRUE>)
		      ;(<AND <EQUAL? ,HERE ,BARGE-CENTER>
			    <NOT ,PUSHED-BEAM>
			    <IN? ,BEAM ,HERE>>
		       <TELL 
"You can't lift it that high over your head to get it out of the deck." CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,BELOW-MAST>
			    <FSET? ,SHIM ,NDESCBIT>
			    <IN? ,BEAM ,SLOT>>
		       <TELL "It's wedged into the slot." CR>
		       <RTRUE>)
		      (<AND <EQUAL? ,HERE ,BELOW-MAST>
			    <IN? ,BEAM ,SLOT>>
		       <TELL 
"The mast hole won't allow a steep enough angle for removing it." CR>
		       <RTRUE>)
		      (,ON-BEAM
		       <COND (<ITAKE>
			      <SETG ON-BEAM <>>
			      <TELL "(getting off the beam first)" CR "Taken."
				    CR>
			      <COND (<NOT <IN? ,PLASTER ,HERE>>
				     <JIGS-UP
"Well, you were never very good walking on air and so, with a scream on your
lips, you plunge to a horrible death in a pit of voracious rats.">)>
			      <SETG BEAM-PLACED <>>
			      <RTRUE>)>)
		      (T
		       <SETG BEAM-PLACED <>>
		       <RFALSE>)>)
	       (<AND <VERB? PUT PUT-ACROSS PUT-ON PUT-AGAINST>
		     <PRSI? ,NICHES>
		     <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
		     <NOT <IN? ,PIT ,HERE>>>
		<SET-THE-BEAM 1>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSI ,ROCKS>
		     <EQUAL? ,HERE ,SOUTH-ANTECHAMBER>>
		<SET-THE-BEAM 2>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,ROCKS>
		     <EQUAL? ,HERE ,SOUTH-ANTECHAMBER>>
		<TELL
"Done. The beam immediately falls to the floor, though." CR>
		<MOVE ,BEAM ,HERE>
		<RTRUE>)
	       (<AND <VERB? PUT-ACROSS PUT>
		     <EQUAL? ,PRSI ,DOORWAY ,ANNEX-DOOR>
		     <EQUAL? ,HERE ,SOUTH-ANTECHAMBER>
		     <IN? ,ROCKS ,HERE>>
		<SET-THE-BEAM 3>
		<RTRUE>)
	       (<AND <VERB? PUT-UNDER>
		     <EQUAL? ,PRSI ,T-LINTEL ,DOORWAY>
		     <EQUAL? ,HERE ,NORTH-ANTECHAMBER>>
		<SET-THE-BEAM 4>
		<RTRUE>)
	       (<AND <VERB? PUT-ACROSS PUT>
		     <EQUAL? ,PRSI ,PIT>
		     <EQUAL? ,HERE ,MID-ANTECHAMBER>>
		<SET-THE-BEAM 5>
		<RTRUE>)
	       (<AND ,ON-BEAM <VERB? DISEMBARK CLIMB-DOWN>>
		<SETG ON-BEAM <>>
		<COND (<AND <IN? ,PLASTER ,WEST-END-OF-PASSAGE>
			    <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>>
		       <TELL
"You're now standing on the ground." CR>)
		      (T
		       <JIGS-UP ,AIR-WALK>
		       <RTRUE>)>)
	       (<AND <VERB? RAISE PULL-UP PUSH-THROUGH>
		     <EQUAL? ,HERE ,BELOW-MAST ,BARGE-CENTER>
		     <FSET? ,SHIM ,NDESCBIT>>
		<TELL 
"You try to raise the mast but it seems to be wedged into something." CR>
		<RTRUE>)
	       (<AND <VERB? PUSH-THROUGH RAISE PULL-UP>
		     <EQUAL? ,HERE ,BELOW-MAST ,BARGE-CENTER>
		     <NOT <FSET? ,SHIM ,NDESCBIT>>>
		<COND (<NOT <EQUAL? <CCOUNT ,WINNER> 0>>
		       <TELL 
"You'll need two hands to do that. Better put everything down." CR>
		       <RTRUE>)
		      (ELSE
		       <MOVE ,BEAM ,BARGE-CENTER>
		       <SETG PUSHED-BEAM T>
		       <PUTP ,BEAM ,P?FDESC
"Lying on the deck of the barge is a long wooden beam.">
		       <TELL
"You have managed to lift the beam up through the hole and you hear it land on
the deck with a thud." CR>)>)
	       (<AND <VERB? PUSH-THROUGH>
		     <EQUAL? ,PRSI ,MAST-HOLE>
		     <EQUAL? ,HERE ,BELOW-MAST>>
		<TELL "It's wedged too tightly in the slot." CR>
		<RTRUE>)
	       (<AND <VERB? PUSH>
		     <NOT <FSET? ,BEAM ,TOUCHBIT>>>
		<TELL "Nice try." CR>)
	       (<VERB? MUNG>
		<TELL 
"This piece of wood is virtually petrified due to its age and original strength." CR>)
	       >>

<ROUTINE DESCRIBE-BEAM-FCN (RARG "AUX" STR)
	 <COND (<VERB? EXAMINE READ>
		<TELL
"This wooden beam is made of an extremely hard wood. It's 10 feet long and has
a diameter of 12 inches. Scratched into it is the following symbol:|
">
		<FIXED-FONT-ON>
		<TELL "|
     /!\\|
">
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<OR <NOT <EQUAL? .RARG ,M-OBJDESC>>
		    <NOT ,BEAM-PLACED>>
		<RFALSE>)
	       (<EQUAL? ,BEAM-PLACED 4> ;"CASE: In N. Ante, beam wedged"
		<TELL
"Wedged under the top of the doorway, perpendicular to the floor, is the wooden
beam." CR>
		<RTRUE>)
	       (<EQUAL? ,BEAM-PLACED 5 1>
		<COND (<EQUAL? ,HERE ,MID-ANTECHAMBER>
		       <TELL
"Through the doorway you can see the beam spanning the pit." CR>)
		      (<EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
		       <TELL "Stretching across the floor">
		       <COND (<EQUAL? ,BEAM-PLACED 1>
			      <TELL " from niche to niche">)>
		       <COND (<NOT ,INNER-DOOR-SEALED>
			      <TELL ", spanning a deep pit,">)>
		       <TELL " is the wooden beam.">
		       <COND (,ON-BEAM
			      <TELL " You are standing on the beam.">)>
		       <CRLF>)>
		<RTRUE>)
	       (<EQUAL? ,BEAM-PLACED 2 3> ;"Case: S. Ante, wedged beam"
		<COND (<EQUAL? ,BEAM-PLACED 2>
		       <SET STR "rocks">)
		      (T <SET STR "doorway">)>
		<TELL
"Wedged between the " .STR ", from side to side, is the stout beam." CR>
		<RTRUE>)>>

<OBJECT SCROLL
	(IN FORE-CABIN)
	(FLAGS TAKEBIT READBIT BURNBIT)
	(DESC "papyrus scroll")
	(FDESC
"Sitting on the deck is a papyrus scroll.")
	(SIZE 1)
	(TEXT
"This scroll was placed here for the Queen's passage to the afterlife.")
	(SYNONYM SCROLL)
	(ADJECTIVE PAPYRU)
	(ACTION READ-SCROLL-FCN)>
	
<ROUTINE READ-SCROLL-FCN ()
	 <COND (<NOT <VERB? READ>>
		<RFALSE>)>
	 <TELL
"The scroll reads as follows:|
">
	 <FIXED-FONT-ON>
	 <TELL "|
*->  <.>  <:.>  ...  <::.>|
|
::  :  **  --->>  -)  (*)" CR>
	 <FIXED-FONT-OFF>
	 <RTRUE>>

;<ROUTINE CLEAR-THE-BEAM ("AUX" F N (FLG <>) STR)
	 <SET F <FIRST? ,BEAM>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<COND (<AND <EQUAL? ,HERE ,MID-ANTECHAMBER>
				    <NOT <FSET? ,PIT ,INVISIBLE>>
				    <EQUAL? ,BEAM-PLACED 1>>
			       <REMOVE .N>
			       <SET STR "into the pit">)
			      (T
			       <MOVE .N ,HERE>
			       <SET STR "onto the floor">)>
			<SET FLG T>)>>
	 <COND (.FLG
		<TELL "Everything on the beam falls " .STR "." CR>)>>