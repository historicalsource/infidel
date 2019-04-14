"RA for
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"RA-This is a file of all rooms and objects found in the upper part of the
pyramid; the Chamber of Ra."

<ROOM CHAMBER-OF-RA
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "Chamber of Ra")
      (NORTH PER ROPE-HOOK-FCN)
      (EAST PER TELL-STAIRS-FCN)
      (SOUTH PER TELL-STAIRS-FCN)
      (WEST PER TELL-STAIRS-FCN)
      (DOWN PER ROPE-DOWN-FCN)
      (UP PER RE-ENABLE-FCN)
      (OUT PER RE-ENABLE-FCN)
      (GLOBAL NORTH-STAIRS EAST-STAIRS SOUTH-STAIRS WEST-STAIRS FEW-STEPS)
      (ACTION MOVE-ROPE-RA)>

<ROUTINE TELL-STAIRS-FCN ("AUX" PLACE (FLG <>) (R-FLG <>))
	 <COND (<IN? ,WINNER ,ALTAR>
		<RETURN ,LANDING-ONE>)>
	 <TELL "(down the ">
	 <COND (<AND ,ROPE-TIED
		     <IN? ,ROPE ,WINNER>>
		<MOVE ,ROPE ,HERE>
		<SET R-FLG T>)>
	 <COND (<PRSO? ,P?EAST>
		<TELL "wide staircase)" CR>
		<SET PLACE ,LANDING-ONE>
		<SET FLG T>)
	       (<PRSO? ,P?WEST>
		<TELL "narrow staircase)" CR>
		<SET PLACE ,LANDING-THREE>
		<SET FLG T>)
	       (<PRSO? ,P?NORTH>
		<TELL "steep staircase)" CR>
		<SET PLACE ,LANDING-ZERO>)
	       (<PRSO? ,P?SOUTH>
		<TELL "winding staircase)" CR>
		<SET PLACE ,LANDING-TWO>)>
	 <COND (.R-FLG
		<TELL "You release the free end of the rope as you walk." CR>)>
	 <COND (.FLG
		<TELL "The staircase winds as you walk down, turning you around
so you face in the opposite direction." CR>
		<CRLF>)>
	 .PLACE>
	 
<ROUTINE RE-ENABLE-FCN ()
	 <COND (<NOT <IN? ,WINNER ,ALTAR>>
		<ENABLE <QUEUE I-GINANDTONIC -1>>)>
	 <COND (<AND ,ROPE-TIED
		     <IN? ,ROPE ,WINNER>>
		<MOVE ,ROPE ,CHAMBER-OF-RA>
		<TELL "You release the free end of the rope as you walk." CR>)>
	 ,EX8>

<GLOBAL PLUNGE-STR
"You take a few steps down the steep staircase when suddenly you lose your
footing as you try to walk on air. You fall a mere 25 feet straight
down and, landing on your head, regret your attempt.">

