pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- Global Variables
pet_stats = {hunger=100, energy=100, happiness=100}
money = 0
pet_name = "kiissmot"
current_screen = "home"

-- Initialization
function _init()
  -- Set initial game state
end

function _update()
  -- Call update function based on current_screen
    if current_screen == "home" then
        update_home()
    elseif current_screen == "shmup" then
        update_shmup_screen()
    elseif current_screen == "shop" then
        update_shop_screen()
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
    elseif current_screen == "Eating" then
        draw_eating_screen()
    end
end


-- Draw Functions
-- Note: The screen is 128x128
function draw_home()
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
    rectfill(x_off+gap,y_off+100-10,x_off+gap+bw,y_off+110-gap,2)
    rectfill(x_off+2*gap+bw,y_off+100-10,x_off+2*gap+2*bw,y_off+110-gap,10)
    rectfill(x_off+3*gap+2*bw,y_off+100-10,x_off+3*gap+3*bw,y_off+110-gap,11)
    

  
end

function draw_shmup_screen()
  -- Draw screen 1
end

function draw_shop_screen()
  -- Draw screen 2
end
-- Similar draw functions for other screens

-- Update Functions
function update_home()
  -- Update logic for home screen if needed
end

-- Similar update functions for other screens

-- Input Handling
function handle_input()
  -- Check for user input and update current_screen or call button actions
end
-- Initialize game
_init()

