function[a,b,c]= arm (arm_phase)
  switch (arm_phase)
  
    case  ('up')
      a = 0;
      b = 0;
      c = 0;
   
    case ('down')
    a = -0.5;
    b = -0.5;
    c = -1.57;
   end
end