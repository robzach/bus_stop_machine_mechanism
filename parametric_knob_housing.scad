/*
Parametric knob housing for bus stop interaction machine

native units are mm

4/1/17 original version with curved cutouts that required complex boolean effort to get right
4/1/17 later in the day:
    - replaced complicated curved cutouts with triangular sections
    - added cutouts for brass bearings, McMaster part 2938T19
    - does not yet allow for actual mounting hardware, so that needs work
4/4/17
    - changed output size to 5/8" which is the acrylic pipe ID
    - added option for DXF output, for printing on paper and manual milling
    - added more variables and calculated variables so nearly every dimension is parametric from the top input values (exception: bearing)
    - added center marker thing (can't make lines so it has to be a polygon)
4/17/17
    - using projection() to make crossection of final design for use as shop drawings (flip this on or off with by commenting/uncommenting)

Robert Zacharias, rz@rzach.me
released to the public domain by the author
*/

x = 150;
y = 100;
z = 50;
holeDia = tomm(7/8);
mouthWidth = tomm(5/8);
guardAllowanceDia = 55; // for guard that rides along next to chain
gearAllowanceDia = 40; // actual width of the gear driving the chain
knobOffsetFromCenter = 20; // along x
cutDepth = 10; // along z


axisPos = [(x/2)+knobOffsetFromCenter, y/2];
axisPos3d = [(x/2)+knobOffsetFromCenter, y/2, z-10];

DXF = false;

if(DXF){
    
    // main body
     difference(){
            square([x, y]);
            translate(axisPos) circle(holeDia/2, center=true);
            translate(axisPos) circle(guardAllowanceDia/2);
            translate([0,y/2]) polygon(points=[[0,-mouthWidth/2],[knobOffsetFromCenter+(x/2),-gearAllowanceDia/2],[knobOffsetFromCenter+(x/2),gearAllowanceDia/2],[0,mouthWidth/2]]);
     }
     
     // bushing
     translate(axisPos){
         difference(){
            circle(tomm(1.25)/2);
            circle(tomm(7/8)/2);
         }
     }
     
     // center mark
     translate(axisPos){
         polygon(points=[[5,5],[-5,5],[-5,-5],[5,-5],[0,0],[5,5]]);
     }
}

else{
    
    // comment following line, and its matching curly bracket, to turn off crossection slicing
    projection(cut=true) translate([0,0,-y/2]) rotate([90,0,0]) {
    
        difference(){
            // box
            linear_extrude(z){
                difference(){
                    square([x, y]);
                    translate(axisPos) circle(holeDia/2, center=true);
                }
            }
        
            // surface cylinder cut
            translate(axisPos3d) linear_extrude(cutDepth+1) circle(guardAllowanceDia/2);
            
            // surface triangular cut
            translate([0,y/2,z-cutDepth]) linear_extrude(cutDepth+1) polygon(points=[[0,-mouthWidth/2],[(x/2)+knobOffsetFromCenter,-gearAllowanceDia/2],[(x/2)+knobOffsetFromCenter,gearAllowanceDia/2],[0,mouthWidth/2]]);
        
            // bearing on bottom side
            translate(axisPos) bearing();
            
            // bearing on top side
            translate(axisPos3d) rotate([180,0,0]) bearing();
        }
    }
}



module bearing(){ // McMaster part 2938T19
    union(){
        linear_extrude(tomm(1/2)) circle(tomm(7/8)/2);
        linear_extrude(tomm(1/8)) circle(tomm(1.25)/2);
    }
}

function tomm (in) = in * 25.4;

// special variables to increase rendering resolution
$fa = 1;
$fs = 1;
