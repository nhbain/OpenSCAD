/*
TITLE OF PART

Author: Nicolas Bain

Usage:

*/

// Modules ----------------------------------------
main ();
// ----------------------------------------

module main ()
{
    ghost();
    width = 2;
    height = 4;
    length = 3;
    //cube ([width,length,height]);
    cylinder(25, 25, 6, $fn=3); //
    
}

module ghost ()
{
    import("/Users/NHB/Documents/TAMU/COMP FAB/OpenSCAD/Destiny_Ghost.stl", convexity=4); // Laptop
}