pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- Global Variables
pet_stats = {hunger=100, energy=100, happiness=100}
money = 0
pet_name = "kissmin"
current_screen = "home"

-- Variables for the home screen
home_button = 0
is_flashing = false
pet_interaction_frame = 0

second_name = "kyouchan"
frame_count = 0

--player position
--player = {x=-48, y=64,flp=false, flip2=false, dy=0, dx=0}





-- Initialization
function _init()
  -- Set initial game state
    player={
    sp=6,
    x=59,
    y=38,
    w=2,
    h=2,
    flp=true,  
    dx=0,
    dy=0,
    max_dx=2,
    max_dy=3,
    acc=0.5,
    boost=4,
    anim=0,
    running=false,
    jumping=false,
    falling=false,
    sliding=false,
    landed=false,
    yoff=12,
    xoff = 0
  }

  gravity=0.3
  friction=0.85

  --simple camera
  cam_x=0

  --map limits
  map_start=0
  map_end=1024

  --test for drawing hitbox
  x1r=0
  y1r=0
  x2r=0
  y2r=0
end

function _update()
  -- Call update function based on current_screen
  frame_count += 1

  if current_screen == "home" then
    update_home()
  elseif current_screen == "shmup" then
    update_shmup_screen()
  elseif current_screen == "shop" then
    update_shop_screen()
  elseif current_screen == "eating" then
    update_eating_screen()
  end
end

function _draw()
  -- Call draw function based on current_screen
  if current_screen == "home" then
    draw_home()
  elseif current_screen == "shmup" then
    draw_shmup_screen()
  elseif current_screen == "shop" then 
    draw_shop_screen()
  elseif current_screen == "eating" then
    draw_eating_screen()
  end
end

