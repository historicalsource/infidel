;"		ANTECHAMBER for INFIDEL"

<ROOM NORTH-ANTECHAMBER
      (IN ROOMS)
      (DESC "Antechamber")
      (LDESC 
"You are in the north end of the Chamber of Eternal Royalty. On the eastern
and western walls are scenes carved in high relief depicting a royal figure,
possibly meant to represent a new ruler, performing the ritual of the
\"opening of the mouth and eyes\", the ceremony of restoring to the mummy
of the departed Queen the use of its senses. The north wall of this area is
a thick, solid wall of stone. In the center of this wall is a timber lintel
on top of a doorway.")
      (FLAGS RLANDBIT)
      (SOUTH TO MID-ANTECHAMBER)
      (NORTH TO BURIAL-CHAMBER IF NORTH-ANTE-DOOR IS OPEN ELSE
"There's no way you can walk through the door.")
      (IN TO BURIAL-CHAMBER IF NORTH-ANTE-DOOR IS OPEN ELSE
"There's no way you can walk through the door.")
      (GLOBAL NORTH-ANTE-DOOR DOORWAY HIEROGLYPHS)
      (ACTION NORTH-ANTE-FCN)>

<OBJECT T-LINTEL
	(IN NORTH-ANTECHAMBER)
	(FLAGS NDESCBIT DONTTAKE)
	(DESC "timber lintel")
	(SYNONYM LINTEL)
	(ADJECTIVE TIMBER)>

<ROUTINE NORTH-ANTE-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG ,M-ENTER ,M-LOOK>
		<COND (<EQUAL? ,BEAM-PLACED 4>
		       <MOVE ,BEAM ,HERE>)>)>
	 <RFALSE>>

<ROOM MID-ANTECHAMBER
      (IN ROOMS)
      (DESC "Antechamber")
      (LDESC 
"You are in the middle of the Chamber of Eternal Royalty, the antechamber. The
walls in this section of the antechamber are covered with beveled tiles of deep
blue lapis lazuli and pink alabaster. At ceiling height, on the west wall, are
paintings depicting the marriage of the goddess Isis and the god Osiris. The
Antechamber stretches out to the north and the south. There's just enough light
cast for you to see the outline of the bottomless pit in the passage to the
east.")
      (FLAGS RLANDBIT)
      (NORTH TO NORTH-ANTECHAMBER)
      (SOUTH TO SOUTH-ANTECHAMBER)
      (EAST PER WALK-BEAM-FCN)
      (OUT PER WALK-BEAM-FCN)
      (GLOBAL DOORWAY PIT PICTURE-PANELS GEMS)
      (ACTION MOVE-PLANK-FCN)>

<OBJECT TILES
	(IN MID-ANTECHAMBER)
	(DESC "tiles")
	(FLAGS DONTTAKE TRYTAKEBIT NDESCBIT)
	(SYNONYM TILES IVORY)
	(TEXT "Quite beautiful, no?")>

<OBJECT PIT
	(IN LOCAL-GLOBALS)
	(DESC "deep pit")
	(FLAGS NDESCBIT INVISIBLE)
	(SYNONYM PIT)
	(ADJECTIVE DEEP)
	(ACTION PIT-FCN)>

<ROUTINE PIT-FCN ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?DOWN>)
	       (<VERB? LOOK-INSIDE LOOK-DOWN EXAMINE>
		<TELL "It's too deep and dark to see much of anything." CR>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "You hear the squealing of rats. Hungry rats." CR>
		<RTRUE>)>>

<ROUTINE MOVE-PLANK-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG ,M-ENTER ,M-LOOK>
		<COND (<EQUAL? ,BEAM-PLACED 1 5>
		       <MOVE ,BEAM ,HERE>)>
		<COND (<EQUAL? ,HERE ,MID-ANTECHAMBER ,MID-PASSAGE>
		       <SETG ON-BEAM <>>)>
		<COND (<NOT <EQUAL? .RARG ,M-BEG>>
		       <RFALSE>)
		      (<NOT <VERB? DROP THROW PUT>>
		       <RFALSE>)
		      (<AND <VERB? PUT>
			    <NOT <PRSI? ,PIT>>>
		       <RFALSE>)
		      (<FSET? ,PIT ,INVISIBLE>
		       <RFALSE>)
		      (<AND <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
			    <AND <NOT <EQUAL? ,PRSO ,WINNER ,ME ,ADVENTURER>>
				 <NOT <EQUAL? ,PRSO ,NOT-HERE-OBJECT>>
				 <IN? ,PRSO ,WINNER>>
			    <EQUAL? .RARG ,M-BEG>>
		       <REMOVE ,PRSO>
		       <TELL "You hear the " D ,PRSO
			     " hit the bottom of the deep pit." CR>
		       <SETG P-IT-LOC <>>
		       <COND (<PRSO? ,TORCH>
			      <KILL-TORCH>)>
		       <RTRUE>)>
		<RFALSE>)>>
	 
<ROUTINE WALK-BEAM-FCN ()
	 <COND (<NOT <EQUAL? ,BEAM-PLACED 1 5>>
		<JIGS-UP
"You step into air then plummet into a deep pit, the home of a rat pack.">)
	       (T 
		<SETG ON-BEAM T>
		<MOVE ,BEAM ,WEST-END-OF-PASSAGE>
		,WEST-END-OF-PASSAGE)>>

<OBJECT LINTEL
	(IN WEST-END-OF-PASSAGE)
	(FLAGS NDESCBIT CONTBIT OPENBIT DONTTAKE)
	(DESC "timber frame")
	(SYNONYM FRAME)
	(ADJECTIVE TIMBER)
	(TEXT
"The timber frame surrounds the doorway.")
	(ACTION BURN-FRAME-FCN)>

