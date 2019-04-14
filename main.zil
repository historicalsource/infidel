"MAIN for
		           INFIDEL
	Copyright 1983 Infocom, Inc.  All Rights Reserved.
"

<GLOBAL PLAYER <>>

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>
 
<CONSTANT M-HANDLED 1>   
 
<CONSTANT M-NOT-HANDLED <>>   
 
<CONSTANT M-OBJECT <>>

<CONSTANT M-BEG 1>  
 
<CONSTANT M-END 6> 
 
<CONSTANT M-ENTER 2>
 
<CONSTANT M-LOOK 3> 
 
<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<ROUTINE GO () 
;"put interrupts on clock chain"
	 <RANDOMIZE-HOLES>
	 <ENABLE <QUEUE I-GINANDTONIC -1>>
	 <ENABLE <QUEUE I-PARACHUTE -1>>
	 <ENABLE <QUEUE I-GROWL -1>>
	 <REMOVE ,WATER>
;"set up and go"
	 <SETG LIT T>
	 <SETG WINNER ,ADVENTURER>
	 <SETG PLAYER ,WINNER>
	 <SETG HERE ,TENT>
	 <SETG P-IT-LOC ,HERE>
	 <SETG P-IT-OBJECT <>>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<TELL ,START-STR CR>
		<CRLF>
		<V-VERSION>
		<CRLF>)>
	 <MOVE ,WINNER ,COT>
	 <V-LOOK>
	 <MAIN-LOOP>
	 <AGAIN>>    


<ROUTINE MAIN-LOOP ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP) 
   #DECL ((CNT OCNT ICNT NUM) FIX (V) <OR 'T FIX FALSE> (OBJ) <OR FALSE OBJECT>
	  (OBJ1) OBJECT (TBL) TABLE (PTBL) <OR FALSE ATOM>)
   <REPEAT ()
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET NUM
		 <COND (<0? <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>> .OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<0? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <NOT .OBJ> <1? .ICNT>> <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<==? ,PRSA ,V?WALK> <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<0? .NUM>
		   <COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <TELL "It's too dark to see." CR>)
			 (T
;"** M"			  <COND (.OBJ
				 <COND (<AND <FSET? .OBJ ,CONTBIT>
					     <NOT <FSET? .OBJ ,OPENBIT>>>
					<TELL "Better open the " D .OBJ
					      " first." CR>
					<THIS-IS-IT .OBJ>
					<SET V <>>)
				       (<NOT <FSET? .OBJ ,CONTBIT>>
					<TELL "There's nothing in that." CR>
					<SET V <>>)
				       (T
					<TELL "It's not in that." CR>
					<SET V <>>)>) 
			        (T
				 <TELL "There isn't anything to ">
				 <SET TMP <GET ,P-ITBL ,P-VERBN>>
				 <COND (,P-OFLAG
					<PRINTB <GET .TMP 0>>)
				       (T
					<WORD-PRINT <GETB .TMP 2>
						    <GETB .TMP 3>>)>
				 <TELL "!" CR>
				 <SET V <>>)>)>)
		  (T
		   <SETG P-NOT-HERE 0>
		   <SETG P-MULT <>>
		   <COND (<G? .NUM 1> <SETG P-MULT T>)>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
				  <COND (<G? ,P-NOT-HERE 0>
					 <TELL "The ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
						<TELL "other ">)>
					 <TELL "object">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "s">)>
					 <TELL " that you mentioned ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "are">)
					       (T <TELL "is">)>
					 <TELL "n't here." CR>)
					(<NOT .TMP>
					 <TELL 
"I don't know what you're referring to." CR>)>
				  <RETURN>)
				 (T
				  <COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
					(T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
				  <SETG PRSO <COND (.PTBL .OBJ1) (T .OBJ)>>
				  <SETG PRSI <COND (.PTBL .OBJ) (T .OBJ1)>>
				  <COND (<VERB? COMPARE> T)
					(<G? .NUM 1>
					 <COND (<EQUAL? .OBJ1
							 ,NOT-HERE-OBJECT>
						 <SETG P-NOT-HERE
						       <+ ,P-NOT-HERE 1>>
						 <AGAIN>)
						(<AND <VERB? TAKE>
						      ,PRSI
						      <EQUAL? <GET <GET ,P-ITBL
									,P-NC1>
								   0>
							      ,W?ALL>
						      <NOT <IN? ,PRSO ,PRSI>>>
						 <AGAIN>)
						(<AND <EQUAL? ,P-GETFLAGS
							      ,P-ALL>
						      <VERB? TAKE>
						      <OR <AND <NOT <EQUAL?
								    <LOC .OBJ1>
								     ,WINNER
								     ,HERE>>
							       <NOT <FSET?
								    <LOC .OBJ1>
								   ,TRANSBIT>>>
							  <FSET? .OBJ1
								 ,DONTTAKE>
							  <EQUAL? .OBJ1
								  ,PLASTER
								  ,PLASTER1>>>
						 <AGAIN>)
						(<AND <EQUAL? ,P-GETFLAGS
							      ,P-ALL>
						      <VERB? DROP>
						      <NOT <IN? .OBJ1 ,WINNER>>
						      <NOT <IN? ,P-IT-OBJECT
								,WINNER>>>
						 <AGAIN>)
						(T
						 <COND (<EQUAL? .OBJ1 ,IT>
							<PRINTD ,P-IT-OBJECT>)
						       (T <PRINTD .OBJ1>)>
						 <TELL ": ">)>)>
				  <SET TMP T>
				  <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
				  <COND (<==? .V ,M-FATAL> <RETURN>)>)>>)>
	    <COND (<NOT <==? .V ,M-FATAL>>
		   ;<COND (<==? <LOC ,WINNER> ,PRSO>
			  <SETG PRSO <>>)>
		   ;"Removing this code should fix the problem that AGAIN
		     loses when in a vehicle and it is the PRSO."
		   <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	    <COND (<VERB? AGAIN WALK SAVE RESTORE SCORE VERSION WAIT> T)
		  (T
		   <SETG L-PRSA ,PRSA>
		   <SETG L-PRSO ,PRSO>
		   <SETG L-PRSI ,PRSI>)>
	    <COND (<==? .V ,M-FATAL> <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE SAVE VERSION> T)
		  (T <SET V <CLOCKER>>)>)>>>
 
