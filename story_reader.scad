$fn=60;

box_x_len=200;
box_y_len=120;
box_z_len=35; // FIXME
box_wall_thickness=3;

buttons_y_offset=box_y_len*0.37;
previous_button_radius=7.25;
volume_button_radius=12;
next_button_radius=7.25;

front();
// battery_pack();

module front() {
  difference() {
  // case
  color("turquoise") cube([box_x_len, box_y_len, box_z_len]);
  
  // interior
  translate([box_wall_thickness, box_wall_thickness, -1])
    cube([box_x_len-2*box_wall_thickness, box_y_len-2*box_wall_thickness, box_z_len-box_wall_thickness+1]);

  translate([box_x_len/2, buttons_y_offset, 0]) {
    // left speaker vent
    translate([30, 0, 0])
      rotate([0, 0, 45])
      speaker_vent();
    // right speaker vent
    translate([-30, 0, 0])
      rotate([0, 0, 135])
      translate([0, -31, 0]) speaker_vent();

    // "previous" button
    translate([-60, -7.25, 0])
      cylinder(100, previous_button_radius+0.5, previous_button_radius+0.5);
    // volume and play/pause rotary button
    translate([0, -7.25, 0])
      cylinder(100, volume_button_radius+0.5, volume_button_radius+0.5);
    // "next" button
    translate([60, -7.25, 0])
      cylinder(100, next_button_radius+0.5, next_button_radius+0.5);
    }
  }

  translate([box_x_len/2, buttons_y_offset, 0]) {
    // Speakers
    translate([0, 0, box_z_len-box_wall_thickness-17]) { // 17 => speaker height
      // left speaker
      translate([30, 0, 0])
        rotate([0, 0, 45])
          color("black") speaker();
      // right speaker
      translate([-30, 0, 0])
        rotate([0, 0, 135])
          translate([0, -31, 0]) color("black") speaker();
    }

    // Buttons
    translate([0, 0, box_z_len-box_wall_thickness]) {
      // "previous" button
      translate([-60, -7.25, 0]) 
        color("red") cylinder(5, previous_button_radius, previous_button_radius);
      // volume and play/pause rotary button
      translate([0, -7.25, 0])
        color("gold") cylinder(7, volume_button_radius, volume_button_radius);
      // "next" button
      translate([60, -7.25, 0])
        color("red") cylinder(5, next_button_radius, next_button_radius);
    }
  }
  
  // power switch
  translate([box_x_len-22, box_y_len*0.22, (box_z_len-15)/2])
    rotate([90, 0, 90])
      switch();
  
  // Main elec board
  rotate([180, 0, 0])
    translate([(box_x_len-45)/2, -box_y_len+box_wall_thickness, -box_z_len+box_wall_thickness+2])
      main_board();
  
  // Battery pack
  rotate([-90, 0, 0])
    // translate([(box_x_len-134.5)/2, -22, box_wall_thickness])
    translate([(box_x_len-134.5)/2, -box_z_len+box_wall_thickness, box_wall_thickness])
      battery_pack();
}

module switch() {
  // connector
  translate([10, 5, 0]) color("gold") cube([1, 5, 10]);
  // connector
  translate([3, 5, 0]) color("gold") cube([1, 5, 10]);
  difference() {
    union() {
      // body
      translate([1, 1.5, 10]) color("black") cube([19, 12, 11]);
      // cover
      translate([0, 0, 21]) color("black") cube([21, 15, 2]);
    }
    translate([3, 2.5, 11]) cube([15, 10, 30]);
  }
  // lever
  translate([3.5, 2.5, 21.5]) rotate([0, 10, 0]) {
    color("black") cube([14, 10, 3]);
    translate([1.5, 3.5, 2.6]) color("white") text("O", 4);
    translate([10, 3.5, 2.6]) color("white") text("I", 4);
  }
}

module audio_jack() {
  // TODO
}

module usb() {
  // TODO
}

module battery_pack() {
  // battery holder
  difference() {
    color("black") {
      cube([134.5, 22, 16]);
//      r=11;
//      translate([0, r, r+2]) rotate([0, 90, 0]) cylinder(134.5, r, r);
    }
    translate([2, 2, 2]) cube([130.5, 18, 14]);
//    translate([2, 11, 13]) rotate([0, 90, 0]) cylinder(130.5, 10, 10);
//    translate([-1, 3.5, 16]) cube([136, 15, 30]);
  }
  
  // 2 18650 cells
  translate([2, 11, 11]) {
    rotate([0, 90, 0]) {
      translate([0, 0, 0]) battery_18650();
      translate([0, 0, 65.5]) battery_18650();
    }
  }
}

module battery_18650() {
  color("silver") cylinder(0.5, 8, 8);
  translate([0, 0, 0.5]) color("blue") cylinder(64, 9, 9);
  translate([0, 0, 65]) color("silver") cylinder(0.5, 6, 6);
}

module rotary_encoder() {
  // TODO
}

module main_board() {
  color("green") cube([45, 35, 2]);
}

module speaker_vent(height=100) {
  y_len=31;
  sound_hole_offset_1=23;
  sound_hole_offset_2=40;
  sound_hole_radius=11;
  translate([sound_hole_offset_1, y_len/2, 0])
    cylinder(height, sound_hole_radius, sound_hole_radius);
  translate([sound_hole_offset_2, y_len/2, 0])
    cylinder(height, sound_hole_radius, sound_hole_radius);
  translate([sound_hole_offset_1, (y_len-sound_hole_radius*2)/2, 0])
    cube([17, sound_hole_radius*2, height]);
}

module speaker() {
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
  translate([fixation_hole_offset, fixation_hole_offset, 0])
    cylinder(z_len, fixation_hole_radius, fixation_hole_radius);
  translate([fixation_hole_offset, y_len-fixation_hole_offset, 0])
    cylinder(z_len, fixation_hole_radius, fixation_hole_radius);
  translate([x_len-fixation_hole_offset, fixation_hole_offset, 0])
    cylinder(z_len, fixation_hole_radius, fixation_hole_radius);
  translate([x_len-fixation_hole_offset, y_len-fixation_hole_offset, 0])
    cylinder(z_len, fixation_hole_radius, fixation_hole_radius);
  
  // sound hole
  translate([sound_hole_offset_1, y_len/2, z_len-sound_hole_height])
    cylinder(sound_hole_height, sound_hole_radius, sound_hole_radius);
  translate([sound_hole_offset_2, y_len/2, z_len-sound_hole_height])
    cylinder(sound_hole_height, sound_hole_radius, sound_hole_radius);
  translate([sound_hole_offset_1, (y_len-sound_hole_radius*2)/2, z_len-sound_hole_height])
    cube([17, sound_hole_radius*2, sound_hole_height]);
  }
}
