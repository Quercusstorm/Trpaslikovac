%variables
TIME_STEP = 64; %world time_step
time = 0;
time_delay = 1000;
read = 1;
simulation_stop = 0;

LM_pos = 0; %motor position transfer
RM_pos = 0;

%speeds and accelaritons
move_speed = 1;
move_acceleration = 5;

grabber_speed = 1;
grabber_acceleration = 5;

arm_speed = 1;
arm_acceleration = 5;

%phase settings
search_phase = "pick";
phase = "rotate";


%arm and grabber
pivot_1 = wb_robot_get_device('pivot_1');
pivot_2 = wb_robot_get_device('pivot_2');
pivot_3 = wb_robot_get_device('pivot_3');
pivot_4 = wb_robot_get_device('pivot_4');
finger_a = wb_robot_get_device('grabber finger A');
finger_b = wb_robot_get_device('grabber finger B');
finger_c = wb_robot_get_device('grabber finger C');
wb_motor_set_velocity(pivot_1, arm_speed)
wb_motor_set_velocity(pivot_2, arm_speed)
wb_motor_set_velocity(pivot_3, arm_speed)
wb_motor_set_velocity(pivot_4, arm_speed)
wb_motor_set_velocity(finger_a, grabber_speed);
wb_motor_set_velocity(finger_b, grabber_speed);
wb_motor_set_velocity(finger_c, grabber_speed);
wb_motor_set_acceleration(pivot_1, arm_acceleration);
wb_motor_set_acceleration(pivot_2, arm_acceleration);
wb_motor_set_acceleration(pivot_3, arm_acceleration);
wb_motor_set_acceleration(pivot_4, arm_acceleration);
wb_motor_set_acceleration(finger_a, grabber_acceleration);
wb_motor_set_acceleration(finger_b, grabber_acceleration);
wb_motor_set_acceleration(finger_c, grabber_acceleration);
  
%idar
lidar = wb_robot_get_device('lidar');
wb_lidar_enable(lidar, TIME_STEP);
wb_lidar_enable_point_cloud(lidar);

%motors
left_motor = wb_robot_get_device('left_motor');
right_motor = wb_robot_get_device('right_motor');
wb_motor_set_velocity(left_motor, move_speed);
wb_motor_set_velocity(right_motor, move_speed);
wb_motor_set_acceleration(left_motor, move_acceleration);
wb_motor_set_acceleration(right_motor, move_acceleration);





%loop
while wb_robot_step(TIME_STEP) ~= -1

  time = TIME_STEP + time; %count time every loop
  coordinates = lidar_scan(lidar); %read lidar every loop

  if read == 1
    %save('coordinates.mat','coordinates')         %save coordinates for testing
    [distance, angle, status] = lidar_search(coordinates, search_phase); %search object
    [rotate_R, rotate_L] = rotate_robot(angle); %calc rotate
    [move_R, move_L] = move_robot(distance); %calc move
    read = 0; %read off for other loops
  end

  if phase == "rotate" %rotate phase
    wb_motor_set_position(left_motor, rotate_L + LM_pos); %motor rotate
    wb_motor_set_position(right_motor, rotate_R + RM_pos);
    move_time = 1000 * move_speed * abs(rotate_L) + time_delay; %time calc
    if time > move_time %rotete delay
      if status == 0
        read = 1;
      else
        phase = "move";
      end
      time = 0; %null time
      LM_pos = rotate_L + LM_pos; %motor position update
      RM_pos = rotate_R + RM_pos;
     end
   end
  
  if phase == "move" %move phase
    wb_motor_set_position(left_motor, move_L + LM_pos); %motor rotate
    wb_motor_set_position(right_motor, move_R + RM_pos);
    move_time = 1000 * move_speed * abs(move_L) + time_delay; %time calc
    if time > move_time %move delay
      if search_phase == "pick"
        arm_phase = "open";
        phase = "grabber";
      else
        arm_phase = "down";
        phase = "arm";
      end
      LM_pos = move_L + LM_pos; %motor position update
      RM_pos = move_R + RM_pos;
      time = 0; %null time
    end
  end
  
  if phase == "grabber" %grabber phase
    [grab_pos_1, grab_pos_2,grab_pos_3] = arm (arm_phase); %finger calc
    wb_motor_set_position(finger_a, grab_pos_1); %finger move
    wb_motor_set_position(finger_b, grab_pos_2);
    wb_motor_set_position(finger_c, grab_pos_3);
    move_time = 1000 * grabber_speed * abs(grab_pos_3) + time_delay; %time calc
    if time > move_time %grabber delay
      if search_phase == "pick"
        if arm_phase == "open"
          phase = "arm";
          arm_phase = "down";
         else
           phase = "search_switch";
         end
       else 
         if arm_phase == "open"
           phase = "arm";
           arm_phase = "up";
         else
           phase = "search_switch";
         end
       end
       time = 0; %null time
     end
   end 
  
  if phase == "arm" %arm phase
    [arm_pos_1, arm_pos_2, arm_pos_3] = arm (arm_phase); %arm calc
    wb_motor_set_position(pivot_1, arm_pos_1); %arm move
    wb_motor_set_position(pivot_2, arm_pos_1);
    wb_motor_set_position(pivot_3, arm_pos_2);
    wb_motor_set_position(pivot_4, arm_pos_3);
    move_time = 1000 * arm_speed * abs(arm_pos_3) + time_delay; %time calc
    if time > move_time %arm delay
      if search_phase == "pick"
        if arm_phase == "down"
          arm_phase = "close";
          phase = "grabber";
        else 
        phase = "search_switch";
        end
      else
        if arm_phase == "down"
          arm_phase = "open";
          phase = "grabber";
        else 
          phase = "search_switch";
        end
      end
      time = 0; %null time
    end
  end

  if phase == "search_switch" %search phase switch
    
      [move_R, move_L] = move_robot (-0.12); %move back from object
      wb_motor_set_position(left_motor, move_L + LM_pos); %motor rotate
      wb_motor_set_position(right_motor, move_R + RM_pos);
      move_time = 1000 * move_speed * abs(move_L) + time_delay; %time calc
      if time > move_time
        if simulation_stop == 1
          return %simulation stop
        else
          search_phase = "place"; %switch search phase
          read = 1; %read on
          phase = "rotate";
          simulation_stop = 1;
          LM_pos = move_L + LM_pos; %motor position update
          RM_pos = move_R + RM_pos;
          time = 0; %null time
        end
      end
  end 
  
  drawnow;

end