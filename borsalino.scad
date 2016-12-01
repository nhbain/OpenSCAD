/*
Parameterized, modular Borsalino by Henk van Putten (2013)

Author: Nicolas Bain

Usage: This is modeled after the Borsalino sculpture created by Henk van Putten. Credit for the original design goes to him. I simply recreated it using this program and added some features. 

Changing the side parameter will directly affect the radius of the sweeps. So, only this parameter needs to be changed.
*/
// Libraries from https://github.com/openscad/scad-utils ----------------------------------------
use <sweep.scad>
use <scad-utils/transformations.scad>
use <scad-utils/shapes.scad>
use <scad-utils/morphology.scad>
// ----------------------------------------

// Modules ----------------------------------------
main ();
// ----------------------------------------

module main ()
{
    side =  14; // Side length of the square cross section. This directly affects the overall shape of the borsalino.
    r = .5*side; // sweep radius of the endcap
    R = r + sqrt(2)*r; //sweep radius of the medial axis of the connector.
    buffer = 5; //Simply a parameter for spacing of the modules
    endcap(side,buffer);
    //male_sleeve(side);
    //connector(side, r, R);
     
}

module endcap(side, buffer)
{
        r = .5*side; // sweep radius of the endcap
        R = r + sqrt(2)*r; //sweep radius of the medial axis of the connector.
    
        difference(){
            rotate_extrude(convexity = 10, $fn = 100)
            basic_square(side);
            
            translate([0, -side, -side/2])
            cube([side*2,side*2, side*2], false);
            
            translate([-.2*side,  (.125*side)/2 ,  (.125*side)/2])
            female(side);
            
            mirror([0, 1, 0])
            translate([-.2*side,  (.125*side)/2 ,  (.125*side)/2])
            female(side);
        }
 }
 
 module connector(side, r, R)
 {
        difference(){
            rotate_extrude(convexity = 10, $fn = 100)
            square([R+r, side], false);
            
            rotate_extrude(convexity = 10, $fn = 100)
            square([R-r, side], false);
            
            translate([-side*2, -side*2.5, -side/2])
            cube([side*2,side*5, side*2], false);
            
            rotate([0, 0, 90])
            translate([-side*2, -side*2.5, -side/2])
            cube([side*2,side*5, side*2], false);
            
            rotate([0, 0, 135])
            translate([-side*2, -side*2.5, -side/2])
            cube([side*2,side*5, side*2], false);
            
            translate([-(side- (.125*side))/2,  (R+r)/2 -  (.125*side)/1.5 ,  (.125*side)/2])
            female(side);
            
            rotate([0, 0, 315])
            translate([-(side- (.125*side))/2,  (R+r)/2 -  (.125*side)/1.5 ,  (.125*side)/2])
            female(side);
        }
 }
 
 module basic_square(side, buffer)
 {
        translate([side/2, side/2, 0])
        difference(){
            square(side, true);
            square(side - (side/2), true);
        }
 }
 
 module female(side)
 {
        cube([side- (.125*side), side- (.125*side), side- (.125*side)]);
 }
 
module male_sleeve(side)
 {
        small_side = side- (.125*side);
        translate([-.2*side,  (.125*side)/2 ,  (.125*side)/2])
        difference(){
            cube([.4*side, side- (.125*side), side- (.125*side)]);
            translate([-side/2, (small_side - (small_side/2.5))/3, (small_side - (small_side/2.5))/3])
            cube([side, small_side - (small_side/2.5), small_side - (small_side/2.5)]);
        }
 }