<ROUTINE ROPE-HOOK-FCN ()
	 <COND (<IN? ,WINNER ,ALTAR>
		<RETURN ,LANDING-ONE>)
	       (<AND ,ROPE-TIED
		     <EQUAL? ,LANDING ,LANDING-ZERO>>
		<TELL "(down the rope)" CR>
		<RETURN ,LANDING-ZERO>)
	       (<AND ,ROPE-TIED ,LANDING>
		<TELL "(down the steep staircase)" CR>
		<JIGS-UP ,PLUNGE-STR>)
	       (,ROPE-TIED
		<JIGS-UP
"You grasp the rope firmly in your hands, but the fall is shorter than you
thought. You reach the bottom with a resounding splat accompanied by a chorus
of pain led by ganglions you never knew you had. Just before you (thankfully)
black out, you release your grip from the rope.">)
	       (ELSE
		<JIGS-UP ,PLUNGE-STR>)>>
		

<ROUTINE ROPE-DOWN-FCN ()
	 <COND (<OR <NOT ,ROPE-TIED>
		    <NOT ,ROPE-PLACED>>
		<COND (<IN? ,WINNER ,ALTAR>
		       <RETURN ,LANDING-TWO>)
		      (<EQUAL? ,HERE ,CHAMBER-OF-RA>
		       <TELL
"Since there are four staircases going down, you'd better say which staircase."
 CR>)
		      (T
		       <JIGS-UP ,PLUNGE-STR>)>
		<RFALSE>)
	       (ELSE
		<COND (<NOT ,ROPE-HACK>
		       <TELL "(down the rope)" CR>)>
		<RETURN ,LANDING>)>>
		     
<GLOBAL ROPE-HACK <>>

<ROUTINE MOVE-ROPE-RA (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <EQUAL? ,ROPE-TIED ,ALTAR>>
		<DISABLE <INT I-GINANDTONIC>>
		<MOVE ,ROPE ,HERE>
		<FCLEAR ,ROPE ,NDESCBIT>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-ENTER>
		<DISABLE <INT I-GINANDTONIC>>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL ,RA-STR>
		<COND (,ROPE-PLACED
		       <FSET ,ROPE ,NDESCBIT>
		       <TELL
" Descending the " D ,ROPE-PLACED " is one end of the rope.">)>
		<TELL 
" In the center of the room is a large red sandstone altar mounted solidly in
the floor.">
		<COND (,ROPE-TIED
		       <TELL " The rope is tied to the " D ,ROPE-TIED ".">
		       <COND (<AND <IN? ,ROPE ,CHAMBER-OF-RA>
				   <NOT ,ROPE-PLACED>>
			      <TELL 
" The other end of the rope rests on the floor.">)
			     (<IN? ,ROPE ,ALTAR>
			      <TELL
" The other end rests on the altar.">)>)>
		<CRLF>)
	       (<EQUAL? .RARG ,M-END>
		<FCLEAR ,ROPE ,NDESCBIT>
		<SETG ROPE-HACK <>>
		<RFALSE>)
	       (<AND <EQUAL? .RARG ,M-BEG>
		     <OR ,ROPE-TIED ,ROPE-PLACED>
		     <NOT <IN? ,ROPE ,WINNER>>>
		<FSET ,ROPE ,NDESCBIT>
		<RFALSE>)>>

<GLOBAL RA-STR
"You are standing in the Chamber of Ra, a tribute to the Sun God. Even though
the only natural light enters through the opening above, the room is
brilliantly lit as though the walls themselves generated light. The room
slopes inward and the walls meet at an open point, over your head. The heat of
the desert filters down through the opening and, as the air slowly circulates,
the deep, long-dead musty odors from the depths of the pyramid assault your
senses. Four staircases descend from here: a steep one to the north, a winding
one to the south, a wide one to the east, and a narrow one to the west.">

<OBJECT NORTH-STAIRS
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT CLIMBBIT)
	(DESC "steep staircase")
	(SYNONYM STAIRC STAIRS STEPS STAIR)
	(ADJECTIVE STEEP NORTH)
	(ACTION RA-STAIRS-FCN)>

<OBJECT EAST-STAIRS
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT CLIMBBIT)
	(DESC "wide staircase")
	(SYNONYM STAIRC STAIRS STEPS STAIR)
	(ADJECTIVE WIDE EAST)
	(ACTION RA-STAIRS-FCN)>

<OBJECT SOUTH-STAIRS
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT CLIMBBIT)
	(DESC "winding staircase")
	(SYNONYM STAIRC STAIRS STEPS STAIR)
	(ADJECTIVE WINDIN SOUTH)
	(ACTION RA-STAIRS-FCN)>

<OBJECT WEST-STAIRS
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT CLIMBBIT)
	(DESC "narrow staircase")
	(SYNONYM STAIRC STAIRS STEPS STAIR)
	(ADJECTIVE NARROW WEST)
	(ACTION RA-STAIRS-FCN)>

