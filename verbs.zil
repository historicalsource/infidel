"VERBS for
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

"SUBTITLE DESCRIBE THE UNIVERSE"

"SUBTITLE SETTINGS FOR VARIOUS LEVELS OF DESCRIPTION"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Super-brief descriptions." CR>>

\

"SUBTITLE DESCRIBERS"

;<ROUTINE V-RNAME ()
	 <TELL D ,HERE CR>>

;<ROUTINE V-OBJECTS ()
	 <DESCRIBE-OBJECTS T>>

;<ROUTINE V-ROOM ()
	 <DESCRIBE-ROOM T>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF> <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (ELSE
		<TELL "I see nothing special about the "
		      D ,PRSO "." CR>)>>

<GLOBAL LIT <>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL
"It is pitch black. Off in the distance you hear hideous squealing and what can
only be the sound of thousands of tiny, clawed feet coming closer." CR>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS> <TELL D ,HERE CR>)>
	 <COND (<OR .LOOK? <NOT ,SUPER-BRIEF>>
		<SET AV <LOC ,WINNER>>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are ">
		       <COND (<EQUAL? .AV ,ALTAR>
			      <TELL "on">)
			     (T <TELL "in">)>
		       <TELL " the " D .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <==? ,HERE .AV>> <FSET .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (ELSE
		<TELL "I can't see anything in the dark." CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "There is a">
		<VOWEL? .OBJ>
		<TELL D .OBJ>
		<COND (<AND <FLAMING? .OBJ>
			    <NOT <EQUAL? .OBJ ,MANY-MATCHES>>>
		       <TELL " (lit and burning)">)
		      (<AND <EQUAL? .OBJ ,ROPE>
			    ,ROPE-TIED
			    <EQUAL? ,HERE ,CHAMBER-OF-RA>>
		       <TELL " (tied to the altar)">)>
		<TELL " here.">)
	       (ELSE
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL "A">
		<VOWEL? .OBJ>
		<TELL D .OBJ>
		<COND (<FSET? .OBJ ,WEARBIT> <TELL " (being worn)">)>
		<COND (<AND <FLAMING? .OBJ>
			    <NOT <EQUAL? .OBJ ,MANY-MATCHES>>>
		       <TELL " (lit and burning)">)>
		<COND (<AND <EQUAL? .OBJ ,ROPE> ,ROPE-TIED>
		       <TELL " (tied to the " D ,ROPE-TIED ")">)>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0) "AUX" Y 1ST? AV STR
		     (PV? <>) (INV? <>) (FLG <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND (<NOT .Y> <RETURN <NOT .1ST?>>)
			      (<==? .Y .AV> <SET PV? T>)
			      (<==? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>
				      <SET FLG T>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <SET FLG T>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>
	 .FLG>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<==? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ
			     " is:" CR>)
		      (ELSE
		       <TELL "The " D .OBJ " contains:" CR>)>)>>

"SUBTITLE SCORING"

<GLOBAL MOVES 0>
<GLOBAL SCORE 0>
<GLOBAL BASE-SCORE 0>

<GLOBAL WON-FLAG <>>

<GLOBAL SCORE-MAX 400>

<ROUTINE SCORE-UPD (NUM)
	 #DECL ((NUM) FIX)
	 <SETG BASE-SCORE <+ ,BASE-SCORE .NUM>>
	 <SETG SCORE <+ ,SCORE .NUM>>
	 T>

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
	 #DECL ((OBJ) OBJECT (TEMP) FIX)
	 <COND (<GETP .OBJ ,P?VALUE>
		<COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
		       <SCORE-UPD .TEMP>
		       <PUTP .OBJ ,P?VALUE 0>)>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Your score is " N ,SCORE>
	 <TELL " out of a possible " N ,SCORE-MAX ", in ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " move.">) (ELSE <TELL " moves.">)>
	 <CRLF>
	 <TELL
"This score gives you the rank of a ">
	 <COND (<G? ,SCORE 390>
		<TELL "master adventurer">)
	       (<G? ,SCORE 320>
		<TELL "very good adventurer">)
	       (<G? ,SCORE 200>
		<TELL "fairly good looter">)
	       (<G? ,SCORE 100>
		<TELL "poor professor">)
	       (ELSE
		<TELL "fumbling beginner">)>
	 <TELL "." CR>
	 ,SCORE>

<ROUTINE FINISH ()
	 <V-SCORE>
	 <QUIT>>

<ROUTINE V-QUIT ("OPTIONAL" (ASK? T) "AUX" SCOR)
	 #DECL ((ASK?) <OR ATOM <PRIMTYPE LIST>> (SCOR) FIX)
	 <V-SCORE>
	 <COND (<OR <AND .ASK?
			 <TELL
"Do you wish to leave the game? (Y is affirmative): ">
			 <YES?>>
		    <NOT .ASK?>>
		<QUIT>)
	       (ELSE <TELL "Ok." CR>)>>

<ROUTINE PRE-FINISH ()
	 <V-SCORE>
	 <TELL
"Do you wish to start the game again? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Okay. Restarting..." CR>
		<RESTART>
		<TELL "Failed. Please reboot your system." CR>
		<QUIT>)
	       (ELSE <TELL "Ok. See you next time!" CR>
		<QUIT>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	 <TELL
"INFIDEL|
Copyright 1983 by Infocom, Inc.  All rights reserved.|
INFIDEL is a trademark of Infocom, Inc.|
Release ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

<ROUTINE IN-HERE? (OBJ)
	 <OR <IN? .OBJ ,HERE>
	     <GLOBAL-IN? .OBJ ,HERE>>>

<ROUTINE V-AGAIN ("AUX" OBJ)
	 <COND (<==? ,L-PRSA ,V?WALK>
		<PERFORM ,L-PRSA ,L-PRSO>)
	       (T
		<SET OBJ
		     <COND (<AND ,L-PRSO <NOT <LOC ,L-PRSO>>>
			    ,L-PRSO)
			   (<AND ,L-PRSI <NOT <LOC ,L-PRSO>>>
			    ,L-PRSI)>>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
		       <TELL "I can't see the " D .OBJ " anymore." CR>
		       <RFATAL>)
		      (T
		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>

"SUBTITLE DEATH AND TRANSFIGURATION"

<GLOBAL DEAD <>>
<GLOBAL DEATHS 0>
<GLOBAL LUCKY 1>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 #DECL ((DESC) ZSTRING (PLAYER?) <OR ATOM FALSE>)
 	 <TELL .DESC CR>
	 <TELL "
|    ****  You have died  ****
|
|">
	 <COND (<NOT ,PYRAMID-OPENED>
		<TELL
"You feel yourself disembodied in a deep blackness. A voice from the void, or
perhaps it's just your dying thoughts, rings in your ears.|
|
\"Obsessions are the torment of men's souls, reaching out for something greater
than life has offered. Perhaps this is what makes the difference between an
ordinary mortal and an adventurer!\" It is the last thing you hear." CR>)
	       (T
		<TELL
"The great mysteries of the ancient pyramid remain unsolved. Although your
desperation has served you well in getting this far, to get farther requires a
wisdom, tempered by experience." CR>)>
	 <CRLF>
	 <PRE-FINISH>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Use directions for movement here." CR>>

<ROUTINE V-LAUNCH ()
	  <TELL "How in blazes does one launch that?" CR>>

<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 #DECL ((TBL) TABLE (VAL) ANY)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<GOTO .VAL>)>>

<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 #DECL ((ITM) ANY (TBL) TABLE (CNT LEN) FIX)
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<==? <GET .TBL .CNT> .ITM>
			<COND (<==? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 #DECL ((PT) <OR FALSE TABLE> (PTS) FIX (STR) <OR ZSTRING FALSE>
		(OBJ) OBJECT (RM) <OR FALSE OBJECT>)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<==? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<==? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<==? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<==? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "You can't go that way." CR>
			      <RFATAL>)>)
		      (<==? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <NOT ,LIT> <PROB 90>>
		<JIGS-UP
"Oh, no! You have been devoured by 6,502 rats!">)
	       (T
		<TELL "You can't go that way." CR>
		<RFATAL>)>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 <SETG P-IT-LOC ,HERE>>

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "You are empty-handed." CR>)>>

<GLOBAL INDENTS
	<TABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

\

<ROUTINE PRE-TAKE ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)>
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <COND (<EQUAL? ,PRSO ,KNAPSACK>
			      <RFALSE>)
			     (T <TELL "You are already wearing it." CR>)>)
		      (<EQUAL? ,PRSO ,ONE-MATCH>
		       <TELL "You already have one. One at a time, now!" CR>)
		      (T <TELL "You already have it." CR>)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "You can't reach that." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<NOT <==? ,PRSI <LOC ,PRSO>>>
		       <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
				   <FSET? ,PRSI ,CONTBIT>
				   <NOT <FSET? ,PRSI ,OPENBIT>>>
			      <TELL "You'd better open the " D ,PRSI 
				    " first." CR>
			      <THIS-IS-IT ,PRSI>
			      <RTRUE>)
			     (<EQUAL? ,PRSO ,LOCK>
			      <RFALSE>)
			     (<AND <EQUAL? ,PRSO ,SHOVEL>
				   <EQUAL? ,PRSI ,SAND>>
			      <SETG PRSI <>>
			      <RFALSE>)
			     (ELSE
			      <TELL "The " D ,PRSO
				    " isn't in the " D ,PRSI "." CR>)>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<==? ,PRSO <LOC ,WINNER>> <TELL "You are in it, loser!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<==? <ITAKE> T>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are now wearing the " D ,PRSO "." CR>)
		      (T <TELL "Taken." CR>)>)>>

<GLOBAL FUMBLE-NUMBER 7>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ TEMP)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load is too heavy." CR>
		       <CRLF>)>
		<RFALSE>)
	       (<G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		<TELL "You're carrying too many individual items already!" CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FSET ,PRSO ,TOUCHBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<SCORE-OBJ ,PRSO>
	        <RTRUE>)>>

<ROUTINE V-PUT-ACROSS ()
	  <TELL "You can't do that." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>
		<RTRUE>)
	       (T <TELL "There's no good surface on the " D ,PRSI "." CR>)>>

