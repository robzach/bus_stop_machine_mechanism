x = 100;
y = 80;
z = 40;
holeDia = tomm(0.75);

$fa = 2;
$fs = 2;

difference(){
    // box
    linear_extrude(z){
        difference(){
            square([x, y]);
            translate([60,40]) circle(holeDia/2, center=true);
        }
    } 

    difference(){
        // circle to use for selecting out itty slice
        translate([35,50,z-10]) linear_extrude(11) circle(17);
        
        // same big cylinder and rectangle that appear below
        union(){
            translate([60,40,z-10]) linear_extrude(15) circle(45/2);
            translate([0,30,z-10]) linear_extrude(15) square([40,20]);
        }
        
        // circle that actually cuts out the smoothing cut
        translate([19,110,z-10]) linear_extrude(15) circle(60);
    }
    
    difference(){
        // circle to use for selecting out itty slice
        translate([35,30,z-10]) linear_extrude(11) circle(17);
        
        // same big cylinder and rectangle that appear below
        union(){
            translate([60,40,z-10]) linear_extrude(15) circle(45/2);
            translate([0,30,z-10]) linear_extrude(15) square([40,20]);
        }
        
        // circle that actually cuts out the smoothing cut
        translate([19,-30,z-10]) linear_extrude(15) circle(60);
    }

    // surface cylinder cut
    translate([60,40,z-10]) linear_extrude(15) circle(45/2);
    
    // surface rectangle cut
    translate([0,30,z-10]) linear_extrude(15) square([40,20]);

}

function toin (mm) = mm / 25.4;
function tomm (in) = in * 25.4;