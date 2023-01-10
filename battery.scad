/**
 * Battery pack
 */

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