<ROUTINE PRE-PUT ("AUX" OBJ)
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<PRSO? ,PLASTER ,PLASTER1 ,LINTEL>
		<TELL "That's weird." CR>
		<RTRUE>)
	       (<EQUAL? ,PRSI ,GROUND ,SAND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,ONE-MATCH>
		<RFALSE>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)
	       (<AND <PRSI? ,LEFT-DISC ,RIGHT-DISC ,MID-DISC>
		     <FIRST? ,PRSI>>
		<SET OBJ <FIRST? ,PRSI>>
		<COND (<EQUAL? .OBJ ,PRSO>
		       <TELL "Better have your eyes checked." CR>)
		      (T <TELL "There's no room. The " D .OBJ 
		      " is already on the " D ,PRSI "." CR>)>
		<RTRUE>)
	       (<STAIRWAY-CHECK?>
		<RTRUE>)
	       (<PRSI? ,TORCH>
		<PERFORM ,V?DROP ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE STAIRWAY-CHECK? ()
	 <COND (<AND <PRSO? ,ROPE>
		     ,ROPE-TIED>
		<RFALSE>)
	       (<AND <OR <EQUAL? ,PRSI ,NORTH-STAIRS ,SOUTH-STAIRS>
			 <EQUAL? ,PRSI ,WEST-STAIRS ,EAST-STAIRS>>
		     <EQUAL? <LOC ,WINNER> ,CHAMBER-OF-RA ,TINY-LANDING>>
		<TELL "You hear the " D ,PRSO " crash below." CR>
		<COND (<NOT <IN? ,PRSO ,WINNER>>
		       <TELL "You're not holding the " D ,PRSO "." CR>
		       <RTRUE>)
		      (<PRSI? ,NORTH-STAIRS>
		       <MOVE ,PRSO ,LANDING-ZERO>
		       <RTRUE>)
		      (<PRSI? ,EAST-STAIRS>
		       <MOVE ,PRSO ,LANDING-ONE>
		       <RTRUE>)
		      (<PRSI? ,WEST-STAIRS>
		       <MOVE ,PRSO ,LANDING-THREE>
		       <RTRUE>)
		      (<PRSI? ,SOUTH-STAIRS>
		       <MOVE ,PRSO ,LANDING-TWO>
		       <RTRUE>)
		      (ELSE <RFALSE>)>)>>

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "You can't do that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "The " D ,PRSI " isn't open." CR>)
	       (<==? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "The " D ,PRSO " is already in the " D ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<AND <NOT <EQUAL? ,PRSI ,PUNCH-PANEL>>
			    <FSET? ,PRSO ,NDESCBIT>>
		       <FCLEAR ,PRSO ,NDESCBIT>)>
		<TELL "Done." CR>)>
	 <COND (<AND <EQUAL? ,PRSO ,BEAM>
		     ,BEAM-PLACED
		     <NOT <EQUAL? ,PRSI ,NICHES>>>
		<SETG BEAM-PLACED <>>
		<SETG ON-BEAM <>>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSO ,DEAD-BOOK ,SCARAB>
		     <NOT <PRSI? ,S-AREA ,L-AREA>>>
		<SETG CAN-TURN-STATUES <>>)>>

<ROUTINE PRE-DROP ()
	 <COND (<==? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <HELD? ,PRSO>>
		<TELL 
"That's easy for you to say since you don't even have it." CR>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE HELD? (OBJ)
	 <COND (<NOT .OBJ> <RFALSE>)
	       (<IN? .OBJ ,WINNER> <RTRUE>)
	       (T <HELD? <LOC .OBJ>>)>>

<ROUTINE V-GIVE ()
	 <TELL "You can't give the " D ,PRSO " to a">
	 <VOWEL? ,PRSI>
	 <TELL D ,PRSI "!" CR>>

<ROUTINE V-SGIVE ()
	 <TELL "FOOOO!!" CR>>

<ROUTINE V-DROP ("OPTIONAL" (SUPPRESS <>))
	 <COND (<IDROP>
		<COND (<NOT SUPPRESS>
		       <TELL "Dropped." CR>)>)>>

;<ROUTINE PRE-THROW ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <IN? ,PRSO ,WINNER>>
		<TELL "You're not carrying the " D ,PRSO "." CR>
		<RTRUE>)>>

<ROUTINE V-THROW ()
	 <COND (<AND ,PRSI
		     <OR <FSET? ,PRSI ,CONTBIT>
			 <FSET? ,PRSI ,CLIMBBIT>>>
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)
	       (ELSE
		<IDROP>
		<TELL "Thrown." CR>
		<RTRUE>)>>

<ROUTINE IDROP ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>> <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "You're not carrying the " D ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "The " D ,PRSO " is closed." CR>
		<RFALSE>)
	       (T <MOVE ,PRSO <LOC ,WINNER>> <RTRUE>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL "You must tell me how to do that to the " D ,PRSO "." CR>
		)
	       (<NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>
		<COND (<FSET? ,PRSO ,OPENBIT> <TELL "It is already open." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <COND (<NOT <FIRST? ,PRSO>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "The " D ,PRSO " opens." CR>
			      <TELL .STR CR>)
			     (T
			      <COND (<NOT <PRSO? ,MAP>>
				     <TELL "Opening">)
				    (T
				     <TELL "Unfolding">)>
			      <TELL " the " D ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <TELL "The " D ,PRSO " opens." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T <TELL "The " D ,PRSO " fails to open." CR>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T))
	 #DECL ((OBJ) OBJECT (F N) <OR FALSE OBJECT>)
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <TELL ", ">
			       <COND (<NOT .N> <TELL "and ">)>)>
			<TELL "a">
			<VOWEL? .F>
			<TELL D .F>
			<SET F .N>
			<COND (<NOT .F> <RETURN>)>>)>>

<ROUTINE V-CLOSE ()
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL "You must tell me how to do that to the " D ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <==? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>)
		      (T <TELL "It is already closed." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The " D ,PRSO " is now closed." CR>
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (T <TELL "It is already closed." CR>)>)
	       (ELSE
		<TELL "You cannot close that." CR>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WEARBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

"WEIGHT:  Get sum of SIZEs of supplied object, recursing to the nth level."

<ROUTINE WEIGHT
	 (OBJ "AUX" CONT (WT 0))
	 #DECL ((OBJ) OBJECT (CONT) <OR FALSE OBJECT> (WT) FIX)
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <==? .OBJ ,WINNER> <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

<ROUTINE V-BUG ()
	 <TELL
"If there is a problem here, it is unintentional. You may report
your problem to the address provided in your documentation." CR>>

<GLOBAL COPR-NOTICE
" a transcript of interaction with INFIDEL.|
INFIDEL is a trademark of Infocom, Inc.|
Copyright (c) 1983 Infocom, Inc.  All rights reserved.|">

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" ,COPR-NOTICE CR>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends" ,COPR-NOTICE CR>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO> <TELL "I don't juggle objects!" CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<AND <EQUAL? ,PRSO ,BEAM>
		     <NOT <FSET? ,BEAM ,TOUCHBIT>>>
		<TELL
"Sure. But it might be better to be a little more specific in how you want it
moved." CR>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving the " D ,PRSO " reveals nothing." CR>)
	       (T <TELL "You can't move the " D ,PRSO "." CR>)>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,BURNBIT>
		<COND (<FLAMING? ,PRSO>
		       <COND (<EQUAL? ,PRSO ,ONE-MATCH>
			      <TELL "One">)
			     (T <TELL "It">)>
		       <TELL " is already lit." CR>)
		      (<AND <EQUAL? ,PRSO ,TORCH>
			    <NOT ,PRSI>
			    <NOT <IN? ,ONE-MATCH ,WINNER>>>
		       <TELL 
"You expect to light the torch with your glowing intellect?" CR>
		       <RTRUE>)
		      (<AND <OR <EQUAL? ,PRSI ,MATCHES
					,ONE-MATCH ,SINGLE-MATCH>
				<IN? ,ONE-MATCH ,WINNER>>
			    <EQUAL? ,PRSO ,TORCH>>
		       <ENABLE <QUEUE I-TORCH -1>>
		       <LIGHT-THE ,TORCH <>>
		       <FSET ,TORCH ,TOUCHBIT>)
		      (<AND <OR <EQUAL? ,PRSO ,MANY-MATCHES ,SINGLE-MATCH 
					,EMPTY-MATCHES>
				<EQUAL? ,PRSO ,ONE-MATCH>>
			    <AND <NOT <IN? ,ONE-MATCH ,WINNER>>
				 <NOT <IN? ,MATCHES ,WINNER>>>>
		       <TELL "I see no match here." CR>
		       <RTRUE>)
		      (<OR <EQUAL? ,PRSO ,MANY-MATCHES ,SINGLE-MATCH 
					,EMPTY-MATCHES>
				<EQUAL? ,PRSO ,ONE-MATCH>>
		       <COND (<L? ,MATCH-COUNT 1>
			      <TELL 
"That's a little tough to do with an empty book of matches." CR>
			      <RTRUE>)
			     (T
			      <COND (<NOT <IN? ,ONE-MATCH ,WINNER>>
				     <MATCH-MOVER>)>
			      <TELL "You have now lit a match." CR>
			      <LIGHT-THE ,ONE-MATCH T>
			      <ENABLE <QUEUE I-MATCH-OUT 3>>)>)
		      (ELSE
		       <TELL "I don't know how to light the " D ,PRSO"." CR>)>)
	       (T
		<TELL "You can't light that." CR>)>
	 <RTRUE>>

<ROUTINE FLAMING? (OBJ)
	 <COND (<FSET? .OBJ ,FLAMEBIT>
		<RTRUE>)>>

<ROUTINE LIGHT-THE (OBJECT SUPPRESS?)
	 <FSET .OBJECT ,ONBIT>
	 <FSET .OBJECT ,FLAMEBIT>
	 <COND (<EQUAL? .OBJECT ,ONE-MATCH>
		<COND (<FSET? ,MATCHES ,OPENBIT>
		       <COND (<PROB 10>
			      <TELL
"Ooops! You didn't remember to close the cover before striking! The matchbook
bursts into flames, burning your fingertips." CR>
			      <MOVE ,BURNED-MATCHBOOK <LOC ,MATCHES>>
			      <FSET ,BURNED-MATCHBOOK ,OPENBIT>
			      <REMOVE ,MATCHES>
			      <REMOVE ,MANUAL>
			      <REMOVE ,ONE-MATCH>
			      <SETG MATCH-COUNT 0>
			      <SET SUPPRESS? T>)>)>)>
	 <COND (<NOT .SUPPRESS?>
		<TELL "The " D .OBJECT " is now lit." CR>)>
	 <COND (<NOT ,LIT>
		<SETG LIT <LIT? ,HERE>>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,BURNBIT>
		<COND (<NOT <FLAMING? ,PRSO>>
		       <TELL "It is already out." CR>)
		      (<EQUAL? ,PRSO ,MATCHES ,ONE-MATCH>
		       <DISABLE <INT I-MATCH-OUT>>
		       <I-MATCH-OUT T>
		       <RTRUE>)
		      (ELSE
		       <TELL "The " D ,PRSO " is now out." CR>
		       <KILL-TORCH>)>)
	       (ELSE <TELL "You can't extinguish that." CR>)>
	 <RTRUE>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 #DECL ((NUM) FIX)
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<CLOCKER> <RETURN>)>
		 <SETG MOVES <+ ,MOVES 1>>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND (<EQUAL? ,PRSO ,TENT-OBJ>
		<RFALSE>)
	       (<EQUAL? ,PRSO ,BOAT>
		<RFALSE>)
	       (<EQUAL? ,PRSO ,BEAM>
		<PERFORM ,V?CLIMB-ON ,BEAM>
		<RTRUE>)
	       (<FSET? ,PRSO ,VEHBIT>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL "You are already on the " D .AV ", cretin!" CR>)
		      (T <RFALSE>)>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (T
		<TELL "I suppose you have a theory on getting into the "
		      D ,PRSO "." CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("OPTIONAL" OBJ "AUX" AV)
	 #DECL ((AV) OBJECT)
	 <TELL "You are now ">
	 <COND (<EQUAL? ,PRSO ,ALTAR>
		<TELL "on">)
	       (T <TELL "in">)>
	 <TELL " the " D ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <COND (<NOT <EQUAL? ,PRSO ,ALTAR ,CRATE ,SLAB>>
		<APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>)>
	 <RTRUE>>

<GLOBAL STOOD-UP <>>

<ROUTINE V-DISEMBARK ()
	 <COND (<NOT <==? <LOC ,WINNER> ,PRSO>>
		<TELL "You're not in that!" CR>
		<RFATAL>)
	       (<FSET? ,HERE ,RLANDBIT>
		<COND (<NOT ,STOOD-UP>
		       <TELL 
"You push yourself up and manage to get out of the cot. Your legs are a little
wobbly, though, and your head swims." CR>
		       <SETG STOOD-UP T>)
		      (T
		       <TELL "You are on your feet again." CR>)>
		<MOVE ,WINNER ,HERE>)
	       (T
		<TELL
"You realize, just in time, that getting out here would probably be fatal." CR>
		<RFATAL>)>>

<ROUTINE V-BLAST ()
	 <TELL "You can't blast anything by using words." CR>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <LOC ,WINNER>)
	             (AV <>) OLIT)
	 #DECL ((RM WLOC) OBJECT (LB) <OR ATOM FALSE> (AV) <OR FALSE FIX>)
	 <SET OLIT ,LIT>
	 <COND (<FSET? .WLOC ,VEHBIT>
		<TELL "You'd better get ">
		<COND (<EQUAL? .WLOC ,ALTAR>
		       <TELL "off">)
		      (T <TELL "out">)>
		<TELL " of the " D .WLOC " first." CR>
		<RTRUE>
		;<SET AV <GETP .WLOC ,P?VTYPE>>)>
	 <COND (<OR <AND <NOT .LB> <OR <NOT .AV> <NOT <FSET? .RM .AV>>>>
		    <AND <FSET? ,HERE ,RLANDBIT>
			 .LB
			 .AV
			 <NOT <==? .AV ,RLANDBIT>>
			 <NOT <FSET? .RM .AV>>>>
		<COND (.AV <TELL "You can't go there in a">
		       <VOWEL? .WLOC>
		       <TELL D .WLOC ".">)
		      (T <TELL "You can't go there without a vehicle.">)>
		<CRLF>
		<RFALSE>)
	       (<FSET? .RM ,RMUNGBIT> <TELL <GETP .RM ,P?LDESC> CR> <RFALSE>)
	       (T
		<COND (.AV <MOVE .WLOC .RM>)
		      (T
		       <MOVE ,WINNER .RM>)>
		<SETG HERE .RM>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT>
			    <NOT ,LIT>
			    <PROB 85>>
		       <JIGS-UP
"Oh, no! An army of eleventy-seven rats, starved for affection (and food),
leapt upon your body in a show of rodentine appreciation and devoured you!">)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<COND (<NOT <==? ,HERE .RM>> <RTRUE>)
		      (<NOT <==? ,ADVENTURER ,WINNER>>
		       <TELL "The " D ,WINNER " leaves the room." CR>)
		      (.V? <V-FIRST-LOOK>)>
		<RTRUE>)>>

