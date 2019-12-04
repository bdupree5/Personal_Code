;Alberto Jimenez
;Brandon DuPree
;Attacking simulator 

INCLUDE Irvine32.inc		;used for certian calls

.386
ExitProcess proto, dwExitCode:dword ;Exit protocal

.data
;Menu, not implimented, Wanted too but not enough time
menu0 byte" ___________________________________________",0dh,0ah,
		  "|  _____________           _________        |",0dh,0ah,
		  "| |   Player	   |		 |	Enemy  |	   |",0dh,0ah,
		  "| |	 Health    |         |	Health |       |",0dh,0ah,0;end first srting of the menu
menu1 byte"| |	 Attack    |         |  Attack |       |",0dh,0ah,
		  "| |_____________|         |_________|       |",0dh,0ah,
		  "|										   |",0dh,0ah,
		  "|___________________________________________|",0 ;end the second string of the menu


;String variables, for story 
story_start byte "Welcome to RPG Adventure part 2.",0dh,0ah,
"Where this time around we just go sraight into the action",0dh,0ah,
"Were we left last off you picked up a book and you thought it saved the world.",0dh,0ah,
"It turns out that instead, it turned people turned into Gnomes!!",0dh,0ah,
"The only way to stop this is to slay the Gnomes!!",0dh,0ah,0

pick_weapon byte "Pick your weapon of choosing, or dont. We cant force you to do anything.",0dh,0ah,
"Dagger = D",0dh,0ah,
"Axe = A",0dh,0ah,
"Bow = B",0dh,0ah,
"Longsword = L",0dh,0ah,
"You pick Nothing = N",0dh,0ah,0

welcome byte "Welcome to the limited dungeon. Here you will fight Enemies untill you die or you run out of turns.",0dh,0ah,
"You will be struck by lighting if you die or run out of turns.",0dh,0ah,
"Tough luck.",0dh,0ah,0

monster_approach byte "A small gnome approaches you, hes pissed. He knows you turned him into a gnome!",0dh,0ah,
"You didn't expect him to surprise you, he stabs you in your calf!",0dh,0ah,0

rebuttle byte "With your bleeding calf, You attack the little bastard.(A)",0dh,0ah,0

;Loop Strings
hero_turn byte"You attack!",0dh,0ah,0
gnome_turn byte "The Gnome attaks!" ,0dh,0ah,0

;Weapon choice strings
pick_dagger byte"This thing is rusty, good luck surviving.",0dh,0ah,0
pick_axe byte"For the viking in you.",0dh,0ah,0
pick_bow byte"I mean, its not the best but its better than the dagger.",0dh,0ah,0
pick_longsword byte"Excellent choice, the long sword does the most damage.",0dh,0ah,0

;Weapon Variables 
dagger    dword 5
axe       dword 15
bow       dword 8
longsword dword 20

;stats & Hero and Monster
hero  byte "Hero life . . .",0
gnome byte "Gnome life . . . ",0
new_space byte " ",0dh,0ah,0 ;lol


life_hero   dword 100
attack_hero dword ?

life_gnome dword 100
gnome_attack dword 15

;misc, used for the screen, if i can get it to work, not used
rows byte ?
cols byte ?

;Death Messages
pick_nothing byte "So you decided to pick nothing. No Problem",0dh,0ah,
"Lightning strikes you. You are dead.",0dh,0ah,0

dead_gnome byte "So you killed a small gnome. Bet you feel pretty big and mighty.",0dh,0ah,
"Turns out killing him turned you into a gnome too!",0dh,0ah,
"Back us up on Kickstarter!",0dh,0ah,0
dead_hero byte "The gnome killed the mighty hero. What a shame.",0dh,0ah,
"Back us up on Kickstarter!",0dh,0ah,0

