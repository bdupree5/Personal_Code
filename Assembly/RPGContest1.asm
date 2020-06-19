;Brandon DuPree
;Albtero Jimenez
;Irvine library gave constant Trojan errors and didn't let me compile or continue exection
;of the program. I just allowed the trojans, my own code so i didn't see the harm
;Just something weird that we encountered 
;sources http://programming.msjc.edu/asm/help/index.html

INCLUDE Irvine32.inc		;used for certian calls

.386
ExitProcess proto,dwExitCode:dword

COMMENT !
Not sure how to do hero name inside strings, update it for new one 

!

;Need ReadChar to read user input and WriteString to display it. 
;use Clrscr to get new text to show and Delay 1000 = 1 sec

.data
;Story Strings, ending string in null char
hero_greeting BYTE "Hello traveler, what is your name? ",0	
gretting_msg BYTE "Nice to meet you. Are you ready to embark in this dangerous adventure?",0dh,0ah,0
;not implimented 
adventure_start BYTE "Beware for this will be dangerous and every choice will impact your story!"	

;Chapter 1 Strings 
ch_one_scene_one BYTE "You wake up at a shoreline in a deserted Island with a small knife attached to your belt.",0ah,0ah,
"You can't remember how you got there, but you must hurry, a storm is brewing in the horizon!",0dh,0ah,
"What will you do? Will you make a shelter on the shore? (S) or will you make your way inland in an attempt to find shelter? (I)",0dh,0ah,
"Or do nothing. . .(N) ",0dh,0ah,0
ch_one_opt1 BYTE  "You begin to build your shelter but the storm hits you faster than expected, your shelter gets detroyed and you have no choice but to go inland.",0dh,0ah,0
ch_one_opt2 BYTE "You adventure into the jungle in search for shelter... ",0dh,0ah,0
ch_one_end BYTE "Once Inland, you discover a small cave with a faint light coming from it, you approach it and realize that there is a small fire that has almost gone out.",0dh,0ah,
"You sit by it to wait the storm out, wondering, who made this fire...?",0dh,0ah,0

;Chapter 2 Strings 
ch_two_scene_one BYTE "While waiting by the fire, you hear a creaking noise from one of the cave walls, you look and notice that a small passage has opened.",0dh,0ah,
"Do you investigate the passage? (P) or do you run into the storm and take your chances.(C) ",0
ch_two_opt1 BYTE "You get closer to the passage and notice a strange odor coimg out of it, you take out your knife as precaution and proceed into the unknown.",0dh,0ah,0
ch_two_opt2 BYTE "You run outside the cave and into the storm, you hear thunder and suddenly evrything lights up around you, You have been struck by lightning.",0dh,0ah,0

;Chapter 3 Strings
ch_three_scene_one BYTE"As you walk through the passage, the odor gets stronger, however, you proceed.",0dh,0ah,
"You begin to notice a faint light at the end of the corridor, and as you approach it, you can make out a humanesque figure.",0dh,0ah,0
ch_three_scene_two BYTE "You finally make it close enough to the source of the light that you can distingish the figure standing by it, it is an Orc! ",0dh,0ah,
"You realize its too late to turn back since he has spotted you, and you must decide what to do, will you face him in battle? (B) or will you try to run past him and try to find a possible escape? (E)",0dh,0ah,0
ch_three_opt1 BYTE "You take out your knife and wait for the Orc's attack, fortunatelly the Orc is big and clumsy, and he trips over while running at you, which gives you the chance to use your knife to defeat your opponent.",0dh,0ah,
"You are Victorious!",0dh,0ah,0
ch_three_opt2 BYTE "You run past the Orc with blazing speed, to realize the only way of escape is a door which you realize is closed after frantically attempting to open it. ",0dh,0ah,
"You fearfully look back, however due to your sudden movements and the clumsyness of the Orc, the monster lays on the floor stabbed by his own sword, defeated! You got Lucky. ",0dh,0ah,0
       