<ROUTINE V-BACK
	 ()
	 <TELL
"Sorry, my memory isn't that good. You'll have to give a direction." CR>>

<ROUTINE V-POUR ()
	 <COND (<NOT <OR <EQUAL? ,PRSO ,OIL-JAR ,LIQUID ,WATER>
			 <EQUAL? ,PRSO ,C-SAND>>>
		<TELL "You can't pour that." CR>
		<RTRUE>)
	       (T
		<TELL "Poured." CR>
		<COND (<EQUAL? ,PRSO ,OIL-JAR ,LIQUID>
		       <SETG OIL-LEFT 0>
		       <REMOVE ,LIQUID>)
		      (<EQUAL? ,PRSO ,C-SAND>
		       <SETG SAND-FILLED <>>
		       <REMOVE ,C-SAND>)
		      (T
		       <REMOVE ,WATER>
		       <SETG WATER-LEFT 0>)>)>>

<ROUTINE V-POUR-IN ("AUX" L)
	 <COND (<NOT <OR <EQUAL? ,PRSO ,OIL-JAR ,LIQUID ,WATER>
			 <EQUAL? ,PRSO ,C-SAND>>>
		<TELL "You can't pour that into anything." CR><RTRUE>)
	       (<NOT <FSET? ,PRSI ,CONTBIT>>
		<TELL "You'd have a lot of trouble pouring the " D ,PRSO
		      " into the " D ,PRSI "." CR>
		<RTRUE>)
	       (<EQUAL? ,PRSI ,GOLD-CUP ,SILVER-CUP>
		<COND (<OR <AND <EQUAL? ,PRSO ,WATER>
				<EQUAL? <LOC ,LIQUID> ,PRSI>>
			   <AND <EQUAL? ,PRSO ,LIQUID>
				<EQUAL? <LOC ,WATER> ,PRSI>>>
		       <TELL "Oil and water never mixed together well." CR>
		       <RTRUE>)>
		<SET L <LOC ,PRSO>>
		<TELL "Okay. The " D ,PRSI " has been filled, but the "
		      D .L " is now empty." CR>
		<MOVE ,PRSO ,PRSI>
		<COND (<EQUAL? ,PRSO ,WATER>
		       <SETG WATER-LEFT 0>)
		      (<EQUAL? ,PRSO ,C-SAND>
		       <SETG SAND-FILLED <>>)>)
	       (T
		<TELL "Why bother?" CR>)>>
	        

<ROUTINE PRE-POUR-ON ("AUX" LIQ)
	 <COND (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<EQUAL? ,PRSO ,WATER ,C-SAND>
		<SET LIQ ,PRSO>
		<COND (<NOT <FSET? <LOC .LIQ> ,OPENBIT>>
		       <TELL "You'd better open the " D <LOC .LIQ> " first."
			     CR>
		       <RTRUE>)
		      (<FLAMING? ,PRSI>
		       <TELL "Poured." CR>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <COND (<NOT <SETG LIT <LIT? ,HERE>>>
			      <TELL " It is now pitch black.">)>
		       <COND (<EQUAL? .LIQ ,WATER>
			      <SETG WATER-LEFT <- ,WATER-LEFT 10>>
			      <COND (<L? ,WATER-LEFT 10>
				     <REMOVE ,WATER>)>)
			     (T
			      <SETG SAND-FILLED <>>
			      <REMOVE ,C-SAND>)>
		       <FCLEAR ,PRSI ,FLAMEBIT>
		       <FCLEAR ,PRSI ,ONBIT>
		       <RTRUE>)
		      (T
		       <TELL "Poured." CR>
		       <COND (<EQUAL? .LIQ ,WATER>
			      <SETG WATER-LEFT <- ,WATER-LEFT 10>>
			      <COND (<L? ,WATER-LEFT 10>
				     <REMOVE ,WATER>)>
			      <TELL "The " D ,PRSI
				     " gets wet, but quickly dries." CR>)
			     (T
			      <COND (<GETP ,HERE ,P?MAP>
				     <TELL "The sand is gone with the wind." CR>)
				    (T <TELL 
"The sand falls through the cracks in the stone floor." CR>)>
			      <SETG SAND-FILLED <>>)>
		       <RTRUE>)>)
	       (<NOT <EQUAL? ,PRSO ,OIL-JAR ,LIQUID>>
		<TELL "You can't pour that on anything." CR><RTRUE>)
               (<0? ,OIL-LEFT>
		<TELL "Why bother? The jar is empty." CR>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSI ,TORCH>>
		<TELL
"Why waste precious liquid? But, if you insist, done! The liquid evaporates in
a few moments." CR>
		<SETG OIL-LEFT 0>
		<REMOVE ,LIQUID>
		<RTRUE>)
	       (<NOT <FSET? ,OIL-JAR ,OPENBIT>>
		<TELL 
"A little tough to get that wick through the closed jar, eh?" CR>
		<RTRUE>)
	       (T
		<TELL "The tip of the torch has been covered with the liquid.">
		<COND (<FLAMING? ,TORCH>
		       <TELL 
" The torch flares up, singeing your eyebrows. Phew! Close call, there!">
		       <SETG TORCH-TURNS 0>)>
		<CRLF>
		<SETG OIL-LEFT <- ,OIL-LEFT 20>>
		<SETG OIL-SOAKED T>
		<SETG OILED-TORCH T>)>>

<ROUTINE V-POUR-ON () <TELL "Foo!" CR>>

<ROUTINE V-SPRAY () <V-SQUEEZE>>
<ROUTINE V-SSPRAY () <PERFORM ,V?SPRAY ,PRSI ,PRSO>>

<ROUTINE V-SQUEEZE ()
	  <TELL "How singularly useless." CR>>

<ROUTINE PRE-OIL ()
	 <TELL "You probably put spinach in your gas tank, too." CR>>

<ROUTINE V-OIL () <TELL "That's not very useful." CR>>

<ROUTINE PRE-FILL ("AUX" T)
	 #DECL ((T) <OR FALSE TABLE>)
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<AND <NOT ,PRSI>
		     <SET T <GETPT ,HERE ,P?GLOBAL>>>
		<COND (<ZMEMQB ,GLOBAL-WATER .T <PTSIZE .T>>
		       <SETG PRSI ,GLOBAL-WATER>
		       <RFALSE>)
		      (T
		       <TELL "There is nothing to fill it with.">
		       <COND (<GETP ,HERE ,P?MAP>
			      <TELL " Except for some sand.">)>
		       <CRLF>
		       <RTRUE>)>)>
	 <COND (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>)
		      (T
		       <TELL "There's nothing to fill it with.">
		       <COND (<GETP ,HERE ,P?MAP>
			      <TELL " Except for maybe some sand.">)>
		       <CRLF>)>)
	       (<EQUAL? ,PRSI ,GLOBAL-WATER>
		<COND (<OR <EQUAL? ,WATER-LEFT 40>
			   <IN? ,C-SAND ,PRSO>>
		       <TELL "It's already full." CR>)
		      (<NOT <FSET? ,PRSO ,CONTBIT>>
		       <HOW? ,PRSO>
		       <RTRUE>)
		      (<NOT <FSET? ,PRSO ,OPENBIT>>
		       <TELL "Tough to do when the " D ,PRSO " is closed." CR>)
		      (<NOT <PRSO? ,CANTEEN ,GOLD-CUP ,SILVER-CUP>>
		       <TELL <PICK-ONE ,YUKS> CR>)
		      (<IN? ,LIQUID ,PRSO>
		       <TELL "Oil and water don't mix." CR>)
		      (T
		       <MOVE ,WATER ,PRSO>
		       <COND (<EQUAL? ,HERE ,RIVER-BANK>
			      <SETG WATER-LEFT 40>)
			     (T
			      <SETG WATER-LEFT 0>)>
		       <TELL "Okay, you have filled the " D ,PRSO "." CR>)>)
	       (<EQUAL? ,PRSI ,WATER>
		<COND (<IN? ,LIQUID ,PRSO>
		       <TELL "Oil and water don't mix." CR>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?POUR-IN ,WATER ,PRSO>
		       <THIS-IS-IT ,PRSO>
		       <RTRUE>)>)
	       (<EQUAL? ,PRSI ,LIQUID ,OIL-JAR>
		<COND (<IN? ,WATER ,PRSO>
		       <TELL "Water and oil don't mix." CR>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?POUR-IN ,LIQUID ,PRSO>
		       <RTRUE>)>)
	       (T <TELL "You may know how to do that, but I don't." CR>)>>

<ROUTINE V-ADVENTURE () <TELL "A hollow voice says \"Fool.\"" CR>>

<ROUTINE V-DRINK ()
	 <COND (<PRE-EAT>
		<RTRUE>)
	       (T
		<V-EAT>)>>

<ROUTINE PRE-EAT ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <FSET? ,PRSO ,FOODBIT>>
		<COND (<EQUAL? <ITAKE <>> T>
		       <TELL "(Taken)" CR>
		       <RFALSE>)
		      (T <RTRUE>)>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <EQUAL? ,PRSO ,ME ,WINNER ,ADVENTURER>>
		     <FSET? ,PRSO ,FOODBIT>>
		<TELL "You're not holding the " D ,PRSO "." CR>
		<RTRUE>)>>

