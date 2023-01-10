/**
 * Switch
 */

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
