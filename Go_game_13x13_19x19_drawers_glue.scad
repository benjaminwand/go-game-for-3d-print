// variables, to be changed
dist19 = 10.5;      // distance between stones of 13x13 field
pin = 9;            // vertical space pin needs in box
minW = 1.5;         // least wall thickness

// calculated proportions, don't touch
s = dist19 * 9;     // half size for pattern
s2 = dist19 * 9.5;  // half board size
dist13 = dist19 * 1.5;   // distance between stones of 9x9 field
drawer_height = pin + minW;
height = drawer_height + 5.5; 
drawer_width = 17 * dist19 - 5;

/*
Print each of the following parts separately.

Alternatively the cross pattern can be printed under the matching part 
or 19er_cross/3er_cross can be enabled. 

How to get the decorative pattern onto boards:
https://www.youtube.com/watch?v=YVKqZ20nSNI
*/

// 19 side of board
difference(){
    union() {
        base();
        connecters();
    }
    19er_pins();
  //  19er_cross();
};

// 13 side of board
translate([-2.4*s, 0, 0]) 
    difference(){
        base();    
        holes();
        13er_pins();
       // 13er_cross();
    };

// drawers
translate([2.3*s, 0, 0])
    drawer();
translate([2.3*s, 0, 0]) 
    mirror([1, 0, 0]) drawer();
/*
// 19 cross pattern (if needed)
translate([0, 2.3*s, 0]) difference(){
    for(i=[-s: dist19: s], j=[-s: dist19: s]){
        translate([0, j, 0]) cube([2*s, 0.5, 0.2], true);
        translate([i, 0, 0]) cube([0.5, 2*s, 0.2], true);
    };
    for(i=[-s: dist19: s], j=[-s: dist19: s])
    translate([i, j, 0]) cube(2, true);
};

// 13 cross pattern (if needed)
translate([-2.4*s, 2.3*s, 0]) difference(){
    for(i=[-s: dist13: s], j=[-s: dist13: s]){
        translate([0, j, 0]) cube([2*s, 0.5, 0.2], true);
        translate([i, 0, 0]) cube([0.5, 2*s, 0.2], true);
    };
    for(i=[-s: dist13: s], j=[-s: dist13: s])
    translate([i, j, 0]) cube(2, true);
};
*/

// modules
module base() hull () for (i=[-s2, s2], j=[-s2, s2])
    translate([i, j, 0])cylinder(2.5, 2, 2, false, $fn=20);

module 19er_pins() for(i=[-s: dist19: s], j=[-s: dist19: s])
    translate([i, j, 0]) cylinder(10, 0.8, 0.8, $fn=15, true);

module 13er_pins() for(i=[-s: dist13: s], j=[-s: dist13: s])
    translate([i, j, 0]) cylinder(10, 0.8, 0.8, $fn=15, true);

module 19er_cross() for(i=[-s: dist19: s], j=[-s: dist19: s])
{translate([i, 0, 0]) rotate([90, 0, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);
translate([0, j, 0]) rotate([0, 90, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);}

module 13er_cross() for(i=[-s: dist13: s], j=[-s: dist13: s])
{translate([i, 0, 0]) rotate([90, 0, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);
translate([0, j, 0]) rotate([0, 90, 0])
    cylinder(2*s, 0.8, 0.8, $fn=15, true);}

module 1_connector()
    {cylinder(height-2.5, 2, 2, false, $fn=20);
    translate([0, 0, height-2.5]) cylinder(2, 2, 0, false, $fn=20);}

module connecters()
    {for (i=[-s2 +dist19 : dist19: s2 -dist19], j=[-s2 + dist19, s2 - dist19])
        translate([i, j, 0]) 1_connector();
    for (j=[-6.5*dist19, -5.5*dist19,
        -3.5*dist19, -2.5*dist19, 
        -0.5*dist19, 0.5*dist19, 
        2.5*dist19, 3.5*dist19, 
        5.5*dist19, 6.5*dist19])
        translate([0, j, 0]) 1_connector();
    } 
        
module 1_hole()
    translate([0, 0, 0.51]) cylinder(2, 0, 2, false, $fn=20);

module holes()
    {for (i=[-s2 +dist19 : dist19: s2 -dist19], j=[-s2 + dist19, s2 - dist19])
        translate([i, j, 0]) 1_hole();
    for (j=[-6.5*dist19, -5.5*dist19,
        -3.5*dist19, -2.5*dist19, 
        -0.5*dist19, 0.5*dist19, 
        2.5*dist19, 3.5*dist19, 
        5.5*dist19, 6.5*dist19])
        translate([0, j, 0]) 1_hole();
    } 
        
module shape2d() hull() {
    translate([dist19 - 1.3, 0]) scale([1, 1.7]) circle(4, $fn=25);
    translate([dist19 - 0.3, 0]) square([0.1, height], true);
    };
    
module handle() 
    translate([dist19 * 8.5, 0, drawer_height/2+2.75]) rotate([90, 0, 0])
    intersection(){
        linear_extrude(2, center = true) shape2d();
        cube([3*dist19, drawer_height, drawer_height], true);
    };
    
module drawer() 
    difference(){
        union(){
            translate([2.5, drawer_width / -2, 2.75]) 
                cube([dist19*9, drawer_width, drawer_height], false);
            handle();
        }
        translate([0, 0, drawer_height +3]) 
            cube([20, drawer_width -2*minW, 10], true);
        translate([2.5 + minW, drawer_width/-2 + minW, 3+ minW]) 
            cube([dist19*9 -2*minW, drawer_width -2*minW, drawer_height], false);
    };