-- Draw Functions
-- Note: The screen is 128x128
function draw_home()
    camera(0,0)
    cls(1)
    -- Draw a black Box to display the pet about 1/3 the height of the screen and 90% of the width--
    x_off = 9
    y_off = 9
    rectfill(x_off, y_off, 128-x_off, 50, 0)

    -- Draw the Pets name in the middlle of the scren--
    print(pet_name, 64-#pet_name*2, 55, 7)
    
    -- Bottom Rectangle for Pet stats and buttons underneath pet name--
    --rectfill(x_off, 127, 128-x_off, 30, 3)
    rectfill(x_off, y_off+55 ,128-x_off ,y_off+110, 12)
    gap = 5
    -- Inner rectangle for pet stats
    rectfill(x_off+gap, y_off+55+gap ,128-x_off -gap,y_off+100-gap-10, 0)

    -- Draw buttons for different screens -- 
    --print((128-2*x_off-4*gap)/3) --how to calculate the width of the button
    bw = 30 -- button width
    rectfill(x_off+gap,y_off+100-10,x_off+gap+bw,y_off+110-gap,0)
    rectfill(x_off+2*gap+bw,y_off+100-10,x_off+2*gap+2*bw,y_off+110-gap,0)
    rectfill(x_off+3*gap+2*bw,y_off+100-10,x_off+3*gap+3*bw,y_off+110-gap,0)
    
    -- Draw the stats of the pet
    text_off = 3
    print("hunger: "..pet_stats.hunger, x_off+gap+text_off, y_off+57+gap, 7)
    print("energy: "..pet_stats.energy, x_off+gap+text_off, y_off+56+gap+10, 7)
    print("happiness: "..pet_stats.happiness, x_off+gap+text_off, y_off+54+gap+20, 7)
    --print("money: "..money, x_off+gap, y_off+55+gap+30, 7)

    -- Draw the pet in the black box
    --  spr(n, x, y, [w=1], [h=1], [flip_x=0], [flip_y=0])
    spr(3, 64-5, 25, 1, 2)


    -- Highlight the current screen button
    -- Highlight the current screen button

    if frame_count % 10 == 0 then
        is_flashing = not is_flashing
        
    end


    --print(home_button, 40, 40, 7)

    if is_flashing then
      
      if home_button == 0 then -- go to the shop
        rect(x_off+gap-1, y_off+100-10-1, x_off+gap+bw+1, y_off+110-gap+1, 7)
      
      elseif home_button == 1 then -- go to the shmup game
        rect(x_off+2*gap+bw-1, y_off+100-10-1, x_off+2*gap+2*bw+1, y_off+110-gap+1, 7)
      
      elseif home_button == 2 then -- go to the eating screen
        rect(x_off+3*gap+2*bw-1, y_off+100-10-1, x_off+3*gap+3*bw+1, y_off+110-gap+1, 7)

      elseif home_button == 3 then
      -- Draw a flashing rectangle around the the pet 
        rect(x_off-1, y_off-1, 128-x_off+1, 50+1, 7)
        
      end
    end
  
  -- draw pet interactions 
  if pet_interaction_frame > 0 then
    pet_interaction_frame -= 1
    -- Draw a speech bubble from the pet

    spr(162, 64-17, 13, 3, 2)
  end

end

   

function draw_shmup_screen()
  -- Draw screen 1
  -- the main character is sprite 6, his position should be a variable, so he can move
  cls()
  map(0,0)
  spr(player.sp,player.x,player.y,player.w,player.h,player.flp)
  --draw hitbox
  rect(x1r,y1r,x2r,y2r,8)
end

-- Similar update functions for other screens
function update_shmup_screen()
  --physics
  player.dy+=gravity
  player.dx*=friction

  --controls
  if btn(⬅️) then
    player.dx-=player.acc
    player.running=true
    player.flp=false
  end
  if btn(➡️) then
    player.dx+=player.acc
    player.running=true
    player.flp=true
  end

  --slide
  if player.running
  and not btn(⬅️)
  and not btn(➡️)
  and not player.falling
  and not player.jumping then
    player.running=false
    player.sliding=true
  end

  --jump
  if btnp(❎)
  and player.landed then
    player.dy-=player.boost
    player.landed=false
  end

  --check collision up and down
  if player.dy>0 then
    player.falling=true
    player.landed=false
    player.jumping=false

    player.dy=limit_speed(player.dy,player.max_dy)

    if collide_map(player,"down",0) then
      player.landed=true
      player.falling=false
      player.dy=0
      player.y-=((player.y+player.h*8)%8)-1
    end
  elseif player.dy<0 then
    player.jumping=true
    if collide_map(player,"up",1) then
      player.dy=0
    end
  end

  --check collision left and right
  if player.dx<0 then

    player.dx=limit_speed(player.dx,player.max_dx)

    if collide_map(player,"left",1) then
      player.dx=0
    end
  elseif player.dx>0 then

    player.dx=limit_speed(player.dx,player.max_dx)

    if collide_map(player,"right",1) then
      player.dx=0
    end
  end

  --stop sliding
  if player.sliding then
    if abs(player.dx)<.2
    or player.running then
      player.dx=0
      player.sliding=false
    end
  end

  player.x+=player.dx
  player.y+=player.dy

  --limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
    player.x=map_end-player.w
  end


  -- Camera logic
  -- Ensure camera follows the player smoothly and stays within bounds
  cam_x = player.x - 64  -- Center camera on player
  cam_x = max(cam_x, map_start)  -- Clamp camera to the left edge
  cam_x = min(cam_x, map_end - 128)  -- Clamp camera to the right edge
  camera(cam_x, 0)
end

function draw_shop_screen()
  -- Draw screen 2
  print("shop screen", 40, 40, 7)
end
-- Similar draw functions for other screens

function draw_eating_screen()
  -- Draw screen 3
  print("eating screen", 40, 40, 7)
end

-- Update Functions
function update_home()
  -- Update logic for home screen if needed
  -- Check for button presses

  -- up button is pressed
  if btnp(2) then
    home_button = 3
  end

  -- down button is pressed and home_button is 3
  if home_button == 3 and btnp(3) then
    home_button = 0
  end

  -- Left and right cyles through the buttons 1-3
  
  if btnp(1) and home_button < 3 then 
      home_button = abs(home_button+1)%3
  end
  
  if btnp(0) and home_button < 3 then 
      home_button = abs(home_button-1)%3
  end

  -- A button is pressed
  if btnp(4) then
    if home_button == 0 then
      cls()
      current_screen = "shop"
    elseif home_button == 1 then
      cls()
      current_screen = "shmup"
    elseif home_button == 2 then
      cls()
      current_screen = "eating"
    elseif home_button == 3 then
      -- make a global variable to keep track of the number of frames
      pet_interaction_frame = 30
    
    end
  end
end


function update_shop_screen()
  -- Update logic for shop screen if needed
  -- if B button is pressed, go back to home screen
  if btnp(5) then
    cls()
    current_screen = "home"
  end
end

function update_eating_screen()
  -- Update logic for eating screen if needed
  if btnp(5) then
    cls()
    current_screen = "home"
  end
end

-- Input Handling
function handle_input()
  -- Check for user input and update current_screen or call button actions
end
-- Initialize game
_init()

function collide_map(obj,aim,flag)
 --obj = table needs x,y,w,h
 --aim = left,right,up,down

 local x=obj.x  local y=obj.y
 local w=obj.w*8  local h=obj.h*8

 local x1=0	 local y1=0
 local x2=0  local y2=0

 if aim=="left" then
   x1=x-1      y1=y+10
   x2=x        y2=y+h-2

 elseif aim=="right" then
   x1=x+w-1    y1=y+10
   x2=x+w      y2=y+h-2

 elseif aim=="up" then
   x1=x+5      y1=y-1
   x2=x+w-5    y2=y

 elseif aim=="down" then
   x1=x+5      y1=y+h
   x2=x+w-5    y2=y+h
 end

 x1r = x1
 y1r = y1
 x2r = x2
 y2r = y2

 --pixels to tiles
 x1/=8    y1/=8
 x2/=8    y2/=8

 if fget(mget(x1,y1), flag)
 or fget(mget(x1,y2), flag)
 or fget(mget(x2,y1), flag)
 or fget(mget(x2,y2), flag) then
   return true
 else
   return false
 end

end

function limit_speed(num,maximum)
  return mid(-maximum,num,maximum)
end

__gfx__
0000000000000000000000000000000000000000000000000000000000000000eeeeeeee00000000d666666d0000000000000000000000000000000000000000
0000000000aaaa00000000000000000000000000000000000000000000000000e8e8eeee00000000d666666d0000000000aaaaaa000000000007777770000000
007007000aaaaaa0000000000000000000000004444440000000000000000000ee8eeeee00000000d666666d0000000000aaaaaa000000000007777770000000
000770000aaaaaa0000000000000000000000044444444000000000000000000eeeeeeee00000000d666666d000000000055a55a000000000007777770000000
00077000070a70a00000000000000000000000444444440000000d0d00000000eeeeeeee00000000d666666d000000000aa999aa000000000077777770000000
007007000a999aa0000000000aaaaaa000000544074407d00000060600000000eeee8e8e0000000066666666000000000aaa9aaaa00000000077777777000000
000000000aa99aaaaa000000070a07a00000054444f0445000000ddd00000000eeeee8ee00000000666666660000000000aaaaaa000000000007777770000000
000000000aaaaaaaaa000000077a77a000005544440f045d000000d600004000eeeeeeee00000000ddd66ddd00000000aaaaaaa7aa0000000777777777700000
00000000000aaaaaaaaa0000aa999aa00000554444444455000000d0000000008888888800000000ddd66ddd0000000090777977000000000707777770000000
0000000000aaaaaaaaaa0000aaa9aaaa0000004444444440000044440aaaaa008888888805600000ddd66ddd0000000099977990000000000777777700000000
0000000000aaaaaaaaa000000aaaaaa0000004444444444000044444475aaa008888e88806600000ddd66ddd0000000000000000000000000000000000000000
0000000000aaaaaaaaa0000aaaaaaa7aa000040444444440000444449aaaaa008888888800000000ddd66ddd0000000000000000000000000000000000000000
000000000009aa9aa0000009077797700000000444444400000754444aaaaa008e88888800000000ddd66ddd0000000000000000000000000000000000000000
00000000000900900000000999779900000000044444440000f44444455577708888888800000000ddd66ddd0000000000000000000000000000000000000000
0000000000990099000000000000000000000004000004000ff44444455550008888888800000000ddd66ddd0000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000ff4444444555500888888e800000000ddd66ddd0000000000000000000000000000000000000000
dddddddd66666666666666660000000000000000666666d600000d0d000000000000000000000000ddd66ddd0000000000000000000000000000000000000000
dd6dddd6666666d66d666d6600088800000000006666666600000606000000000000008880000000ddd66ddd0000000000000000000000000000000000000000
ddddddddd666d6666666666d66888880000000006ddddddd00000ddd000000000006688888000000ddd66ddd0000000000000000000000000000000000000000
dddddddddd666666666666dd00aaaaaa0000000066666666000000d60088800000000aaaaaa00000ddd66ddd0000000000000000000000000000000000000000
dddd6ddddddddddddddddddd0070a07a00000000666666d6000000d06688880000000aaaaaa00000ddd66ddd0000000000000000000000000000000000000000
dddddddddddddddddddddddd0077a77a0000000066666666000044440aaaaa000000055a55a00000ddd66ddd0000000000000000000000000000000000000000
dddddddddddddddddddddddd0aa999aa000000006ddddddd00044444470aaa000000aa999aa00000d666666d0000000000000000000000000000000000000000
dddddddddddddddddddddddd0aaa9aaaa000000066666666000444449aaaaa000000aaa9aaaa0000d666666d0000000000000000000000000000000000000000
00000000000000006262222100aaaaaa0000000066666666000704444aaaaa0000000aaaaaa000000000000011111111000c0121000000000000000000000000
000000000000000011555155aaaaaaa7aa000000d6dddddd00f4444445557770000aaaaaaa7aa0000000000011111611c001c1c0000000000000000000000000
0000000000000000111111119077779700000000d6dddddd0ff444444555500000090777797000000000000066555111c0111011000000000000000000000000
0000000000000000222222619997779900000000d6ddd6dd0ff4444444555500000999777990000000000000dd5dd1160001100c000000000000000000000000
0000000055500000111111110000000000000000dddddddd00000000000555000000000000000000000000001d6dd5112001c001000e0e000aaaa00000000000
0000000000500aa0111111120000000000000000dddddddd0000000000000000000000000000000000000000dddd6151000110000000e000aaaaaa0000000000
00000000005aaa00555222210000008080000000dddddddd0000080800000000000000000000000770000000ddddd1dd000000010000000aaaaaaaa0e0e00000
000000000aaaaa00115551110000008e80000000d6dddddd00000e0e00000000000000000000007777770000dddddddd000001010000000a77aa77a00e000000
000000000aaaaa000000000000aaaaaa0000000000000000000008880000000000000000808007777557000000000000000000000000000a70aa07a000000000
00000000a7a0a005000000000070a07a00000000000000000000008e00008080000000008e8007775507000000000008880000000000000aaa99aaa000000000
00000000a7aaaa55000000000077a77a00000000000000000000008000008e800000aaaaaa0007750000000000000088088800000000aa9aaa44aaa9aaa00000
8e00ee88aaa8a850000000000aa999aa0000000000000000000004440aaaaa000000aaaaaa0007700000077757777880002800000000aaa9aaaaaa99aaa00000
8eeee888aaaa8a00000000000aaa9aaaa00000000000000000044444470aaa00000055a55a0007707777000077077777002280000000aaaaaaaaaaaaaa000000
00ee888aa0aaaa0000000000000eeeee0000000000000000000444449aaaaa00000aa999aa00077000777777770777777777700000000aa9a9aaaaaaaa000000
0088888aa0aaaa00050000000aee8e8eea000000000000000007044448eeee00000aaa9aaaa0077000775700770572775700700000000aaaaaaaaaaaa0000000
0e888888aa00aaa555000000090ee8e9000000000000000000f444444555777000000eeeee000770077557077705727757777080000000aaa9aaaaaaa0000000
0ee888800aaaaaaaa00000000999777990000000000000000ff4444445555000000aee8e8eea0077777557775505707787828880000000aaaaaaaaaaa0000000
0008880000aaaaa0000000000000000000000000000000000ff444444455550000090ee8e90000077700000000057057070008200000000a9aaaaa9a00000000
00088000005000000000000000000000000000000000000000000000000555000009997779900000000000000000005007777000000000009aaaaa9000000000
00088000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099000009900000000
00000000050000000000000000044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000444444440000000000000000000909000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000005570a07a455000000000000000000a0a0000000000000000000000000000000000aaaa00000000000000aaaa0000000000000000
0000000000000000000000055477a77a455000000000000000000999000000000000000000000000000000000aaaaaa000000000000aaaaaa000000000000000
0000000000000077000000054aa999aa45550000000000000000009a00000000000000444444000000000000aaaaaaaa0000000000aaaaaaaa00000000000000
0000000000777777700000004aaa9aaaa5550000000000000000009000000000000004444444400000000000aaaaaaaa0000000000a77aa77a00000000000000
000000000077777777000000444444444400000000000000000004440444455000055aaaaaa4550000000000a55aa55a0000000000a70aa07a00000000000000
000000000777c7777700000000044444000000000000000000044444470a44550055455a55a4550000000000aaa99aaa0000000000aaa99aaa00000000000000
00000000777cc777777000000a4444444a000000000000000004444492aa44000054aa999aa4555000000000aaa44aaa0000000000aaa44aaa00000000000000
000000007771cc777770000009044449450000000000000000070444424444500004aaa9aaaa55500000000aaaaaaaaaa00000000aaaaaaaaaa0000000000000
000000007771cc7cc777000009997779945000000000000000f444444555777000044444444440000000aaaaaaaaaaaaaaaa00aaaaaaaaaaaaaaaa0000000000
000000006771117cc77700000000000000000000000000000ff444444555500000000044444000000000aaaa9a9aaaaaaaaa00aaaa9a9aaaaaaaaa0000000000
000000006771177c177700000000000000000000000000000ff44444445555000000a4444444a00000000aaaaaaaaaaaaaa0000aaaaaaaaaaaaaa00000000000
000000000677777c17770000000000000000000000000000000000000005550000009044449450000000000aaa9aaaaaa00000000aaa9aaaaaa0000000000000
000000007777777117770000000000000000000000000000000000000000000000009997779945000000000aaaaaaaaaa00000000aaaaaaaaaa0000000000000
0000000077706676766000000000000000000000000000000000000000000000000000000000000000000000a9aaaa9a0000000000a9aaaa9a00000000000000
000000077000000000000000000000000000000000000000000000000000000000000000000000000000000009aaaa90000000000009aaaa9000000000000000
00000007000000000000000000000000000000000000000000000000000000000000000000000000000000009900009900000000009900009900000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000007777777777777777777777777777777777777777777777777700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700
00000000000000000000000000000000000000000000000000000000000000000000000000007555500000000000000000000000000000000000000000000700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055700
00000000000000000000000000000550000000000000000000000000000000000000000000007555555006600000000000000000000000066660000005555700
00000002a00202020202020252525252020200008181818181818181818181818181818181818100000000660000000000000000000000666665555555555700
000000088888ee0000000000000555500000aaa0a000000000000000000000000000000000007555555566666000007777770000000000666665555555555700
00000002a10202020202020253020253020200008181818181818181818181818181818181818100000000666000077777777000000000666555555555555700
00000008888888000000055500000000000000000000000000888880000000000000000000007055555566660000777777777700000000066655555555555700
00000002a10202020202020202020202020200008181818181808080808080808081818181818100000000600000777777777700000000006605555555555700
00000000088e00000000005550000000000000000000000000888880000000000000000000007000000000000000775777577700000000000000555555550700
00000002a20202020202020202020202020200008181818181808080808080808081818181818100000000000000775777577700000000000000000000000700
00000000000000000000000555000000000000000000000000888880000000000000000000007000000000000000777777777700000000000000000000000700
00000002020202121212122222220202020200008181818181818181818181818181818181818100000000000000777666667700000000000000000000000700
00000000000000000000000000000000000000000000000000088800000000000000000000007000000000000000777666667700000000000000000000000700
00000002020202020202020202020202020200008181818181818181818181818181818181818100000000000000777777777777770000000000000000770700
00000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000007777777777770000000000000000770700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777777766600000000000000000707700
000000055555dd000000000777777770000000888888000000000000000000000000000000007000000000000007777777776677770000000000000000707700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000077776dd6777770000000000000000770700
0000000555555500000000777777777770000888888800000000000000000008800000000000700000000000005006666dddd777770050000000000000070700
0000008080808080808080808080808080800000000000000000000000000000000000000000000000000000005077766766d777770050007000000000070700
00000000055d0000000077777777777777000888888800000000000000000008888000000000700007000007605077777776dd77775550077000000000070700
00000080808080808080808080808080808000000000000000000000000000000000000000000000000000706655555777777d77555666676766666776666700
00000000000000000000777775555777700008888888000088888880000008888888000000007066666666666666666ddddddddddddd66666666666666666700
00000080808080818181818181818080808000000000000000000000000000000000000000000000000000666666666dddddddddddd666666666666666666700
0000000000000000000006777777776600000888888800088888888800088888880000000000766766656666666666666dddddddd66666666666676676656700
00000080808080528181818181528080808000000000000000000000000000000000000000000000000000666666666666666666666666666666666666666700
00000030000000000000000000777000000008888800000088888880000888888000000000007777777777777777777777777777777777777777777777777700
00000080808080808080808080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000006bbbb030000000000000077000000000000000000000000000000888800000000000000000000000000000000000000000000000000000000000000000
00000080808080808080808080808080808000000000000000000000000000000000000000000000000000777777777777777777777777777777777777777700
00003013333bb00000000000000000000000666666000000000000000000000ddd00000000007666666666666666666666666666666666666600000000000700
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000666666666666dddddddddd66666660000000000700
00000633333355600000000000000000000ccccc11000006777777000000006dddd600000000766666666686666666666dddddddddddd6666666070000000700
0000066767775660000000000fff0000000ccccc11000006777763000000066111dd00000000766666666686666666661dddddddddddd1666666670000000700
000000666666660000000000fffff000000d5cc7110000335555733000006621d10000000000766666666686666666611ddddddddddd11166666676000000700
000000000000000000000000fffff000000c5577110000333333355000066ddd11000000000076666555668666666611dddddd1ddddd11116666666760070700
000000000000000000000000fffff000000c55771100000333333500000dd1dd2d000000000076665555666666661111d66ddd111ddd11111666566676700700
000000000000000000000000fff7f000000c07701100000035335000000ddddd2000000000007655555556861111111dd6666dd66666d1111666666676700700
0000000000a0000000000000fff7f0000007ee7d1100000000000000000ddddd0000000000007555555556611111111dd7711dd77117d1111666666666666700
000000000000aaa00a000000ff77f000000cc55d1000000000000000000dddd00000000000007555555556611177777ddd777dd7777dd1111166666666666700
0000000000aaaaa0a00000000fff0000000cc55d0000000000000000000000000000000000007555555556611170707ddddd6666dddddd111166666686666700
0000000000aaaaaaaaa0000000000000000000000000000000000000000000000000000000007555555566666676677dddd661166ddddd11116ddd6686666700
00000000a0aaaaaaa00000000000000000000000000000000000000000000000000000000000755555556667777767777d6666116ddddd111ddddd6686666700
000000000aaaaaaaaa000000000000000000000000000000000000000000000000000000000075555556666677777777dd666666dddddd66dddddd6686666700
000000000aaaaaaaaaa0000000000000000000000000000000000000000000000000000000007555556666666d66dd777dddddddddddd6dddddddd6666666700
000000000aaaaaaaaaa00000000000000000000000000000000000000000000000000000000075566666666667766777dddddddddddddddddddddd6686666700
0000000000aaaaaaaa000000000000000000000000000000000000000000000000000000000076666666666675777775ddddddddddddddddddddd66666666700
000000000000000000000000000000000000000000000000000044440000000000000000000076666676666665577755dddddddddddddddddddd666666666700
0000000000000000000000000000000000000000000000000000444400000000000000000000766666666666dddddddddddddddddddddddddddd666665556700
00000000000000000000000000000000000000000000000000002992000000000000000000007666666666ddddddddddddddddddddddddddddd6666555556700
000000000000001100000000000d66d6000000000555000000004444d0d000000000000000007666666666ddddddddddddddddddddddddd66666666555555700
000000000000011110000000000dd6d6000000000505000000054444ddd000000000000000007667666666ddddddddd66ddddddddddddddd6666666555555700
0000000000001111110000000000d660000000000505000000554ff45c00000000000000000076676776666ddddddd666ddddddddddddddd6666666555555700
00000000000006666000000000006660000000008585800000554ff45d000000000000000000766767666666dddd6666dddddddddddddddd6666666555555700
000000000000066660000000000aaaaa0000000088888000000000000000000000000000000076666666666666666666dddddddddddddddd6666666555555700
000000000000067760000000000a7a7a0000000088888000000000000000000000000000000076666666566666666666ddddddddddddddddd666666655555700
000000000000067760000000000a999a0000000088888000000000000000000000000000000076666666666666666666ddddddddddddddddd666666655555700
00000000000000000000000000000000000000000000000000000000000000000000000000007777777777777777777777777777777777777777777777777700
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b
3b003c3c3c0000000000000000003c3c0000000000003c000000000000003c3c0000000000003c3c3c3c3c3c3c3c3c3c0000000000003c3c003c3c00003c3c3c3c3c3c000000000000003c3c3c3c3c003c3c3c0000003c3c3c3c002d2d3c2d3c002d2d2d2d3c3c3c0000003c3c3c3c3c3c0000003c3c3c3c3c3c3c3c3c3c3c3b
3200003c000000000000000000003c00000000000000000000000000000000000000000000000000003c3c3c3c000000000000000000000000000000003c3c3c3c003c000000000000003c3c003c000000003c000000003c2d2d002d2d3c2d2d002d2d2d2d003c000000003c3c00000000000000000000003c3c3c3c3c3c3c3b
3200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003c0000000000000000000000000000000000000000002d2d2d0000002c2c2c2d2d2d2d2d000000000000000000000000000000000000000000003c3c3c32
32000000000000000000003b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002d2d2d2d2d2d2d2d2d2d2d2d2d2d2d00000000000000000000000000000000000000000000000032
3b3c000000000000003b3b3b000000000000000000003b3b3b000000000000000000000000000000000000000000000000000000003b3b0000000000000000000000000000000000000000000000000000000000000000002d2d2d3b3b3b3b3b3b3b3b3b3b3b2d3b3b3b00000000000000000000000000000000000000000032
013c000000433b3b3b3b3b3b3b3b0000003b003b00003b3b3b000000000000000000000000000000003b3b00000000000000000000000000000000003b000000000000000000000000000000003b000000000000000000002d2d3b3b3b3b3b3b3b3b3b3b3b3b2d3b3b3b3b000000000000000000000000000000000000000032
113c3c00003b3b3b3b3b3b3b3b3b0000003b003b00003b3b3b3b0000000000003b0000000000000000000000003b3b3b0000000000000000000000003b000000000000003b00000000000000003b3b00003b00003b3b00002d3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b0000000000000000000000000000000000000032
3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b
__sfx__
0059002036550315302f5502e5503055037530335402d5402d5303354035550305502d530305403353036532305302a530275302c5502d560285702557026560295502d5402f5403054033540335402e5502c550
001400002a0502a0502c050340502d0502a05032050350503005033050320503105031050300502f050000002f0502e050000002d050000002c050000002c050000002b0502b050000002b0502a0502a0502a050
0010000021050200501f050000001e0501d0501c05000000000001b050000001a0500000000000190500000000000000001805000000000001805000000000001805000000000000000000000170500000000000
001000002605024050230502405025050250502505025050240502405023050230502205021050210502105020050200502005021050210502105020050200502005020050200501f0501f0501f0501f0501f050
001000000205002050020500205002050020500105000000010500000001050000000105000000010500000002050000000205000000000000205000000030500000003050000000405005050050500505006050
001400002561001610266101c610026102561024610026102161000610006101e6101d61020610016101f6101f610006101f610216101e61007610006101c61019610206101a6101f610006101e610206101a610
00140000372503225035250362503a2503d25032250312503a2503d250000003725036250382503b2500000000000372500000035250000000000034250000000000037250362500000000000372500000000000
001000000645006450064500545005450044500445006450064500645000000000002a450294502845025450224501f4501b45018450134500e4500b450084500645005450000000445003450000000245002450
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000000000000003a2100000000000000002e21000000000002b2100000035210000003a210000000000000000292100000000000332100000000000000003021000000000000000035210000000000000000
001800001801018010180101801013010180101801018010180101801014010180101801015010170101601017010170101701017010170101901016010150101601016010160101601019010160101901016010
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001e00002b7102a7102a7102a7102a7102a7102b7102a7102a7102a7102a7102a7102a7102a7102a7102a7102a7102a7102a7102a710297102971028710287102871028710287102871028710287102871028710
002300003205035050310502e0502e050310503405035050340502c0502d0502e050320503305034050320502e0502b0502c0502f050320503205033050320502d05029050280502c05031050340503405033050
001500000954000040095400004008540095400855000050085600006008560000600756000060085600006008560000600856000060085600006008560000600856000060085600006008560000600756000060
000800001655016550165501655000000165501655016550155501555015550155501455000000000001355013550135501255000000125500000011550000001155000000105501055010550105501055010550
000f000010150141501b150231502b15032150361503415032150331503415034150331502f3502e35031350363503035025350273502a3502c3502f3503135032350333502b35025350283502b3502e35030350
00050000083500f3501b350283503835037350323502b3501b3500f4500f450033000330003300033000330003300033000330003300033000330003300033000230002300023000230002300023000230001300
001000000000000000000000255004550075500c5501055014550185501e55023550275502c5502d5502d5502d550295002a5002a500000002a500000002a5000000000000295002850027500265002350021500
00020000000000a450094500945008450074500745006450064500545004450044500345003450024500245002450156000000000000156001560000000156000000015600000000000000000156000000000000
00030000000000f3500c3500a35008350073500635005350043500f3000f3000f3000f3000f3000f3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000133500e3500b3500935007350063500535005350053500535005300053000530005300053000530006300063001730000000183001930019300193000000000000000000000000000000000000000000
0005000000000000001f0502205027050280502d0502e3002e3002f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
002000001885000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
06 01020304
00 05060744
00 090a4344
03 0f105144
03 11534344
00 13424344
00 14424344
00 15424344
00 16424344
00 17424344
00 18424344
00 19424344

