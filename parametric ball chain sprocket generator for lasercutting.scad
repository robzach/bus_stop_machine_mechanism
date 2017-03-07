// Parametric ball chain sprocket generator for lasercutting
// by Robert Zacharias, rz@rzach.me
// October 20, 2016
// released to the public domain by the author

// special variables to increase resolution
$fa = 1;
$fs = 1;

// diameter of each ball in the chain, approximately 4.76mm for #10 chain
ballDiameter = 4.76; 

// length of link between neighboring balls; note that this value will be different when the chain is straight versus going around a curve so some experimentation may be in order. Approximately 1.8mm for #10 chain in a straight run.
linkLength = 1.8;

// number of teeth the sprocket will accomodate
numTeeth = 40;

// size of hole in center of all pieces
centerHoleRadius = 5;

// amount guard plates overhang the gear plate
guardPlateOverhangRadius = 7; 

showGuards = "yes"; //[yes,no]

// preview[view:north, tilt:top]

circumference = (ballDiameter + linkLength) * numTeeth;
circleRadius = circumference / (2 * PI);

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
    
    circle(centerHoleRadius);
}
//
// top and bottom guards to keep chain aligned on sprocket

if (showGuards == "yes"){
    translate([(circleRadius + guardPlateOverhangRadius/2) * 2 + 1, 0, 0]) 
    difference(){
        circle(circleRadius + guardPlateOverhangRadius);
        circle(centerHoleRadius);
    }
    
    translate([(circleRadius + (guardPlateOverhangRadius + circleRadius) * 3) + 2, 0, 0]) 
    difference(){
        circle(circleRadius + guardPlateOverhangRadius);
        circle(centerHoleRadius);
    }
}