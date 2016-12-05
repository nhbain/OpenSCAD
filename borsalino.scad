/*
Parameterized, modular Borsalino by Henk van Putten (2013)

Author: Nicolas Bain

Usage: This is modeled after the Borsalino sculpture created by Henk van Putten. Credit for the original design goes to him. I simply recreated it using this program and added some features. 

Changing the side parameter directly affects the radius of the sweeps. So, only this parameter needs to be changed if you desire a different size model.
*/

// Modules ----------------------------------------
main ();
// ----------------------------------------

module main ()
{
    side =  14; // Side length of the square cross section. This directly affects the overall shape of the borsalino.
    r = .5*side; // sweep radius of the endcap
    R = r + sqrt(2)*r; //sweep radius of the medial axis of the connector.
    //endcap(side);
    //male_sleeve(side);
    //connector(side, r, R);
    //rhombic_extender(side);
    //twisted_connector(side);
    knot_module(side);
    //rhombic_endcap(side);
}

module endcap(side)
{
        r = .5*side; // sweep radius of the endcap
        R = r + sqrt(2)*r; //sweep radius of the medial axis of the connector.
    
        difference(){
            rotate_extrude(convexity = 10, $fn = 100)
            basic_square(side,0);
            
            translate([0, -side, -side/2])
            cube([side*2,side*2, side*2], false);
            
            translate([-.2*side,  (.125*side)/2 ,  (.125*side)/2])
            female(side);
            
            mirror([0, 1, 0])
            translate([-.2*side,  (.125*side)/2 ,  (.125*side)/2])
            female(side);
        }
 }
 
 module rhombic_endcap(side)
{
        r = .5*side; // sweep radius of the endcap
        R = r + sqrt(2)*r; //sweep radius of the medial axis of the connector.
    
        difference(){
            rotate_extrude(convexity = 10, $fn = 100)
            basic_rhombus(side, 45);
            
            translate([0, -side*2, -side/2])
            cube([side*2,side*4, side*2], false);
            
            translate([-.2*side, (side/2 + side/4.5) ,  (.225*side)/2])
            rotate([45,0,0])
            female(side);
            
            mirror([0, 1, 0])
            translate([-.2*side, (side/2 + side/4.5) ,  (.225*side)/2])
            rotate([45,0,0])
            female(side);
        }
 }
 
 module twisted_connector(side)
 {
        difference(){
            linear_extrude(height = 2*side, center = false, convexity =10,  twist=90, slices = 100)
            basic_square(side,0);
            
            translate([.125*side*.5,  (.125*side)*.5 ,  -(side - .21*side)])
            female(side);
            
            translate([.125*side*.5,  -(.125*side*.5) -( side- (.125*side))  ,  ( 2*side - .08*side)])
            female(side);
            
        }
 }
 
 module rhombic_extender(side)
 {
        difference(){
            translate([0,0,side])
            rotate([0,90,0])
            cube([side, side, side*2]);
            
            translate([-.7*side,  (.125*side)/2 ,  (.125*side)/2])
            female(side);
           
            translate([(-.2*side + 2*side),  (.125*side)/2 ,  (.125*side)/2])
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
 
 module basic_rhombus(side, rotation)
 {
        translate([(side/2 + side/4.5), (side/2 + side/4.5), 0])
        rotate([0,0,rotation])
        difference(){
            square(side, true);
            square(side - (side/2), true);
        }
 }
 module basic_square(side,rotation)
 {

        translate([(side/2), (side/2), 0])
        rotate([0,0,rotation])
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
 
 module sixteengon_bend(side)
 {
        difference(){
            rotate_extrude(convexity = 10, $fn = 100)
            translate([side, side, 0])
            difference(){
                circle(r=side,  $fn=16);
                circle(r= side - (side/2), $fn=16);
            }
            translate([-side*2, -side*2.5, 0])
            cube([side*2,side*5, side*2], false);
            
            rotate([0, 0, 90])
            translate([-side*2, -side*2.5, 0])
            cube([side*2,side*5, side*2], false);
            
            rotate([0, 0, 150])
            translate([-side*2, -side*2.5, 0])
            cube([side*2,side*5, side*2], false);
        }
 }
 
 module knot_module(side)
 {
        difference(){
            union(){
                rotate([0,90,0])
                translate([-side, side, -side/4])
                difference(){
                    cylinder(r=side, h=side/4, $fn=16);
                    cylinder(r=side - (side/2), h=side/4, $fn=16);
                }
                sixteengon_bend(side);
                rotate([0,90,-30])
                translate([-side, side, 0])
                cylinder(r=side- (.125*side), h= .15*side, $fn=16);
            }
            rotate([0,90,0])
            translate([-side, side, -.26*side])
            cylinder(r=side- (.125*side), h= .15*side, $fn=16);
        }
 }