<GLOBAL NILE-DRINKS 0>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 #DECL ((NOBJ) <OR OBJECT FALSE> (EAT? DRINK?) <OR ATOM FALSE>)
	 <COND (<AND <SET EAT? <FSET? ,PRSO ,FOODBIT>> <IN? ,PRSO ,WINNER>>
		<COND (<VERB? DRINK> <TELL "How can you drink that?">)
		      (ELSE
		       <TELL 
"That really hit the spot. It did make you a little thirstier, though.">
		       <REMOVE ,PRSO>
		       <SETG THIRST <+ ,THIRST 10>>
		       <DISABLE <INT I-GROWL>>
		       <COND (<NOT <GETP ,HERE ,P?MAP>>
			      <ENABLE <QUEUE I-PYRAMID-DRINK -1>>)>)>
		<CRLF>)
	       (<SET DRINK? <FSET? ,PRSO ,DRINKBIT>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <AND <SET NOBJ <LOC ,PRSO>>
				<IN? .NOBJ ,WINNER>
				<FSET? .NOBJ ,OPENBIT>>>
		       <TELL "You feel much refreshed.">
		       <COND (,SANDY-CANTEEN
			      <TELL 
" Some sand from the bottom of the canteen is gritty in your mouth, though.">)>
		       <CRLF>
		       <SETG WATER-LEFT <- ,WATER-LEFT 10>>
		       <COND (<L? ,WATER-LEFT 10>
			      <REMOVE ,PRSO>)>
		       <SETG THIRST 0>
		       <SETG PYR-THIRST 0>
		       <DISABLE <INT I-PYRAMID-DRINK>>)
		      (<IN? ,PRSO ,LOCAL-GLOBALS>
		       <COND (<G? ,NILE-DRINKS 3>
			      <TELL 
"You're going to start sloshing around soon." CR>
			      <RTRUE>)>
		       <TELL
"You kneel down and drink deeply from the Nile and feel refreshed." CR>
		       <SETG NILE-DRINKS <+ ,NILE-DRINKS 1>>
		       <SETG THIRST 0>
		       <SETG PYR-THIRST 0>
		       <DISABLE <INT I-PYRAMID-DRINK>>)
		      (T <TELL 
"I'd like to oblige, but it's not within easy reach." CR>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL "I don't think that the "
		      D
		      ,PRSO
		      " would agree with you." CR>)>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,VILLAIN>
		       <TELL "Insults of this nature won't help you." CR>)
		      (T
		       <TELL "What a loony!" CR>)>)
	       (T
		<TELL
"Such language in a high-class establishment like this!" CR>)>>

<ROUTINE V-LISTEN ()
	 <TELL "The " D ,PRSO " makes no sound." CR>>

<ROUTINE V-FOLLOW ()
	 <TELL "Give me a break!" CR>>

<ROUTINE V-STAY ()
	 <TELL "You will be lost without me!" CR>>

<GLOBAL PRAYER-HACK 0>

<ROUTINE V-PRAY ()
	 <SETG PRAYER-HACK <+ ,PRAYER-HACK 1>>
	 <COND (<L? ,PRAYER-HACK 3>
		<TELL "If you pray enough, your prayers may be answered." CR>)
	       (T
		<TELL "No one is listening..." CR>)>>

<ROUTINE V-LEAP ("AUX" T S) #DECL ((T) <OR FALSE TABLE>)
	 <COND (<AND ,PRSO
		     <NOT <PRSO? ,INTDIR>>>
		<PERFORM V?BOARD ,PRSO>
		<RTRUE>)
	       (<SET T <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .T>>
		<COND (<OR <==? .S 2>					 ;NEXIT
			   <AND <==? .S 4>				 ;CEXIT
				<NOT <VALUE <GETB .T 1>>>>>
		       <TELL
"This was not a very safe place to try jumping." CR>
		       <JIGS-UP <PICK-ONE ,JUMPLOSS>>)
		      (T <V-SKIP>)>)
	       (ELSE <V-SKIP>)>>

<ROUTINE V-SKIP () <TELL <PICK-ONE ,WHEEEEE> CR>>

<ROUTINE V-LEAVE () <DO-WALK ,P?OUT>>

<GLOBAL HS 0>

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<TELL
		 "I think that only schizophrenics say \"Hello\" to a">
		<VOWEL? ,PRSO>
		<TELL D ,PRSO "." CR>)
	       (ELSE <TELL <PICK-ONE ,HELLOS> CR>)>>

<GLOBAL HELLOS
	<LTABLE "Hello."
	       "Good day."
	       "Nice weather we've been having lately."
	       "Goodbye.">>

<GLOBAL WHEEEEE
	<LTABLE "Very good. Now you can go to the second grade."
	       "Have you tried hopping around, too?"
	       "Are you enjoying yourself?"
	       "Wheeeeeeeeee!!!!!"
	       "Do you expect me to applaud?">>

<GLOBAL JUMPLOSS
	<LTABLE "You should have looked before you leaped."
	       "I'm afraid that leap was a bit much for your weak frame."
	       "In the movies, your life would be passing in front of your eyes."
	       "Geronimo.....">>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT> <TELL "It is impossible to read in the dark." CR>)
	       (,PRSI 
		<TELL "How does one look through a">
		<VOWEL? ,PRSI>
		<TELL D ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<AND <NOT <FSET? ,PRSO ,READBIT>>
		     <NOT <EQUAL? ,PRSO ,WALLS>>>
		<TELL "How can I read a">
		<VOWEL? ,PRSO>
		<TELL D ,PRSO "?" CR>)
	       (<EQUAL? ,PRSO ,WALLS>
		<TELL "There's nothing on the walls worth reading." CR>)
	       (ELSE <TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<GETP ,HERE ,P?MAP>
		<TELL "There is nothing but sand there." CR>)
	       (ELSE
		<TELL "There is nothing but dust there." CR>)>>

<ROUTINE V-LOOK-DOWN () <TELL "You can't see anything down there." CR>>

<ROUTINE V-LOOK-BEHIND () <TELL "There is nothing behind the " D ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE ("OPTIONAL" (REACH? <>))
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The "
			     D
			     ,PRSO
			     " is open.">)
		      (ELSE <TELL "The " D ,PRSO " is closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,VICBIT>
		       <TELL "There is nothing special to be ">
		       <COND (.REACH?
			      <TELL "felt">)
			     (T
			      <TELL "seen">)>
		       <TELL "." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO> <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     (<FSET? ,PRSO ,SURFACEBIT>
			      <COND (<IN? ,WINNER ,PRSO>
				     <TELL "You're on it!" CR>
				     <RTRUE>)
				    (T
				     <TELL "There is nothing on the "
					    D ,PRSO "." CR>
				     <RTRUE>)>)
			     (T
			      <TELL "The " D ,PRSO " is empty." CR>
			      <RTRUE>)>)
		      (ELSE <TELL "The " D ,PRSO " is closed." CR>)>)
	       (ELSE
		<TELL "I don't know how to ">
		<COND (<NOT .REACH?>
		       <TELL "look inside a">)
		      (ELSE <TELL "feel inside a">)>
		<VOWEL? ,PRSO>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	       <FSET? .OBJ ,OPENBIT>>>

<ROUTINE V-REPENT () <TELL "It could very well be too late!" CR>>

<ROUTINE PRE-BURN ()
	 <COND (<AND <EQUAL? ,PRSO ,TORCH>
		     <EQUAL? ,PRSI ,ONE-MATCH ,MANY-MATCHES>
		     <OR <IN? ,ONE-MATCH ,WINNER>
			 <IN? ,MATCHES ,WINNER>>>
		<COND (<NOT <FLAMING? ,PRSI>>
		       <COND (<L? ,MATCH-COUNT 1>
			      <TELL "You're out of matches. Sorry." CR>
			      <RTRUE>)
			     (ELSE
			      <COND (<NOT <IN? ,ONE-MATCH ,WINNER>>
				     <TELL "(lighting a match first)" CR>
				     <MATCH-MOVER>)
				    (T
				     <TELL "(lighting the match first)" CR>)>
			      <LIGHT-THE ,ONE-MATCH T>
			      <ENABLE <QUEUE I-MATCH-OUT 3>>)>)>
		<PERFORM ,V?LAMP-ON ,TORCH ,ONE-MATCH>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSO ,TORCH>
		     <IN? ,PRSI ,WINNER>
		     <FLAMING? ,PRSI>> 
		<PERFORM ,V?LAMP-ON ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <NOT <IN? ,PRSI ,WINNER>>
		     <NOT <IN? ,PRSI ,HERE>>
		     <NOT <EQUAL? <LOC <LOC ,PRSI>> ,HERE>>>
		<TELL "I see no " D ,PRSI " here." CR>
		<RTRUE>)
	       (<FLAMING? ,PRSI> <RFALSE>)
	       (<FSET? ,PRSI ,BURNBIT>
		<TELL "You'd better light ">
		<COND (<EQUAL? ,PRSI ,MANY-MATCHES>
		       <TELL "a match">)
		      (ELSE <TELL "the " D ,PRSI>)>
		<TELL " first." CR>
		<RTRUE>)
	       (T <TELL "With a">
		<VOWEL? ,PRSI>
		<TELL D ,PRSI "??!?" CR>)>>

<ROUTINE V-BURN ()
	 <COND (<EQUAL? ,PRSO ,BOAT ,DECK>
		<JIGS-UP ,BARGE-BURN-STR>
		<RFATAL>)
	       (<FSET? ,PRSO ,BURNBIT>
		<COND (<IN? ,PRSO ,WINNER>
		       <TELL "The " D ,PRSO " catches fire and is consumed.">
		       <EMPTY-THE ,PRSO>
		       <REMOVE ,PRSO>
		       <SETG P-IT-LOC <>>
		       <COND (<PRSO? ,ROPE>
			      <SETG ROPE-TIED <>>
			      <SETG ROPE-PLACED <>>)>)
		      (<AND <PRSO? ,SHIM ,BEAM>
			    <EQUAL? <LOC ,PRSO> ,HERE ,BELOW-MAST>
			    <OR <EQUAL? ,HERE ,BARGE-CENTER ,FORE-CABIN
					,AFT-CABIN>
				<EQUAL? ,HERE ,BELOW-DECK ,BELOW-MAST>>>
		       <TELL "The " D ,PRSO
" catches fire, but before you have a chance to react, the fire spreads." CR>
		       <JIGS-UP ,BARGE-BURN-STR>)
		      (<PRSO? ,SHIM ,BEAM>
		       <REMOVE ,PRSO>
		       <SETG P-IT-LOC <>>
		       <TELL "The " D ,PRSO
" catches fire and is consumed." CR>
		       <COND (<PRSO? ,BEAM>
			      <COND (<AND ,ON-BEAM
					  <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
					  <NOT <IN? ,PLASTER ,HERE>>>
				     <JIGS-UP ,AIR-WALK>)
				    (,BEAM-PLACED
				     <COND (<IN? ,WINNER ,ANNEX>
					    <JIGS-UP ,ANNEX-BEAM-STR>
					    <RFATAL>)
					   (<IN? ,WINNER ,BURIAL-CHAMBER>
					    <JIGS-UP ,BURIAL-BEAM-STR>)
					   (<IN? ,WINNER ,NORTH-ANTECHAMBER>
					    <DROP-THE-BLOCKS>
					    <RTRUE>)
					   (<IN? ,WINNER ,SOUTH-ANTECHAMBER>
					    <CLOSE-THE-ANNEX>
					    <RTRUE>)>)>)>
		       <RTRUE>)
		      (ELSE <TELL "You don't have the " D ,PRSO "." CR>)>)
	       (<AND <EQUAL? ,PRSO ,OIL-JAR ,LIQUID>
		     <FLAMING? ,PRSI>>
		<PERFORM ,V?DIP-IN ,PRSI ,OIL-JAR>
		<RTRUE>)
	       (T <TELL "I don't think you can burn the " D ,PRSO "." CR>)>>

<ROUTINE PRE-TURN ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL "You can't turn that!" CR>)
	       (<AND ,PRSI
		     <EQUAL? ,PRSI ,INTDIR>>
		<TELL "You can't turn things to a specific direction." CR>
		<RTRUE>)>>