;Chapter 4 Strings
ch_four_scene_one BYTE "You walk towards the door by the wall of the cave, and notice that it has somehow unlocked.",0dh,0ah,
"You venture through it, and inside you see an altar, with two bright books wide open.",0dh,0ah,0 
ch_four_scene_two BYTE "The book on the left emanates a darker light than the other one, and you can somehow feel negative thoughts building up inside you just from looking at it.",0dh,0ah,
"The other book shines bright and warm, you can feel it calling you towards it like a warm summmer breeze",0dh,0ah,
"As you look at both books, you hear a loud voice coming out of the cave walls.",0dh,0ah,0 
ch_four_scene_three BYTE   "YOU MUST CHOOSE!!, ONE BOOK WILL GIVE YOU LIGHT, HOWEVER, IT WILL BRING DESPAIR TO MANY OTHERS",0dh,0ah,
"THE OTHER WILL SAVE THE PEOPLE OF THIS WORLD OF CERTAIN SUFFERING, HOWEVER, THE PATH WILL NOT BE SO EASY FOR YOU",0dh,0ah,
"Will you choose the dark book? (save others) (D), or the lighter book? (save yourself) (L).",0dh,0ah,0
ch_four_opt1 BYTE "You pick up the dark book, knowing that it will not lead you to much good, however you think of your loved ones and proceed.",0dh,0ah,0
ch_four_opt1_sub1 BYTE "Due to your courage throuhgout this adventure, the book shines bright as you pick it up, and after a bright light, you appear back at the beach.",0dh,0ah,
"The storm has passed, and you can see by the shore a boat with its engine running ready for you.",0dh,0ah,
"Congratulations, you have escaped and saved the people of earth.",0dh,0ah,0
COMMENT !
ch_four_opt1_sub2 BYTE "Due to your lack of courageous choices in this adventure, the book decides to hold back, it faintly glows and you appear back at the beach.",0dh,0ah,
"The storm remains around you, and you can see by the shore a boat in poor condition but running.",0dh,0ah,
"You hop on it and begin to make your way out of the island knowing that the path ahead of you will be tough, but knowing that you made the right choice.",0dh,0ah,
"Congratulations, you have escaped and saved the people of earth, however, you will struggle fighting your destiny in the forseable future.",0dh,0ah,0
!
ch_four_opt2 BYTE "You pick up the light book, knowing that it will lead you to much good, even if it will hurt the rest.",0dh,0ah,0
ch_four_opt2_sub1 BYTE "Due to your lack courage throuhgout this adventure, the book shines bright as you pick it up, and after a bright light, you appear back at the beach.",0dh,0ah,
"The storm has passed, and you can see a small shelter has appeared around the shore, however, you notice that the world around the island looks to be in agony.",0dh,0ah,
"You sit down in the sand contemplating how earth suffers while you can't do anything about it wondering wether you made the right choice.",0dh,0ah,0
;COMMENT ! ;comment here 
;ch_four_opt2_sub2 BYTE "Due to your courageous choices in this adventure, the book decides to hold back, it faintly glows and you appear back at the beach.",0dh,0ah,
;"The storm has passed, and you can see by the shore a boat in poor condition but running.",0dh,0ah,
;"You approach it and see a sign saying: YOU ACTED HEROIC DURING YOU ADVENTURE, HOWEVER YOU MADE THE WRONG CHOICE AT THE END, THIS BOAT GIVES YOU A CHANCE TO REMEDY YOUR CHOICES, BUT YOU WILL HAVE A HARD FUTURE, MAKE THE RIGHT CHOICE!.",0dh,0ah,
;"You hesitate, and look back at the shore where a cozy shelter has appeared for you, but you get in the boat anyways and sail into a world in need of help.",0dh,0ah,0
;!

;Quit messages will impliment later, when quit try and make screen red for updated version
quit_1 BYTE "We didn't want to go on an adventure anyway",0dh,0ah,0
death_by_light BYTE  "Lighting Stricks you. Your journey ends here.",0dh,0ah,0
;choice strings IF I HAD ONE 

;holds maximum chars to read, is in conjunction with hero name and player choice
MAX = 50								;hold 50 chars 
hero_name BYTE ?						;Holds heros names 

;stat variables in newer version, for updated version add player health, maybe attack stats 

