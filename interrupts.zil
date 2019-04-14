"INTERRUPTS for
			      INFIDEL
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

;"		
		Interrupt Routines for
			PYRAMID"

<GLOBAL RING-COUNTER 0>

<ROUTINE I-RING-KILL ()
	 <SETG RING-COUNTER <+ ,RING-COUNTER 1>>
	 <COND (<EQUAL? ,RING-COUNTER 3>
		<TELL 
"You're starting to feel a little woozy. You blink your eyes, but can't seem
to focus correctly. You think you see Craige standing by a wall." CR>)
	       (<EQUAL? ,RING-COUNTER 5>
		<TELL
"Your ring finger is starting to throb painfully." CR>)
	       (<G? ,RING-COUNTER 7>
		<JIGS-UP
"You fall over on your face as a quick-acting poison from the ring makes its
way to your heart. Bye!">)>>

<ROUTINE I-GINANDTONIC ()
	 <COND (<G? ,THIRST 400>
		<JIGS-UP
"Like a grape, left out in the sun too long, you turn into a raisin for lack of
water.">)
	       (<AND <G? ,THIRST 380>
		     <L? ,THIRST 387>>
		<SETG NILE-DRINKS 0>
		<TELL
"If you don't drink something, and now, you're gonna be history." CR>)
	       (<AND <G? ,THIRST 300>
		     <L? ,THIRST 317>>
		<SETG NILE-DRINKS 0>
		<COND (<NOT <ROOM? ,TENT ,TENT2 ,SUPPLY-TENT>>
		       <TELL "You'd better drink something, and soon!" CR>)
		      (T
		       <TELL "You wipe your fevered brow." CR>)>)
	       (<AND <G? ,THIRST 200>
		     <L? ,THIRST 217>>
		<SETG NILE-DRINKS 0>
		<COND (<NOT <ROOM? ,TENT ,TENT2 ,SUPPLY-TENT>>
		       <TELL 
"You scowl at the sun, cursing its searing heat." CR>)
		      (T
		       <TELL 
"Even in the tent the heat starts to get to you." CR>)>)>>

<ROUTINE I-MATCH-OUT ("OPTIONAL" BLOWN? "AUX" (FLG <>))
	 <COND (<FSET? ,ONE-MATCH ,FLAMEBIT>
		<COND (<NOT .BLOWN?>
		       <TELL "Your match went out.">)
		      (.BLOWN?
		       <TELL "You blow out the match and toss it aside.">)>
		<SET FLG T>)>
	 <FCLEAR ,ONE-MATCH ,ONBIT>
	 <FCLEAR ,ONE-MATCH ,FLAMEBIT>
	 <FCLEAR ,MANY-MATCHES ,FLAMEBIT>
	 <COND (<AND <IN? ,ONE-MATCH ,WINNER>
		     <NOT .BLOWN?>>
		<TELL " And it burned your fingers, too! You drop it. ">
		<BUT-WHERE?>
		<SET FLG <>>)>
	 <MOVE ,ONE-MATCH ,GLOBAL-OBJECTS>
	 <COND (,LIT
		<SETG LIT <LIT? ,HERE>>)>
	 <COND (<NOT <SETG LIT <LIT? ,HERE>>>
		<TELL " It is now pitch black.">
		<SET FLG T>)>
	 <COND (.FLG
		<CRLF>)>>

<ROUTINE I-TORCH ("AUX" (FLG <>))
	 <SETG TORCH-TURNS <+ ,TORCH-TURNS 1>>
	 <COND (<NOT ,OILED-TORCH>
		<TELL "Your torch is too dry and burns itself out quickly." CR>
		<KILL-TORCH>
		<SET FLG T>)>
	 <COND (<OR <IN? ,TORCH ,WINNER>
		    <EQUAL? <LOC ,TORCH> <LOC ,WINNER>>>
		<COND (<EQUAL? ,TORCH-TURNS 150>
		       <TELL "Your torch is beginning to sputter." CR>
		       <SET FLG T>)
		      (<EQUAL? ,TORCH-TURNS 162>
		       <TELL "Your torch is getting very, very dim." CR>
		       <SET FLG T>)
		      (<EQUAL? ,TORCH-TURNS 175>
		<TELL "With a final blaze of glory, your torch goes out." CR>
		       <KILL-TORCH>
		       <SET FLG T>)>)
	       (<G? ,TORCH-TURNS 174>
		<KILL-TORCH>)>
	 .FLG>

<ROUTINE KILL-TORCH ("OPTIONAL" (IN-SLAB? <>))
	 <FCLEAR ,TORCH ,ONBIT>
	 <FCLEAR ,TORCH ,FLAMEBIT>
	 <COND (<NOT .IN-SLAB?>
		<SETG OIL-SOAKED <>>
		<SETG OILED-TORCH <>>
		<SETG TORCH-TURNS 0>)>
	 <COND (,LIT
		<SETG LIT <LIT? ,HERE>>)>
	 <COND (<NOT <SETG LIT <LIT? ,HERE>>>
		<TELL "It is now pitch black." CR>)>
	 <DISABLE <INT I-TORCH>>>

<ROUTINE I-RESET-STATUES ("AUX" (CHECK-OFF 0) (COUNTER 0)
			   (CLEAR-OFF 0) (FLG <>) STR)
	 <REPEAT ()
		 <COND (<EQUAL? .CHECK-OFF 4>
			<RETURN>)
		       (T
			<SET CHECK-OFF <+ .CHECK-OFF 1>>
			<COND (<OR <NOT <EQUAL? <GET ,ORDER-LTBL .CHECK-OFF>
					    <GET ,TURNED-LTBL .CHECK-OFF>>>
				   <FSET? <GET ,TURNED-LTBL .CHECK-OFF>
					  ,CLAMPBIT>> 
			       <SETG TURN-OFFSET 0>
			       <REPEAT ()
				       <SET CLEAR-OFF <+ .CLEAR-OFF 1>>
				       <COND (<EQUAL? .CLEAR-OFF 5>
					      <RETURN>)>
				       <PUT ,TURNED-LTBL .CLEAR-OFF <>>
				       <COND (<NOT <FSET? <GET ,STATUE-TBL
							  <- .CLEAR-OFF 1>>
						     ,CLAMPBIT>>
					      <SET COUNTER <+ .COUNTER 1>>)>
				       <FSET <GET ,STATUE-TBL <- .CLEAR-OFF 1>>
					     ,CLAMPBIT>>
			       <SET STR <GET ,NUM-TBL .COUNTER>>
			       <COND (<NOT .COUNTER>
				      <TELL
"A loud click comes from beneath the four statues as they clamp down on the
cover again." CR>)
				     (T
				      <TELL "The " .STR " statue">
				      <COND (<G? .COUNTER 1>
					     <TELL
"s, heavy though they are, effortlessly swing back in unison to clamp down on the quartz cover again." CR>)
					    (T
					     <TELL
", heavy though it is, effortlessly swings back to clamp down on the quartz cover again." CR>)>)>
			       <SET FLG T>
			       <RETURN>)>)>>
	 <COND (<NOT .FLG> ;"order was correct"
		<TELL 
"The statues freeze in their current positions and you hear a light click come
from the cover of the sarcophagus." CR>
		<SETG CAN-TURN-STATUES <>>
	        <SETG STATUES-SET T>
		<SETG SCORE <+ ,SCORE 35>>)>>
		
<GLOBAL HUNGER 0>

<ROUTINE I-GROWL ()
	 <SETG HUNGER <+ ,HUNGER 1>>
	 <COND (<AND <G? ,HUNGER 70>
		     <L? ,HUNGER 73>>
		<TELL "Your stomach growls in hunger." CR>)
	       (<AND <G? ,HUNGER 100>
		     <L? ,HUNGER 103>>
		<TELL 
"You feel yourself growing weaker. Without nourishment, this is a losing
cause!" CR>)
	       (<G? ,HUNGER 140>
		<JIGS-UP
"You fall over on your face, dreaming of Thanksgiving dinner. Needless to say,
it was you against hunger. And hunger won.">)>> 

<ROUTINE I-PARACHUTE ()
	 <COND (<L? ,MOVES 3>
		<COND (<IN-A-TENT?>
		       <TELL CR 
"You hear a plane flying high overhead, outside the tent." CR>)
		      (T
		       <TELL CR 
"You crane your neck and see a plane, high overhead, circling the encampment." CR>)>
		<RTRUE>)
	       (<L? ,MOVES 5>
		<COND (<IN-A-TENT?>
		       <TELL CR "It sounds as if the plane is circling." CR>)
		      (T
		       <TELL CR 
"The plane seems to be circling right overhead." CR>)>
		<RTRUE>)
	       (<EQUAL? ,MOVES 5>
		<COND (<NOT <IN-A-TENT?>>
		       <TELL CR 
"You look up to see a small speck appear right beneath the plane -- probably a
parachute. The plane heads off far to the northwest, dipping its wings in a
salute." CR>)
		      (T
		       <TELL CR "It sounds as if the plane is flying off." CR>)>
		<RTRUE>)
	       (<EQUAL? ,MOVES 6>
		<COND (<NOT <IN-A-TENT?>>
		       <TELL CR 
"A small speck descending from the plane overhead gets larger until you see a
crate, dangling from a parachute." CR>)
		      (T
		       <TELL CR "You can barely hear the plane." CR>)>
		<RTRUE>)
	       (<EQUAL? ,MOVES 7>
		<COND (<IN-A-TENT?>
		       <MOVE ,CRATE <PICK-ONE ,ROOM-LTBL>>
		       <TELL CR
"The sound of something heavy landing comes from nearby." CR>)
		      (T
		       <TELL CR 
"At last, your luck seems to be changing. A large crate lands right before you,
its parachute flapping in the breeze. The parachute breaks away from the crate
and drifts off in the wind." CR>
		       <MOVE ,CRATE ,HERE>)>
		<FSET ,CRATE ,VEHBIT>
		<DISABLE <INT I-PARACHUTE>>
		<RTRUE>)>>
		 
<ROUTINE IN-A-TENT? ("OPTIONAL" (COT-TOO? T))
	 <COND (.COT-TOO?
		<COND (<OR <EQUAL? <LOC ,WINNER> ,TENT ,TENT2 ,SUPPLY-TENT>
			   <EQUAL? <LOC ,WINNER> ,COT>>
		       <RTRUE>)
		      (T <RFALSE>)>)
	       (<NOT .COT-TOO?>
		<COND (<EQUAL? <LOC ,WINNER> ,TENT ,TENT2 ,SUPPLY-TENT>
		       <RTRUE>)
		      (ELSE <RFALSE>)>)
	       (ELSE
		<RFALSE>)>>

<GLOBAL RANDOM-ROOM-LTBL
	<LTABLE P1 P2 P3 P4 P5 P6 P7 P8 EX1 EX3 EX5 EX7 EX9
		FIRE>>

<GLOBAL ROOM-LTBL
	<LTABLE P1 P2 P3 P4 P5 P6 P7 P8 FIRE>> 

<ROUTINE RANDOMIZE-HOLES ("AUX" (OFFS 0) MAX)
	 <SET MAX <GET ,RANDOM-ROOM-LTBL 0>>
	 <REPEAT ()
		 <SET OFFS <+ .OFFS 1>>
		 <COND (<G? .OFFS .MAX>
			<RETURN>)
		       (T
			<PUTP <GET ,RANDOM-ROOM-LTBL .OFFS>
			      ,P?CAPACITY <RANDOM 2>>)>>>

<GLOBAL PYR-THIRST 0>

<ROUTINE I-PYRAMID-DRINK ()
	 <COND (<GETP ,HERE ,P?MAP>
		<DISABLE <INT I-PYRAMID-DRINK>>
		<RFALSE>)>
	 <SETG PYR-THIRST <+ ,PYR-THIRST 1>>
	 <SETG NILE-DRINKS 0>
	 <COND (<EQUAL? ,PYR-THIRST 1>
		<TELL
"Even in this pyramid, you need to drink something, and soon." CR>)
	       (<EQUAL? ,PYR-THIRST 10>
		<TELL
"Your throat feels as if it's coated with razor blades. Some water would be in
order." CR>)
	       (<EQUAL? ,PYR-THIRST 19>
		<TELL "Better drink something. NOW!" CR>)
	       (<EQUAL? ,PYR-THIRST 25>
		<JIGS-UP
"Well, your body could only take so much of this heat. Like a car, idling on a
crowded highway, your body decides it's time to overheat. Such is death.">)>>