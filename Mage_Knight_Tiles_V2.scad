$fn = 30;

TL = 110;
TW = 140;
TH = 27;
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

module lid(){
    
  translate([0,Tol,0])  cube([TL-2,TW-26-Tol*2,LidH-Tol]);
  translate([0,0-3+Tol,LidH]) rotate([0,90,0]) linear_extrude(TL-2) polygon([[LidH,0],[LidH,LidH],[Tol,LidH]], paths=[[0,1,2]]);
  translate([0,TW-26-Tol,LidH]) rotate([0,90,0]) linear_extrude(TL-2) polygon([[Tol,0],[LidH,0],[LidH,LidH]], paths=[[0,1,2]]);


}

module Box() 
{
difference()
{
   RCube(TL, TW, TH+LidH, ipR =3, ipFlatTop=true);

    
   // rails for lid 
   translate([28, 0, TH]) cube([TL-56, TW, LidH]);
   translate([0, 13, TH]) cube([TL, TW-26, LidH]);
  translate([2,13-3,TH+3]) rotate([0,90,0]) linear_extrude(TL) polygon([[LidH,0],[LidH,LidH],[0,LidH]], paths=[[0,1,2]]);
  translate([2,TW-13,TH+3]) rotate([0,90,0]) linear_extrude(TL) polygon([[0,0],[LidH,0],[LidH,LidH]], paths=[[0,1,2]]);


   
}
}

Box();
   // Lid
translate([0,TW+20,0]) lid();
