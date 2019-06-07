$fn = 30;

TL = 110;
TW = 140;
TH = 27;
RailWidth = 5;
LidH = 3;

WT = 2;

Tol =0.3;


module RCube(x,y,z,ipR=2, ipFlatTop = 0)
{
    hull(){
      translate([ipR,ipR,ipR]) sphere(ipR);
      translate([x-ipR,ipR,ipR]) sphere(ipR);
      translate([ipR,y-ipR,ipR]) sphere(ipR);
      translate([x-ipR,y-ipR,ipR]) sphere(ipR);
      if (ipFlatTop > 0)
        {
          translate([ipR,ipR,z-ipR]) cylinder(r=ipR,h=ipR);
          translate([x-ipR,ipR,z-ipR]) cylinder(r=ipR,h=ipR);
          translate([ipR,y-ipR,z-ipR]) cylinder(r=ipR,h=ipR);
          translate([x-ipR,y-ipR,z-ipR]) cylinder(r=ipR,h=ipR);
        }
        else
        {  
          translate([ipR,ipR,z-ipR]) sphere(ipR);
          translate([x-ipR,ipR,z-ipR]) sphere(ipR);
          translate([ipR,y-ipR,z-ipR]) sphere(ipR);
          translate([x-ipR,y-ipR,z-ipR]) sphere(ipR);
        }
    }   
} 

module lid(ipTol = 0.3){
    
  translate([0,LidH+ipTol,0]) cube([TL-2,TW-RailWidth*2-ipTol*2,LidH-ipTol]);
  translate([0,ipTol,LidH]) rotate([0,90,0]) linear_extrude(TL-2) polygon([[LidH,0],[LidH,LidH],[ipTol,LidH]], paths=[[0,1,2]]);
  translate([0,TW-RailWidth*2+LidH-ipTol,LidH]) rotate([0,90,0]) linear_extrude(TL-2) polygon([[ipTol,0],[LidH,0],[LidH,LidH]], paths=[[0,1,2]]);


}

module Box() 
{
difference()
{
   RCube(TL, TW, TH, ipR=2, ipFlatTop=true);

   translate([WT,RailWidth,WT]) RCube((TL-3*WT)/2, (TW-WT-2*RailWidth)/2, TH+10, ipR =4);
   translate([TL/2+WT/2,RailWidth,WT]) RCube((TL-3*WT)/2, (TW-WT-2*RailWidth)/2, TH+10, ipR =4);
   translate([WT,TW/2+WT/2,WT]) RCube((TL-3*WT)/2, (TW-WT-2*RailWidth)/2, TH+10, ipR =4);
   translate([TL/2+WT/2,TW/2+WT/2,WT]) RCube((TL-3*WT)/2, (TW-WT-2*RailWidth)/2, TH+10, ipR =4);

   translate([WT,RailWidth-LidH,TH-LidH]) lid(0);
    
   // rails for lid 
//   translate([28, 0, TH]) cube([TL-56, TW, LidH]);
//   translate([0, 13, TH]) cube([TL, TW-26, LidH]);
//  translate([2,13-3,TH+3]) rotate([0,90,0]) linear_extrude(TL) polygon([[LidH,0],[LidH,LidH],[0,LidH]], paths=[[0,1,2]]);
//  translate([2,TW-13,TH+3]) rotate([0,90,0]) linear_extrude(TL) polygon([[0,0],[LidH,0],[LidH,LidH]], paths=[[0,1,2]]);


   
}
}

Box();
translate([0,TW+20,0]) lid();
