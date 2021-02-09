d = 90; // diameter
h = 13; // height

$fn=60;
fs=360/$fn; // like fn for 'upper part'

/* 
Print parts seperatly.
How to get the decorative pattern onto the lid:
https://www.youtube.com/watch?v=YVKqZ20nSNI
*/

// lower part
translate([d, 0, 0])difference(){
    cylinder(12, d/2-2, d/2-2, false);
    translate([0, 0, 2]) cylinder(12, d/2-3.5, d/2-3.5, false);
    };
    
// decoration
translate([d * -0.5 - 30, 0, 0])
    for(i=[-24: 6: 24], j=[-24: 6: 24])
        {translate([i, 0, 0]) cube([0.5, 48.5, 0.3], true);
        translate([0, j, 0]) cube([48.5, 0.5, 0.3], true);}
        
// upper part
for (i = [1:fs:360]) hull(){
    rotate([0, 0, i-45])translate([d/2-0.85, 0, 0])hull(){
        translate([0, 0, 0.75])cube(1.5, true); 
        translate([0, 0, sin(3*i)*5 + 6.5])sphere(0.75);
    };
    rotate([0, 0, (i+fs)-45])translate([d/2-0.85, 0, 0])hull(){
        translate([0, 0, 0.75])cube(1.5, true); 
        translate([0, 0, sin(3*(i+fs))*5 + 6.5])sphere(0.75);
    };
    
};
cylinder(1.5, d/2 - 0.1, d/2 - 0.1,false);

// upper part alternative    
translate([0, d + 3, 0])difference(){
    cylinder(h, d/2 - 0.1, d/2 - 0.1, false);
    translate([0, 0, 1.5]) cylinder(12, d/2 - 1.6, d/2 - 1.6, false);
    translate([0, 0, 1.01 + h/2])rotate([90, 0, 0])
        linear_extrude(d, center = true)
            polygon(points = [for (i=[-d/2:d/2]) 
                [i, -cos(i*360/d)*(h/2-1) ]]);
    };