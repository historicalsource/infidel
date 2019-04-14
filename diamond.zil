"DIAMOND for
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"DIAMOND AREA"
  
<ROOM ROOM-OF-NEPHTHYS
      (IN ROOMS)
      (DESC "Room of Nephthys")
      (FLAGS RLANDBIT)
      (LDESC 
"You have entered the room of the protective goddess Nephthys. The walls here
are cut from pink granite, elaborately decorated with bright red carnelian and
pale yellow feldspar. Along the northeast wall are panels of beaten gold, and
midway up this wall, under the winged symbol of Nephthys, you can see some
hieroglyphs. To the southeast, an opening has been cut in the thick granite
wall.") 
      (SE TO A-PRIME)
      (OUT TO A-PRIME)
      (GLOBAL HIEROGLYPHS DOORWAY PICTURE-PANELS GEMS-2)
      (ACTION SCORE-RMS)>

<OBJECT NEPHTH-JEWEL
	(IN ROOM-OF-NEPHTHYS)
	(FLAGS TAKEBIT)
	(DESC "diamond cluster")
	(VALUE 5)
	(SIZE 2)
	(FDESC
"A large diamond cluster, glittering in your light, sits on the floor directly
under the hieroglyphs.")
	(SYNONYM CLUSTE)
	(MAP 2)
	(ADJECTIVE DIAMON)>

<OBJECT HERRING-JEWEL
	(IN LANDING-ZERO)
	(FLAGS TAKEBIT)
	(DESC "golden cluster")
	(SIZE 2)
	(FDESC
"A large golden cluster sits on the floor.")
	(SYNONYM CLUSTE)
	(MAP 2)
	(ADJECTIVE GOLDEN GOLD)>

<OBJECT SELKIS-JEWEL
	(IN ROOM-OF-SELKIS)
	(FLAGS TAKEBIT)
	(VALUE 5)
	(SIZE 2)
	(DESC "ruby cluster")
	(FDESC
"A beautiful ruby cluster, sparkling like fire, sits on the floor.")
	(MAP 2)
	(SYNONYM CLUSTE)
	(ADJECTIVE RUBY)>

<OBJECT ISIS-JEWEL
	(IN ROOM-OF-ISIS)
	(FLAGS TAKEBIT VOWELBIT)
	(VALUE 5)
	(SIZE 2)
	(DESC "emerald cluster")
	(FDESC
"Lying on the ground is a brilliant, glowing emerald cluster.")
	(MAP 2)
	(SYNONYM CLUSTE)
	(ADJECTIVE EMERAL)>

<OBJECT NEITH-JEWEL
	(IN ROOM-OF-NEITH)
	(FLAGS TAKEBIT VOWELBIT)
	(DESC "opal cluster")
	(FDESC
"An opal cluster, glistening with the light of a thousand fires, lies on the
floor.")
	(SYNONYM CLUSTE)
	(ADJECTIVE OPAL)
	(VALUE 5)
	(MAP 2)
	(SIZE 2)>

<ROOM ROOM-OF-SELKIS
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Room of Selkis")
      (LDESC 
"You are standing in a small room, that of the protective goddess Selkis.
There are red, blue and green patterns on the walls formed from small glazed
tiles that have been carefully arranged in order of shade. The darkest tiles
border the floor, and become lightest near the ceiling. On one wall,
inscribed in a beaten gold panel, is the symbol of Selkis, under which you can
see some hieroglyphic text. An opening through the southwest wall leads out
of this room.")
      (SW TO B-PRIME)
      (OUT TO B-PRIME)
      (GLOBAL HIEROGLYPHS DOORWAY GEMS-2 PICTURE-PANELS)
      (ACTION SCORE-RMS)>

<OBJECT TWINKLERS
	(IN ROOM-OF-ISIS)
	(FLAGS NDESCBIT DONTTAKE)
	(DESC "quartz")
	(SYNONYM LIGHTS QUARTZ CHIPS PATTER)
	(ADJECTIVE THOUSA TINY)
	(TEXT
"They twinkle in the light, making beautiful patterns.")>

<ROOM ROOM-OF-ISIS
      (IN ROOMS)
      (DESC "Room of Isis")
      (FLAGS RLANDBIT)
      (LDESC
"This is the room of the protective goddess Isis. You stand in amazement
in the center of the room as thousands of tiny lights twinkle around you.
With great surprise you realize that the light from your torch is being
reflected by the mirror-like surfaces of innumerable quartzite chips.
These are set artfully into red clay panels in the walls, and are surrounded
by shiny red jasper fragments. On the southwest wall, under the winged symbol
of Isis, some hieroglyphic text is inscribed in a gold panel. To the northeast
is an arched opening, and, looking through it, you can barely make out a
hallway.")
      (NE TO D-PRIME)
      (OUT TO D-PRIME)
      (GLOBAL HIEROGLYPHS PICTURE-PANELS GEMS DOORWAY)
      (ACTION SCORE-RMS)>

<ROOM ROOM-OF-NEITH
      (IN ROOMS)
      (DESC "Room of Neith")
      (FLAGS RLANDBIT)
      (LDESC
"You are standing in the room of the protective goddess Neith. This room
seems dark and mysterious with its decorations of inky-blue lapis lazuli
and jet-black obsidian. Gold scrollwork defines an area on one of the
walls, in the center of which is the symbol of Neith. Below this you can
see some hieroglyphs etched into a beaten gold panel. There is a door in
the northwest wall leading out of the room.")
      (NW TO E-PRIME)
      (OUT TO E-PRIME)
      (GLOBAL HIEROGLYPHS PICTURE-PANELS PICTURES GEMS)
      (ACTION SCORE-RMS)>

<OBJECT GEMS
	(IN LOCAL-GLOBALS)
	(DESC "gem")
	(FLAGS NDESCBIT)
	(SYNONYM LAZULI OBSIDI JASPER GEMS)
	(ADJECTIVE LAPIS RED INKY- BLUE JET-B)
	(TEXT
"The gems are quite remarkable, forming a delicate piece of art. To remove
any of them would be beyond thinking. Even for you.")>

<OBJECT GEMS-2 
	(IN LOCAL-GLOBALS)
	(DESC "tile")
	(FLAGS NDESCBIT)
	(SYNONYM CARNEL FELDSP GEMS TILES)
	(ADJECTIVE RED YELLOW BLUE GREEN BRIGHT)
	(TEXT
"They are quite remarkable, forming a delicate piece of art. To remove
any of them would be beyond thinking. Even for you.")> 

<ROUTINE SCORE-RMS (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,HERE ,TOUCHBIT>>>
		<SETG SCORE <+ ,SCORE 25>>)>
	 <RFALSE>>
		
<ROOM LANDING-ZERO
      (IN ROOMS)
      (DESC "Circular Room")
      (LDESC 
"You are in a strange, round room which sits in the center of four hallways.
These hallways lead off to the northeast, southeast, southwest and northwest
like the spokes of a wheel. Above your head is a long tunnel which stretches up
and out of sight.")
      (FLAGS RLANDBIT)
      (NW TO A-PRIME)
      (NE TO B-PRIME)
      (SW TO D-PRIME)
      (SE TO E-PRIME)
      (UP TO CHAMBER-OF-RA IF ROPE-TIED ELSE
"There's no way to get back up there.")
      (ACTION CIRCULAR-ROOM-FCN)>

<ROUTINE LOOK-DOWN-HALLS ()
	 <TELL "As you peer down the dimly-lit hallways, you ">
	 <COND (<NOT <STATUE-OPPOSITE?>>
		<TELL "see that the doors in all four hallways are
balanced halfway open." CR>)
	       (ELSE
		<TELL "notice that the door to the ">
		<TELL ,HALL-DIR>
		<TELL 
" is closed, while the one in the opposite hallway is all the way open. The
other two are halfway open." CR>)>
	 <FSET ,ROPE ,NDESCBIT>>

<GLOBAL CIRCLE-SCORED <>>

<ROUTINE CIRCULAR-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,ROPE ,HERE>
		<FCLEAR ,ROPE ,NDESCBIT>
		<REMOVE ,ISIS-DOOR>
		<REMOVE ,NEPHTH-DOOR>
		<REMOVE ,NEITH-DOOR>
		<REMOVE ,SELKIS-DOOR>
		<COND (<NOT ,CIRCLE-SCORED>
		       <SETG SCORE <+ ,SCORE 30>>
		       <SETG CIRCLE-SCORED T>)>
		<COND (<AND <NOT ,VERBOSE>
			    <FSET? ,HERE ,TOUCHBIT>>
		       <LOOK-DOWN-HALLS>
		       <CRLF>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<FCLEAR ,ROPE ,NDESCBIT>
		<TELL <GETP ,LANDING-ZERO ,P?LDESC> CR>
		<DESCRIBE-ROPE-FCN ,M-OBJDESC>
		<LOOK-DOWN-HALLS>)>>

<OBJECT HUGE-STATUE
	(IN LANDING-ZERO)
	(DESC "large statue")
	(FDESC
"Sitting in the middle of the floor is a large statue, about two feet shorter
than you. It reminds you a little of Miss Ellingsworth.")
	(FLAGS TAKEBIT TRYTAKEBIT)
	(SIZE 281)
	(SYNONYM STATUE)
	(ADJECTIVE HUGE)
	(ACTION HUGE-STATUE-FCN)
	(TEXT
"It is carved out of dark gray basalt and its features resemble a woman at the
height of her beauty, most probably the ancient Queen. The statue itself must
weigh more than you do.")>

<OBJECT HEAD
	(IN HUGE-STATUE)
	(FLAGS INVISIBLE TAKEBIT)
	(DESC "broken head")
	(SYNONYM HEAD)
	(SIZE 20)
	(ADJECTIVE BROKEN)
	(TEXT
"This head was once part of the magnificent statue of the Queen.")
	(ACTION HEAD-FCN)>

<ROUTINE HEAD-FCN ()
	 <COND (<VERB? RAISE>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<VERB? SHAKE>
		<TELL "It's as empty as yours." CR>
		<RTRUE>)
	       (<VERB? CLIMB-ON>
		<TELL "Next you'll be asking for tumbling lessons." CR>
		<RTRUE>)>>

<ROUTINE HUGE-STATUE-FCN ()
	 <COND (<AND <VERB? MOVE TAKE PUSH PUSH-TO>
		     <FSET? ,HEAD ,INVISIBLE>>
		<TELL
"The statue teeters, swaying and rocking back and forth, then falls over,
its top-heavy structure striking the floor with a dull, loud thud. As you
look over the damage, you see the head has separated from the statue." CR>
		<MOVE ,HEAD ,HERE>
		<FCLEAR ,HEAD ,INVISIBLE>
		<FSET ,HUGE-STATUE ,TOUCHBIT>
		<RTRUE>)
	       (<VERB? TAKE RAISE>
		<TELL "It's far too heavy." CR>
		<RTRUE>)
	       (<VERB? PUSH RAISE MOVE>
		<TELL
"The statue rocks over and back on its back. Looks like it's headed nowhere
fast." CR>
		<RTRUE>)
	       (<VERB? MUNG>
		<COND (<FSET? ,HEAD ,INVISIBLE>
		       <PERFORM ,V?PUSH ,HUGE-STATUE>
		       <RTRUE>)
		      (T
		       <TELL
"Haven't you done enough damage to that beautiful relic?" CR>)>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,HEAD ,INVISIBLE>
		       <RFALSE>)
		      (T
		       <TELL
"The statue lies on the floor, its head broken off. In this state, the statue
weighs a little less than you but it's still far too heavy to carry." CR>
		       <RTRUE>)>)>>

<ROOM A-PRIME
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Northwest Hallway")
      (LDESC
"You are standing in the middle of the Northwest Hallway. The walls here are
smooth and undecorated, carved out of granite. The hallway continues to the
northwest and to the southeast.") 
      (SE TO LANDING-ZERO)
      (NW TO ROOM-OF-NEPHTHYS IF NEPHTH-DOOR IS OPEN ELSE
"There's no way to get through the stone door.")
      (ACTION CLOSE-DEM-DOOAHS)>

<OBJECT NEPHTH-DOOR
	(IN A-PRIME)
	(FLAGS DOORBIT NDESCBIT)
	(DESC "stone door")
	(SYNONYM DOOR)
	(ADJECTIVE STONE)
	(ACTION STONE-DOOR-FCN)>

<ROUTINE STONE-DOOR-FCN ()
	 <COND (<VERB? OPEN RAISE>
		<TELL "You can't. It's got to weigh 50 tons." CR>
		<RTRUE>)>>

<ROOM B-PRIME
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Northeast Hallway")
      (LDESC
"You are standing midway down the long Northeast Hallway. The high walls
are undecorated, but bear the marks of the stonecarver's tool. The hallway
continues to the northeast and the southwest.")
      (SW TO LANDING-ZERO)
      (NE TO ROOM-OF-SELKIS IF SELKIS-DOOR IS OPEN ELSE
"There's no way to get through the stone door.")
      (ACTION CLOSE-DEM-DOOAHS)>

<OBJECT SELKIS-DOOR
	(FLAGS DOORBIT NDESCBIT)
	(DESC "stone door")
	(SYNONYM DOOR)
	(ADJECTIVE STONE)
	(ACTION STONE-DOOR-FCN)>

<ROOM D-PRIME
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Southwest Hallway")
      (LDESC
"You are midway down the Southwest Hallway. The walls of this narrow passage
are unadorned and smooth. The hallway continues to the southwest and the
northeast.")
      (NE TO LANDING-ZERO)
      (SW TO ROOM-OF-ISIS IF ISIS-DOOR IS OPEN ELSE
"There's no way to get through the stone door.")
      (ACTION CLOSE-DEM-DOOAHS)>

<OBJECT ISIS-DOOR
	(FLAGS DOORBIT NDESCBIT)
	(DESC "stone door")
	(SYNONYM DOOR)
	(ADJECTIVE STONE)
	(ACTION STONE-DOOR-FCN)>

<ROOM E-PRIME
      (IN ROOMS)
      (FLAGS RLANDBIT)
      (DESC "Southeast Hallway")
      (LDESC
"You are midway down the Southeast Hallway. This corridor is undecorated and
the walls are polished to a smooth lustre. The hallway continues to the
southeast and the northwest.")
      (NW TO LANDING-ZERO)
      (SE TO ROOM-OF-NEITH IF NEITH-DOOR IS OPEN ELSE
"There's no way to get through the stone door.")
      (ACTION CLOSE-DEM-DOOAHS)>

<OBJECT NEITH-DOOR
	(FLAGS DOORBIT NDESCBIT)
	(DESC "stone door")
	(SYNONYM DOOR)
	(ADJECTIVE STONE)
	(ACTION STONE-DOOR-FCN)>

<GLOBAL HALL-DIR <>>

<GLOBAL STATUE-CHK-TBL ;"starts @ 0, inc by 3"
	<TABLE A-PRIME E-PRIME "southeast"
	       E-PRIME A-PRIME "northwest"
	       B-PRIME D-PRIME "southwest"
	       D-PRIME B-PRIME "northeast">>

<ROUTINE STATUE-OPPOSITE? ("AUX" (OFFS -3) H-CHK T-CHK (FLG <>))
	 <REPEAT ()
		 <SET OFFS <+ .OFFS 3>>
		 <COND (<G? .OFFS 9>
			<RETURN>)
		       (T
			<SET H-CHK <GET ,STATUE-CHK-TBL .OFFS>>
			<SET T-CHK <GET ,STATUE-CHK-TBL <+ .OFFS 1>>>
			<COND (<AND <EQUAL? ,HERE .H-CHK ,LANDING-ZERO>
				    <G? <WEIGHT .T-CHK> 300>>
			       <SET FLG T>
			       <SETG HALL-DIR <GET ,STATUE-CHK-TBL
						   <+ .OFFS 2>>>)>)>>
	 <RETURN .FLG>>

<GLOBAL KLUDGE-FLG <>>

<ROUTINE CLOSE-DEM-DOOAHS (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SET KLUDGE-FLG <>>
		<COND (<STATUE-OPPOSITE?>
		       <COND (<EQUAL? ,HERE ,A-PRIME>
			      <FSET ,NEPHTH-DOOR ,OPENBIT>)
			     (<EQUAL? ,HERE ,B-PRIME>
			      <FSET ,SELKIS-DOOR ,OPENBIT>)
			     (<EQUAL? ,HERE ,D-PRIME>
			      <FSET ,ISIS-DOOR ,OPENBIT>)
			     (ELSE
			      <FSET ,NEITH-DOOR ,OPENBIT>)>)
		      (<G? <WEIGHT ,HERE> 300>
		       <RFALSE>)
		      (T <TELL 
"As you enter the corridor, a huge stone door begins to slide down from the
ceiling closing off any further progress. The closer you come to the door, the
further down the door descends until, eventually, it is close to the floor.
When you turn around, you can barely see beyond the Circular Room where an
identical door has risen off the floor an equal amount." CR>
		       <CRLF>
		       <COND (<EQUAL? ,HERE ,A-PRIME ,E-PRIME>
			      <MOVE ,NEPHTH-DOOR ,A-PRIME>
			      <FCLEAR ,NEPHTH-DOOR ,OPENBIT>
			      <MOVE ,NEITH-DOOR ,E-PRIME>
			      <FCLEAR ,NEITH-DOOR ,OPENBIT>)
			     (<EQUAL? ,HERE ,B-PRIME ,D-PRIME>
			      <MOVE ,SELKIS-DOOR ,B-PRIME>
			      <MOVE ,ISIS-DOOR ,D-PRIME>
			      <FCLEAR ,SELKIS-DOOR ,OPENBIT>
			      <FCLEAR ,ISIS-DOOR ,OPENBIT>)>
		       <SET KLUDGE-FLG T>)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <STATUE-OPPOSITE?>
		     <NOT ,KLUDGE-FLG>>
		<TELL
"The path before you remains open, the stone door having risen to the ceiling,
counterbalanced by the door in the opposite corridor." CR>
		<SET KLUDGE-FLG T>
		<RTRUE>)>>