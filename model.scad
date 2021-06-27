thickness = 10;

width = 200;
depth = 300;

wheel_diameter = 100;
wheel_y_offset = wheel_diameter / 2;
wheel_z_offset = -28;

brush_holder_x_offset = 10;
brush_holder_y_offset = 10;

brush_diameter_inner = 25;
brush_diameter = 80;
brush_length = 80;

$fn = 180;

module motorR835() {
    // https://asset.conrad.com/media10/add/160267/c1/-/en/000227579DS01/datenblatt-227579-modelcraft-rb350200-0a101r-getriebemotor-12-v-1200.pdf
    color("lightgrey", 1.0) {
        back_diameter = 35;
        back_height = 29;
        
        middle_diameter = 37;
        middle_height = 27;
        
        front_diameter = 12;
        front_height = 7;
        front_offset = 7;
        
        turning_diameter = 6;
        turning_height = 15;
        
        screw_diameter = 3; // 6~M3xp0.5
        screw_height = 6; // ???
        
        cylinder(d=back_diameter, back_height);
        translate([0, 0, back_height]) difference() {
             cylinder(d=middle_diameter, middle_height);
            // screw holes
            rotate([0, 0, 30]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, middle_height - screw_height]) cylinder(d=screw_diameter, screw_height);
            rotate([0, 0, -30]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, middle_height - screw_height]) cylinder(d=screw_diameter, screw_height);
            rotate([0, 0, 90]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, middle_height - screw_height]) cylinder(d=screw_diameter, screw_height);           
            rotate([0, 0, -90]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, middle_height - screw_height]) cylinder(d=screw_diameter, screw_height);
            rotate([0, 0, 150]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, middle_height - screw_height]) cylinder(d=screw_diameter, screw_height);
            rotate([0, 0, -150]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, middle_height - screw_height]) cylinder(d=screw_diameter, screw_height);
        }
        
        translate([front_offset, 0, back_height + middle_height]) cylinder(d=front_diameter, front_height);
        
        translate([front_offset, 0, back_height + middle_height + front_height]) cylinder(d=turning_diameter, turning_height);
    }
}


module motorHolder() {
    //translate([width / 2 + thickness, depth / 2 + thickness, 0]) motorR835();
    
    thickness = 2;
    width = 40;
    depth = 40;
    height = 58;
    
    middle_diameter = 37;
    middle_height = 27;
    
    front_diameter = 12 + 1;
    front_offset = 7;
           
    screw_diameter = 3; // 6~M3xp0.5
    screw_height = 6; // ???
    
    base_plate_screw_distance_y = 30;
    base_plate_screw_distance_z = 40;

    color("blue", 0.8) {
        difference() {
            cube([width + thickness, depth + 2 * thickness, height + thickness]);
            translate([thickness, thickness, 0]) cube([width, depth, height]);
            
            translate([width / 2 + thickness, depth / 2 + thickness, height]) {
                // screw holes
                rotate([0, 0, 30]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, 0]) cylinder(d=screw_diameter, thickness);
                rotate([0, 0, -30]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, 0]) cylinder(d=screw_diameter, thickness);
                rotate([0, 0, 90]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, 0]) cylinder(d=screw_diameter, thickness);           
                rotate([0, 0, -90]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, 0]) cylinder(d=screw_diameter, thickness);
                rotate([0, 0, 150]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, 0]) cylinder(d=screw_diameter, thickness);
                rotate([0, 0, -150]) translate([middle_diameter / 2 - 0.5 - screw_diameter / 2, 0, 0]) cylinder(d=screw_diameter, thickness);
            }
        
            // motor axis
            translate([width / 2 + thickness + front_offset, depth / 2 + thickness, height]) cylinder(d=front_diameter, thickness);
            
            // base plate screws
            translate([0, (depth - base_plate_screw_distance_y) / 2 + thickness, (height - base_plate_screw_distance_z) / 2]) rotate([0, 90, 0]) cylinder(d=3, 5);
            translate([0, (depth - base_plate_screw_distance_y) / 2 + thickness + base_plate_screw_distance_y, (height - base_plate_screw_distance_z) / 2]) rotate([0, 90, 0]) cylinder(d=3, 5);
            translate([0, (depth - base_plate_screw_distance_y) / 2 + thickness, (height - base_plate_screw_distance_z) / 2 + base_plate_screw_distance_z]) rotate([0, 90, 0]) cylinder(d=3, 5);
            translate([0, (depth - base_plate_screw_distance_y) / 2 + thickness + base_plate_screw_distance_y, (height - base_plate_screw_distance_z) / 2 + base_plate_screw_distance_z]) rotate([0, 90, 0]) cylinder(d=3, 5);
        }
    }
}
//motorHolder();