__gfx__
00000000000000000000000000000000000000000000000000000d0d000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaa000000000000000000000000000000000000000606000000000000000000000000000000000000000000000000000000000000000000000000
007007000aaaaaa00000000000000000000000044444400000000ddd000000000000000000000000000000000000000000000000000000000000000000000000
000770000aaaaaa000000000000000000000004444444400000000d6000000000000000000000000000000000000000000000000000000004000000000000000
00077000070a70a000000000000000000000004444444400000000d0000000000000000000000000000000000000000000000000000000009000000000000000
007007000a999aa0000000000444444000000544074407d000004444044444000000000000000000000000000000000000000000000000009000000000000000
000000000aa99aaaaa000000070407400000054444f0445000044444470444000000000000000000000000000000000000000000000000004000000000000000
000000000aaaaaaaaa0000000774774000005544440f045d00044444924444000000000000000000000000000000000000000000000000009007777a30000000
00000000000aaaaaaaaa000044999440000055444444445500070444424444000000000000000000000000000000000000000000000000004777777330000000
0000000000aaaaaaaaaa000044494444000000444444444000f44444455577700000000000000000000000000000000000000000000000064777667f00000000
0000000000aaaaaaaaa000000444444000000444444444400ff44444455550000000000000000000000000000000000000000000000006674776667f00000000
0000000000aaaaaaaaa000044444447440000404444444400ff44444445555000000000000000000000000000000000000000000000066777766677f00000000
000000000009aa9aa000000907779770000000044444440000000000000555000000000000000000000000000000000000000000000667777660077f00000000
00000000000900900000000999779900000000044444440000000d0d0000000000000000000000000000000000000000000000000096f7766600777700000000
000000000099009900000000000000000000000400000400000006060000000000000000000000000000000000700000000000000088ff7740077e6200000000
00000000000000000000000000000000000000000000000000000ddd000000000000000000000000000000000070000000000000008fff664077777200000000
000000000000000000000000000000000000000000000000000000d6008880000000000000000000000000000700000000000000000ffff04777662000000000
000000000000000000000000000888000000000000000000000000d06688880000000000000000000000778788880ee0000000000007e5757ee6667000000000
0000000000000000000000006688888000000000000000000000444404444400000000000000000000887088eeeeee00000000000005e6627666620000000000
0000000000000000000000000444444000000000000000000004444447044400000000000000000008e88888880000000000000000000e22e222257f08000000
00000000000000000000000000704074000000000000000000044444924444000000000000000008eeeeeee88000000000000000000005522255577f78900000
0000000000000000000000000077477400000000000000000007044442444400000000000000008e7ee888800000000000000000000000000455657777800000
00000000000000000000000004499944000000000000000000f4444445557770000000000000008ee77788000000000000000000000000000665667767770000
0000000000000000000000000444944440000000000000000ff4444445555000000000000000008eeeeee8000000000000000000000000007666a87767777000
0000000000000000000000000044444400000000000000000ff4444444555500000000000000008e8888e8000000000000000000000000007676a87677ff7000
0000000000000000000000004444444744000000000000000000000000055500000000000000008ee88888000000000000000000000000000ee6666677f78000
00000000000000000000000090777797000000000000000000000000000000000000000000000088e888878000ee000000000000000000000f2e006667778000
00000000000000000000000099977799000000000000000000000808000000000000000000000008ee77778000ee0000000000000000000000500200667f7000
00000000555000000000000000000000000000000000000000000e0e00000000000000000000000008ee8ee000ee000000000000000000000040028866670000
0000000000500aa00000000000000000000000000000000000000888000000000000000000000000008eee888eeee00000000000000000002040022666670000
00000000005aaa00000000000000008080000000000000000000008e00008080000000000000000000088888880eee0000000000000000ef2220078667600000
000000000aaaaa00000000000000008e80000000000000000000008000008e800000000000000000000080000000eee000000000000000ee2226666777000000
000000000aaaaa0000000000004444440000000000000000000004440444440000000000000000000000000000000ee000000000000000eee2667ff770000000
00000000a7a0a0050000000000704074000000000000000000044444470444000000000000000000000000000000000000000000000000007777777700000000
00000000a7aaaa550000000000774774000000000000000000044444924444000000000000000000000000000000000000000000000000000050000000000000
8e00ee88aaa8a850000000000449994400000000000000000007044442eeee000000000000000000000000000000000000000000000000000040000000000000
8eeee888aaaa8a000000000004449444400000000000000000f44444455577700000000000000000000000000000000000000000000000000040000000000000
00ee888aa0aaaa0000000000000eeeee00000000000000000ff44444455550000000000000000000000000000000000000000000000000000040000000000000
0088888aa0aaaa000500000004ee8e8ee4000000000000000ff44444445555000000000000000000000000000000000000000000000000000040000000000000
0e888888aa00aaa555000000090ee8e9000000000000000000000909000055000000000000000000000000000000000000000000000000000040000000000000
0ee888800aaaaaaaa000000009997779900000000000000000000a0a000000000000000000000000000000000000000000000000000000000040000000000000
0008880000aaaaa00000000000000000000000000000000000000999000000000000000000000000000000000000000000000000000000000000000000000000
0008800000500000000000000000000000000000000000000000009a000000000000000000000000000000000000000000000000000000000000000000000000
00088000055000000000000000000000000000000000000000000090000900000000000000000000000000000000000000000000000000000000000000000000
000000000500000000000000000099000000000000000000000004440aaaaa000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000aaaaaa0000000000000000000444444704aa000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000070407aa000000000000000000444449244aa000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000a774774a0000000000000000007044442aaaa000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000a4499944a00000000000000000f444444555aa000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000a44494444a000000000000000ff444444555500000000000000000000000000000000000000000eee8e888e00000000000000000
000000000000000000000000aaaaaaaaaa000000000000000ff44444445555000000000000000000000000000000000000000888888888880000000000000000
000000000000000000000000000aaaaa000000000000000000000000000055000000000000000000000000000000000000088888888888888880000000000000
00000000000000000000000004aaaaaaa40000000000000000000000000000000000000000000000000000000000000000888888888888888880000000000000
000000000000000000000000090aaaa9aa0000000000000000000000000000000000000000000000000000000000000008888888882222222880000000000000
000000000000000000000000099977799aa000000000000000000000000000000000000000000000000000000000000088888888822222277000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088888888822277777000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088888778222777677000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000888877788227777677000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088888888227776677000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007778888777776777000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777777d777770000000000000000
000000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000d7777777777777600000000000000000
000000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000d7777777777777000000000000000000
000000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000ddddd777777777000000000000000000
0000000000000000000000000000000000000000000000000000000000000005000000000000000000000000000000007ddd7777777660000000000000000000
0000000000000000000000000000000000000000000000000050000000000005000000000000000000000000000000000ddddddd777600000000000000000000
00000000000000000000000000000000000000000000000000500000000000050000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000500000000000500000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000500000000005000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000050000050000000050000000000000000000000007000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000500005000000050000000000000000000000000ff00000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000050000500000050000000000000000000000000ff7000000000000000000000000000000aaa0000000
0000000000000000000000000000000000000000000000055000500000050000000000000000000000000ff7000000000000000000000000000aaa9aa0000000
0000000000000000000000000000000000000000000000005000550000500000000000005000000000000ff70000000000000000000000000aa999aa00000000
00000000000000000000000000000000000000050000000005555555dd500b00000000055000000000000ff77000000000000000000000aa999aaaa000000000
00000000000000000000000000000000000000005000000555555d5ddd20033b030000550000000000000ff777000000000000000000aa99aaaa7aa000000000
0000000000000000000000000000000000000000050000555555ddddd522933b000005000000000000000ff77700000000000000000aa99aaaaa7a0000000000
000000000000000000000000000000000000000000500555555dddddd92999aa9aa5500000000000000000f7770000000000000000aa99aaaaaa7a0000000000
000000000000000000000000000000000000000000055555555d0d509929944a9a95000000000000000000ff770000000000000099a99aaaaaa7700000000000
000000000000000000000000000000000000000000000555555ddd009299aa49aa99000000000000000000ff7707700000000009aa9aaaaa77a7000000000000
000000000000000000000000000000000000000000005505000055055299aa4999999000000000000007007f7777700000000009a99aaaaaa77a000000000000
00000000000000000000000000000000000000000000555555505000529aaaa44aa99000000000000007007f777f700000000099a9aaaaaaaaaa000000000000
00000000000000000000000000000000000000000000555555500000529aaaa44aaa9000000000000007007f777ff0000000009999aaaaaaaaa0000000000000
00000000000000000000000000000000000000055000555505000000029aaaa449aa9000000000000007007f777ff000000009999aaaa777aaa0000000000000
00000000000000000000000000000000000000000555505505000000022aa944499a0000000000000007007f777700000000099a9aaaaaa77aa4000000000000
0000000000000000000000000000000000000000000055550050000000299594999a000000000000000777ff77770000000099999aa5dddd7ddd000000000000
0000000000000000000000000000000000000000000055555050000005059259999a000000000000000777ff777700000000999ad550d747777d450000000000
0000000000000000000000000000000000000000000055550500000055000225999000000000000000777f7f777700000000dd55557077077544455000000000
000000000000000000000000000000000000000000000555050505055505ddd555555000000000007777f7ff777700000000d577770007777774455000000000
0000000000000000000000000000000000000000000005555550005550dddddddd50055550000000777ff7ff77770000007d55777707777774004d4400000000
00000000000000000000000000000000000000000000505555555005055dddddd55000005550000077777e7777770000004d47777777777774007dd400000000
000000000000000000000000000000000000000000050005555555050055ddddd500000000050000777278e7f7770000004d477777777770007474dd00000000
00000000000000000000000000000000000000000005000005555555555ddddd500000000000000077428877f770000000dd4777777777777774774d00000000
0000000000000000000000000000000000000000000500000055555555dddd5550000000000000044442887ff770000000d74777777777777777755d0a000000
0000000000000000000000000000000000000000000000000050000050d50d0055000000000000444442227fff70000000444777777777777777775daaa00000
0000000000000000000000000000000000000000000000000500000050d500000500000000000444444222ff7700000000747111117777777777775daaaa0000
0000000000000000000000000000000000000000000000005000000050d500000500000000000444444224277700000000757111111222271777775aa0000000
0000000000000000000000000000000000000000000000050000000050d5000000500000000004999992292aa990000000701127777777222117777dd0000000
0000000000000000000000000000000000000000000000500000000500d5000000500000000004999922999aaa90000000701572ff72277777717775d0000000
0000000000000000000000000000000000000000000000500000000500d0000000050000000044999999999aaa9000000070112222ff277777712771d0000000
000000000000000000000000000000000000000000000500000000050000000000050000000049999aa9999aaa90000000001112255f777666711771d0000000
0000000000000000000000000000000000000000000050000000000500000000000500000004499992929a9aaa900000000011151755266677771771d0000000
00000000000000000000000000000000000000000000500000000005000000000000500000044999a2999a9aaa900000000001111112f66666671711d0000000
000000000000000000000000000000000000000000000000000000050000000000005000000499992999999aaa900000000000111112f6f666661711d0000000
000000000000000000000000000000000000000000000000000000500000000000005000004449992999999aa9900000000000001111f6f666661711d0000000
000000000000000000000000000000000000000000000000000000500000000000005000004049999999999a99900000000000000111f6666666121dd0000000
00000000000000000000000000000000000000000000000000000000000000000000050000004499900999a999000000000000000112fff66662121d10000000
0000000000000000000000000000000000000000000000000000000000000000000005000000944900009999990000000000000000222ff66661171100000000
000000000000000000000000000000000000000000000000000000000000000000000500000099490000099999000000000000000000722f6611711100000000
00000000000000000000000000000000000000000000000000000000000000000000005000000990000009999a00000000000000000075777717511100000000
00000000000000000000000000000000000000000000000000000000000000000000000000000990000009999a00000000000000000011115117511000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000990000000999a00000000000000000011111115501000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000090000000099900000000000000000000111115551000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000090000000099000000000000000000000011175511000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000090000000009000000000000000000000001175511000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005517111000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005511111000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005555111000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000555100000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055500000000000
__gff__
0000000200000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0059002036550315302f5502e5503055037530335402d5402d5303354035550305502d530305403353036532305302a530275302c5502d560285702557026560295502d5402f5403054033540335402e5502c550
001000002a0502a0502c050340502d0502a05032050350503005033050320503105031050300502f050000002f0502e050000002d050000002c050000002c050000002b0502b050000002b0502a0502a0502a050
0010000021050200501f050000001e0501d0501c05000000000001b050000001a0500000000000190500000000000000001805000000000001805000000000001805000000000000000000000170500000000000
001000002605024050230502405025050250502505025050240502405023050230502205021050210502105020050200502005021050210502105020050200502005020050200501f0501f0501f0501f0501f050
001000000205002050020500205002050020500105000000010500000001050000000105000000010500000002050000000205000000000000205000000030500000003050000000405005050050500505006050
001400002561001610266101c610026102561024610026102161000610006101e6101d61020610016101f6101f610006101f610216101e61007610006101c61019610206101a6101f610006101e610206101a610
00140000372503225035250362503a2503d25032250312503a2503d250000003725036250382503b2500000000000372500000035250000000000034250000000000037250362500000000000372500000000000
001000000645006450064500545005450044500445006450064500645000000000002a450294502845025450224501f4501b45018450134500e4500b450084500645005450000000445003450000000245002450
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000000000000003a2500000000000000002e25000000000002b2500000035250000003a250000000000000000292500000000000332500000000000000003025000000000000000035250000000000000000
001800001802018020180201802013020180201803018030180301803014030180301803015030170301603017020170201702017020170201902016020150201602016020160201602019030160201902016020
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

