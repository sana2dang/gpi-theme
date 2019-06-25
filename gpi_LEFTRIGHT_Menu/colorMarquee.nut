fe.add_transition_callback( "colorMarquee" );

local colorMarqueeUse = false;
local delay_time = 0;
local play_delay = 200;
local introPlay = false;

function colorMarquee( ttype, var, transition_time )
{		
	if( ttype == Transition.StartLayout || ttype == Transition.ToNewList || ttype == Transition.FromOldSelection ) 
	{
		delay_time = fe.layout.time;
		colorMarqueeUse = true;
	}
	/*
	if( colorMarqueeUse )
	{
		//local emulatorNm = fe.add_text( "[System]", 20, 100, 1200,200 );	
		local emulator= fe.game_info(Info.System);
		local romName = fe.game_info( Info.Name );
		switch( ttype )
		{
			case Transition.FromOldSelection:
				//system( "/home/pi/dev/colorMarquee/colorMarquee.sh "+ romName );
				system("python /home/pi/dev/colorMarquee/colorMarquee.py " + emulator+ " " + romName + " &"  );
				return false;	
		}
	}
	*/
	return false;
}




function on_tick(tick_time) 
{
	if( tick_time - delay_time >= play_delay  && colorMarqueeUse )
	{
		if( !introPlay )
		{		
			introPlay = false;
			colorMarqueeUse  = false;			
			local emulator= fe.game_info(Info.System);
			local romName = fe.game_info( Info.Name );

			//local cc = fe.add_text( emulator, 0 , 500 , 1000, 100);
			//cc.char_size = 30;
			
			if( emulator == "" )
			{
				introPlay= true;
				system("python /home/pi/dev/colorMarquee/colorMarquee.py intro &"  );			
			}
			else
			{
				//system( "/home/pi/dev/colorMarquee/colorMarquee.sh "+ romName );
				system("python /home/pi/dev/colorMarquee/colorMarquee.py " + emulator+ " '" + romName + "' &"  );
			}
	
		}
	}
}

fe.add_ticks_callback( this, "on_tick" );