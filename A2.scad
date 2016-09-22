/*
Destiny Ghost Container

Author: Nicolas Bain

Usage: This is modeled after the Ghost character in the game Destiny. All credit for the original design goes to Bungie. I simply recreated it using this program and added features. 

*/

// Modules ----------------------------------------
main ();
// ----------------------------------------

module main ()
{
    roundness = 2;
    size = 60;
    ghost();
    face(roundness,size);
    face(roundness,-size);
    //face(roundness,-size, true);
    color("red")
        translate([(size/2), (size/2),(size/2)])
            cube([-(size*2), -(size*2), -size]);
    //cube ([width,length,height]);
    //rotate([0,0,0])
        //cylinder(25, 25, 6, $fn=3); // Triangular prism
    
    
}

module ghost ()
{
    //import("/Users/NHB/Documents/TAMU/COMP FAB/OpenSCAD/Destiny_Ghost.stl", convexity=4); // Laptop
    translate([80, -80, -1])
        import("/Users/NHB/Documents/TAMU/489/OpenSCAD/Destiny_Ghost.stl", convexity=4); // iMac
}


module face (roundness, size)
{
    difference()
    {
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
        translate([-(size/2), -(size/2),-(size/2)])
            cube([size*2, size*2, size]);
    }
}
