include <batteries.scad>;
include <speakers.scad>;
include <switchs.scad>;
include <audio.scad>;

/*
 * TODO
 * - Status LED
 * - Speaker supports
 * - Volume/play/pause circuit support
 * - Main board support
 */

$fn=60;

box_x_len=200;
box_y_len=120;
box_z_len=35; // FIXME
box_wall_thickness=3;

buttons_y_offset=box_y_len*0.37;
volume_button_radius=13;

// front(display_accessories=true);
// front(display_accessories=false);
speaker_support();

module front(display_accessories=true) {
  difference() {
    // Case
    color("turquoise") cube([box_x_len, box_y_len, box_z_len]);

    // Interior
    translate([box_wall_thickness, box_wall_thickness, -1])
      cube([box_x_len-2*box_wall_thickness, box_y_len-2*box_wall_thickness, box_z_len-box_wall_thickness+1]);

    translate([box_x_len/2, buttons_y_offset, 0]) {
      // Left speaker vent
      translate([30, 0, 0])
        rotate([0, 0, 45])
          speaker_sound_hole(100);
      // Right speaker vent
      translate([-30, 0, 0])
        rotate([0, 0, 135])
          translate([0, -31, 0])
            speaker_sound_hole(100);

      // "Previous" button
      translate([-60, -7.25, 0])
        cylinder(100, 16/2, 16/2);
      // Volume and play/pause rotary button
      translate([0, -7.25, 0])
        cylinder(100, volume_button_radius+0.2, volume_button_radius+0.2);
      // "Next" button
      translate([60, -7.25, 0])
        cylinder(100, 16/2, 16/2);
    }

    // Power switch
    translate([box_x_len-22, box_y_len*0.22, (box_z_len-15)/2])
      rotate([90, 0, 90])
        switch_21_15_body();
    
    // USB socket
    translate([box_x_len-box_wall_thickness, 11, (box_z_len-10)/2])
      cube([box_wall_thickness, 5, 10]);
    
    // Audio jack
    translate([2.5, box_y_len*0.22, (box_z_len-11.5)/2])
      cube([2, 6, 11.5]);
    translate([0, box_y_len*0.22+3, box_z_len/2])
      rotate([0, 90, 0]) cylinder(4, 3, 3);
    translate([-1, box_y_len*0.22+3, box_z_len/2])
      rotate([0, 90, 0]) cylinder(2, 4, 4);
  }

  // Back cover fixation
  color("turquoise") {
    translate([box_wall_thickness, box_wall_thickness, box_wall_thickness])
      back_cover_support();
    translate([box_x_len-box_wall_thickness-5, box_wall_thickness, box_wall_thickness])
      back_cover_support();
    translate([box_wall_thickness, box_y_len-box_wall_thickness-5, box_wall_thickness])
      back_cover_support();
    translate([box_x_len-box_wall_thickness-5, box_y_len-box_wall_thickness-5, box_wall_thickness])
      back_cover_support();
    translate([(box_x_len-5)/2, (box_y_len-5)/2, box_wall_thickness])
      back_cover_support();
  }

  if (display_accessories) {
    //
    // Accessories
    //

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

      // "Previous" button
      translate([-60, -7.25, 20])
        previous_button();
      // Volume and play/pause rotary button
      translate([0, -7.25, box_z_len-box_wall_thickness])
        color("gold") cylinder(7, volume_button_radius, volume_button_radius);
      // "Next" button
      translate([60, -7.25, 20])
        next_button();
    }
    
    // Power switch
    translate([box_x_len-22, box_y_len*0.22, (box_z_len-15)/2])
     rotate([90, 0, 90])
        switch_21_15();

    // USB socket
    translate([box_x_len-box_wall_thickness, 11, (box_z_len-10)/2])
      color("black") cube([box_wall_thickness+1, 5, 10]);
    
    // Audio jack
    translate([16.5, 6+box_y_len*0.22, (11.5+box_z_len)/2])
      rotate([90, 180, 0])
        audio_3_5_jack_socket(with_screw=true, screw_gap=1.5);
    
    // Main elec board
    rotate([180, 0, 0])
      translate([(box_x_len-45)/2, -box_y_len+box_wall_thickness, -box_z_len+box_wall_thickness+2])
        main_board();
    
    // Battery pack
    rotate([-90, 0, 0])
      translate([(box_x_len-134.5)/2, -box_z_len+box_wall_thickness, box_wall_thickness])
        battery_pack();
    // Walls
    color("turquoise") {
      translate([(box_x_len-134.5)/2-0.5*box_wall_thickness, box_wall_thickness, box_z_len-1.5*box_wall_thickness-22])
        cube([134.5+box_wall_thickness, box_wall_thickness, 0.5*box_wall_thickness]);
      translate([(box_x_len-134.5)/2-0.5*box_wall_thickness, box_wall_thickness, box_z_len-1.5*box_wall_thickness-22])
        cube([0.5*box_wall_thickness, box_wall_thickness, box_wall_thickness]);
      translate([(box_x_len-134.5)/2+134.5, box_wall_thickness, box_z_len-1.5*box_wall_thickness-22])
        cube([0.5*box_wall_thickness, box_wall_thickness, box_wall_thickness]);
    }
  }
}

module main_board() {
  color("green") cube([45, 35, 2]);
}

module next_button() {
  color("black") cylinder(13, 16/2, 16/2);
  translate([0, 0, 13]) color("black") cylinder(2.5, 19/2, 19/2);
  translate([0, 0, 13+2.5]) color("red") cylinder(4, 12.5/2, 12.5/2);
}

module previous_button() {
  next_button();
}

module back_cover_support() {
  difference() {
    cube([5, 5, box_z_len-2*box_wall_thickness]);
    translate([2.5, 2.5, 0]) cylinder(box_z_len, 1.5, 1.5);
  }
}

module speaker_support() {
  // Support
  difference() {
    cube([x_len, y_len, box_wall_thickness]);
    speaker_sound_hole(height=box_wall_thickness);
    speaker_fixation_holes(height=box_wall_thickness);
  }
  speaker_mesh(height=box_wall_thickness);
  // This part is inserted in box surface
  translate([0, 0, box_wall_thickness])
    speaker_mesh(height=box_wall_thickness);
}