<ROUTINE BURN-FRAME-FCN ()
	 <COND (<VERB? BURN>
		<TELL
"You light the timber frame surrounding the door. The wood is slow to catch,
but then, in a bursting flash, the entire frame is consumed. You shield your
eyes and move back to keep from being burned, but as you take a step back, ">
		<COND (<NOT ,ON-BEAM>
		       <JIGS-UP
"your foot lands on empty space and you plummet downward to darkness.">)
		      (T
		       <JIGS-UP
"you lose your balance on the mast. Your foot misses the mast and you slip,
falling into the darkness below.">)>)>> 

<ROOM SOUTH-ANTECHAMBER
      (IN ROOMS)
      (DESC "Antechamber")
      (LDESC
"You are in the southern end of the Chamber of Eternal Royalty. From here you
can see the room stretching out towards the north. The south wall is painted to
resemble large baskets of lotus flowers with their blue petals framing an image
of the Sun God, Amun Ra. The west wall has a timber doorway, inset several feet
into the rocks, outlining a door.")
      (FLAGS RLANDBIT)
      (NORTH TO MID-ANTECHAMBER)
      (WEST TO ANNEX IF ANNEX-DOOR IS OPEN ELSE
"The way to the west is blocked by a closed door.")
      (IN TO ANNEX IF ANNEX-DOOR IS OPEN ELSE
"The way to the west is blocked by a closed door.")
      (GLOBAL HIEROGLYPHS DOORWAY ANNEX-DOOR)
      (ACTION ANNEX-BEAM-MOVER)>

<OBJECT ROCKS
	(IN SOUTH-ANTECHAMBER)
	(FLAGS NDESCBIT DONTTAKE CONTBIT OPENBIT SURFACEBIT)
	(DESC "rocks")
	(CAPACITY 35)
	(SYNONYM ROCKS)
	(ACTION ROCKS-FCN)>

<ROUTINE ROCKS-FCN ()
	 <COND (<AND <VERB? PUT-UNDER PUT-AGAINST PUT>
		     <EQUAL? ,PRSI ,ROCKS>
		     <NOT <EQUAL? ,PRSO ,BEAM>>>
		<TELL "Weird!" CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<EQUAL? ,BEAM-PLACED 2 3>
		       <TELL "The rocks support the beam." CR>
		       <RTRUE>)
		      (ELSE
		       <TELL "I see nothing special about the rocks." CR>
		       <RTRUE>)>)
	       (<VERB? OPEN CLOSE>
		<TELL
"Huh? The rocks? Come on! They're on either side of the doorway!" CR>
		<RTRUE>)>
	 <RFALSE>>

<OBJECT CHIPS1
	(FLAGS NDESCBIT TAKEBIT DONTTAKE TOUCHBIT)
	(DESC "plaster dust")
	(SYNONYM DUST CHIP CHIPS)
	(TEXT
"The dust and chips are just remnants of your incessant tapping, tapping at the
chamber door. Only this and nothing more.")
	(ACTION TAKE-A-CHIP-FCN)>

<OBJECT CHIPS2
	(FLAGS NDESCBIT TAKEBIT DONTTAKE TOUCHBIT)
	(DESC "plaster dust")
	(SYNONYM DUST CHIP CHIPS)
	(TEXT
"The dust and chips are just remnants of your incessant tapping, tapping at the
chamber door. Only this and nothing more.")
	(ACTION TAKE-A-CHIP-FCN)>

<ROUTINE TAKE-A-CHIP-FCN ()
	 <COND (<VERB? TAKE PUT MOVE RAISE
		       PULL-UP MUNG PUT>
		<TELL
"Be serious. Have you any acquaintance with particle physics? How about quarks?
Know anything about quarks? Let me put it to you this way: There are more
pieces of plaster dust and chips here than you have seconds in your life." CR>
		<RTRUE>)>>

<ROOM ANNEX
      (IN ROOMS)
      (DESC "Annex")
      (LDESC
"You are in the Chamber of Rebirth, the Annex. As you gaze about this small
room, strange kohl-rimmed eyes gaze back at you from the painted figures
which cover all of the walls. There are scenes of a great procession, with
white-clad princesses offering gifts of precious oils and papyri to the
mummified figure of the Queen. Bastet, the cat goddess, holds the mummy
erect. Above you, painted on the ceiling, is the image of Tueris, the
hippopotamus goddess. The only way out is through the doorway to the east.")
      (FLAGS RLANDBIT)
      (EAST TO SOUTH-ANTECHAMBER IF ANNEX-DOOR IS OPEN)
      (OUT TO SOUTH-ANTECHAMBER IF ANNEX-DOOR IS OPEN)
      (GLOBAL ANNEX-DOOR DOORWAY PICTURES)
      (ACTION ANNEX-BEAM-MOVER)>

<ROUTINE ANNEX-BEAM-MOVER (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG ,M-ENTER ,M-LOOK>
		<COND (<EQUAL? ,BEAM-PLACED 2 3>
		       <MOVE ,BEAM ,HERE>)>)>
	 <RFALSE>>

<OBJECT SLAB
	(IN ANNEX)
	(FLAGS DONTTAKE CONTBIT SURFACEBIT OPENBIT)
	(DESC "slab")
	(SYNONYM SLAB)
	(ADJECTIVE HUGE STONE)
	(CAPACITY 200)
	(DESCFCN DESCRIBE-SLAB-FCN) 
	(ACTION OPEN-SLAB-FCN)>

<OBJECT SLAB-SEAM
	(IN ANNEX)
	(FLAGS NDESCBIT DONTTAKE CONTBIT)
	(DESC "thin seam")
	(CAPACITY 1)
	(SYNONYM SEAM)
	(ADJECTIVE THIN)
	(ACTION SEAM-FCN)>

<ROUTINE SEAM-FCN ()
	 <COND (<AND <EQUAL? ,PRSO ,SLAB-SEAM>
		     <NOT <FSET? ,SLAB ,SURFACEBIT>>>
		<TELL "I see no seam here." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The seam is barely visible. It goes into the edge of the slab no more than an
eighth of an inch." CR>)
	       (<AND <VERB? PUT PUT-ACROSS PUT-ON>
		     <PRSI? ,SLAB-SEAM>>
		<TELL "It's not deep enough to wedge anything into it." CR>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,SLAB-SEAM>
		<RTRUE>)>>
	       
<ROUTINE OPEN-SLAB-FCN ("AUX" (FLG <>))
	 <COND (<VERB? OPEN RAISE MOVE>
		<COND (<NOT <FSET? ,SLAB ,SURFACEBIT>>
		       <TELL "It's already open." CR>
		       <RTRUE>)
		      (<AND <IN? ,ISIS-JEWEL ,HOLE-3>
			    <IN? ,NEPHTH-JEWEL ,HOLE-1>
			    <IN? ,SELKIS-JEWEL ,HOLE-2>
			    <IN? ,NEITH-JEWEL ,HOLE-4>>
		       <TBL-TO-INSIDE ,SLAB ,SLAB-TBL
"The slab opens slowly and gracefully as if some internal mechanism balanced
its huge weight.">
		       <RTRUE>)
		      (T
		       <TELL "It won't budge." CR>
		       <RTRUE>)>)
	       (<AND <VERB? CLOSE>
		     <NOT <FSET? ,SLAB ,SURFACEBIT>>>
		<COND (<AND <IN? ,TORCH ,SLAB>
			    <FLAMING? ,TORCH>>
		       <SET FLG T>)>
	        <INSIDE-OBJ-TO ,SLAB-TBL ,SLAB>
		<COND (.FLG
		       <KILL-TORCH T>)>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<DESCRIBE-SLAB-FCN ,M-OBJDESC>
		<RTRUE>)>>

<GLOBAL SLAB-TBL ;"Thirt (30) slots to hold objects in the slab"
	<LTABLE DEAD-BOOK SPATULA 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

<ROUTINE HOLEY (H "OPTIONAL" (X? <>) "AUX" OBJ)
	 <SET OBJ <FIRST? .H>>
	 <COND (<NOT .OBJ>
		<COND (<EQUAL? .X? T>
		       <TELL " The " D .H " is empty.">
		       <RTRUE>)
		      (T
		       <RTRUE>)>)>
	 <TELL " Sitting in the " D .H " is a">
	 <VOWEL? .OBJ>
	 <TELL D .OBJ ".">>

<ROUTINE DESCRIBE-SLAB-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-OBJDESC>
		<TELL
"Sitting in the middle of this room is a huge stone slab.">
	 <COND (<FSET? ,SLAB ,SURFACEBIT>
		<TELL
" Around its side runs a seam which is barely detectable. On top of the slab
are four round holes, one in each corner.">
		<HOLEY ,HOLE-1>
		<HOLEY ,HOLE-2>
		<HOLEY ,HOLE-3>
		<HOLEY ,HOLE-4>
		<COND (<FIRST? ,SLAB>
		       <TELL " Sitting on the top of the slab ">
		       <COND (<G? <CCOUNT ,SLAB> 1>
			      <TELL "are ">)
			     (T <TELL "is ">)>
		       <PRINT-CONTENTS ,SLAB>
		       <TELL ".">)>
		<CRLF>
		<RTRUE>)
	       (T <TELL " The slab is open">
		<COND (<FIRST? ,SLAB>
		       <TELL " and holds ">
		       <PRINT-CONTENTS ,SLAB>)
		      (T <TELL " and quite empty">)>
		<TELL "." CR>
		<RTRUE>)>)>>

<OBJECT HOLE-4
	(IN ANNEX)
	(FLAGS NDESCBIT CONTBIT DONTTAKE OPENBIT)
	(DESC "fourth hole")
	(SYNONYM HOLE HOLES)
	(ADJECTIVE FOURTH)
	(CAPACITY 2)
	(MAP 2)
	(CONTFCN D-HOLE-FCN)
	(ACTION DIAMOND-HOLE-FCN)>

<OBJECT HOLE-3
	(IN ANNEX)
	(FLAGS NDESCBIT CONTBIT DONTTAKE OPENBIT)
	(DESC "third hole")
	(SYNONYM HOLE HOLES)
	(ADJECTIVE THIRD)
	(CAPACITY 2)
	(MAP 2)
	(CONTFCN D-HOLE-FCN)
	(ACTION DIAMOND-HOLE-FCN)>

<OBJECT HOLE-2
	(IN ANNEX)
	(FLAGS NDESCBIT CONTBIT DONTTAKE OPENBIT)
	(DESC "second hole")
	(SYNONYM HOLE HOLES)
	(ADJECTIVE SECOND)
	(CAPACITY 2)
	(MAP 2)
	(CONTFCN D-HOLE-FCN)
	(ACTION DIAMOND-HOLE-FCN)>

<OBJECT HOLE-1
	(IN ANNEX)
	(FLAGS NDESCBIT CONTBIT DONTTAKE OPENBIT)
	(DESC "first hole")
	(SYNONYM HOLE HOLES)
	(ADJECTIVE FIRST)
	(CAPACITY 2)
	(MAP 2)
	(CONTFCN D-HOLE-FCN)
	(ACTION DIAMOND-HOLE-FCN)>

<ROUTINE D-HOLE-FCN ()
	 <COND (<AND <VERB? TAKE>
		     <OR <EQUAL? <LOC ,PRSO> ,HOLE-1 ,HOLE-2>
			 <EQUAL? <LOC ,PRSO> ,HOLE-3 ,HOLE-4>>>
		<COND (<ITAKE>
		       <FCLEAR ,PRSO ,NDESCBIT>
		       <TELL "Taken." CR>
		       <RTRUE>)
		      (T
		       <RTRUE>)>)>>

<ROUTINE DIAMOND-HOLE-FCN ("AUX" (FLG <>))
	 <COND (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <OR <PRSO? ,HOLE-1 ,HOLE-2 ,HOLE-3>
			 <PRSO? ,HOLE-4>>>
		<TELL "The hole sits in the ">
		<COND (<EQUAL? ,PRSO ,HOLE-1>
		       <TELL "northwest">)
		      (<EQUAL? ,PRSO ,HOLE-2>
		       <TELL "northeast">)
		      (<EQUAL? ,PRSO ,HOLE-3>
		       <TELL "southwest">)
		      (T <TELL "southeast">)>
		<TELL " corner of the slab.">
		<HOLEY ,PRSO T>
		<CRLF>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <OR <PRSI? ,HOLE-1 ,HOLE-2 ,HOLE-3>
			 <PRSI? ,HOLE-4>>>
		<COND (<FIRST? ,PRSI>
		       <TELL "The hole is already filled." CR>
		       <RTRUE>)
		      (<AND <PRSI? ,HOLE-1>
			    <PRSO? ,NEPHTH-JEWEL>>
		       <SET FLG T>)
		      (<AND <PRSI? ,HOLE-2>
			    <PRSO? ,SELKIS-JEWEL>>
		       <SET FLG T>)
		      (<AND <PRSI? ,HOLE-3>
			    <PRSO? ,ISIS-JEWEL>>
		       <SET FLG T>)
		      (<AND <PRSI? ,HOLE-4>
			    <PRSO? ,NEITH-JEWEL>>
		       <SET FLG T>)>
		<FSET ,PRSO ,NDESCBIT>
		<COND (<NOT .FLG>
		       <RFALSE>)
		      (T
		       <TELL 
"Done. A light click comes from beneath the corner." CR>
		       <MOVE ,PRSO ,PRSI>
		       <RTRUE>)>)>>
	
<ROOM BURIAL-CHAMBER
      (IN ROOMS)
      (DESC "Burial Chamber")
      (SOUTH TO NORTH-ANTECHAMBER IF NORTH-ANTE-DOOR IS OPEN)
      (EAST TO TREASURY)
      (FLAGS RLANDBIT)
      (ACTION BURIAL-CHAMBER-DESC)
      (LDESC "LDESC")
      (GLOBAL NORTH-ANTE-DOOR DOORWAY)>

<ROUTINE BURIAL-CHAMBER-DESC (RARG "AUX" (OFFSET -1) (HOLDING 0) TEMP-HOLD)
	 <COND (<EQUAL? .RARG ,M-BEG ,M-LOOK ,M-ENTER>
		<COND (<AND <EQUAL? <LOC ,BEAM> ,BURIAL-CHAMBER 
				    ,NORTH-ANTECHAMBER>
			    ,BEAM-PLACED>
		       <MOVE ,BEAM ,HERE>)>)>
	 <COND (<NOT <EQUAL? .RARG ,M-LOOK>>
		<RFALSE>)>
	 <TELL
"You have entered the Chamber of Departure Towards the Funeral Destinies, the
Burial Chamber. There is a doorway leading into a small room off to the east.
In the middle of the chamber, stretching almost from wall to wall, is a huge,
ancient sarcophagus. Its cover is composed of pure quartz and through the
shining light you can see the golden, gleaming mummiform coffin. ">
	 <DESCRIBE-COVER>
	 <REPEAT ()
		 <SET OFFSET <+ .OFFSET 1>>
		 <COND (<G? .OFFSET 3>
			<RETURN>)
		       (<FSET? <GET ,STATUE-TBL .OFFSET> ,CLAMPBIT>
			<SET HOLDING <+ .HOLDING 1>>)>>
	 <TELL
" Four statues surround the sarcophagus, one in each corner: Isis, Nephthys,
Neith and Selkis. ">
	 <COND (<EQUAL? .HOLDING 4>
		<TELL 
"Their outstretched arms clamp down tightly on the quartz cover." CR>
		<RTRUE>)
	       (<0? .HOLDING>
		<TELL
"All four statues face away from the quartz cover, their grip on it released." CR>
		<RTRUE>)>
	 <SET OFFSET -1>
	 <SET TEMP-HOLD .HOLDING>
	 <REPEAT ()
		 <COND (<0? .HOLDING>
			<RETURN>)
		       (ELSE
			<SET OFFSET <+ .OFFSET 1>>
			<COND (<FSET? <GET ,STATUE-TBL .OFFSET> ,CLAMPBIT>
			       <TELL <GET ,STATUE-NAME-TBL .OFFSET>>
			       <COND (<G? .HOLDING 2>
				      <TELL ", ">)
				     (<G? .HOLDING 1>
				      <TELL " and ">)>
			       <SET HOLDING <- .HOLDING 1>>)>)>>
	 <COND (<G? .TEMP-HOLD 1>
		<TELL " are ">)
	       (T <TELL " is ">)>
	 <TELL "facing inward, ">
	 <COND (<G? .TEMP-HOLD 1>
		<TELL "their">)
	       (T <TELL "its">)>
	 <TELL 
" heavy arms clamping down tightly over the quartz cover of the
sarcophagus." CR>>

<ROOM TREASURY
      (IN ROOMS)
      (DESC "Treasury")
      (LDESC
"You are in the Chamber of Reconstitution of the Body, the Treasury. To the
west is a doorway leading back into the Burial Chamber.")
      (FLAGS RLANDBIT)
      (WEST TO BURIAL-CHAMBER)
      (OUT TO BURIAL-CHAMBER)>

<OBJECT SCARAB-TABLE
	(IN TREASURY)
	(FLAGS CONTBIT OPENBIT DONTTAKE)
	(DESC "granite table")
	(SYNONYM TABLE)
	(ADJECTIVE GRANITE)
	(CAPACITY 100)
	(DESCFCN PROB-DESC)
	(ACTION SCARAB-TABLE-F)>

<ROUTINE SCARAB-TABLE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<PROB-DESC 15>
		<RTRUE>)>>

<ROUTINE DISC-CONTFCN ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? <LOC ,PRSO> ,LEFT-DISC ,RIGHT-DISC>
		     <NOT <IN? ,SCARAB ,MID-DISC>>>
		<JIGS-UP
"You should have left well enough alone. As you pick it up, the discs go wildly
out of balance and, before you realize what you've done, the ceiling comes down
to meet the floor. Unfortunately, you were between them at the time.">
		<RFATAL>)>>

<OBJECT LEFT-DISC
	(IN SCARAB-TABLE)
	(DESC "left disc")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT DONTTAKE TRANSBIT)
	(CAPACITY 30)
	(SYNONYM DISC)
	(ADJECTIVE LEFT)
	(CONTFCN DISC-CONTFCN)
	(ACTION PUSH-DISC-FCN)>
 
<OBJECT RIGHT-DISC
	(IN SCARAB-TABLE)
	(DESC "right disc")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT DONTTAKE TRANSBIT)
	(CAPACITY 30)
	(SYNONYM DISC)
	(ADJECTIVE RIGHT)
	(CONTFCN DISC-CONTFCN)
	(ACTION PUSH-DISC-FCN)>

<OBJECT MID-DISC
	(IN SCARAB-TABLE)
	(DESC "middle disc")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT DONTTAKE TRANSBIT)
	(CAPACITY 30)
	(SYNONYM DISC)
	(ADJECTIVE MIDDLE)
	(ACTION PUSH-DISC-FCN)>

<ROUTINE PUSH-DISC-FCN ("AUX" LEFT-STATUS RIGHT-STATUS L-WEIGHT R-WEIGHT)
	 <COND (<NOT <EQUAL? ,PRSO ,LEFT-DISC ,RIGHT-DISC ,MID-DISC>>
		<RFALSE>)
	       (<VERB? PUSH MOVE>
		<TELL 
"The discs float up and down several times until they come back into balance."
		      CR>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<SET LEFT-STATUS <FIRST? ,LEFT-DISC>>
		<SET RIGHT-STATUS <FIRST? ,RIGHT-DISC>>
		<COND (.LEFT-STATUS
		       <SET L-WEIGHT <WEIGHT .LEFT-STATUS>>)>
		<COND (.RIGHT-STATUS
		       <SET R-WEIGHT <WEIGHT .RIGHT-STATUS>>)>
		<COND (<PRSO? ,LEFT-DISC>
		       <TELL-ABOUT ,LEFT-DISC .L-WEIGHT .R-WEIGHT>
		       <CRLF>)
		      (<PRSO? ,MID-DISC>
		       <TELL-ABOUT ,MID-DISC .L-WEIGHT .R-WEIGHT>
		       <CRLF>)
		      (T
		       <TELL-ABOUT ,RIGHT-DISC .R-WEIGHT .L-WEIGHT>)>
		<RTRUE>)>>

<ROUTINE PROB-DESC
	 (RARG "AUX" LEFT-STATUS RIGHT-STATUS (L-WEIGHT 0) (R-WEIGHT 0))
	 <COND (<NOT <EQUAL? .RARG ,M-OBJDESC 15>>
		<RFALSE>)>
	 <SET LEFT-STATUS <FIRST? ,LEFT-DISC>>
	 <SET RIGHT-STATUS <FIRST? ,RIGHT-DISC>>
	 <COND (.LEFT-STATUS
		<SET L-WEIGHT <WEIGHT .LEFT-STATUS>>)>
	 <COND (.RIGHT-STATUS
		<SET R-WEIGHT <WEIGHT .RIGHT-STATUS>>)>
	 <COND (<EQUAL? .RARG ,M-OBJDESC>
		<TELL
"In the room is a large, granite table. Cut out from the top of this table are
three circles of polished granite. ">)>
	 <TELL-ABOUT ,LEFT-DISC .L-WEIGHT .R-WEIGHT>
	 <TELL " ">
	 <TELL-ABOUT ,MID-DISC .L-WEIGHT .R-WEIGHT>
	 <TELL " ">
	 <TELL-ABOUT ,RIGHT-DISC .R-WEIGHT .L-WEIGHT>>
	 
<ROUTINE TELL-ABOUT (DISC W-1 W-2 "AUX" (BALANCED <>) (SAFE <>) (EMPTY <>)
		     OBJ OFFSET POSITION INCHES)
	 <SET POSITION "even with">
	 <COND (<AND <0? .W-1>
		     <0? .W-2>>
		<SET EMPTY T>)>
	 <COND (<NOT <FIRST? .DISC>>
		<TELL "The " D .DISC " is empty, and it is ">)
	       (T
		<SET OBJ <FIRST? .DISC>>
		<TELL "Sitting on the " D .DISC " is a">
		<VOWEL? .OBJ>
		<TELL D .OBJ ", and the " D .DISC " is ">)>
	 <COND (<AND <EQUAL? .W-2 .W-1>
		     <NOT .EMPTY>>
		<SET BALANCED T>)>
	 <COND (.BALANCED
		<COND (<EQUAL? .W-1 8>
		       <SET SAFE T>)>)>
	 <COND (<G? .W-1 .W-2>
		<SET POSITION "below">)
	       (<G? .W-2 .W-1>
		<SET POSITION "above">)
	       (.EMPTY
		<SET POSITION "above">)
	       (<AND .BALANCED
		     <NOT .SAFE>>
		<SET POSITION "below">)>
	 <COND (<AND <NOT .BALANCED>
		     <NOT .EMPTY>>
		<SET OFFSET <ABS <- .W-1 .W-2>>>)
	       (.EMPTY
		<SET OFFSET 1>)
	       (<NOT .SAFE>
		<SET OFFSET <ABS <- .W-1 8>>>)>
	 <COND (.SAFE
		<SET INCHES "exactly">)
	       (<G? .OFFSET 8>
		<SET INCHES "9 inches">)
	       (T
		<SET INCHES <GET ,INCH-LTBL .OFFSET>>)>
	 <COND (<EQUAL? .DISC ,MID-DISC>
		<COND (<AND .SAFE
			    <FIRST? .DISC>>
		       <TELL "slightly above">)
		      (<FIRST? .DISC>
		       <TELL "slightly below">)
		      (T
		       <TELL "exactly even with">)>)
	       (<EQUAL? .DISC ,LEFT-DISC ,RIGHT-DISC>
		<TELL .INCHES " " .POSITION>)>
	 <TELL " the top of the table.">
	 <COND (<EQUAL? .DISC ,RIGHT-DISC>
		<CRLF>)>>

<GLOBAL INCH-LTBL
	<LTABLE "one inch" "two inches" "three inches" "four inches"
		"five inches" "six inches" "seven inches" "eight inches">>

<ROOM TOP-OF-STAIRS
      (IN ROOMS)
      (DESC "Top of Stairway")
      (LDESC 
"You are at the top of a sixteen-step stairway. It leads west and down. The
strange passageway into the cube rooms lies to the south. The walls here are
painted in somber colors -- deep ochres, browns and blacks, but the scenes the
paintings depict are oddly gay. Priests smile, their hands lifted up high to
Amun Ra, offering flower petals in their palms, while a young girl, bedecked
in black, stands by watching, a twisted smile on her face.")
      (FLAGS RLANDBIT)
      (WEST TO STAIRS-BOTTOM)
      (DOWN TO STAIRS-BOTTOM)
      (SOUTH TO SECRET-PASSAGE)
      (UP TO SECRET-PASSAGE)
      (GLOBAL PICTURES STAIRS)>
      

<ROOM STAIRS-BOTTOM 
      (IN ROOMS)
      (DESC "Bottom of Stairs")
      (LDESC
"You are at the bottom of the sixteen-step stairway. The stairway goes up to
the east, while to the west is solid plaster. Painted on the plaster
are some hieroglyphs.") 
       (FLAGS RLANDBIT)
       (WEST TO EAST-END-OF-PASSAGE IF PLASTER-GONE ELSE
"Solid plaster is blocking your way.")
       (EAST TO TOP-OF-STAIRS)
       (UP TO TOP-OF-STAIRS)
       (GLOBAL HIEROGLYPHS STAIRS DOORWAY)>

<ROOM EAST-END-OF-PASSAGE
      (IN ROOMS)
      (DESC "Narrow Passageway")
      (LDESC 
"You are at the east end of what seems like a long, straight passageway. After
carefully looking over the walls, stones and floor, you determine that it is
safe to proceed.")
      (EAST TO STAIRS-BOTTOM)
      (WEST TO MID-PASSAGE)
      (FLAGS RLANDBIT)>

<ROOM MID-PASSAGE
      (IN ROOMS)
      (DESC "Narrow Passageway")
      (LDESC
"You are in the middle of a long, east/west passage. The passage is narrow and
seems to be little more than a hallway hewn out of stone.")
      (FLAGS RLANDBIT)
      (WEST TO WEST-END-OF-PASSAGE)
      (EAST TO EAST-END-OF-PASSAGE)>

<ROOM WEST-END-OF-PASSAGE
      (IN ROOMS)
      (DESC "Narrow Passageway")
      (LDESC 
"You have reached the west end of the passage. Before you is a door surrounded
by a heavy timber frame. The door is entirely blocked up with plaster. Toward
the bottom of the north wall and the south wall, about three inches off the
floor, are two small niches. There are some hieroglyphs on the plaster.")
      (FLAGS RLANDBIT)
      (EAST TO MID-PASSAGE)
      (WEST PER JERRY-HACK-F)
      (GLOBAL DOORWAY HIEROGLYPHS PIT)
      (ACTION MOVE-PLANK-FCN)>

<ROUTINE JERRY-HACK-F ()
	 <COND (<FSET? ,INNER-DOOR ,OPENBIT>
		<RETURN ,MID-ANTECHAMBER>)
	       (T
		<TELL "You can't walk through a closed door." CR>
		<THIS-IS-IT ,INNER-DOOR>
		<RFALSE>)>>

<OBJECT NICHES
	(IN WEST-END-OF-PASSAGE)
	(FLAGS NDESCBIT DONTTAKE CONTBIT OPENBIT)
	(DESC "small niche")
	(TEXT
"Each small niche rests about three inches off the floor. They are recessed
into the walls, one on either side of the passageway.")
	(SYNONYM NICHE NICHES)
	(ADJECTIVE SMALL)
	(CAPACITY 1)
	(ACTION NICHE-F)>

<ROUTINE NICHE-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<TELL <GETP ,NICHES ,P?TEXT>>
		<COND (<EQUAL? ,BEAM-PLACED 1>
		       <TELL " Resting in the niches is the wooden beam.">)>
		<CRLF>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>)>>

<OBJECT PLASTER1
	(IN STAIRS-BOTTOM)
	(FLAGS NDESCBIT TAKEBIT TRYTAKEBIT DONTTAKE)
	(DESC "plaster")
	(SYNONYM PLASTE)
	(SIZE 5)
	(ACTION PLASTER1-FCN)>

<ROUTINE PLASTER1-FCN ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"Some hieroglyphics on the plaster say:|
">
		<PLASTER1-GLYPHS>
		<RTRUE>)
	       (<VERB? TAKE MUNG ATTACK>
		<COND (<NOT ,PRSI>
		       <COND (<IN? ,PICK-AXE ,WINNER>
			      <SETG PRSI ,PICK-AXE>)
			     (<IN? ,SHOVEL ,WINNER>
			      <SETG PRSI ,SHOVEL>)
			     (ELSE
			      <SETG PRSI ,HANDS>)>
		       <TELL "(with your " D ,PRSI ")" CR>)>
		<COND (<PRSI? ,PICK-AXE>
		       <REMOVE ,PLASTER1>
		       <SETG P-IT-LOC <>>
		       <MOVE ,PLASTER ,WEST-END-OF-PASSAGE>
		       <SETG SCORE <+ ,SCORE 10>>
		       <TELL
"The chips fly where they may as you relentlessly flail at the plaster with
your trusty pick axe. In just a few minutes you manage to clear all the
plaster from the doorway." CR>
		       <SETG PLASTER-GONE T>
		       <PUTP ,STAIRS-BOTTOM ,P?LDESC
"You are at the bottom of the sixteen-step stairway. The stairway goes up to
the east, while the way to the west has been cleared.">
		       <MOVE ,CHIPS1 ,HERE>
		       <RTRUE>)
		      (T <TELL
"You scratch at the plaster but accomplish little."
                          CR>)>)>>

<OBJECT INNER-DOOR
	(IN WEST-END-OF-PASSAGE)
	(FLAGS NDESCBIT DOORBIT VOWELBIT DONTTAKE)
	(SYNONYM DOOR)
	(ADJECTIVE INNER)
	(DESC "inner door")
	(ACTION INNER-DOOR-FCN)>

<ROUTINE INNER-DOOR-FCN ()
	 <COND (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <IN? ,PLASTER ,HERE>>
		<TELL 
"The door is surrounded by a heavy timber frame and is entirely blocked up
with plaster. There are some hieroglyphs on the plaster." CR>
		<RTRUE>)
	       (<VERB? OPEN>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It's already open." CR>
		       <RTRUE>)
		      (,INNER-DOOR-SEALED
		       <TELL "The door is covered with plaster, which is in turn covered with hieroglyphs." CR>)
		      (T
		       <TELL
"The door opens and you are overwhelmed by a musky odor." CR>
		       <FSET ,INNER-DOOR ,OPENBIT>
		       <RTRUE>)>)
	       (<VERB? CLOSE>
		<COND (<NOT <FSET? ,INNER-DOOR ,OPENBIT>>
		       <TELL "It isn't open." CR>)
		      (T <TELL
"Okay. The door is closed." CR>
		       <FCLEAR ,INNER-DOOR ,OPENBIT>)>)>>

<OBJECT PLASTER
	(FLAGS NDESCBIT TAKEBIT DONTTAKE TRYTAKEBIT)
	(SYNONYM PLASTE)
	(DESC "plaster")
	(TEXT
"The plaster is ancient, applied to the door behind it to prevent people from
entering the resting place of the Queen. Some hieroglyphs are etched into the
plaster.")
	(SIZE 5)
	(ACTION PLASTER-FCN)>

<GLOBAL DEATH-BEAM-STR
"The plaster starts to chip away beneath the incessant tapping of your pick
axe. You quickly realize, however, that the tapping has started some sand
flowing out of the bottom of the doorway. Just as you realize the seriousness
of your situation, the floor gives out beneath you and you plummet down, down,
down into a den of voracious rats...">

<ROUTINE PLASTER-FCN ("AUX" (FLG <>))
	 <COND (<VERB? TAKE MUNG ATTACK>
		<COND (<NOT ,PRSI>
		       <SET FLG T>
		       <COND (<IN? ,PICK-AXE ,WINNER>
			      <SETG PRSI ,PICK-AXE>)
			     (<IN? ,SHOVEL ,WINNER>
			      <SETG PRSI ,SHOVEL>)
			     (T
			      <SETG PRSI ,HANDS>)>)>
		<COND (.FLG
		       <TELL "(with your " D ,PRSI ")" CR>)>
		<COND (<EQUAL? ,PRSI ,PICK-AXE>
		       <COND (<NOT ,BEAM-PLACED>
			      <JIGS-UP ,DEATH-BEAM-STR>)
			     (<NOT ,ON-BEAM>
			      <TELL ,DEATH-BEAM-STR>
			      <JIGS-UP
			       " You wave to the beam stretching across the gap as you hurtle past it.">) 
			     (T
			      <TELL
"The plaster chips fly from the door as the incessant tapping of your pick
axe does its work. The tapping has started some sand flowing out of
the bottom of the doorway and the floor starts to give away. In a few
short moments, the floor has disappeared, but thankfully you're safe while
standing on the beam." CR>
			      <SETG INNER-DOOR-SEALED <>>
			      <REMOVE ,PLASTER>
			      <SETG P-IT-LOC <>>
			      <FCLEAR ,PIT ,INVISIBLE>
			      <DUMP-ALL-ON-GROUND>
			      <SETG SCORE <+ ,SCORE 25>>
			      <PUTP ,HERE ,P?LDESC
"You are in the west end of the passage. The plaster has been cleared, allowing
passage to the west.">
			      <THIS-IS-IT ,INNER-DOOR>
			      <MOVE ,CHIPS2 ,HERE>
			      <RTRUE>)>)
		      (T <TELL
			  "You scratch at the plaster but accomplish little."
			  CR>)>)>>

<OBJECT NORTH-ANTE-DOOR
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT DOORBIT)
	(SYNONYM DOOR)
	(ADJECTIVE BURIAL)
	(DESC "burial door")
	(ACTION NORTH-ANTE-DOOR-FCN)>

<ROUTINE NORTH-ANTE-DOOR-FCN ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<FSET? ,BURIAL-CHAMBER ,RMUNGBIT>
		       <TELL
"It's buried behind 3 tons of stones. Forget it." CR>)
		      (T <TELL 
"The door is surrounded by small seals and has a hieroglyph on it." CR>)>)
	       (<VERB? OPEN>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It's already open." CR>
		       <RTRUE>)
		      (<FSET? ,BURIAL-CHAMBER ,RMUNGBIT>
		       <TELL
"With all the stones which fell in the doorway, there's not a chance of ever
getting through again." CR>
		       <RTRUE>)
		      (,ANTE-SEAL
		       <TELL
"I don't think it's that simple. Not only isn't there a doorknob, but the door
is also covered with a seal." CR>)
		      (T
		       <TELL
"The door creaks open and you are assaulted by a deep, musty dead smell." CR>
		       <FSET ,NORTH-ANTE-DOOR ,OPENBIT>
		       <SETG SCORE <+ ,SCORE 40>>
		       <RTRUE>)>)
	       (<VERB? CLOSE>
		<COND (<NOT <FSET? ,NORTH-ANTE-DOOR ,OPENBIT>>
		       <TELL "It isn't open." CR>)
		      (T <TELL
"Closing the door isn't the best of ideas." CR>)>)
	       (<AND <VERB? READ>
		     <NOT <FSET? ,NORTH-ANTE-DOOR ,OPENBIT>>>
		<PERFORM ,V?READ ,HIEROGLYPHS>
		<RTRUE>)>>

<OBJECT N-ANTE-SEAL
	(IN NORTH-ANTECHAMBER)
	(FLAGS NDESCBIT)
	(DESC "seal")
	(SYNONYM SEALS SEAL)>

<OBJECT ANNEX-DOOR
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT DOORBIT VOWELBIT)
	(SYNONYM DOOR)
	(ADJECTIVE ANNEX)
	(DESC "annex door")
	(ACTION ANNEX-DOOR-FCN)>

<ROUTINE ANNEX-DOOR-FCN ()
	 <COND (<VERB? OPEN>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It's already open." CR>
		       <RTRUE>)
		      (<AND ,BEAM-PLACED
			    <IN? ,BEAM ,SOUTH-ANTECHAMBER>>
		       <TELL
"You open the door and two huge stones start to close in on you from either
side. Thankfully, you had the foresight to wedge the beam in the doorway to
prevent a flattening experience." CR>
		       <FSET ,ANNEX-DOOR ,OPENBIT>)
		      (ELSE
		       <JIGS-UP
"You open the door but before you can react, two huge stones close in on you --
one from the left side and one from the right side. Needless to say, you didn't
quite make it...">)>)
	       (<AND <VERB? EXAMINE LOOK-INSIDE>
		     <NOT <FSET? ,ANNEX-DOOR ,OPENBIT>>>
		<TELL
"This door seems to present no difficulty in opening. Lightly etched into it
are some faint symbols." CR>)
	       (<AND <VERB? READ>
		     <NOT <FSET? ,ANNEX-DOOR ,OPENBIT>>>
		<PERFORM ,V?READ ,HIEROGLYPHS>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <FSET? ,ANNEX-DOOR ,OPENBIT>>
		<TELL "Closing this door isn't a very good idea." CR>
		<RTRUE>)>>

<OBJECT ISIS
	(IN BURIAL-CHAMBER)
	(DESC "Isis statue")
	(SYNONYM STATUE)
	(ADJECTIVE ISIS)
	(FLAGS CLAMPBIT TURNBIT NDESCBIT)
	(ACTION TURN-STATUES-FCN)>

<OBJECT NEPHTHYS
	(IN BURIAL-CHAMBER)
	(DESC "Nephthys statue")
	(SYNONYM STATUE)
	(ADJECTIVE NEPHTH)
	(FLAGS NDESCBIT CLAMPBIT TURNBIT)
	(ACTION TURN-STATUES-FCN)>

<OBJECT NEITH
	(IN BURIAL-CHAMBER)
	(DESC "Neith statue")
	(SYNONYM STATUE)
	(ADJECTIVE NEITH)
	(FLAGS NDESCBIT CLAMPBIT TURNBIT)
	(ACTION TURN-STATUES-FCN)>

<OBJECT SELKIS
	(IN BURIAL-CHAMBER)
	(DESC "Selkis statue")
	(FLAGS NDESCBIT CLAMPBIT TURNBIT)
	(SYNONYM STATUE)
	(ADJECTIVE SELKIS)
	(ACTION TURN-STATUES-FCN)>

<OBJECT ARMS
	(IN BURIAL-CHAMBER)
	(DESC "arms")
	(SYNONYM ARM ARMS)
	(FLAGS NDESCBIT DONTTAKE)>

<ROUTINE TURN-STATUES-FCN ("AUX" (OFFSET 0))
	 <COND (<VERB? TURN>
		<COND (<NOT ,CAN-TURN-STATUES>
		       <TELL 
"Nothing happens. These statues seem to be beyond all hope." CR>
		       <RTRUE>)
		      (T
		       <TELL
"The " D ,PRSO " moves slowly, pivoting about its base, ">
		       <COND (<FSET? ,PRSO ,CLAMPBIT>
			      <FCLEAR ,PRSO ,CLAMPBIT>
			      <DO-THE-OFFSET>
			      <TELL
 "releasing its hold on the quartz cover." CR>)
			     (T
			      <FSET ,PRSO ,CLAMPBIT>
			      <TELL
"once more clamping down on the quartz cover." CR>)>
		       <RTRUE>)>)>>
		      
<ROUTINE DO-THE-OFFSET ("AUX" (OFFSET 0))
	 <REPEAT ()
		 <COND (<EQUAL? .OFFSET 4>
			<RETURN>)
		       (T
			<SET OFFSET <+ .OFFSET 1>>
			<COND (<EQUAL? <GET ,TURNED-LTBL .OFFSET> ,PRSO>
			       <RTRUE>)>)>>
	  <SETG TURN-OFFSET <+ ,TURN-OFFSET 1>>
	  <PUT ,TURNED-LTBL ,TURN-OFFSET ,PRSO>
	  <COND (<EQUAL? ,TURN-OFFSET 4>
		 <ENABLE <QUEUE I-RESET-STATUES 1>>)>>

<OBJECT SARCOPH
	(IN BURIAL-CHAMBER)
	(DESC "sarcophagus")
	(FLAGS CONTBIT NDESCBIT DONTTAKE)
	(CAPACITY 1000)
	(SIZE 500)
	(SYNONYM SARCOP COFFIN)
	(ACTION SARCOPH-FCN)>

<ROUTINE SARCOPH-FCN ()
	 <COND (<VERB? OPEN>
		<PERFORM ,V?OPEN ,SARCOPH-COVER>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSI ,SARCOPH>>
		<TELL "The " D ,PRSO " sits on the sarcophagus for a moment, but it quickly slides off its rounded top." CR>
		<MOVE ,PRSO ,HERE>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<RTRUE>)
	       (ELSE
		<RFALSE>)>>

<OBJECT SARCOPH-COVER
	(IN BURIAL-CHAMBER)
	(SIZE 150)
	(FLAGS NDESCBIT CONTBIT SURFACEBIT OPENBIT DONTTAKE)
	(SYNONYM COVER QUARTZ)
	(ADJECTIVE QUARTZ)
	(DESC "quartz cover")
	(CAPACITY 200)
	(ACTION SARCOPH-COVER-FCN)>

<OBJECT S-AREA
	(IN SARCOPH-COVER)
	(FLAGS CONTBIT SURFACEBIT OPENBIT NDESCBIT DONTTAKE)
	(DESC "smaller recess")
	(SYNONYM RECESS AREA AREAS)
	(ADJECTIVE SMALLE SMALL)
	(CAPACITY 100)
	(MAP 3)
	(CONTFCN RECESS-CONTFCN)
	(ACTION SETBIT-FCN)
	(SIZE 1)>

<OBJECT L-AREA
	(IN SARCOPH-COVER)
	(FLAGS CONTBIT SURFACEBIT OPENBIT NDESCBIT DONTTAKE)
	(DESC "larger recess")
	(SYNONYM RECESS AREA AREAS)
	(ADJECTIVE LARGE LARGER)
	(CAPACITY 100)
	(CONTFCN RECESS-CONTFCN)
	(ACTION SETBIT-FCN)
	(SIZE 1)
	(MAP 4)>

<ROUTINE SETBIT-FCN ("AUX" OBJ)
	 <COND (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,L-AREA ,S-AREA>
		     <FIRST? ,PRSI>>
		<TELL "There's already something on it." CR>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,L-AREA ,S-AREA>
		     <EQUAL? ,PRSO ,BEAM>>
		<TELL
"I don't think the beam would fit in there. It's a little too long." CR>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,L-AREA ,S-AREA>>
		<FSET ,PRSO ,NDESCBIT>
		<RFALSE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL 
"The area is recessed about an inch below the quartz cover."
CR>
		<COND (<SET OBJ <FIRST? ,PRSO>>
		       <TELL "Sitting in the " D ,PRSO " is a">
		       <VOWEL? .OBJ>
		       <TELL D .OBJ "." CR>)
		      (T
		       <TELL "The " D ,PRSO " is empty." CR>)>
		<RTRUE>)>>

<ROUTINE RECESS-CONTFCN ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? <LOC ,PRSO> ,S-AREA ,L-AREA>>
		<FCLEAR ,PRSO ,NDESCBIT>
		<RFALSE>)>>

<ROUTINE DESCRIBE-COVER ("AUX" S-OBJ L-OBJ)
	 <TELL 
"There is a small recess and a large recess on the top of the cover which you
can make out as thin, outlined areas.">
	 <SET S-OBJ <FIRST? ,S-AREA>>
	 <SET L-OBJ <FIRST? ,L-AREA>>
	 <COND (.S-OBJ
		<TELL " Resting in the smaller recess is a">
		<VOWEL? .S-OBJ>
		<TELL D .S-OBJ ".">)>
	 <COND (.L-OBJ
		<TELL " Sitting in the larger recess is the " D .L-OBJ ".">)>>

<ROUTINE SARCOPH-COVER-FCN ("AUX" STR (COUNTER 0) (OFFS -1))
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<DESCRIBE-COVER>
		<CRLF>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,SARCOPH-COVER>>
		<TELL "You place the " D ,PRSO " on the cover, but it slides
right off onto the ground." CR>
		<MOVE ,PRSO ,HERE>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<RTRUE>)
	       (<AND <VERB? OPEN MOVE>
		     <NOT ,STATUES-SET>>
		<SET STR "a single statue.">
		<REPEAT ()
			<SET OFFS <+ .OFFS 1>>
			<COND (<G? .OFFS 3>
			       <RETURN>)
			      (<FSET? <GET ,STATUE-TBL .OFFS> ,CLAMPBIT>
			       <SET COUNTER <+ .COUNTER 1>>)>>
		<COND (<G? .COUNTER 1>
		       <SET STR "the statues.">)>
		<TELL
"You tug, push, pull, yank and generally tire yourself out trying to open the
cover until you take a moment, wipe your brow, and look around. You notice that
the cover is being held in place by " .STR CR>
		<RTRUE>)
	       (<AND <VERB? OPEN MOVE>
		     ,STATUES-SET>
		<ENDING>
		<CRLF>
		<FINISH>)>>

<GLOBAL SCARAB-DEATH-STR
"As soon as you lift the scarab from the disc, the left and right discs rise
far enough above the surface of the table to activate a mechanism. You hear it
click just before the ceiling comes down to meet the floor.">

<ROUTINE SCARAB-CHECK-FCN ("AUX" L-W R-W (L-OBJ <>) (R-OBJ <>))
	 <COND (<VERB? EXAMINE READ>
		<TELL
"Etched onto its back is the following:|
">
		<FIXED-FONT-ON>
		<TELL "|
              >*>|
">
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<VERB? TAKE>
		<SETG CAN-TURN-STATUES <>>
		<SET L-OBJ <FIRST? ,LEFT-DISC>>
		<SET R-OBJ <FIRST? ,RIGHT-DISC>>
		<COND (<IN? ,SCARAB ,MID-DISC>
		       <COND (<OR <NOT .L-OBJ>
				  <NOT .R-OBJ>>
			      <JIGS-UP ,SCARAB-DEATH-STR>
			      <RFATAL>)
			     (T
			      <SET L-W <WEIGHT .L-OBJ>>
			      <SET R-W <WEIGHT .R-OBJ>>
			      <COND (<AND <EQUAL? .L-W 8>
					  <EQUAL? .R-W 8>>
				     <RFALSE>)
				    (T
				     <JIGS-UP ,SCARAB-DEATH-STR>)>)>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT PUT-ON>
		     <IN? ,SCARAB ,MID-DISC>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,S-AREA ,L-AREA>
		     <FIRST? ,PRSI>>
		<TELL "There's already something on it." CR>
		<RTRUE>)
	       (<VERB? MOVE>
		<TELL
"You'd better not. Not until you know what's going on here." CR>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,S-AREA>>
		<MOVE ,SCARAB ,S-AREA>
		<TELL "Done." CR>
		<FSET ,SCARAB ,NDESCBIT>
		<COND (<IN? ,DEAD-BOOK ,L-AREA>
		       <SETG CAN-TURN-STATUES T>
		       <TELL
"You hear a clicking sound come from beneath all of the statues as you place
the scarab within the smaller outlined area on the cover." CR>)>
		<RTRUE>)>>
 
<OBJECT SCARAB
	(IN MID-DISC)
	(FLAGS TAKEBIT TRYTAKEBIT READBIT)
	(DESC "scarab")
	(VALUE 10)
	(SYNONYM SCARAB)
	(SIZE 8)
	(MAP 3)
	(ACTION SCARAB-CHECK-FCN)>
	
<OBJECT DEAD-BOOK
	(FLAGS READBIT CONTBIT TAKEBIT VOWELBIT)
	(DESC "ancient book")
	(SYNONYM BOOK)
	(ADJECTIVE ANCIEN)
	(ACTION DEAD-BOOK-FCN)
	(SIZE 5)
	(MAP 4)
	(CAPACITY 1)
	(VALUE 10)>

<OBJECT PAGE
	(IN DEAD-BOOK)
	(DESC "page")
	(SYNONYM PAGE)
	(FLAGS NDESCBIT READBIT BURNBIT TURNBIT DONTTAKE TRYTAKEBIT)
	(ACTION PAGE-FCN)
	(SIZE 1)>

<ROUTINE PAGE-FCN ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"Hieroglyphs can be seen as follows:|
">
		<FIXED-FONT-ON>
		<TELL "|
        =  .           !   !|
<-*  #  =  -  #  !@!  !---!|
|
            .           !  !|
::  #  >*>  -  #  !@!  !--!|
">
		<FIXED-FONT-OFF>
		<RTRUE>)
	       (<VERB? TURN>
		<TELL "Unnecessary page turning may destroy the book." CR>
		<RTRUE>)
	       (<VERB? BURN>
		<PERFORM ,V?BURN ,DEAD-BOOK>)
	       >>

<OBJECT CRUMBLED-BOOK
	(FLAGS INVISIBLE BURNBIT TAKEBIT CONTBIT READBIT VOWELBIT OPENBIT)
	(DESC "ancient book")
	(SYNONYM BOOK DEAD)
	(SIZE 5)
	(TEXT
"This is what is left of the ancient Book of the Dead. Like the Queen it once
referred to, it too has seen better days.")
	(VALUE -20)
	(MAP 4)>

<ROUTINE DEAD-BOOK-FCN ()
	 <COND (<VERB? TAKE>
		<FCLEAR ,DEAD-BOOK ,NDESCBIT>
		<SETG CAN-TURN-STATUES <>>
		<RFALSE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,DEAD-BOOK ,CRUMBLED-BOOK>>
		<TELL "You'd do more damage putting things on the " D ,PRSI 
		      " than it would be worth." CR>
		<RTRUE>)
	       (<VERB? READ EXAMINE>
		<COND (<NOT <FSET? ,DEAD-BOOK ,OPENBIT>>
		       <TELL 
"The book isn't open. On the cover is the following, though:|
">
		       <FIXED-FONT-ON>
		       <TELL "|
       =|
       =" CR>
		       <FIXED-FONT-OFF>)
		      (T
		       <PERFORM ,V?READ ,PAGE>)>
		<RTRUE>)
	       (<VERB? OPEN>
		<COND (<AND ,PRSI
			    <PRSI? ,SPATULA>>
		       <TELL
"You open the book carefully using the spatula. You can see some faint
writing on the page." CR>
		       <FSET ,PRSO ,OPENBIT>
		       <RTRUE>)
		      (T
		       <TELL 
"Oops! The ancient papyrus pages crumble due to your less-than-delicate touch." CR>
		       <MOVE ,CRUMBLED-BOOK <LOC ,DEAD-BOOK>>
		       <REMOVE ,DEAD-BOOK>
		       <THIS-IS-IT ,CRUMBLED-BOOK>
		       <FCLEAR ,CRUMBLED-BOOK ,INVISIBLE>
		       <RTRUE>)>)
	       (<AND <VERB? READ>
		     <FSET? ,DEAD-BOOK ,OPENBIT>>
		<PERFORM ,V?READ ,PAGE>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,S-AREA ,L-AREA>
		     <FIRST? ,PRSI>>
		<TELL "There's already something on it." CR>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,L-AREA>>
		<MOVE ,DEAD-BOOK ,L-AREA>
		<FSET ,DEAD-BOOK ,NDESCBIT>
		<TELL
"The book now rests in the larger area on the cover of the sarcophagus." CR>
		<COND (<IN? ,SCARAB ,S-AREA>
		       <SETG CAN-TURN-STATUES T>
		       <TELL
"From beneath each of the four statues there comes a loud click." CR>)>
		<RTRUE>)>>
	

<OBJECT SPATULA
	(FLAGS TAKEBIT TOOLBIT TOUCHBIT)
	(DESC "small spatula")
	(SYNONYM SPATUL)
	(ADJECTIVE SMALL)
	(TEXT
"This spatula was originally used for opening books and turning their pages.")>

<ROUTINE ENDING ()
	 <TELL
"You lift the cover with great care, and in an instant you see all your dreams
come true. The interior of the sarcophagus is lined with gold, inset with
jewels, glistening in your torchlight. The riches and their dazzling beauty
overwhelm you. You take a deep breath, amazed that all of this is yours. You
tremble with excitement, then realize the ground beneath your feet is
trembling, too.|
|
As a knife cuts through butter, this realization cuts through your mind,
makes your hands shake and cold sweat appear on your forehead. The Burial
Chamber is collapsing, the walls closing in. You will never get out of this
pyramid alive. You earned this treasure. But it cost you your life.|
|
And as you sit there, gazing into the glistening wealth of the inner
sarcophagus, you can't help but feel a little empty, a little foolish.
If someone were on the other side of the quickly-collapsing wall, they could
have dug you out. If only you'd treated the workers better. If only you'd cut
Craige in on the find. If only you'd hired a reliable guide.|
|
Well, someday, someone will discover your bones here. And then you
will get your fame." CR>>

<ROUTINE DUMP-ALL-ON-GROUND ("AUX" L LOCB N F (FLG <>))
	 <SET L <LOC ,WINNER>>
	 <REMOVE ,WINNER>
	 <REMOVE ,INNER-DOOR>
	 <REMOVE ,NICHES>
	 <REMOVE ,LINTEL>
	 <COND (,BEAM-PLACED
		<SET LOCB <LOC ,BEAM>>
		<REMOVE ,BEAM>)>
	 <SET F <FIRST? ,HERE>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<REMOVE .N>
			<SET FLG T>)>>
	 <COND (.FLG
		<TELL CR "Everything on the floor falls into the pit." CR>)>
	 <MOVE ,WINNER .L>
	 <COND (.LOCB
		<MOVE ,BEAM .LOCB>)>
	 <MOVE ,INNER-DOOR ,WEST-END-OF-PASSAGE>
	 <MOVE ,NICHES ,WEST-END-OF-PASSAGE>
	 <MOVE ,LINTEL ,WEST-END-OF-PASSAGE>>

