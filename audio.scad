$fn=60;

// audio_3_5_jack_socket(with_screw=true, screw_gap=1.5);

module audio_3_5_jack_socket(with_screw=false, screw_gap=0) {
  color("black") cube([14, 11.5, 6]);
  translate([14, 5.75, 3])
    rotate([0, 90, 0])
      color("silver") {
        difference() {
          cylinder(3.5, 3, 3);
          cylinder(4, 3.5/2, 3.5/2);
        }
        translate([0, 0, screw_gap]) audio_3_5_jack_socket_screw();
      }
}

module audio_3_5_jack_socket_screw() {
  difference() {
    cylinder(2, 4, 4);
    cylinder(3, 3, 3);
  }
}
