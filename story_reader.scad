include <battery.scad>;
include <speakers.scad>;
include <switch.scad>;

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

module audio_jack() {
  // TODO
}

module usb() {
  // TODO
}

module rotary_encoder() {
  // TODO
}

module main_board() {
  color("green") cube([45, 35, 2]);
}
