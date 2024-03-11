

//--- Collisions

// X
repeat(abs(hsp))
{
    if (!place_meeting(x + sign(hsp), y, obj_solid))
	{
        x += sign(hsp);
    }
	else
	{
        hsp = 0;
        break;
    }
}

// Y
repeat(abs(vsp))
{
    if (!place_meeting(x, y + sign(vsp), obj_solid))
	{
        y += sign(vsp);
    }
	else
	{
        vsp = 0;
        break;
    }
}

//--- Move

// Input
var _jump = keyboard_check_pressed(ord("Z")),
	_run = keyboard_check(ord("X"));
var _move_x = keyboard_check(vk_right) - keyboard_check(vk_left);

// Move X
if (_move_x != 0)
{
	var _max_speed = _run ? ground_speed_run : ground_speed_walk;
	hsp = clamp(hsp + (ground_speed_accel * _move_x), -_max_speed, _max_speed);
}
else
{
	hsp = lerp(hsp, 0, 0.1);
}

// Move Y
ground = place_meeting(x, y + 1, obj_solid);
if (!ground)
{
	vsp = clamp(vsp + spd_gravity, -jump_height, air_vsp_fall_max);
}
if (ground && _jump)
{
	vsp = -jump_height;
	ground = false;
}

//--- Misc

// Sprite Facing
if (_move_x != 0){image_xscale = _move_x;}