.code
main PROC 
	;Gets height and width of screen
	call GetMaxXY
	mov rows, dh
	mov cols, dl

	;Story Start 
	call ClrScr
	mov edx, offset story_start
	call WriteString
	call WaitMsg
		
	;Weapon Choice 
	call ClrScr
	mov edx, offset pick_weapon
	call WriteString

	inputChecking:				;Input Checking, for the checker in you
	call ReadChar				;Gets input from user to decide weapon choice 

	;Compare statements to decide which, weapon damage is stored in BL register 
	cmp al,"D"
	mov ebx, dagger
	mov attack_hero, ebx
	je Dagger_

	cmp al,"A"
	mov ebx,axe
	mov attack_hero, ebx
	je Axe_

	cmp al,"B"
	mov ebx,bow
	mov attack_hero,ebx
	je Bow_

	cmp al,"L"
	mov ebx,longsword
	mov attack_hero,ebx
	je LongSword_

	cmp al,"N"
	je quit

	jmp inputChecking		;if you dont pick the choice it jmps back to the start and you have to choose 

	Dagger_:
	call ClrScr
	mov edx, offset pick_dagger 
	call WriteString
	call WaitMsg
	jmp limited_dungeon

	Axe_:
	call ClrScr
	mov edx, offset pick_axe
	call WriteString
	call WaitMsg
	jmp limited_dungeon

	Bow_:
	call ClrScr
	mov edx, offset pick_bow
	call WriteString
	call WaitMsg
	jmp limited_dungeon

	LongSword_:
	call ClrScr
	mov edx, offset pick_longsword
	call WriteString
	call WaitMsg 
	jmp limited_dungeon
	
	;used for the main loop to constantly kill creature until you die 
	;you get 5 turns for demo sake to kill a gnome. Got it?
	limited_dungeon:
	call ClrScr
	mov edx, offset welcome				;Welcome message
	call WriteString
	call WaitMsg 

	call ClrScr
	mov edx, offset monster_approach	;lol, i just find it funny
	call WriteString
	call WaitMsg
	;call rebuttle, then we start the attacking 
	call ClrScr
	mov edx, offset rebuttle
	call WriteString
	call WaitMsg

	cmp al,"A"							;attack
	je start_attack_phase

										;Temporary until i think of something else 

	;Main attack phase 
	start_attack_phase:
	call ClrScr							;Clear before battle starts 
	mov cl,5							;start loop with 5 so it doesn't take to long 
	mov eax,100							;temp life start 
	mov life_gnome, eax					;temp life start

;Loop Start
L1:
	;Hero attacks
	mov edx, offset hero_turn			
	call WriteString
	mov ebx, attack_hero				;Example
	sub life_gnome,ebx					;100 - 20 for sword
	mov eax,life_gnome					;store 80 into eax
	mov life_gnome,eax					;store 80 into the gnomes life
	cmp life_gnome,0					;if gnome life is zero jump to gnome dying quit selection
	je quit2

	mov edx, offset gnome				;States new health of gnome
	call WriteString					;Write out gnome followed by the number 
	call WriteDec
	mov edx, offset new_space			;added for new line return after decimal
	call WriteString					;States new health of gnome
	
	call WaitMsg
	mov edx, offset new_space			;added for new line return after decimal
	call WriteString		

	;Gnome attacks now
	mov edx, offset gnome_turn			
	call WriteString					;Example
	mov edi,gnome_attack				;store attack in register 
	sub life_hero,edi					;hero life should be 85.
	mov eax, life_hero
	mov life_hero,eax
	
	mov edx, offset hero				;Hero attacks message
	call WriteString
	call WriteDec						;added for new line return after decimal
	mov edx, offset new_space			
	call WriteString					;States new health of hero

	dec CL								;decrement cl so we can count down what were doing 
	jnz L1								;jumps back to L1 if its not zero

	jmp quit3


	invoke ExitProcess,0
main ENDP
;Quit Procedure
quit PROC
	call ClrScr
	mov edx, offset pick_nothing
	call WriteString
	mov edx, offset new_space			
	call WriteString	
	call WaitMsg
	invoke ExitProcess,0
quit ENDP

quit2 PROC
	call ClrScr
	mov edx, offset dead_gnome
	call WriteString
	mov edx, offset new_space			
	call WriteString	
	call WaitMsg
	invoke ExitProcess,0
quit2 ENDP

quit3 PROC
	call ClrScr
	mov edx, offset dead_hero
	call WriteString
	mov edx, offset new_space			
	call WriteString	
	call WaitMsg
	invoke ExitProcess,0
quit3 ENDP




end main