module brush() {
    color("white", 0.4) {
        cylinder(d=brush_diameter_inner, brush_length);
        for ( z_offset = [0: brush_length/10: brush_length]) {
            for ( z_rotate = [0:10:360]) {
                translate([0, 0, z_offset]) rotate([0, 0, z_rotate]) translate([0, -0.5, 0]) cube([brush_diameter / 2, 1, 1]);
            }
        }
    }
}

module backplate() {
    width = 200;
    depth = 200;
    thickness = 3;
    border_height = 5;
    
    cable_hole_diameter = 5;
    left_motor_cable_hole = [60, 25, 0];
    right_motor_cable_hole = [140, 25, 0];
    
    connect_holes_diameter = 3;
    
    color("green", 1) {
        difference() {
            cube([width, depth, thickness + border_height]);
            translate([thickness, thickness, thickness]) cube([width - 2 * thickness, depth - 2 * thickness, border_height]);
            
            
            // TODO sure what are the exact translate calculation
            // left motor
            translate([4 + 2 + 5, 1 + depth / 2 - 30 / 2, 0]) cylinder(d=3, thickness);
            translate([4 + 2 + 5, 1 + depth / 2 - 30 / 2 + 30, 0]) cylinder(d=3, thickness);
            translate([4 + 2 + 5 + 40, 1 + depth / 2 - 30 / 2 + 30, 0]) cylinder(d=3, thickness);
            translate([4 + 2 + 5 + 40, 1 + depth / 2 - 30 / 2, 0]) cylinder(d=3, thickness);
            translate([75, depth / 2, 0]) cylinder(d=cable_hole_diameter, thickness);
            
            // right motor
            translate([width - 58 + 4 + 2 + 5, 1 + depth / 2 - 30 / 2, 0]) cylinder(d=3, thickness);
            translate([width - 58 + 4 + 2 + 5, 1 + depth / 2 - 30 / 2 + 30, 0]) cylinder(d=3, thickness);
            translate([width - 58 + 4 + 2 + 5 + 40, 1 + depth / 2 - 30 / 2 + 30, 0]) cylinder(d=3, thickness);
            translate([width - 58 + 4 + 2 + 5 + 40, 1 + depth / 2 - 30 / 2, 0]) cylinder(d=3, thickness);
            translate([125, depth / 2, 0]) cylinder(d=cable_hole_diameter, thickness);
            
            
            for (z_rotate = [0: 90: 360]) {
                translate([width / 2, depth / 2, 0]) rotate([0, 0, z_rotate]) translate([- 3 * width / 8, depth / 2 - thickness, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
                translate([width / 2, depth / 2, 0]) rotate([0, 0, z_rotate]) translate([- 1 * width / 8, depth / 2 - thickness, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
                translate([width / 2, depth / 2, 0]) rotate([0, 0, z_rotate]) translate([1 * width / 8, depth / 2 - thickness, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
                translate([width / 2, depth / 2, 0]) rotate([0, 0, z_rotate]) translate([3 * width / 8, depth / 2 - thickness, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
            }

            
        }
    }
}

//backplate();
//translate([60, 44 / 2 + 100, -2]) rotate([180, 90, 0]) motorHolder();
//translate([200 - 60, -44 / 2 + 100, -2]) rotate([0, 90, 0]) motorHolder();

module frontplate() {
    width = 200;
    depth = 100;
    
    width_part_depth = 20;
    
    arm_width = 64;
    
    thickness = 3;
    border_height = 5;
    
    cable_hole_diameter = 5;
    motor_cable_hole = [60, 25, 0];
    
    connect_holes_diameter = 3;
    // brush holder
    //translate([0, depth, 0]) cube([width / 2 - brush_length / 2 - brush_holder_x_offset, brush_diameter + brush_holder_y_offset, thickness]);
    color("green", 1) {
        difference() {
            cube([width, depth, thickness + border_height]);
            translate([arm_width, width_part_depth, 0]) cube([width, depth, thickness + border_height]);
            translate([thickness, thickness, thickness]) cube([width - 2 * thickness, width_part_depth - 2 * thickness, border_height]);
            translate([thickness, thickness, thickness]) cube([arm_width - 2 * thickness, depth - 2 * thickness, border_height]);
            //translate([width - arm_width + thickness, thickness, thickness]) cube([arm_width - 2 * thickness, depth - 2 * thickness, border_height]);
            
            // connection holes to back
            translate([25, 0, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
            translate([75, 0, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
            translate([125, 0, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
            translate([175, 0, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
            
            motor_x_offset = 9;
            motor_y_offset = 57;
            
            translate([motor_x_offset, motor_y_offset, 0]) cylinder(d=3, thickness);
            translate([motor_x_offset, motor_y_offset + 30, 0]) cylinder(d=3, thickness);
            translate([motor_x_offset + 40, motor_y_offset + 30, 0]) cylinder(d=3, thickness);
            translate([motor_x_offset + 40, motor_y_offset, 0]) cylinder(d=3, thickness);
            //translate([75, depth / 2, 0]) cylinder(d=cable_hole_diameter, thickness);
           
        }
    }
}
//frontplate();
//translate([0, 50, -3]) rotate([180, 0, 0]) rotate([0, -90, 180]) motorHolder();


module wheels_connector() {
    diameter = 60;
    hole_diameter = 6;
    motor_axis_length = 15;
    
    screw_diameter = 4;
    screw_offset = 20;
    
    
    difference() {
        cylinder(d=diameter, motor_axis_length, center=true);
        cylinder(d=hole_diameter, motor_axis_length, center=true);
        
        // wheel connector screws
        for (z_rotate = [0: 90: 360]) {
            rotate([0, 0, z_rotate]) translate([screw_offset, 0, 0]) cylinder(d=screw_diameter, motor_axis_length, center=true);
        }
        
        // motor connector screw
        translate([-diameter/3, diameter/3, 0]) rotate([90, 0, 45]) cylinder(d=screw_diameter, diameter, center=true);
        
    }
    
}

wheels_connector();

module wheels() {
    diameter = 170;
    thickness = 5; //7;
    
    screw_diameter = 4;
    screw_offset = 20;
    
    difference() {
        cylinder(d=diameter, thickness, center=true);
        for (z_rotate = [0: 90: 360]) {
            rotate([0, 0, z_rotate]) translate([screw_offset, 0, 0]) cylinder(d=screw_diameter, thickness, center=true);
        }
    }
    
}
//wheels();

module platform() {
    // base plate
    backplate();
    translate([0, 200, 0]) frontplate();
    
    // left motorHolder
    translate([58 + 2, 40 / 2 + 100 + 3, -2]) rotate([180, 90, 0]) motorHolder();
    
    // right motorHolder
    translate([200 - 58, -40 / 2 + 100 + 3, -2]) rotate([0, 90, 0]) motorHolder();
    
    // brush motorHolder
    //translate([0, depth + brush_diameter / 2 + brush_holder_y_offset, -20]) rotate([180, 0, 0]) rotate([0, -90, 180]) motorHolder();

    // wheels
    translate([-2 * thickness, wheel_y_offset, wheel_z_offset]) rotate([0, 90, 0]) cylinder(d=wheel_diameter, thickness);
    translate([width + thickness, wheel_y_offset, wheel_z_offset]) rotate([0, 90, 0]) cylinder(d=wheel_diameter, thickness);

    // brush
    color("white", 0.4) {
        translate([70, depth + brush_diameter / 2 + brush_holder_y_offset, -26]) rotate([0, 90, 0]) brush();
    }
}

//platform();