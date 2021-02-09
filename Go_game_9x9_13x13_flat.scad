dist13 = 10.5;  // distance between pins on 13x13 boars
dist9 = dist13 * 1.5;
s = dist13 * 6; // size

/*
When trying to print this in one piece, I experienced difficulties with 
warping and ended up printing it in two parts and glueing them together.
To give you the same option, there is an optional cube in the modula 
that can be moved up or down if neccesary.

Alternatively the cross pattern can be printed under the matching part 
or 9er_cross/3er_cross can be enabled. 

How to get the decorative pattern onto boards:
https://www.youtube.com/watch?v=YVKqZ20nSNI
*/

difference(){
    basic_shape();
    13er_pins();
    9er_pins();
    13er_cross();
    9er_cross();
   // to make half games
   // translate([0, 0, 5])cube([s*3, s*3, 10], true);
};

/*
// 13 cross pattern separately
difference(){
    for(i=[-s: dist13: s], j=[-s: dist13: s]){
        translate([0, j, 0]) cube([2*s, 0.5, 0.2], true);
        translate([i, 0, 0]) cube([0.5, 2*s, 0.2], true);
    };
    for(i=[-s: dist13: s], j=[-s: dist13: s])
    translate([i, j, 0]) cube(2, true);
};

// 9 cross pattern separately
difference(){
    for(i=[-s: dist9: s], j=[-s: dist9: s]){
        translate([0, j, 0]) cube([2*s, 0.5, 0.2], true);
        translate([i, 0, 0]) cube([0.5, 2*s, 0.2], true);
    };
    for(i=[-s: dist9: s], j=[-s: dist9: s])
    translate([i, j, 0]) cube(2, true);
};
*/

//modules
module shape() hull() rotate_extrude($fn=50) {
    translate([dist13 - 1.3, 0, 0]) circle(4, $fn=25);
    translate([dist13 - 0.3, 0, 0]) square([0.1,9], true);
    };
    
module basic_shape() hull ()
    for (i=[-s, s], j=[-s, s])
        translate([i, j, 0])shape();
    
module 13er_pins() for(i=[-s: dist13: s], j=[-s: dist13: s])
    translate([i, j, -2]) cylinder(10, 0.8, 0.8, $fn=15);

module 9er_pins() for(i=[-s: dist9: s], j=[-s: dist9: s])
    translate([i, j, -8]) cylinder(10, 0.8, 0.8, $fn=15);

module 13er_cross() for(i=[-s: dist13: s], j=[-s: dist13: s])
{translate([i, 0, 4.5]) rotate([90, 0, 0])cylinder(2*s, 0.8, 0.8, $fn=15, true);
translate([0, j, 4.5]) rotate([0, 90, 0])cylinder(2*s, 0.8, 0.8, $fn=15, true);}

module 9er_cross() for(i=[-s: dist9: s], j=[-s: dist9: s])
{translate([i, 0, -4.5]) rotate([90, 0, 0])cylinder(2*s, 0.8, 0.8, $fn=15, true);
translate([0, j, -4.5]) rotate([0, 90, 0])cylinder(2*s, 0.8, 0.8, $fn=15, true);}