<ROUTINE V-TURN () <TELL "This has no effect." CR>>

<ROUTINE V-PUMP ()
	 <TELL "I really don't see how." CR>>

<ROUTINE V-INFLATE () <TELL "How can you inflate that?" CR>>

<ROUTINE V-DEFLATE () <TELL "Come on, now!" CR>>

<ROUTINE V-LOCK () <TELL "It doesn't seem to work." CR>>

<ROUTINE V-PICK () <TELL "You can't pick that." CR>>

<ROUTINE V-UNLOCK () <V-LOCK>>

<ROUTINE V-CUT ()
	 <COND (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<COND (<EQUAL? ,PRSI ,HANDS>
		       <TELL "Be serious. Karate chop it? Come on!" CR>)
		      (ELSE
		       <TELL
			"I doubt that the \"cutting edge\" of a">
		       <VOWEL? ,PRSI>
		       <TELL D ,PRSI " is adequate." CR>)>)
	       (T
		<TELL "Strange concept, cutting the " D ,PRSO "...." CR>)>>

<ROUTINE V-KILL ()
	 <IKILL "kill">>

<ROUTINE IKILL (STR)
	 #DECL ((STR) ZSTRING)
	 <COND (<NOT ,PRSO> <TELL "There is nothing here to " .STR "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,VILLAIN>>
		     <NOT <FSET? ,PRSO ,VICBIT>>>
		<TELL "I've known strange people, but fighting a">
		<VOWEL? ,PRSO>
		<TELL D ,PRSO "?" CR>)
	       (<OR <NOT ,PRSI> <==? ,PRSI ,HANDS>>
		<TELL "Trying to "
		      .STR
		      " a">
		<VOWEL? ,PRSO>
		<TELL D ,PRSO
		      " with your bare hands is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<TELL "You aren't even holding the " D ,PRSI "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to "
		      .STR
		      " the "
		      D
		      ,PRSO
		      " with a">
		<VOWEL? ,PRSI>
		<TELL
		      D
		      ,PRSI
		      " is suicidal." CR>)
	       (ELSE <TELL "You can't." CR>)>>

<ROUTINE V-ATTACK () <IKILL "attack">>

<ROUTINE V-SWING ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL "Who do you think you are, Benny Goodman?" CR>)
	       (T
		<TELL "Whoosh!" CR>)>>

<ROUTINE V-KICK () <HACK-HACK "Kicking the ">>

<ROUTINE V-WAVE () <HACK-HACK "Waving the ">>

<ROUTINE V-RAISE () <HACK-HACK "Playing in this way with the ">>

<ROUTINE V-LOWER () <HACK-HACK "Playing in this way with the ">>

<ROUTINE V-RUB () <HACK-HACK "Fiddling with the ">>

<ROUTINE V-PUSH () <HACK-HACK "Pushing the ">>

<ROUTINE PRE-PUSH-TO ()
	 <COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <IN? ,PRSO ,LOCAL-GLOBALS>>
		<TELL "Nice try." CR>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<PRSO? ,SARCOPH>
		<TELL "Be serious. Any idea what that must weigh?" CR>
		<RTRUE>)
	       (<AND <NOT <IN? ,PRSO <LOC ,WINNER>>>
		     <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <EQUAL? ,PRSO ,NOT-HERE-OBJECT>>>
		<TELL "Huh? The " D ,PRSO "? Get serious." CR>)>>

<GLOBAL PUSH-TBL
	<TABLE A-PRIME P?NW P?SE
	       B-PRIME P?NE P?SW
	       D-PRIME P?SW P?NE
	       E-PRIME P?SE P?NW>> 

<ROUTINE V-PUSH-TO ("AUX" (OFFS -3) (FLG 0))
	 <COND (<AND <NOT <EQUAL? ,PRSO ,HUGE-STATUE>>
		     <FSET? ,PRSO ,TAKEBIT>>
		<TELL 
"There's no need for that. Why not just pick it up and then carry it there?" 
			CR>
		<RTRUE>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You push and strain, but can't budge the " D ,PRSO "."
		      CR>)
	       (<NOT <EQUAL? ,PRSI ,INTDIR>>
		<TELL "You can't push things to that." CR>
		<RTRUE>)
	       (<EQUAL? ,HERE ,LANDING-ZERO>
		<COND (<AND <NOT <EQUAL? ,P-DIRECTION ,P?NE ,P?NW>>
			    <NOT <EQUAL? ,P-DIRECTION ,P?SE ,P?SW>>>
		       <SET FLG 1>)
		      (ELSE
		       <SET FLG 3>)>)>
	 <COND (<EQUAL? .FLG 0>
		<REPEAT ()
			<SET OFFS <+ .OFFS 3>>
			<COND (<G? .OFFS 9>
			       <RETURN>)
			      (<EQUAL? ,HERE <GET ,PUSH-TBL .OFFS>>
			       <COND (<EQUAL? ,P-DIRECTION 
					      <GET ,PUSH-TBL <+ .OFFS 1>>>
				      <SET FLG 2>)
				     (<NOT 
				       <EQUAL? ,P-DIRECTION
					       <GET ,PUSH-TBL <+ .OFFS 2>>>>
				      <SET FLG 1>)
				     (ELSE
				      <SET FLG 3>)>)>>)>
	 <COND (<EQUAL? .FLG 1>
		<TELL "The statue bumps into a wall." CR>)
	       (<EQUAL? .FLG 2>
		<TELL "It won't fit through the door." CR>)
	       (<EQUAL? .FLG 3>
		<DO-WALK ,P-DIRECTION>
		<MOVE ,HUGE-STATUE ,HERE>
		<THIS-IS-IT ,HUGE-STATUE>
		<TELL "The pushed statue rests on the floor." CR>)>>

<ROUTINE PRE-MUNG ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT ,ME ,WINNER ,ADVENTURER>
		<RFALSE>)
	       (<EQUAL? ,PRSO ,N-ANTE-SEAL>
		<COND (<BREAK-SEAL>
		       <RTRUE>)
		      (T
		       <TELL
"You scratch at the seals but accomplish little." CR>
		       <RTRUE>)>)
	       (<OR <PRSO? ,PLASTER ,PLASTER1 ,LOCK>
		    <PRSO? ,HUGE-STATUE ,HEAD ,CRATE>
		    <PRSO? ,BLACK-BOX ,BEAM>>
	        <RFALSE>)
	       (<NOT <FSET? ,PRSO ,VICBIT>>
		<HACK-HACK "Trying to destroy the ">)
	       (<NOT ,PRSI>
		<TELL "Trying to destroy the " D ,PRSO 
		      " with your bare hands is suicidal." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to destroy the " D ,PRSO " with a">
		<VOWEL? ,PRSI>
		<TELL D ,PRSI
		      " is quite self-destructive." CR>)>>

<ROUTINE V-MUNG () <TELL "Nothing much happens." CR>>

<ROUTINE HACK-HACK
	 (STR)
	 #DECL ((STR) ZSTRING)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS> <VERB? WAVE RAISE LOWER>>
		<TELL "The " D ,PRSO " isn't here!" CR>)
	       (T <TELL .STR D ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE
	 " doesn't seem to work."
	 " isn't notably helpful."
	 " doesn't work."
	 " has no effect.">>

<ROUTINE WORD-TYPE
	 (OBJ WORD "AUX" SYNS)
	 #DECL ((OBJ) OBJECT (WORD SYNS) TABLE)
	 <ZMEMQ .WORD
		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
		<- </ <PTSIZE .SYNS> 2> 1>>>

<ROUTINE V-KNOCK ()
	 <TELL "Why knock on a">
	 <VOWEL? ,PRSO>
	 <TELL D ,PRSO "?" CR>>

<ROUTINE V-CHOMP ()
	 <TELL "I don't know how to do that. I win in all cases!" CR>>

<ROUTINE V-FROBOZZ
	 ()
	 <TELL
"The FROBOZZ Corporation created, owns, and operates this programmer." CR>>

<ROUTINE V-WIN () <TELL "Naturally!" CR>>

<ROUTINE V-YELL () <TELL "Aarrrrrgggggggghhhhhhhhhhh!" CR>>

<ROUTINE V-PLUG () <TELL "This has no effect." CR>>

<ROUTINE V-EXORCISE () <TELL "What a bizarre concept!" CR>>

\

<ROUTINE V-SHAKE ("AUX" X)
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "This seems to have no effect." CR>)
	       (<EQUAL? ,PRSO ,HANDS>
		<TELL
"Nice to meet me. Funny, you think I look like myself." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You can't take it; thus, you can't shake it!" CR>)
	       (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
		     <FIRST? ,PRSO>>
		<TELL "It sounds as if there is something inside the "
		      D
		      ,PRSO
		      "."
		      CR>)
	       (<AND <EQUAL? ,PRSO ,LIQUID ,OIL-JAR>
		     <IN? ,LIQUID ,OIL-JAR>>
		<TELL "The liquid sloshes around." CR>)
	       (<AND <FSET? ,PRSO ,OPENBIT> <FIRST? ,PRSO>>
		<REPEAT ()
			<COND (<SET X <FIRST? ,PRSO>> <MOVE .X ,HERE>)
			      (ELSE <RETURN>)>>
	        <TELL "All of the objects spill onto the ">
		<SPILL-WHERE?>)
	       (T <TELL "There's nothing in the " D ,PRSO "." CR>)>>

<ROUTINE SPILL-WHERE? ()
	 <COND (<IN? ,WINNER ,COT>
		<TELL
		 "ground by the cot.">)
	       (<EQUAL? ,HERE ,RIVER-BANK>
		<TELL
		 "river bank.">)
	       (<GETP ,HERE ,P?MAP>
		<TELL 
		 "sand.">)
	       (<EQUAL? <GETP ,HERE ,P?ACTION> ,BURN-THE-BARGE>
		<TELL 
		 "wooden decking.">)
	       (T
		<TELL "stone floor.">)>
	 <CRLF>>

<ROUTINE PRE-DIG () 
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT ,PRSI>
		<COND (<IN? ,SHOVEL ,WINNER>
		       <SETG PRSI ,SHOVEL>
		       <TELL "(with the shovel)" CR>)
		      (<IN? ,PICK-AXE ,WINNER>
		       <SETG PRSI ,PICK-AXE>
		       <TELL "(with the axe)" CR>)
		      (T <SETG PRSI ,HANDS>
		       <TELL "(with your hands)" CR>)>)>
	 <COND (<FSET? ,PRSI ,TOOLBIT> <RFALSE>)
	       (ELSE
		<TELL "Digging with the " D ,PRSI " is very silly." CR>)>>

<GLOBAL THIRST 0>