<ROUTINE RA-STAIRS-FCN ()
	 <COND (<VERB? LOOK-DOWN EXAMINE>
		<COND (<AND <NOT <FLAMING? ,TORCH>>
			    <NOT <FLAMING? ,MATCHES>>>
		       <TELL
"There's just enough light to see the first few steps." CR>)
		      (<OR <FLAMING? ,TORCH>
			   <FLAMING? ,MATCHES>>
		       <COND (<NOT <PRSO? ,NORTH-STAIRS>>
			      <TELL
"You can see far enough down the stairs to make out a landing below." CR>)
			     (ELSE
			      <TELL
"You can see the first few steps and then what could only be a sheer dropoff,
going down into total darkness." CR>)>)>
		<RTRUE>)
	       (<VERB? CLIMB-DOWN>
		<COND (<PRSO? ,NORTH-STAIRS>
		       <COND (<EQUAL? ,ROPE-PLACED ,NORTH-STAIRS>
			      <PERFORM ,V?CLIMB-DOWN ,ROPE>
			      <RTRUE>)
			     (ELSE
			      <JIGS-UP ,PLUNGE-STR>
			      <RFATAL>)>)
		      (<PRSO? ,EAST-STAIRS>
		       <GOTO ,LANDING-ONE>)
		      (<PRSO? ,SOUTH-STAIRS>
		       <GOTO ,LANDING-TWO>)
		      (<PRSO? ,WEST-STAIRS>
		       <GOTO ,LANDING-THREE>)>)>>

<OBJECT FEW-STEPS
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT CLIMBBIT)
	(DESC "few steps")
	(SYNONYM STEPS STAIRS)
	(ADJECTIVE FEW FIRST)
	(ACTION FEW-STEPS-FCN)>

<ROUTINE FEW-STEPS-FCN ()
	 <COND (<VERB? CLIMB-DOWN BOARD CLIMB-ON>
		;<COND (<AND ,ROPE-TIED
			    <IN? ,ROPE ,WINNER>>
		       <TELL "You release the rope as you walk." CR>)>
		<GOTO ,TINY-LANDING>
		<MOVE-ROPE-HERE ,M-ENTER>
		<COND (<IN? ,ROPE ,HERE>
		       <FCLEAR ,ROPE ,NDESCBIT>
		       <DESCRIBE-ROPE-FCN ,M-OBJDESC>)>
		<RFATAL>)>>

<ROOM TINY-LANDING
      (IN ROOMS)
      (FLAGS RLANDBIT ONBIT)
      (DESC "On the Steep Stairs")
      (LDESC
"You are two steps down the steep staircase when you see before you a deep
dropoff going down into nothingness. To go down any further would be suicide.")
      (DOWN PER ROPE-DOWN-FCN)
      (UP TO CHAMBER-OF-RA)
      (GLOBAL NORTH-STAIRS)
      ;(ACTION TINY-LANDING-F)>

;<ROUTINE TINY-LANDING-F (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<MOVE-ROPE-HERE ,M-ENTER>)>>

<OBJECT ALTAR
	(IN CHAMBER-OF-RA)
	(DESC "stone altar")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT VEHBIT DONTTAKE TRANSBIT
	       TRYTAKEBIT)
	(CAPACITY 1000)
	(SYNONYM ALTAR)
	(ADJECTIVE LARGE STONE)
	(TEXT
"The altar is three feet by five feet and is mounted firmly in the solid floor.")
	(ACTION ALTAR-FCN)>

<ROUTINE ALTAR-FCN ("OPTIONAL" (RARG ,M-OBJECT))
	 <COND (<NOT <EQUAL? .RARG ,M-OBJECT>> <RFALSE>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <OR <NOT <FIRST? ,ALTAR>>
			 <EQUAL? <FIRST? ,ALTAR> ,WINNER ,ADVENTURER>>
		     <PRSO? ,ALTAR>>
		<TELL
		 <GETP ,ALTAR ,P?TEXT> " There is nothing on the altar." CR>
		<RTRUE>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <IN? ,WINNER ,ALTAR>
		     <PRSO? ,ALTAR>
		     <L? <CCOUNT ,ALTAR> 2>>
		<TELL <GETP ,ALTAR ,P?TEXT> CR>
		<RTRUE>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <PRSO? ,ALTAR>>
		<PRINT-CONT ,ALTAR>
		<RTRUE>)
	       (<AND <VERB? OPEN CLOSE>
		     <PRSO? ,ALTAR>>
		<HOW? ,ALTAR>
		<RTRUE>)>>

<GLOBAL LANDING <>>

<ROUTINE MOVE-ROPE-HERE (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <OR <EQUAL? ,LANDING ,HERE>
			 <AND <EQUAL? ,LANDING ,LANDING-ZERO>
			      <EQUAL? ,HERE ,TINY-LANDING>>>>
		<MOVE ,ROPE ,HERE>
		<FCLEAR ,ROPE ,NDESCBIT>
		<RFALSE>)>>

<OBJECT TORCH
	(IN CHAMBER-OF-RA)
	(FLAGS BURNBIT TAKEBIT)
	(DESC "bronze torch")
	(SYNONYM TORCH WICK)
	(ADJECTIVE BRONZE)
	(FDESC
"Leaning against the altar is a bronze torch.")
	(TEXT
"The torch has a tapered tip, much like a wick, which should be able to hold
a large amount of oil.")
	(ACTION TORCH-FCN)>

<ROUTINE TORCH-FCN ()
	 <COND (<AND <PRSI? ,TORCH>
		     <FLAMING? ,TORCH>
		     <IN? ,TORCH ,HERE>
		     <VERB? DROP THROW>
		     <IN? ,PRSO ,WINNER>
		     <FSET? ,PRSO ,BURNBIT>>
		<COND (<VERB? DROP>
		       <TELL "Dropped. ">)
		      (T <TELL "Thrown. ">)>
	        <V-BURN>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL <GETP ,TORCH ,P?TEXT> " The torch is ">
		<COND (<NOT <FLAMING? ,TORCH>>
		       <TELL "not lit">)
		      (<L? ,TORCH-TURNS 125>
		       <TELL "burning brightly">)
		      (<L? ,TORCH-TURNS 160>
		       <TELL "burning dimly">)
		      (<L? ,TORCH-TURNS 175>
		       <TELL "barely lit">)>
		<TELL "." CR>
		<RTRUE>)>>

<OBJECT OIL-JAR
	(IN CHAMBER-OF-RA)
	(SYNONYM JAR)
	(ADJECTIVE PINK SMALL ALABAS)
	(DESC "pink jar")
	(FLAGS CONTBIT TAKEBIT BURNBIT)
	(CAPACITY 4)
	(FDESC
"Lying on the floor, partially covered with dust, is a small pink alabaster
jar.")
       	(ACTION OIL-FCN)>

<ROUTINE OIL-FCN ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<NOT <FSET? ,OIL-JAR ,OPENBIT>>
		       <RFALSE>)
		      (T
		       <COND (<G? ,OIL-LEFT 0>
		       <TELL "Inside the small pink jar is some liquid." CR>)
		      (ELSE
		       <TELL "The jar is empty." CR>)>)>)
	       (<AND <VERB? OPEN>
		     <NOT <FSET? ,OIL-JAR ,OPENBIT>>>
		<COND (<G? ,OIL-LEFT 0>
		       <TELL 
"Opening the jar reveals a small amount of liquid." CR >)
		      (T
		       <TELL "Opened." CR>)>
		<FSET ,OIL-JAR ,OPENBIT>
		<RTRUE>)>>

<OBJECT LIQUID
	(IN OIL-JAR)
	(FLAGS DONTTAKE)
	(DESC "liquid")
	(TEXT 
"The liquid is oily to the touch and smells as if it could be highly volatile.")
	(SYNONYM LIQUID OIL)
	(ACTION LIQUID-FCN)>
	
<ROUTINE LIQUID-FCN ()
	 <COND (<VERB? EXAMINE>
		<RFALSE>)
	       (<VERB? POUR POUR-ON>
		<COND (<NOT <IN? ,OIL-JAR ,WINNER>>
		       <COND (<ITAKE>
			      <TELL "(taken)" CR>
			      <PERFORM ,PRSA ,OIL-JAR>
			      <RTRUE>)
			     (T
			      <TELL 
"Hmm. It would be easier if you were holding it." CR>
			      <RTRUE>)>)
		      (T
		       <PERFORM ,PRSA ,OIL-JAR>
		       <RTRUE>)>)
	       (<AND <VERB? TASTE>
		     <FSET? ,OIL-JAR ,OPENBIT>>
		<TELL "It tastes horrible." CR>)>>
 

