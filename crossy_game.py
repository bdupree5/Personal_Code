#pygame

#library
import pygame


#sets title for the game 
SCREEN_TITLE = "Crossy RPG"
#start with building the screen, need the width and height of the screen
SCREEN_WIDTH = 800 #not reccommended to go over 1000
SCREN_HEIGHT = 800


#make the color of the screen, screen is covered by the background picture 
#these will be tuples of red green and blue values different combos gets different colors(RGB(Red, Green,Black))
WHITE_COLOR = (255,255,255)#pure white RGB
BLACK_COLOR = (0,0,0)#pure black RGB

#add clock variable
clock = pygame.time.Clock()
#font 
pygame.font.init()
font = pygame.font.SysFont("comicsans",75)

class Game:

    #frames
    TICK_RATE = 60

    #initalizer for the game class to set up the width height and title
    def __init__(self,image_path, title, width,height):
        self.title = title
        self.width = width
        self.height = height

        #Creats a new game window and stores in variable game screen
        #window is stored in game_screen, pass in width and height
        self.game_screen = pygame.display.set_mode((width,height))
        #Fills the screen with the color specified
        self.game_screen.fill(WHITE_COLOR)
        #display title on screen
        pygame.display.set_caption(title)

        backgournd_image = pygame.image.load(image_path)
        self.image = pygame.transform.scale(backgournd_image,(width,height))
    
    def run_game_loop(self,level_speed):
        #determines if game is over 
        is_game_over = False
        did_win = False
        direction = 0

        #enemy and player character models and locations
        player_character = PlayerCharacter('player.png',375,700,50,50)
       
        enemy_1 =EnemyCharacter("enemy.png",20,600,50,50)
        enemy_1.SPEED *= level_speed

        enemy_2 =EnemyCharacter("enemy.png",self.width - 40,450,50,50)
        enemy_2.SPEED *= level_speed

        enemy_3 =EnemyCharacter("enemy.png",20,200,50,50)
        enemy_3.SPEED *= level_speed

        treasure = Gameobject("treasure.png",375,50,50,50)
        #while loop to keep game running until user hits x icon
        while not is_game_over:
        #spacing matters 
        #event is a built in function that gets all the inputs, so if event is = to QUIT then make game over true and exit
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    is_game_over = True
                #Detect when key is pressed down
                elif event.type == pygame.KEYDOWN:
                    #move up if up key pressed
                    if event.key == pygame.K_UP:
                        direction = 1
                    #move down if down key pressed 
                    elif event.key == pygame.K_DOWN:
                        direction = -1
                #detect when key is released 
                elif event.type == pygame.KEYUP:
                    #Stop movement when key no longer pressed
                    if event.key == pygame.K_UP or event.key == pygame.K_DOWN:
                        direction = 0
                #shows everything happening in the terminal
                print(event)

            #Redraw the white screen
            self.game_screen.fill(WHITE_COLOR)
            self.game_screen.blit(self.image,(0,0))
            #draw treasure 
            treasure.draw(self.game_screen)
            #update the player position
            player_character.move(direction,self.height)
            #draw the player at the new position
            player_character.draw(self.game_screen)

            #enemy character movement 
            enemy_1.move(self.width)
            enemy_1.draw(self.game_screen)
            
            if level_speed > 2:
                enemy_1.move(self.width)
                enemy_1.draw(self.game_screen)

            if level_speed> 4:
                enemy_2.move(self.width)
                enemy_2.draw(self.game_screen)



            #End game collision
            if player_character.detect_collision(enemy_1):
                is_game_over = True
                did_win = False 
                text = font.render("You lost!",True,BLACK_COLOR)
                self.game_screen.blit(text,(300,350)) # not callable?
                pygame.display.update()
                clock.tick(1)
                break
            elif player_character.detect_collision(treasure):
                is_game_over = True
                did_win = True
                text = font.render("You won!",True,BLACK_COLOR)
                self.game_screen.blit(text,(300,350))
                pygame.display.update()
                clock.tick(1)
                break

            #this will update all the graphics
            pygame.display.update()
            #renders next frame
            clock.tick(self.TICK_RATE)
        if did_win:
            self.run_game_loop(level_speed+0.2)
        else:
            return

class Gameobject:

    def __init__(self,image_path,x,y,width,height):
        object_image = pygame.image.load(image_path)
        #scale the image up
        self.image = pygame.transform.scale(object_image,(width,height))

        self.x_pos = x
        self.y_pos = y

        self.width = width
        self.height = height

        #adds custom images into your game
        self.image = pygame.transform.scale(object_image,(width,height))
    #draw the object by blitting it onto the background (game screen)
    def draw(self, background):
        background.blit(self.image,(self.x_pos,self.y_pos))

#Class to represent the character controlled by the player
class PlayerCharacter(Gameobject):
    SPEED = 10 #How many tiles the character moves per second

    def __init__(self,image_path,x,y,width,height):
        super().__init__(image_path,x,y,width,height)
    #opposite movements up and down/ Move function will move character up if direction > 0 and down if < 0
    def move(self,direction,max_height):
        #Takes care of opp move, aka if -5 is called go up vice versa
        if direction > 0:
            self.y_pos -= self.SPEED
        elif direction < 0:
            self.y_pos += self.SPEED
            #make sure the character never goes past the bottom of the screen
        if self.y_pos >= max_height - 40:#40 is the 40 pos on the screen
            self.y_pos = max_height - 40

    #returns false until collision is met then its true
    def detect_collision(self,other_body):
        #checks for overlap on x and y & width & height
        if self.y_pos > other_body.y_pos + other_body.height:
            return False 
        elif self.y_pos + self.height < other_body.y_pos:
            return False
        if self.x_pos > other_body.x_pos + other_body.width:
            return False
        elif self.x_pos + self.width < other_body.x_pos:
            return False

        return True


#Class to represent the enemy controlled by AI
class EnemyCharacter(Gameobject):
    SPEED = 10 #How many tiles the character moves per second

    def __init__(self,image_path,x,y,width,height):
        super().__init__(image_path,x,y,width,height)
    #opposite movements up and down/ Move function will move character up if direction > 0 and down if < 0
    #enemy bounds
    def move(self,max_width):
        if self.x_pos <= 20:
            self.SPEED = abs(self.SPEED)
        elif self.x_pos >= max_width - 40:
            self.SPEED = -abs(self.SPEED)
        self.x_pos += self.SPEED
       
            

#initalize pygame which allows us to run pygame code.
pygame.init()

new_game = Game("background.png",SCREEN_TITLE,SCREEN_WIDTH,SCREN_HEIGHT)
new_game.run_game_loop(1)





#Exit the game
pygame.quit()
quit()



          