<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>

<GLOBAL L-PRSA <>>  
 
<GLOBAL L-PRSO <>>  
 
<GLOBAL L-PRSI <>>  

%<COND (<GASSIGNED? PREDGEN>

'<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V) ANY)
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <EQUAL? ,IT .I .O>
		    <NOT <EQUAL? ,P-IT-LOC ,HERE>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <EQUAL? ,PRSI ,IT>> <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>
	       <SETG P-IT-LOC ,HERE>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND
		(<SET V <APPLY <GETP ,WINNER ,P?ACTION>>> .V)
		(<SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>> .V)
		(<SET V <APPLY <GET ,PREACTIONS .A>>> .V)
		(<AND .I <SET V <APPLY <GETP .I ,P?ACTION>>>> .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <LOC .O>
		      <SET V <APPLY <GETP <LOC .O> ,P?CONTFCN>>>>
		 .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <SET V <APPLY <GETP .O ,P?ACTION>>>>
		 .V)
		(<SET V <APPLY <GET ,ACTIONS .A>>> .V)>)>
	<COND (<NOT <==? .V ,M-FATAL>>
	       <COND (<==? <LOC ,WINNER> ,PRSO>
		      <SETG PRSO <>>)>
	       <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>)
       (T
	
'<PROG ()

<SETG PDEBUG <>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V) ANY)
	<COND (,PDEBUG
	       <TELL "** PERFORM: PRSA = ">
	       <PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>
	       <COND (<AND .O <NOT <==? .A ,V?WALK>>>
		      <TELL " | PRSO = " D .O>)>
	       <COND (.I <TELL " | PRSI = " D .I>)>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <EQUAL? ,IT .I .O>
		    <NOT <EQUAL? ,P-IT-LOC ,HERE>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <EQUAL? ,PRSI ,IT>> <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>
	       <SETG P-IT-LOC ,HERE>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND (<SET V <D-APPLY "Actor"
				      <GETP ,WINNER ,P?ACTION>>> .V)
		     (<SET V <D-APPLY "Room (M-BEG)"
				      <GETP <LOC ,WINNER> ,P?ACTION>
				      ,M-BEG>> .V)
		     (<SET V <D-APPLY "Preaction"
				      <GET ,PREACTIONS .A>>> .V)
		     (<AND .I <SET V <D-APPLY "PRSI"
					      <GETP .I ,P?ACTION>>>> .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <LOC .O>
			   <SET V <D-APPLY "Container"
					   <GETP <LOC .O> ,P?CONTFCN>>>>
		      .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO"
					   <GETP .O ,P?ACTION>>>>
		      .V)
		     (<SET V <D-APPLY <>
				      <GET ,ACTIONS .A>>> .V)>)>
	<COND (<NOT <==? .V ,M-FATAL>>
	       <COND (<==? <LOC ,WINNER> ,PRSO>
		      <SETG PRSO <>>)>
	       <SET V <D-APPLY "Room (M-END)"
			       <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<DEFINE D-APPLY (STR FCN "OPTIONAL" FOO "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,PDEBUG
		      <COND (<NOT .STR>
			     <TELL CR "  Default ->" CR>)
			    (T <TELL CR "  " .STR " -> ">)>)>
	       <SET RES
		    <COND (<ASSIGNED? FOO>
			   <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       <COND (<AND ,PDEBUG .STR>
		      <COND (<==? .RES 2>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

>)>  
 
<GLOBAL START-STR
"You wake slowly, sit up in your bunk, look around the tent, and try to ignore
the pounding in your head, the cottony taste in your mouth, and the ache in
your stomach. The droning of a plane's engine breaks the stillness and you
realize that things outside are quiet -- too quiet. You know that this can
mean only one thing: your workmen have deserted you. They complained over the
last few weeks, grumbling about the small pay and lack of food, and your
inability to locate the pyramid. And after what you stupidly did yesterday,
trying to make them work on a holy day, their leaving is understandable.|
|
The Professor's map was just an ancient map -- as worthless as an ice cube in
the Arctic without an instrument fine enough to accurately measure longitude
and latitude. You knew that the site was nearby. You dug, and you ordered the
workers to dig, even without the box. As you listen to the plane and rub your
aching eyes, you pray they left you supplies enough to find the pyramid and to
survive, and that the plane's carrying the long-overdue box.">