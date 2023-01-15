/**
 * Speakers
 */
x_len=69.5;
y_len=31;
z_len=17;
recess_x_len=9;
recess_y_len=10;
recess_z_len=14;
fixation_hole_offset=3;
fixation_hole_radius=1.5;
sound_hole_offset_1=23;
sound_hole_offset_2=40;
sound_hole_radius=11;
sound_hole_height=2;

module speaker() {
  difference() {
    cube([x_len, y_len, z_len]);

    // recesses
    cube([recess_x_len, recess_y_len, recess_z_len]);
    translate([0, y_len-recess_y_len, 0])
      cube([recess_x_len, recess_y_len, recess_z_len]);
    translate([x_len-recess_x_len, 0, 0])
      cube([recess_x_len, recess_y_len, recess_z_len]);
    translate([x_len-recess_x_len, y_len-recess_y_len, 0])
      cube([recess_x_len, recess_y_len, recess_z_len]);

    // fixation holes
    speaker_fixation_holes();

    // sound hole
    translate([0, 0, z_len-sound_hole_height])
      speaker_sound_hole();
  }
}

module speaker_fixation_holes(height=z_len) {
  translate([fixation_hole_offset, fixation_hole_offset, 0])
    cylinder(height, fixation_hole_radius, fixation_hole_radius);
  translate([fixation_hole_offset, y_len-fixation_hole_offset, 0])
    cylinder(height, fixation_hole_radius, fixation_hole_radius);
  translate([x_len-fixation_hole_offset, fixation_hole_offset, 0])
    cylinder(height, fixation_hole_radius, fixation_hole_radius);
  translate([x_len-fixation_hole_offset, y_len-fixation_hole_offset, 0])
    cylinder(height, fixation_hole_radius, fixation_hole_radius);
}

module speaker_sound_hole(height=sound_hole_height) {
  translate([sound_hole_offset_1, y_len/2, 0])
    cylinder(height, sound_hole_radius, sound_hole_radius);
  translate([sound_hole_offset_2, y_len/2, 0])
    cylinder(height, sound_hole_radius, sound_hole_radius);
  translate([sound_hole_offset_1, (y_len-sound_hole_radius*2)/2, 0])
    cube([17, sound_hole_radius*2, height]);
}

module speaker_mesh(bar_width=x_len/42.5, hole_width=x_len/42.5, height=5) {
  intersection() {
    speaker_sound_hole(height=height);
    union() {
      for (i = [0:hole_width*2:x_len]) {
        translate([i, 0, 0]) cube([bar_width, y_len, height]);
      }
      for (i = [0:hole_width*2:y_len]) {
        translate([0, i, 0]) cube([x_len, bar_width, height]);
      }
    }
  }
}
