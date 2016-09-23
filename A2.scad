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
    roundness = 1;
    size = 80;
    boundary = 5;
    ghost();
    //face(roundness,size, boundary, 1);
    test(roundness, size, boundary);
    face(roundness,size, boundary, -1);
    //face(roundness,-size, true);
    color("red")
        translate([-(size*1.5), -(size*1.5),-(size)])
            *cube([(size*3), (size*3), size]);
    //cube ([width,length,height]);
    //rotate([0,0,0])
        //cylinder(25, 25, 6, $fn=3); // Triangular prism
    
    
}

module ghost ()
{
    translate([80, -80, -1])
    import("/Users/NHB/Documents/TAMU/COMP FAB/OpenSCAD/Destiny_Ghost.stl", convexity=4); // Laptop
    
    //import("/Users/NHB/Documents/TAMU/489/OpenSCAD/Destiny_Ghost.stl", convexity=4); // iMac
}


module face (roundness, size, buffer, side)
{
    s = size;
    size = size*side;
    buffer = buffer*side;
    echo(size);
    echo(s);
    translate([buffer, buffer,(-size/2)])
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
        translate([-(abs(size*1.5)) - buffer, -(abs(size*1.5)) - buffer,-(abs(size/2))])
            cube([(abs(size*3)), abs((size*3)), abs(size)]);
    }
}

module tetrahedron(roundness, size) 
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
}

module test(roundness, size, buffer)
{
    translate([buffer, buffer,(-size/2)])
    difference()
    {
        tetrahedron(roundness, size);
        
        translate([-(abs(size*1.5)) - buffer, -(abs(size*1.5)) - buffer,-(abs(size/2))])
            cube([(abs(size*3)), abs((size*3)), abs(size)]);
    }
}
