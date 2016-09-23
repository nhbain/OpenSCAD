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
    roundness = 1.5;
    size = 100;
    buffer = 5;
    ghost();
    top(roundness, size, buffer);
    bottom(roundness, -size, -buffer);
    pegs(size);
    //cube ([width,length,height]);
    //rotate([0,0,0])
        //cylinder(25, 25, 6, $fn=3); // Triangular prism
    color("red")
        translate([size/2,size/2,(size/3)])
            *cylinder(size/3, size/3, 0, $fn=4);
    
    
}

module shell(roundness, size) 
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

module top(roundness, size, buffer)
{
    translate([buffer, buffer,(-size/2)])
    //color("red")
        //translate([0,0,0])
            
    difference()
    {
        shell(roundness, size);
        
        translate([-(size/2), -(size/2),-((size/2))])
            cube([(size*2), (size*2), size]);
        
        translate([size/2,size/2,(size)])
            cube([size/3, size/3, size/3], true);
        
        translate([size/2, size/2, size/2])
                sphere(abs(size/3.5));
    }
}

module bottom(roundness, size, buffer)
{
    translate([buffer, buffer,(-size/2)])
    difference()
    {
        shell(roundness, size);
        
        translate([(1.5*size), (1.5*size),((1.5*size))])
            cube([abs((size*2)), abs((size*2)), abs(size)]);
        
        translate([size/2,size/2, 0])
            cube([abs(size/3), abs(size/3), abs(size/3)], true);
        
        translate([size/2, size/2, size/2])
                sphere(abs(size/3.5));
            //cube([abs(size/6), abs(size/6), abs(size/6)]);       
    }
}

module pegs(size)
{
   color("red")
    translate([size/4, size/4, -(size/10)])
    {
        rotate(a = 270, v = [0,0,4])
            cylinder(h=size/10, r=.03*size, center=false);
        
        for(r = [0:90:270])
        {
            rotate(a = r, v =[0,0,1])
                cylinder(h=size/10, r=.03*size, center=false);
        }
    }
        
    
}

module ghost ()
{
    translate([80, -80, -1])
    //import("/Users/NHB/Documents/TAMU/COMP FAB/OpenSCAD/Destiny_Ghost.stl", convexity=4); // Laptop
    
    import("C:\\Users\\NHB\\Documents\\TAMU\\489\\OpenSCAD\\Destiny_Ghost.stl", convexity=4); //Desktop
    //import("/Users/NHB/Documents/TAMU/489/OpenSCAD/Destiny_Ghost.stl", convexity=4); // iMac
}