<ROUTINE V-DIG ("AUX" COUNTER)
	 <COND (<EQUAL? ,PRSO ,PLASTER1 ,PLASTER ,WALLS>
		<PERFORM ,V?MUNG ,PRSO ,PRSI>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSO ,SAND ,GROUND ,HOLE>>
		<TELL "You can't dig in that." CR>)
	       (<EQUAL? ,HERE ,RIVER-BANK>
		<TELL 
"You dig a small hole, but it quickly fills in with water and sand, almost
immediately disappearing." CR>)
	       (<NOT <GETP ,HERE ,P?CAPACITY>>
		<TELL "The ground is too hard here." CR>)
	       (<PRSI? ,HANDS>
		<TELL
"I suppose you also excavate tunnels with a teaspoon?!" CR>)
	       (<PRSI? ,PICK-AXE>
	        <TELL
"Let's face it, for digging in the sand, the axe is cute but ineffective." CR>)
	       (T
		<SET COUNTER <GETP ,HERE ,P?CAPACITY>>
		<SET COUNTER <+ .COUNTER 1>>
		<SETG THIRST <+ ,THIRST 4>>
		<COND (<AND <G? .COUNTER 5>
			    <NOT <EQUAL? ,HERE ,EX8>>>
		       <JIGS-UP
"The walls of the hole collapse around you, smothering you in the shifting
sands.">
		       <RFATAL>)
		      (T
		       <PUTP ,HERE ,P?CAPACITY .COUNTER>
		       <COND (<AND <EQUAL? .COUNTER 6>
				   <EQUAL? ,HERE ,EX8>>
			      <TELL
"You've uncovered what could only be the top of a pyramid. After clearing it
away with your hands, you notice a square opening in the top of it." CR>
			      <PUTP ,HERE ,P?CAPACITY 6>
			      <PUTP ,HERE ,P?LDESC
"You are in the desert, almost out of sight of the encampment to the west. At
last, though, you've found the ancient pyramid. The top of the pyramid is
clearly exposed and on one of its sides is a square opening.">
			      <FCLEAR ,ROCK-LOCK ,INVISIBLE>
			      <MOVE ,PYRAMID ,HERE>
			      <SETG SCORE <+ ,SCORE 25>>)
			     (T
			      <TELL <GET ,DIGGER-LTBL .COUNTER> CR>)>)>)>>

<GLOBAL DIGGER-LTBL
	<LTABLE 
"You've dug a small hole. As you stand there and watch it, the sand starts to
fill it in a little."
"You've enlarged the hole a little, taking out two shovelsfull for every one
that collapses back in from the walls."
"You've made the hole quite sizable, though it's not very deep. The deeper you
dig, the more the walls collapse and so you widen the base of the hole."
"You're knee-deep in the hole, digging away, taking out more and more sand. You
silently curse those workers for having deserted you."
"You've dug yourself into a deep hole. You're actually several feet below the
surrounding sand. The walls look very unstable.">>

<ROUTINE V-SMELL ()
	 <COND (<EQUAL? ,PRSO ,LIQUID>
		<TELL 
"It smells like a mixture of gasoline and embalming fluid. Yum Yum." CR>)
	       (<FLAMING? ,PRSO>
		<TELL "Nice way to singe your nostrils!" CR>)
	       (<PRSO? ,SKELETON>
		<TELL "It smells quite dead." CR>)
	       (<PRSO? ,MAP>
		<TELL "It smells a little musty." CR>)
	       (T <TELL "It smells just like a">
		<VOWEL? ,PRSO>
		<TELL D ,PRSO "." CR>)>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" T)
	 #DECL ((OBJ1 OBJ2) OBJECT (T) <OR FALSE TABLE>)
	 <COND (<SET T <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .T <- <PTSIZE .T> 1>>)>>

<ROUTINE V-SWIM ()
	 <COND (<EQUAL? ,HERE ,RIVER-BANK>
		<JIGS-UP .CROC-STR>
		<RFATAL>)
	       (<NOT <EQUAL? ,PRSO ,NILE-RIBBAH>>
		<TELL "Now that's a cute idea. Maybe I'll try it next century."
		      CR>)
	       (T <TELL "Go jump in a lake!" CR>)>>

<ROUTINE V-UNTIE () <TELL "This cannot be tied, so it cannot be untied!" CR>>

<ROUTINE PRE-TIE ()
	 <COND (<==? ,PRSI ,WINNER>
		<TELL "You can't tie it to yourself." CR>)>>

<ROUTINE V-TIE ()
	 <COND (<EQUAL? ,PRSI ,SCARAB>
		<TELL "The rope's too clumsy to tie to that." CR>)
	       (<NOT <EQUAL? ,PRSI ,BEAM>>
		<TELL "You can't tie the " D ,PRSO " to that." CR>)
	       (ELSE
		<TELL "Don't bother." CR>)>>

<ROUTINE V-TIE-UP () <TELL "You could certainly never tie it with that!" CR>>

<ROUTINE V-MELT () <TELL "I'm not sure that a">
	 <VOWEL? ,PRSO>
	 <TELL D ,PRSO " can be melted." CR>>

<ROUTINE V-MUMBLE
	 ()
	 <TELL "You'll have to speak up if you expect me to hear you!" CR>>

<ROUTINE V-ALARM ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "He's wide awake, or haven't you noticed..." CR>)
	       (ELSE
		<TELL "The " D ,PRSO " isn't sleeping." CR>)>>

<ROUTINE V-ZORK () <TELL "Who?" CR>>

\

<ROUTINE MUNG-ROOM (RM STR)
	 #DECL ((STR) ZSTRING)
	 <FSET .RM ,RMUNGBIT>
	 <PUTP .RM ,P?LDESC .STR>>

<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<TELL "The " D ,PRSO " pays no attention." CR>)
	       (ELSE
		<TELL "You cannot talk to that!" CR>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<EQUAL? ,PRSO ,ALTAR>
		<PERFORM ,V?BOARD ,ALTAR>
		<RTRUE>)
	       (<OR <FSET? ,PRSO ,VEHBIT>
		    <PRSO? ,BEAM>>
		<V-CLIMB-UP ,P?UP T>)
	       (<EQUAL? ,PRSO ,ROPE>
		<PERFORM ,V?TAKE ,ROPE>
		<RTRUE>)
	       (T
		<TELL "You can't climb onto the " D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-FOO ()
	 <COND (<AND <OR <EQUAL? ,PRSO ,ROPE>
			 <EQUAL? ,PRSI ,ROPE>>
		     <IN? ,ROPE ,WINNER>>
		<TELL "You can't do that while you're holding the rope." CR>
		<RFATAL>)
	       (<EQUAL? ,PRSO ,ALTAR>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,INTDIR>
		<TELL "You can't climb a direction!" CR>
		<RFATAL>)
	       (<AND <NOT <FSET? ,PRSO ,CLIMBBIT>>
		     <NOT <FSET? ,PRSO ,VEHBIT>>>
		<TELL "You can't climb that!" CR>
		<RFATAL>)
	       (T
		<V-CLIMB-UP <COND (<EQUAL? ,HERE ,CHAMBER-OF-RA> ,P?DOWN)
				  (<EQUAL? ,PRSO ,PLANK> ,P?NORTH)
				  (T ,P?UP)> T>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X)
	 <COND (<AND .OBJ
		     <ZMEMQ ,W?BEAM
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>
		     >
		<COND (<AND ,ON-BEAM
			    <IN? ,BEAM ,WEST-END-OF-PASSAGE>>
		       <TELL "You're already on the beam." CR>)
		      (<IN? ,BEAM ,WEST-END-OF-PASSAGE>
		       <TELL "You are now standing on the beam." CR>)
		      (<AND <FSET? ,BEAM ,TOUCHBIT>
			    <IN? ,BEAM ,HERE>
			    <NOT ,BEAM-PLACED>>
		       <TELL
"You step onto it, see no sense in remaining on it, then step off it." CR>
		       <RTRUE>)
		      (T <TELL "Get real. You don't have fly feet." CR>
		       <RTRUE>)>
		<SETG ON-BEAM T>)
	       (<GETPT ,HERE .DIR>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<NOT .OBJ>
		<TELL "You can't go that way." CR>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALLS
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Climbing the walls is to no avail." CR>)
	       
	       (ELSE <TELL "Bizarre!" CR>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<AND <EQUAL? ,PRSO ,ROPE ,P?NORTH ,P?DOWN>
		     <NOT ,LANDING>>
		<TELL "It would help if the rope led someplace." CR>
		<RTRUE>)
	       (ELSE <V-CLIMB-UP ,P?DOWN>)>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,VILLAIN>
		<TELL "Why would you send for the " D ,PRSO "?" CR>)
	       (ELSE <TELL "That doesn't make sends." CR>)>>

<ROUTINE V-WIND ()
	 <TELL "You cannot wind up a">
	 <VOWEL? ,PRSO>
	 <TELL D ,PRSO "." CR>>

<ROUTINE V-COUNT ("AUX" OBJS CNT)
	 <COND (<==? ,PRSO ,STONES>
		<TELL 
"There are a lot of stones in the pyramid (about 90,000,000 cubic feet)." CR>)
	       (<OR <EQUAL? ,PRSO ,DRACULA ,BLESSINGS ,FINGER>
		    <EQUAL? ,PRSO ,BASIE>>
		<TELL "What a maroon! What a cahd!" CR>)
	       (T
		<TELL "You have ">
		<COND (<==? ,PRSO ,MATCHES ,MANY-MATCHES>
		       <SET CNT <-  ,MATCH-COUNT 1>>
		       <TELL N .CNT " match">
		       <COND (<NOT <1? .CNT>> <TELL "es.">) (ELSE <TELL ".">)>
		       <CRLF>)
		      (ELSE <TELL "a weird sense of counting!" CR>)>)>>

<ROUTINE V-PUT-UNDER ()
         <TELL "You can't do that." CR>>

<ROUTINE V-PLAY ()
         <COND (<FSET? ,PRSO ,VILLAIN>
	        <TELL
"You are so engrossed in the role of the " D ,PRSO " that
you kill yourself, just as he would have done!" CR>
	        <JIGS-UP "">)
	       (T <TELL "How peculiar!" CR>)>>

<ROUTINE V-MAKE ()
    	<TELL "You can't do that." CR>>

<ROUTINE V-ENTER ()
	 <DO-WALK ,P?IN>>

<ROUTINE V-EXIT ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-CROSS ()
	 <TELL "You can't cross that!" CR>>

<ROUTINE V-SEARCH ()
	 <TELL "You find nothing unusual." CR>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS>
		<TELL
"Within six feet of your head, assuming you haven't left that somewhere." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "Why don't you try finding it yourself?" CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You have it." CR>)
	       (<IN? ,PRSO ,ENDLESS-DESERT>
		<TELL "With all this sand around here? Give me a break!" CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <==? ,PRSO ,PSEUDO-OBJECT>>
		<TELL "It's right here." CR>)
	       (<FSET? .L ,VILLAIN>
		<TELL "The " D .L " has it." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "It's ">
		<COND (<FSET? .L ,SURFACEBIT>
		       <TELL "on">)
		      (T <TELL "in">)>
		<TELL " the " D .L "." CR>)
	       (ELSE
		<TELL "Beats me." CR>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,VICBIT>
		<SETG WINNER ,PRSO>
		<SETG HERE <LOC ,WINNER>>)
	       (<EQUAL? ,PRSO ,ME ,WINNER>
		<TELL "Talking to yourself is diverting, but unnecessary." CR>
		<RFATAL>)
	       (T
		<TELL "You can't talk to the " D ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that the " D ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-IS-IN ()
	 <COND (<IN? ,PRSO ,PRSI>
		<TELL "Yes, it is ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T <TELL "in">)>
		<TELL " the " D ,PRSI "." CR>)
	       (T <TELL "No, it isn't." CR>)>>

<ROUTINE V-KISS ()
	 <TELL "I'd sooner kiss a pig." CR>>

<ROUTINE V-RAPE ()
	 <TELL "An ugly idea from an ugly human." CR>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W> <RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT> <RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RETURN <>>)>>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,VICBIT>>
		<TELL "You must address the " D .V " directly." CR>)
	       (<==? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (ELSE
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<TELL
"Talking to yourself is said to be a sign of impending mental collapse." CR>)>>

<ROUTINE V-INCANT ()
	 <TELL
"The incantation echoes back faintly, but nothing else happens." CR>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RTRUE>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>

<ROUTINE V-THROUGH ("AUX" M)
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL "You hit your head against the "
			    D ,PRSO
			    " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (ELSE <TELL <PICK-ONE ,YUKS> CR>)>>


<GLOBAL YUKS
	<LTABLE "Not within this life cycle."
		"With this kind of wisdom, be glad you're not in a Sphinx."
		"A totally bizarre concept. For sure."
		"Totally different head, man. Like, untubular."
		"Kookie, man."
		"I've heard better ideas from politicians."
		"A truly amazing concept, that."
		"Bizarre barely describes that desire."
		"Let's face it -- that isn't going to happen.">>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "You can't wear the " D ,PRSO "." CR>)
	       (T <PERFORM ,V?TAKE ,PRSO> <RTRUE>)>>