.code
main PROC

	call ClrScr						;Clears screen
	mov edx,offset hero_greeting	;move into edx
	call WriteString				;Writes string to the screen

	mov edx, offset hero_name		;store hero name inside edx
	mov ecx, MAX					;move # of chars into ecx
	Call ReadString					;Reads input

	mov eax,1000					;delay by 1 seconds
	call Delay						;allows for people to read before zooming away

	call ClrScr						;clear screen to let more text be shown without clutter
	mov edx,offset gretting_msg		;asks hero if hes ready, if yes continue story if not quit
	call Writestring				;output gretting message 

	call ReadChar					;Reads choice for yes or no

	cmp al,'Y'						;compare statement to see if they say yes 
	je ChapterONE					;jump to ch start

	;not working with ReadString, But I want it to show the choice, work on in new version 
	cmp al,'N'						;compare statement to see if they say no
	je quit							;jump to quit if they don't wanna play
	
	mov eax,1000					;delay by 1 seconds
	call Delay		

	call ClrScr						;clear screen
	mov edx,offset adventure_start
	call WriteString

	call ChapterONE					;calls chapter one to be executed`
	;maybe make a quit procedure, that goes to quit and ends, implemented it and it doesn't work 
	
	quit:							;quit for saying no to adventure
	call ClrScr
	mov edx, offset quit_1			;quit message for not wanting to adventure 
	call WriteString
	call EndStory					;end if they dont want to adventure

	ret								;end main
	
main ENDP

ChapterONE PROC USES edx

	call Clrscr
	mov edx,offset ch_one_scene_one		
	call WriteString

	call ReadChar						
			
	cmp al,'S'							;build shelter then destroyed
	je option_1

	cmp al,'I'							;shelter in jungle
	je option_2

	cmp al,'N'							;do nothing 
	je die_by_lightning

	;works
	option_1:
	call ClrScr							;clear before starting new scence
	mov edx,offset ch_one_opt1			;scence one
	call WriteString					;display scene
	call WaitMsg						;wait message to continue
	call ClrScr							;clear screen

	mov edx, offset ch_one_end			;call end scence 
	call WriteString					;write end scene
	call WaitMsg						;since it jumps quickly, have user decide when to go
	jmp ChapterTwo						;jump chapter 2
	;works
	option_2:
	call ClrScr
	mov edx,offset ch_one_opt2
	call WriteString
	mov eax, 6000						
	call Delay							;wait 6 seconds
	call ClrScr							;clear screen

	mov edx, offset ch_one_end			;call end scence 
	call WriteString
	call WaitMsg
	jmp ChapterTwo
	;works 
	die_by_lightning:
	call ClrScr							;its not turning red now
	;mov edx,red(black*16)				;Set color to red, indicates bad end to ur journey , fix for updated version
	;call SetTextColor		 
	mov edx, offset death_by_light
	call WriteString
	call EndStory						;end prog, cause ded

	ret

ChapterONE ENDP

;Start Chapter 2
ChapterTWO PROC uses edx
	
	call ClrScr
	mov edx,offset ch_two_scene_one
	call WriteString

	call ReadChar

	cmp al, 'P'							;go into cave 
	je option_1

	cmp al, 'C'							;take chance and ded
	je option_2
	;works
	option_1:							;cave
	call Clrscr
	mov edx,offset ch_two_opt1
	call WriteString
	call WaitMsg						;put delay message so it doesn't jmp immediatly
	jmp ChapterTHREE

	;ded, works,but the ret statement throws exception. idk why 
	option_2:			
	call Clrscr
	;mov edx,red(black*16)				;Set color to red, indicates bad end to ur journey,fix for updated version
	;call SetTextColor					;goes into first quit message too
	mov edx,offset ch_two_opt2
	call WriteString
	call WaitMsg
	
	invoke ExitProcess,0				;this actually worked 
	
ChapterTWO ENDP

ChapterTHREE PROC uses edx

	call ClrScr							;clear screen
	mov edx, offset ch_three_scene_one	;display first message from ch3
	call WriteString
	call WaitMsg						;allow for user to read the prompt
	call ClrScr							;clear before choice selection

	mov edx,offset ch_three_scene_two
	call WriteString

	call ReadChar						;read user input

	cmp al,'B'
	je option_1

	cmp al,'E'
	je option_2
	;works
	option_1:
	call ClrScr							;clear screen for new input
	mov edx, offset ch_three_opt1
	call WriteString
	call WaitMsg
	jmp ChapterFOUR						;jump to ch 4
	;works
	option_2:
	call Clrscr
	mov edx, offset ch_three_opt2
	call WriteString
	call WaitMsg
	jmp ChapterFOUR						;jump to ch 4
	
	ret
ChapterTHREE ENDP

ChapterFOUR PROC uses edx 
	;scene one
	call ClrScr							;clear screen
	mov edx, offset ch_four_scene_one	;display first message from ch4
	call WriteString					;Write message to screen
	
	call WaitMsg						;allow time for user to read
	;scene two
	call ClrScr							;clear screen
	mov edx, offset ch_four_scene_two	;display first message from ch4
	call WriteString

	call WaitMsg						;allow time for user to read

	;scene three
	call ClrScr							;clear screen
	mov edx, offset ch_four_scene_three	;display first message from ch4
	call WriteString

	call ReadChar						;user input here 

	cmp al, 'D'							;choose dark book
	je option1

	cmp al, 'L'							;choose light book
	je option2

	option1:
	call ClrScr
	mov edx,offset ch_four_opt1
	call WriteString
	
	call WaitMsg						;allow for user to read 

	jmp sub_option1
		
		sub_option1:
		call ClrScr
		mov edx, offset ch_four_opt1_sub1
		call WriteString

		call WaitMsg						;allow for user to read 

		invoke ExitProcess,0

	option2:
	call ClrScr
	mov edx,offset ch_four_opt2
	call WriteString
	
	call WaitMsg						;allow for user to read 
										;end prog hopefully
	jmp sub_option2						
		
		sub_option2:
		call ClrScr
		mov edx, offset ch_four_opt2_sub1
		call WriteString

		call WaitMsg		

		invoke ExitProcess,0

	ret
ChapterFOUR ENDP
;just used to quit, need to figure out how to make better 
EndStory PROC uses edx 

	ret

EndStory ENDP


end main