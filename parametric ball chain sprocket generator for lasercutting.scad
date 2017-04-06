// Parametric ball chain sprocket generator for lasercutting
//
// native units intended as millimeters
//
// October 20, 2016 (original)
// March 29, 2017 (added D-cut option; switched to boolean options; refactored slightly)
// April 5, 2017
//  - added tomm() function
//  - changed linkLength to 1.2 by default, which matches previous cuts for the bus stop project
//
// by Robert Zacharias, rz@rzach.me
// released to the public domain by the author

// special variables to increase resolution
$fa = 1;
$fs = 1;

// diameter of each ball in the chain, approximately 4.76mm for #10 chain
ballDiameter = 4.76; 

// length of link between neighboring balls; note that this value will be different when the chain is straight versus going around a curve so some experimentation may be in order. Approximately 1.8mm for #10 chain in a straight run.
linkLength = 1.2;

// number of teeth the sprocket will accomodate
numTeeth = 20;

// size of hole in center of all pieces
centerHoleDiameter = tomm(3/4);

// make a D-cut in the center hole? (for fitting on a shaft with a flat)
dCut = false; // [true, false]
// if yes, what's the perpendicular distance from the opposite side of the circle to the flat being cut out of it
dDist = 4.48; // this worked for a NEMA 17 stepper motor shaft with a flat

// amount guard plates overhang the gear plate
guardPlateOverhangRadius = 7; 

showGuards = true; //[true, false]

// preview[view:north, tilt:top]

circumference = (ballDiameter + linkLength) * numTeeth;
circleRadius = circumference / (2 * PI);
centerHoleRadius = centerHoleDiameter / 2;

echo("circleRadius", circleRadius);
echo("overhang plate radius", guardPlateOverhangRadius + circleRadius);

// main gear with center hole cut out
difference(){  
    circle(circleRadius);
    
    for(i = [0 : numTeeth]) {   
        angleStep = 360/numTeeth;                
        xTranslate = circleRadius*sin(i*angleStep);
        yTranslate = circleRadius*cos(i*angleStep);
        translate([xTranslate, yTranslate, 0]) circle(d = ballDiameter);
    }
    
    cutCenterHole();
    
}

// top and bottom guards to keep chain aligned on sprocket
if (showGuards){
    translate([(circleRadius + guardPlateOverhangRadius/2) * 2 + 1, 0, 0]) 
    difference(){
        circle(circleRadius + guardPlateOverhangRadius);
        cutCenterHole();
    }
    
    translate([(circleRadius + (guardPlateOverhangRadius + circleRadius) * 3) + 2, 0, 0]) 
    difference(){
        circle(circleRadius + guardPlateOverhangRadius);
        cutCenterHole();
    }
}

module cutCenterHole(){
    if (dCut){
        intersection(){
            circle(centerHoleRadius);
            translate([-centerHoleRadius, -centerHoleRadius, 0]){
                square([dDist, centerHoleDiameter]);
            }
        }
    }
    else circle(centerHoleRadius);
}

function tomm(in) = in * 25.4;