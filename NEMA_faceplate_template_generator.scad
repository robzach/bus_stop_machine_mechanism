// NEMA Stepper motor face plate generator
//
// default settings are for NEMA 17 motor pattern
// also contains values for NEMA 23
// native units are millimeters
//
// March 30, 2017 (first version, while I definitely should've been doing homework)
//
// Robert Zacharias, rz@rzach.me
// released by the author to the public domain

// special variables to increase resolution
$fa = 1;
$fs = 1;

// NEMA 17 values
motorFaceSquare = 42.3;
plateWidth = motorFaceSquare *2; // can be any value
plateHeight = motorFaceSquare; // can be any value
centerHoleDiameter = 22;
screwHoleDiameter = 3.4; // clearance hole for M3 screw
screwSpacing = 31; // length of edge of square the screws are arranged in

// NEMA 23 values (comment out NEMA 17 block above and uncomment this block to use)
/*
motorFaceSquare = 56.4;
plateWidth = motorFaceSquare * 2; // can be any value
plateHeight = motorFaceSquare; // can be any value
centerHoleDiameter = 38.1;
screwHoleDiameter = 5;
screwSpacing = 47.14; // length of edge of square the screws are arranged in
*/

difference(){
    // background plate
    translate([-plateWidth/4, -plateHeight/2]) square([plateWidth, plateHeight]);
    
     // center hole
    circle(centerHoleDiameter/2);
    
    translate([-screwSpacing/2,screwSpacing/2]) circle(screwHoleDiameter/2); // UL hole
    translate([screwSpacing/2,screwSpacing/2]) circle(screwHoleDiameter/2); // UR hole
    translate([-screwSpacing/2,-screwSpacing/2]) circle(screwHoleDiameter/2); // LL hole
    translate([screwSpacing/2,-screwSpacing/2]) circle(screwHoleDiameter/2); // LR hole
}