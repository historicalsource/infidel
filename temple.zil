"TEMPLE for
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"TEMPLE--This is the file for the Temple area, the passage(s) leading
to it, and any objects found there. TEMPLE will articulate with the
BARGE area."

<ROOM IN-THE-HALL
      (IN ROOMS)
      (DESC "Steep Passageway")
      (FLAGS RLANDBIT)
      (LDESC
"You are at the top of a steep, descending passage that plunges down to the
north. Although the angle is steep, it looks as if you should have firm enough
footing to travel safely. From the angle, it appears as though the passage
is actually leaving the pyramid, cutting down through the sand high overhead
to an adjoining building.")
      (SOUTH TO BARGE-EXIT) ;"Articulates with BARGE area here"
      (DOWN TO S-END)
      (NORTH TO S-END)
      (OUT TO BARGE-EXIT)>

<ROOM S-END
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Steep Passageway")
      (LDESC
"You are about midway down a steep, descending, north/south passageway which
seems to lead out of the pyramid to the north. The walls of stone are polished
and as smooth as glass, glistening in your light, lighting the passage far to
the north and the south.")
      (SOUTH TO IN-THE-HALL)
      (UP TO IN-THE-HALL)
      (DOWN TO N-END)
      (NORTH TO N-END)>

<ROOM N-END
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Steep Passageway")
      (LDESC
"You are at the north end of a descending passageway. You can see the smoothly
polished passageway rising up and out of sight to the south, heading back into
the pyramid. A large doorway cut into the stone walls lies to the north and,
through it, you can see an immense chamber.")
      (SOUTH TO S-END)
      (UP TO S-END)
      (NORTH TO TEMPLE-ENTER)
      (IN TO TEMPLE-ENTER)
      (GLOBAL DOORWAY)>

<ROOM TEMPLE-ENTER
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Temple Chamber")
      (LDESC
"You are in a huge chamber, immense in its size and scope, especially since it
is far underground. Your light seems to climb and fall from the high walls,
making their top boundaries undefined as they melt into inky darkness,
flickering into the unknown reaches high overhead. There is a huge doorway
carved out of the south wall, the arch at its top barely discernible in your
light. To the north is a similar doorway, slightly scaled down, with pillars on
either side of it, their shadows playing strange tricks on the wall behind
them. You can just barely make out the paintings on the walls, pictures of the
ancient Queen, her servants, and the priests in attendance.")
      (SOUTH TO N-END)
      (NORTH TO SKELETON-ROOM)
      (OUT TO N-END)
      (IN TO SKELETON-ROOM)
      (GLOBAL PICTURES PILLARS)>

<ROOM SKELETON-ROOM
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Inner Chamber")
      (LDESC
"You are in the temple's inner chamber. The ceiling here is lower, low enough
for your light to reach it. There are openings in the east and west walls, and
a large, arched doorway to the south. The walls are covered with paintings,
most of which depict the Queen in different stages of preparation for her trip
on the royal barge. One in particular, larger than any of the others, shows the
Queen and all of her attendants aboard the barge, floating through the air on
their way to the netherworld. There are some detailed hieroglyphs on one of the
walls.")
      (OUT TO TEMPLE-ENTER)
      (SOUTH TO TEMPLE-ENTER)
      (WEST TO GOLDEN-ROOM)
      (EAST TO SILVER-ROOM)
      (GLOBAL HIEROGLYPHS PICTURES DOORWAY)>

<ROOM GOLDEN-ROOM
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Golden Room")
      (LDESC
"You are in a room whose walls are covered with gold leaf. Your light reflects
off the walls with a rich, warm tone and reveals the outlines of hieroglyphics
engraved in the gold itself. There is a doorway cut into the south wall and,
through the reflected light, you can tell it leads into a small chamber. There
is another doorway leading out to the east.")
      (EAST TO SKELETON-ROOM)
      (SOUTH TO GCUP-ROOM)
      (OUT TO SKELETON-ROOM)
      (IN TO GCUP-ROOM)
      (GLOBAL HIEROGLYPHS GOLD-LEAF)>

<OBJECT GOLD-LEAF
	(IN LOCAL-GLOBALS)
	(FLAGS NDESCBIT DONTTAKE TOUCHBIT)
	(DESC "glittering leaf")
	(SYNONYM LEAF)
	(ADJECTIVE GOLD SILVER)
	(TEXT
"The walls are covered with it. And it's very beautiful.")>

<ROOM GCUP-ROOM
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Golden Alcove")
      (LDESC
"You are in a small alcove off the Golden Room. Sitting in the middle of this
small room is a roughly-hewn slab of granite, much like a legless table.")
      (OUT TO GOLDEN-ROOM)
      (NORTH TO GOLDEN-ROOM)
      (GLOBAL TABLE)>

<ROOM SILVER-ROOM
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Silver Room")
      (LDESC 
"You are in the Silver Chamber, a room whose walls reflect your light
brilliantly due to their silver surface. A doorway leads west and out, while
another doorway leads into a smaller room to the south.")
      (OUT TO SKELETON-ROOM)
      (WEST TO SKELETON-ROOM)
      (IN TO SCUP-ROOM)
      (SOUTH TO SCUP-ROOM)
      (GLOBAL HIEROGLYPHS GOLD-LEAF)>

<ROOM SCUP-ROOM
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Silver Alcove")
      (LDESC
"You are in a small alcove off the Silver Room. Sitting in the middle of this
small room is a roughly-hewn slab of granite, much like a legless table.")
      (OUT TO SILVER-ROOM)
      (NORTH TO SILVER-ROOM)
      (GLOBAL TABLE)>

<OBJECT GOLD-TABLE
	(IN GCUP-ROOM)
	(FLAGS CONTBIT SURFACEBIT OPENBIT NDESCBIT TRANSBIT DONTTAKE)
	(DESC "granite table") 
	(SYNONYM TABLE SLAB)
	(ADJECTIVE GRANITE)
	(CAPACITY 100)
	(ACTION HUH?)>

<OBJECT GOLD-CUP
	(IN GOLD-TABLE)
	(FLAGS CONTBIT OPENBIT TAKEBIT SEARCHBIT)
	(DESC "golden chalice")
	(FDESC
"Sitting in the middle of the granite table is a gleaming chalice made
of gold.")
	(TEXT
"The cup is heavier than you thought it might be. The outside of it is
beautifully etched with scenes of the Queen and her handmaidens.")
	(SYNONYM CUP CHALIC)
	(ADJECTIVE GOLD GOLDEN)
	(VALUE 15)
	(CAPACITY 5)
	(SIZE 8)
	(MAP 1)
	(ACTION CUP-FCN)>

<OBJECT SILVER-CUP
	(IN SILVER-TABLE)
	(FLAGS CONTBIT OPENBIT TAKEBIT SEARCHBIT)
	(DESC "silver chalice")
	(TEXT
"There's a thin line etched inside the chalice which travels all the way
around it. The chalice is not very heavy.")
	(FDESC
"Sitting in the middle of the granite table is a chalice made of gleaming silver.")
	(SYNONYM CUP CHALIC)
	(ADJECTIVE SILVER)
	(VALUE 15)
	(SIZE 5)
	(CAPACITY 5)
	(MAP 1)
	(ACTION CUP-FCN)>

<OBJECT LINE
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "line")
	(SYNONYM LINE)
	(ADJECTIVE THIN)
	(TEXT
"The line goes around the interior of the silver cup.")
	(ACTION LINE-FCN)>

<ROUTINE LINE-FCN ()
	 <COND (<NOT <OR <HELD? ,SILVER-CUP>
		    <IN? ,SILVER-CUP ,HERE>>>
		<TELL "I can't see any " D ,PRSO " here." CR>
		<RTRUE>)>>

<ROUTINE CUP-FCN ()
	 <COND (<AND <PRSO? ,SILVER-CUP>
		     <VERB? EXAMINE LOOK-INSIDE>
		     <OR <IN? ,WATER ,SILVER-CUP>
			 <IN? ,LIQUID ,SILVER-CUP>>>
		<TELL "The ">
		<COND (<IN? ,WATER ,SILVER-CUP>
		       <TELL "water">)
		      (T
		       <TELL "oily liquid">)>
		<TELL " fills the cup up to the line." CR>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)>>

<OBJECT SILVER-TABLE
	(IN SCUP-ROOM)
	(FLAGS CONTBIT SURFACEBIT TRANSBIT OPENBIT NDESCBIT DONTTAKE)
	(DESC "granite table") 
	(SYNONYM TABLE SLAB)
	(ADJECTIVE GRANITE)
	(CAPACITY 100)
	(ACTION HUH?)>

<OBJECT SKELETON
	(IN SKELETON-ROOM)
        (DESC "skeleton")        
	(FDESC 
"Lying before you in tortured repose are the bony remains of a former
adventurer, someone who tried looting the pyramid long, long ago. As you bend
over to pay your respects, something glitters, catching your eye as you move
your head.")
	(SYNONYM SKELET REMAIN BONES ADVENT)
	(ADJECTIVE BONY)
	(FLAGS TRYTAKEBIT TAKEBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 15)
	(ACTION SKELETON-FCN)>

<ROUTINE SKELETON-FCN ()
	 <COND (<OR <VERB? TAKE SHAKE MOVE>
		    <AND <VERB? PUT>
			 <EQUAL? ,PRSO ,SKELETON>>>
		<TELL
"If you tried that, the skeleton would fall apart, bone by bone." CR>
		<RTRUE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)
	       (<VERB? ALARM>
		<TELL "Let the dead rest." CR>
		<RTRUE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<COND (<IN? ,RING ,DIGITS>
		       <TELL
"On the bony digits of one hand is a jeweled ring." CR>)
		      (T
		       <TELL
"I see nothing special about the " D ,PRSO "." CR>)>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<HOW? ,PRSO>
		<RTRUE>)>>

<OBJECT DIGITS
	(IN SKELETON)
	(DESC "calcified hand")
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(SYNONYM DIGITS HAND)
	(ADJECTIVE BONY CALCIF)
	(ACTION DIGIT-FCN)>

<ROUTINE DIGIT-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<PERFORM ,V?EXAMINE ,SKELETON>
		<RTRUE>)>>

<OBJECT RING
	(IN DIGITS)
	(FLAGS TAKEBIT DONTTAKE NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(DESC "jeweled ring")
	(SYNONYM RING)
	(ADJECTIVE JEWELE)
	(TEXT
"At first glance, you are overwhelmed with the beauty and richness of the ring.
On close examination you notice the ring has a tiny needle on the inside of
the band.")
	(SIZE 1)
	(ACTION WEAR-RING-FCN)>

<ROUTINE WEAR-RING-FCN ()
	 <COND (<AND <VERB? WEAR>
		     <IN? ,RING ,WINNER>>
		<TELL
"Ouch! It seems you've pricked your finger while putting on the ring."
		CR>
		<ENABLE <QUEUE I-RING-KILL -1>>
		<FSET ,RING ,WEARBIT>
		<RTRUE>)
	       (<VERB? WEAR>
		<TELL "(Taken)" CR>
		<MOVE ,RING ,WINNER>
		<PERFORM ,V?WEAR ,RING>
		<RTRUE>)
	       (<VERB? TAKE>
		<COND (<ITAKE>
		       <TELL "Taken." CR>
		       <FCLEAR ,RING ,NDESCBIT>
		       <FCLEAR ,NEEDLE ,INVISIBLE>
		       <FCLEAR ,RING ,DONTTAKE>
		       <PUTP ,SKELETON ,P?FDESC
"Lying before you in tortured repose are the bony remains of a former adventurer.">)>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <FSET? ,RING ,NDESCBIT>>
		<FCLEAR ,NEEDLE ,INVISIBLE>
		<FCLEAR ,RING ,NDESCBIT>
		<FCLEAR ,RING ,DONTTAKE>
		<PUTP ,SKELETON ,P?FDESC
"Lying before you in tortured repose are the bony remains of a former adventurer.">
		<RFALSE>)
	       (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)
	       (<VERB? DISEMBARK>
		<TELL "It's stuck on your finger." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL <GETP ,RING ,P?TEXT> CR>
		<FCLEAR ,NEEDLE ,INVISIBLE>
		<FCLEAR ,RING ,DONTTAKE>
		<RTRUE>)>>

<OBJECT NEEDLE
	(IN RING)
	(FLAGS NDESCBIT INVISIBLE DONTTAKE TRYTAKEBIT)
	(DESC "tiny needle")
	(SYNONYM NEEDLE)
	(ADJECTIVE TINY)
	(SIZE 1)
	(TEXT
"Inside the band is a small needle set at an angle designed to pierce the skin.")
	(ACTION TOUCH-NEEDLE-FCN)>

<ROUTINE TOUCH-NEEDLE-FCN ()
	 <COND (<VERB? RUB>
		<TELL
"You prick your finger on the tiny needle sticking out from the inside of the
ring." CR>
		<ENABLE <QUEUE I-RING-KILL -1>>
		<RTRUE>)
	       (<VERB? DROP THROW PUT PUT-ON>
		<TELL "Better find a haystack first." CR>)
	       (<VERB? SMELL>
		<TELL "It smells very faintly of almonds." CR>)
	       (<VERB? TASTE>
		<JIGS-UP
"Ugh! It tastes terrible!|
|
You stand there in horrified amazement, feeling the poison creeping down your
throat and acting on your body almost instantaneously. Time to shuffle off...">
		<RFATAL>)>>

