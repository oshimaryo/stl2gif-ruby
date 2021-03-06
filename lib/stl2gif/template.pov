#include "math.inc"
#include "finish.inc"
#include "transforms.inc"

background {color rgb 1}

light_source {
  <-500,500,400>
  rgb 1
  shadowless
  fade_distance 0.95
}

light_source {
  <700,-700,700>
  rgb 1
  shadowless
  fade_distance 0.75
}

global_settings {
  assumed_gamma 2
  ambient_light rgb <0.2,0.2,0.2>
}

#declare __Default__ = {{{modelData}}}

#declare Min_ext = min_extent(__Default__);
#declare Max_ext = max_extent(__Default__);

#declare X_len = Max_ext.x - Min_ext.x;
#declare Y_len = Max_ext.y - Min_ext.y;
#declare Z_len = Max_ext.z - Min_ext.z;

#declare Radius = max(X_len / atan(pi / 5), Y_len / atan(pi / 5), Z_len / atan(pi / 5));
#declare Theta = -pi / 2 * pow(2.71828, -Y_len / (X_len * 4));
#declare Phi = {{phi}};

#declare X_offset = Min_ext.x + X_len / 2;
#declare Y_offset = Min_ext.y + Y_len / 2;
#declare Z_offset = Min_ext.z;

#declare X_pos = Radius * sin(Theta) * cos(Phi) + X_offset;
#declare Y_pos = Radius * sin(Theta) * sin(Phi) + Y_offset;
#declare Z_pos = Radius * cos(Theta) + Z_offset;

#declare look_at_z = (Max_ext.z - Min_ext.z) / 4;

#debug concat("radius:", str(Radius, 5, 0))
#debug concat("theta:", str(Theta, 5, 0))
#debug concat("phi:", str(Phi, 5, 0))
#debug concat("look_at:", str(look_at_z, 5, 0))

camera {
  orthographic
  location <X_pos, Y_pos, Z_pos>
  sky <0, 0, 1>
  look_at <X_offset, Y_offset, look_at_z>
}

sky_sphere
{
	pigment
	{
		gradient y
		color_map
		{
			[0.0 rgb <1.0,1.0,1.0>]		//153, 178.5, 255	//150, 240, 192
			[0.7 rgb <0.9,0.9,0.9>]		//  0,  25.5, 204	//155, 240, 96
		}
		scale 2
		translate 1
	}
}

object {
  __Default__
  texture {
    pigment {color <1,1,1>}
    finish {
      phong 0.0
      ambient 0.2
    }
  }
}


