/*
Parametric knob housing for bus stop interaction machine

native units are mm

4/1/17 original version with curved cutouts that required complex boolean effort to get right
4/1/17 later in the day:
    - replaced complicated curved cutouts with triangular sections
    - added cutouts for brass bearings, McMaster part 2938T19
    - does not yet allow for actual mounting hardware, so that needs work

Robert Zacharias, rz@rzach.me
released to the public domain by the author
*/

x = 100;
y = 80;
z = 50;
holeDia = tomm(3/4);
mouthWidth = tomm(1/2);

difference(){
    // box
    linear_extrude(z){
        difference(){
            square([x, y]);
            translate([60,40]) circle(holeDia/2, center=true);
        }
    } 

    // surface cylinder cut
    translate([60,40,z-10]) linear_extrude(15) circle(45/2);
    
    // surface triangular cut
    translate([0,40,z-10]) linear_extrude(15) polygon(points=[[0,-mouthWidth/2],[60,-45/2],[60,45/2],[0,mouthWidth/2]]);

    // bearing on bottom side
    translate([60,40]) bearing();
    
    // bearing on top side
    translate([60,40,z-10]) rotate([180,0,0]) bearing();

}

module bearing(){
    union(){
        linear_extrude(tomm(1/2)) circle(tomm(7/8)/2);
        linear_extrude(tomm(1/8)) circle(tomm(1.25)/2);
    }
}

// special variables to increase rendering resolution
$fa = 1;
$fs = 1;

function toin (mm) = mm / 25.4;
function tomm (in) = in * 25.4;