<ROUTINE V-THROW-OFF ()
	 <COND (<NOT <EQUAL? ,PRSI ,BOAT ,ALTAR ,DECK>>
		<TELL "You can't throw anything off of that!" CR>)
	       (<PRSI? ,BOAT ,DECK>
		<COND (<NOT <EQUAL? ,HERE ,BARGE-CENTER>>
		       <TELL "From where you are now? Get serious." CR>
		       <RTRUE>)
		      (T <TELL
"Thrown. You hear it land in the darkness to the south." CR> 
		       <MOVE ,PRSO ,BARGE-ENTRANCE>
		       <FSET ,PRSO ,TOUCHBIT>
		       <FCLEAR ,PRSO ,NDESCBIT>
		       <RTRUE>)>)
	       (<PRSI? ,ALTAR>
		<COND (<NOT <IN? ,WINNER ,ALTAR>>
		       <TELL
"Don't you think you should be standing on the altar first?" CR>)
		      (T
		       <PERFORM ,V?THROW ,PRSO>
		       <RTRUE>)>)>>
		       
<ROUTINE V-$VERIFY ()
	 <TELL "Verifying game..." CR>
	 <COND (<VERIFY> <TELL "Game correct. Don't panic yet." CR>)
	       (T <TELL CR "** Game File Failure ** (Panic)" CR>)>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (ELSE
		<TELL "You are already standing, I think." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE V-WALK-TO ()
	 <COND (<AND <EQUAL? ,PRSO ,PLANK>
		     <IN? ,PRSO ,HERE>>
		<TELL "Yo ho." CR>
		<COND (<EQUAL? ,HERE ,BARGE-ENTRANCE>
		       <DO-WALK ,P?UP>
		       <RTRUE>)
		      (T <DO-WALK ,P?DOWN>)>
		<RTRUE>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<TELL "It's here!" CR>)
	       (T <TELL "You should supply a direction!" CR>)>>

;"Finds the room on the other side of a door"

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) T)
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET T <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .T> ,DEXIT>
				    <EQUAL? <GETB .T ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE V-DRINK-FROM ("AUX" OBJ)
	 <COND (<NOT ,PRSI>
		<COND (<EQUAL? ,PRSO ,NILE-RIBBAH>
		       <SET OBJ ,GLOBAL-WATER>)
		      (<EQUAL? ,PRSO ,CANTEEN>
		       <SET OBJ ,WATER>)
		      (<EQUAL? ,PRSO ,OIL-JAR>
		       <SET OBJ ,LIQUID>)
		      (T
		       <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
			      <TELL "How peculiar!" CR>
			      <RTRUE>)
			     (<NOT <FIRST? ,PRSO>>
			      <TELL "There's nothing to drink in the " D ,PRSO
				    "." CR>
			      <RTRUE>)
			     (T
			      <SET OBJ <FIRST? ,PRSO>>
			      <COND (<NOT <FSET? .OBJ ,DRINKBIT>>
				     <TELL
"I don't think there's anything worth drinking in the " D ,PRSO "." CR>
				     <RTRUE>)>)>)>
		<PERFORM ,V?DRINK .OBJ>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSO ,GLOBAL-WATER ,WATER>
		     <EQUAL? ,PRSI ,NILE-RIBBAH>>
		<COND (<NOT <EQUAL? ,HERE ,RIVER-BANK>>
		       <TELL "I see no " D ,PRSO " here." CR>
		       <RTRUE>)
		      (ELSE
		       <PERFORM ,V?DRINK ,PRSO>
		       <RTRUE>)>)
	       (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "Better open the " D ,PRSI " first." CR>)
	       (<NOT <IN? ,PRSO ,PRSI>>
		<TELL "I can't see any " D ,PRSO " in the " D ,PRSI "." CR>)
	       (T
		<PERFORM ,V?DRINK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Are you so very tired, then?" CR>>

<ROUTINE V-DIP-IN ()
	 <COND (<AND <EQUAL? ,PRSI ,GLOBAL-WATER ,NILE-RIBBAH>
		     <EQUAL? ,PRSO ,CANTEEN>>
		<PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSI ,OIL-JAR ,LIQUID>>
		<TELL "You can't dip the " D ,PRSO " in that!" CR>)
	       (<OR <FLAMING? ,PRSO>
		    <FLAMING? ,PRSI>>
		<JIGS-UP
"Poof. There's no need to get burned up about it though...">)
	       (<NOT <EQUAL? ,PRSO ,TORCH>>
		<TELL "Huh? Dip the " D ,PRSO "!?" CR>
		<RTRUE>)
	       (T
		<PERFORM ,V?POUR-ON ,OIL-JAR ,TORCH>
		<RTRUE>)>>

<ROUTINE V-PUT-AGAINST ()
	 <TELL "You can't do that." CR>>

<ROUTINE BREAK-SEAL ()
	 <COND (<AND <NOT <EQUAL? ,PRSI ,PICK-AXE>>
		     <NOT <IN? ,WINNER ,PICK-AXE>>>
		<RFALSE>)>
	 <COND (<EQUAL? ,BEAM-PLACED 4>
		 <TELL
"You manage to destroy the seal. You glance to the right and see fine sand
running from a crack in the stone. The beam creaks and groans under tremendous
pressure as the 3 ton stone block above your head starts to lower.  The beam
holds the weight, saving you from a flattening fate."CR>
                <SETG ANTE-SEAL <>>
		<THIS-IS-IT ,NORTH-ANTE-DOOR>
		<RTRUE>)
	       (<OR <NOT <IN? ,BEAM ,NORTH-ANTECHAMBER>>
		    <NOT ,BEAM-PLACED>>
		<JIGS-UP 
"You manage to destroy the seal, but as you stand in the doorway, you hear the
distinct sound of grinding stone. You glance to your right and see fine sand
running from a crack in the wall. You're totally unaware of the 3 tons of
carved stone block falling onto your head from directly above.">)>>

<ROUTINE V-TASTE ()
	 <TELL "It tastes just like a">
	 <VOWEL? ,PRSO>
	 <TELL D ,PRSO "!" CR>>

<ROUTINE V-ROLL ()
	 <COND (<NOT <EQUAL? ,PRSO ,HUGE-STATUE>>
		<TELL "Why bother?" CR>)
	       (T
		<TELL "The statue bumps into a wall." CR>)>>
	       
<ROUTINE V-PUSH-THROUGH ()
	 <TELL
"Pushing the " D ,PRSO " in that way isn't particularly helpful." CR>>

<ROUTINE HOW? (OBJ)
	 <TELL "I don't know how to do that to a">
	 <VOWEL? .OBJ>
	 <TELL D .OBJ "." CR>>

<ROUTINE VOWEL? (OBJ)
	 <COND (<FSET? .OBJ ,VOWELBIT>
		<TELL "n">)>
	 <TELL " ">>

<ROUTINE HUH? ("OPTIONAL" (RARG <>))
	 <COND (<VERB? OPEN CLOSE>
		<HOW? ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SMOKE ()
	 <TELL "Smoking is bad for your health." CR>>

<ROUTINE V-UNFOLD ()
	 <COND (<NOT <EQUAL? ,PRSO ,MAP>>
		<HOW? ,PRSO>)
	       (T
		<PERFORM ,V?OPEN ,MAP>
		<RTRUE>)>>

<ROUTINE V-FOLD ()
	 <COND (<NOT <EQUAL? ,PRSO ,MAP>>
		<HOW? ,PRSO>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's already folded up." CR>
		<RTRUE>)
	       (T
		<TELL "Okay. The map has been folded." CR>
		<FCLEAR ,MAP ,OPENBIT>
		<RTRUE>)>>

<GLOBAL CROC-STR
"You manage to wade a few feet into the river, but this makes the crocodiles
spring into action -- they advance far more quickly than you thought possible.
You panic and turn to the bank, attempting to flee. Your splashing about makes
the beasts double their efforts and reach you just as you are about to step on
shore. The last thought you have is a slight amazement at how many teeth a
crocodile has and just how sharp they are.">

<ROUTINE V-HOLE-DIG ()
	 <COND (<NOT <EQUAL? ,PRSO ,HOLE>>
		<TELL "I don't know how to dig a">
		<VOWEL? ,PRSO>
		<TELL D ,PRSO "." CR>)
	       (<EQUAL? ,PRSI ,SAND>
		<PERFORM ,V?DIG ,SAND>
		<RTRUE>)
	       (ELSE
		<TELL "I can't dig in the " D ,PRSI "." CR>
		<RTRUE>)>>

<ROUTINE V-DIG-WITH ()
	 <PERFORM ,V?DIG ,SAND ,PRSO>
	 <RTRUE>>

<ROUTINE V-TURN-OVER ()
	 <COND (<IN? ,PRSO ,WINNER>
		<TELL "Okay. There's nothing of interest there." CR>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "You'd better pick it up first." CR>)
	       (ELSE
		<TELL "Good luck!" CR>)>>
		
<ROUTINE V-READ-INSIDE ()
	 <TELL "There's nothing to read there." CR>>

<ROUTINE PRE-REACH-IN ()
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL "You can't reach into that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "The " D ,PRSO " is closed." CR>)>>

<ROUTINE V-REACH-IN ()
	 <PERFORM ,V?LOOK-INSIDE ,PRSO>>

<ROUTINE V-CLEAN ()
	 <TELL
"Cleanliness may be next to godliness, but there are limits." CR>>

<ROUTINE PRE-PULL-UP ()
	 <COND (<NOT <EQUAL? ,PRSO ,BEAM>>
		<PERFORM ,V?MOVE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-PULL-UP ()
	 <COND (<FSET? ,BEAM ,TOUCHBIT>
		<TELL "Why bother?" CR>)
	       (<NOT <EQUAL? ,HERE ,BARGE-CENTER>>
		<TELL "That's a little tough to do from here." CR>)
	       (ELSE
		<PERFORM ,V?PUSH-THROUGH ,BEAM ,MAST-HOLE>)>>

<ROUTINE V-THROW-DOWN ("AUX" FOO)
	 <COND (<STAIRWAY-CHECK?>
		<RTRUE>)
	       (<NOT <EQUAL? ,PRSO ,ROPE>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<AND <EQUAL? ,PRSI ,INTDIR>
		     <EQUAL? ,P-DIRECTION ,P?NORTH>>
		<SET FOO ,NORTH-STAIRS>)
	       (<AND <EQUAL? ,PRSI ,INTDIR>
		     <EQUAL? ,P-DIRECTION ,P?SOUTH>>
		<SET FOO ,SOUTH-STAIRS>)
	       (<AND <EQUAL? ,PRSI ,INTDIR>
		     <EQUAL? ,P-DIRECTION ,P?EAST>>
		<SET FOO ,EAST-STAIRS>)
	       (<AND <EQUAL? ,PRSI ,INTDIR>
		     <EQUAL? ,P-DIRECTION ,P?WEST>>
		<SET FOO ,WEST-STAIRS>)
	       (ELSE
		<SET FOO ,GROUND>)>
	 <PERFORM ,V?PUT ,PRSO .FOO>
	 <RTRUE>>

<ROUTINE V-TIME ()
	 <TELL "Tickity tockity, sprickity sprockety." CR>>

<ROUTINE PRE-COMPARE ("AUX" (FLG <>))
	 <COND (<PRSO? ,NOT-HERE-OBJECT>
		<RFALSE>)
	       (<NOT <GETP ,PRSO ,P?MAP>>
		<SET FLG T>)
	       (<NOT <EQUAL? <GETP ,PRSO ,P?MAP>
			     <GETP ,PRSI ,P?MAP>>>
		<SET FLG T>)>
	 <COND (.FLG
		<TELL "Comparisons between the " D ,PRSO " and the " D ,PRSI
		      " would not really help." CR>
		<RTRUE>)
	       (ELSE
		<RFALSE>)>>

<ROUTINE V-COMPARE ()
	 <COND (<PRSO? ,ROCK-LOCK ,STONE-KEY>
		<TELL 
"It looks as if the small cube would fit into the opening almost exactly." CR>)
	       (<EQUAL? <GETP ,PRSO ,P?MAP> 1> ;"CUPS"
		<TELL
"The two chalices are of exactly the same size and dimensions, though empty
they have different weights." CR>)
	       (<AND <EQUAL? <GETP ,PRSO ,P?MAP> 3 4> ;"Book & L AREA"
		     <EQUAL? <GETP ,PRSO ,P?MAP> <GETP ,PRSI ,P?MAP>>>
		<TELL "Looks as if the area is just big enough to hold it." CR>)
	       (<AND <EQUAL? <GETP ,PRSO ,P?MAP> 3 4> ;"Book & L AREA"
		     <NOT <EQUAL? <GETP ,PRSO ,P?MAP> <GETP ,PRSI ,P?MAP>>>>
		<TELL "Well, the match up between them wasn't made in heaven."
		      CR>)
	       (T
		<TELL "The " D ,PRSO " and the " D ,PRSI " are the same size."
		      CR>)>>

<ROUTINE V-FOO-COMPARE ()
	 <COND (<L? <GET ,P-PRSO 0> 2>
		<TELL "You have to compare the " D ,PRSO " to something else."
		      CR>
		<RTRUE>)
	       (T
	        <PERFORM ,V?COMPARE <GET ,P-PRSO 1> <GET ,P-PRSO 2>>
		<RFATAL>)>>

<ROUTINE V-WEIGH ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Tough to do without a scale." CR>)
	       (T
		<TELL "Now that's bizarre!" CR>)>>

<ROUTINE V-FILL-OUT ()
	 <COND (<NOT <EQUAL? ,PRSO ,MANUAL>>
		<TELL "There's no need for filling that out." CR>)
	       (T
		<TELL
"Okay. Find me a pen or a pencil and I'll do the best I can." CR>)>>
		     
<ROUTINE V-PLASTER-REMOVE ()
	 <COND (<AND <EQUAL? ,PRSO ,PLASTER1 ,PLASTER ,N-ANTE-SEAL>
		     <OR <EQUAL? ,PRSI ,DOORWAY ,ANNEX-DOOR ,WALLS>
			 <PRSI? ,NORTH-ANTE-DOOR ,INNER-DOOR>>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (ELSE
		<PERFORM ,V?CLEAN ,PRSO>)>>

<ROUTINE V-CHASTISE ()
	 <TELL 
"Please be more specific. LOOKing AT, BEHIND, UNDER, THROUGH, INSIDE, ON, DOWN,
FOR, or any other method of LOOKing mean different things to me. Please
specify which preposition you'd like to use next time, like LOOK AT THE " D ,PRSO ", or LOOK INSIDE THE " D ,PRSO "." CR>>

<ROUTINE V-LOOK-UP ()
	 <COND (<AND <L? ,MOVES 8>
		     <NOT <IN-A-TENT?>>>
		<TELL "You see a pretty plane. Oh boy!" CR>)
	       (<EQUAL? <LOC ,WINNER> ,COT>
		<MOVE ,WINNER ,HERE>
		<PERFORM ,V?LOOK-UP>
		<MOVE ,WINNER ,COT>
		<RTRUE>)
	       (<IN-A-TENT?>
		<TELL "You see canvas. What else?" CR>)
	       (<OR <GETP ,HERE ,P?MAP>
		    <EQUAL? ,HERE ,CHAMBER-OF-RA>>
		<TELL "You see a blue sky with wisps of billowy clouds." CR>)
	       (<OR <EQUAL? ,HERE ,BELOW-MAST ,BELOW-DECK ,AFT-CABIN>
		    <EQUAL? ,HERE ,FORE-CABIN>>
		<TELL "You see wood. What else?" CR>)
	       (<EQUAL? ,HERE ,TEMPLE-ENTER>
		<TELL "You see inky blackness." CR>)
	       (T
		<TELL "You see stones. What else?" CR>)>>

<ROUTINE V-HELP ()
	 <COND (,PRSO
		<COND (<NOT <EQUAL? ,PRSO ,WINNER>>
		       <TELL "The " D ,PRSO " doesn't need any help." CR>
		       <RTRUE>)>)>
	 <TELL "You got yourself into this -- now get yourself out of it." CR>>

<ROUTINE V-STAND-UNDER ()
	 <COND (<AND <EQUAL? ,PRSO ,CRATE ,PLANE ,PARACHUTE>
		     <IN? ,PRSO ,GLOBAL-OBJECTS>>
		<COND (<NOT <IN-A-TENT?>>
		       <TELL "It looks like that's just where you are." CR>)
		      (T
		       <TELL "Better get out of the tent first." CR>)>)
	       (T
		<TELL "You can't stand under that!" CR>)>>

<ROUTINE V-SLEEP ()
	 <COND (<IN? ,WINNER ,COT>
		<TELL 
"You close your eyes, but your mind is too active to let you sleep." CR>)
	       (<IN? ,COT ,HERE>
		<MOVE ,WINNER ,COT>
		<TELL "You get into the cot and try to get comfy. ">
		<V-SLEEP>
		<RTRUE>)
	       (,PRSO
		<TELL "That doesn't sound too comfortable to me." CR>)
	       (T
		<TELL "Better find a good place to lie down." CR>)>>

<ROUTINE V-FILL-IN ()
	 <COND (<NOT <EQUAL? ,PRSO ,HOLE ,MANUAL>>
		<TELL "I don't know how to fill in the " D ,PRSO "." CR>)
	       (<PRSO? ,HOLE>
		<TELL "Let time and Mother Nature take care of that." CR>)
	       (T
		<PERFORM ,V?FILL-OUT ,MANUAL>
		<RTRUE>)>>

<ROUTINE V-WET ()
	  <PERFORM ,V?POUR-ON ,PRSI ,PRSO>
	  <RTRUE>>

<ROUTINE V-SIT-ON ()
	 <COND (<EQUAL? ,PRSO ,CRATE>
		<TELL
"You easily weigh enough to make the crate's life-cycle far shorter than it
would have liked. Needless to say, after having been crushed flat by your
heartless attempt, it decides to move on, find what the next life-cycle has in
store for it, and vanishes into the mystical unknown." CR>
		<REMOVE ,CRATE>
		<SETG P-IT-LOC <>>
		<RTRUE>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?CLIMB-ON ,PRSO>
		<RTRUE>)
	       
	       (<EQUAL? ,PRSO ,GROUND ,SAND ,DECK>
		<TELL "No sitting down on the job, now." CR>)
	       (T
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE TBL-TO-INSIDE (OBJ TBL "OPTIONAL" STR "AUX" (OFFS 0) MAX)
	 <COND (<NOT <FSET? .OBJ ,SURFACEBIT>>
		<TELL "The " D .OBJ " is already open." CR>
		<RTRUE>)>
	 <COND (<FIRST? .OBJ>
		<OBJS-SLIDE-OFF .OBJ>)>
	 <SET MAX <GET .TBL 0>>
	 <COND (<NOT .STR>
		<TELL "Opened.">)
	       (T <TELL .STR>)>
	 <FCLEAR .OBJ ,SURFACEBIT>
	 <REPEAT ()
		 <SET OFFS <+ .OFFS 1>>
		 <COND (<G? .OFFS .MAX>
			<RETURN>)
		       (<NOT <EQUAL? <GET .TBL .OFFS> 0>>
			<MOVE <GET .TBL .OFFS> .OBJ>
			<PUT .TBL .OFFS 0>)>>
	 <COND (<FIRST? .OBJ>
		<TELL " Opening the " D .OBJ " reveals ">
		<PRINT-CONTENTS .OBJ>
		<TELL ".">)>
	 <CRLF>>

<ROUTINE INSIDE-OBJ-TO (TBL OBJ "AUX" (OFFS 0) F N)
	 <COND (<FSET? .OBJ ,SURFACEBIT>
		<TELL "The " D .OBJ " is already closed." CR>
		<RTRUE>)>
	 <FSET .OBJ ,SURFACEBIT>
	 <TELL "Closed." CR>
	 <COND (<NOT <FIRST? .OBJ>>
		<RTRUE>)>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<REMOVE .N>
			<REPEAT ()
				<SET OFFS <+ .OFFS 1>>
				<COND (<EQUAL? <GET .TBL .OFFS> 0>
				       <PUT .TBL .OFFS .N>
				       <RETURN>)>>)>>>
	       
<ROUTINE OBJS-SLIDE-OFF (OBJ "AUX" F N THERE)
	 <SET THERE <LOC .OBJ>>
	 <COND (<EQUAL? .THERE ,WINNER>
		<SET THERE ,HERE>)>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<MOVE .N .THERE>)>>
	 <TELL "Everything on the " D .OBJ " slides off its top." CR>
	 <CRLF>>

<ROUTINE V-JUMP-ROPE ()
	 <COND (<NOT <EQUAL? ,PRSO ,ROPE>>
		<TELL "I can jump rope, and that's about all." CR>)
	       (T
		<TELL "Well, it takes all kinds of weirdos..." CR>)>>

<ROUTINE EMPTY-THE (OBJ "OPTIONAL" (BURN? T) "AUX" F N (FLG <>))
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (T
			<SET N .F>
			<SET F <NEXT? .N>>
			<COND (<AND <EQUAL? ,HERE ,WEST-END-OF-PASSAGE>
				    <NOT <FSET? ,PIT ,INVISIBLE>>>
			       <REMOVE .N>
			       <SET FLG 1>)
			      (T
			       <MOVE .N ,HERE>
			       <SET FLG 2>)>)>>
	 <COND (<NOT .FLG>
		<RTRUE>)
	       (T
		<TELL " Whatever was inside the " D .OBJ>
		<COND (<EQUAL? .FLG 1>
		       <TELL " has fallen out." CR>)
		      (<EQUAL? .FLG 2>
		       <TELL " falls into the pit." CR>)>)>>
		
		