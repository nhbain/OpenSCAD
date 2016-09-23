/*
Destiny Ghost Container

Author: Nicolas Bain

Usage: This is modeled after the Ghost character in the game Destiny. All credit for the original design goes to Bungie. I simply recreated it using this program and added some features. 

*/

// Modules ----------------------------------------
main ();
// ----------------------------------------

module main ()
{
    roundness = 1.5; //This affects the shape of the ghost. The ideal range is 0 < r <= 4. 
    size = 60; // Overall size of the ghost. If you change this drastically, you may have to increase buffer size before export
    buffer = 5; //Simply a parameter to space the top and bottom halves of the ghost so they don't overlap
    
    top(roundness, size, buffer); 
    bottom(roundness, -size, -buffer);
}

module shell(roundness, size) 
{
    //this module forms the basic shape of the ghost by performing a union between two tetrahedrons
    //that use the eight points of a cube as vertices
    union(){
        hull()
        {
            translate([0,0,0])
                sphere(roundness);
            
            translate([size,size,0])
                sphere(roundness);
            
            translate([0,size,size])
                sphere(roundness);
            
            translate([size, 0, size])
                sphere(roundness);
        }

        hull()
        {
            translate([size,size,size])
                sphere(roundness);
            
            translate([0,0,size])
                sphere(roundness);
            
            translate([size,0,0])
                sphere(roundness);
            
            translate([0, size, 0])
                sphere(roundness);
        }
    }
}

module top(roundness, size, buffer)
{
    // This module constructs the top face of the ghost (the one with the eye)
    translate([buffer, buffer,(-size/2)]) //This translate is just to make sure that the top and bottom pieces don't collide
    {
        union(){
            difference()
            {
                shell(roundness, size); 
                
                translate([-(size/2), -(size/2),-(size/2)])
                    cube([size*2, size*2, size]); //Cube used to cut off the bottom half of the shell
                
                translate([size/2, size/2, (size + size/12)])
                    cube([size/3, size/3, size/2], true); //Cube used to cut out the square space for the eye
                
                translate([size/2, size/2, size/2])
                        sphere(abs(size/3.5)); // Sphere used to cut and create the "container space"
                
            }
            top_slider(size,buffer); // Add slider piece to top half 
            
            translate([size/2, size/2, (size - size/5.5)])
                eye(size);  // Place the eye in the square space cut out previously
            
        }
    }
}

module bottom(roundness, size, buffer)
{
    // This module constructs the bottom face of the ghost
    translate([buffer, buffer,(-size/2)]) //This translate is just to make sure that the top and bottom pieces don't collide
    {
        union()
        {
            difference()
            {
                shell(roundness, size);
                
                translate([(1.5*size), (1.5*size),((1.5*size))])
                    cube([abs((size*2)), abs((size*2)), abs(size)]); //Cube used to cut off the bottom half of the shell
                
                translate([size/2,size/2, -size/12])
                    cube([abs(size/3), abs(size/3), abs(size/2)], true); //Cube used to cut out the square space for the back piece
                
                translate([size/2, size/2, size/2])
                        sphere(abs(size/3.5)); // Sphere used to cut and create the "container space"
                
                bottom_slider(size,buffer); //Cut into the bottom of the shell to make the hole for the top_slider
                
                translate([0,0,0])
                    cube([size/10, size/10, size/10], false);
            }
            
            translate([size/2, size/2, -(size/32 - size/4.2)]) 
                back(-size); // Place the back piece into the square space cut previously
        }
    }
}

module top_slider(size, buffer)
{
    // Create a piece that can slide into the bottom half of the shell so that they lock into place.
    difference()
    {
        translate([(size/1.35), (size/3.85), size/2 - size/30])
            rotate([0,0,45])
                cube([size/1.4, size/18, size/15], true); //Main shape of slider
        
        translate([(size/1.35 - size/50), (size/3.85), (size/2 - size/45) ])
            rotate([0,0,45])
                cube([size/1.3, size/25, size/22], true); //Cut out the inside of the main shape
    }
}

module bottom_slider(size, buffer)
{
    // Create a hole in the bottom half of the shell that matches the top_slider
    difference()
    {
        translate([(size/1.35), (size/3.85), size/2 - size/30])
            rotate([0,0,45])
                cube([abs(size*2), abs(size/18), abs(size/15)], true);
        
        translate([(size/1.35 - size/50), (size/3.85), (size/2 - size/45) ])
            rotate([0,0,45])
                cube([abs(size*2), abs(size/25), abs(size/22)], true);
    }
}

module eye(size)
{
    translate([0,0, size/44])
    {
        union()
        {
            difference()
            {
                cylinder(h = size/22, r=size/8, center=true, $fn=60); // Form the shape of the eye
                
                translate([0,0, size/44])
                    cylinder(h = size/22, r = size/10, center = true, $fn=60); // Cut out the center
            }
            
            translate([0,0, 0])
                cylinder(h = size/44, r = size/48, center=true, $fn=60); // Forms the pupil
            
            iris(size);
        }
    }
}

module iris(size)
{
    {
        difference()
        {
            cube([size/10, size/10, size/44], true); // Form the basic shape of the iris (in this case a square)
            
            cube([size/15, size/15, size/22], true); // Cut out the center to make room for the pupil
            
            rotate([0,0,-45]){
                for( pos = [ [-size/15,0,0], [0,0,0], [size/15,0,0] ] ) 
                {
                    translate(pos)
                        cube([size/120, size/7, size/22], true); // Cut away parts of the square to give it a more defined shape
                }
            }
        }
    }
}

module back(size)
{
   rotate([0,0,-45])
   {
        difference()
        {
            sphere(abs(size/8)); // Sphere for basic shape
            
            translate([0,0, -(size/16)])
                cube([size/2, size/2, size/8], true); // Cube to cut away the bottom half of the sphere
            
            translate([0,0, size/7.5])
                cube([size/50, size/4, size/10], true); // Cut into the 
        }
   }
}