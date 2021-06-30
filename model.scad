include <libraries/OpenSCAD-Arduino-Mounting-Library/arduino.scad>


thickness = 10;

width = 200;
depth = 300;

wheel_diameter = 100;
wheel_y_offset = wheel_diameter / 2 + 50;
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
    translate([width / 2 + thickness, depth / 2 + thickness, 0]) motorR835();
    
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

module brushConnector() {
    diameter = 20;
    hole_diameter = 6;
    motor_axis_length = 15;
    
    screw_diameter = 3.3;
    screw_offset = 20;
    
    brush_inner_diameter = 11;
    brush_length = 20;
    
    
    difference() {
        cylinder(d=diameter, motor_axis_length, center=true);
        cylinder(d=hole_diameter, motor_axis_length, center=true);

        // motor connector screw
        translate([-diameter/3, diameter/3, 0]) rotate([90, 0, 45]) cylinder(d=screw_diameter, diameter, center=true);
    }
    
    translate([0, 0, motor_axis_length / 2 + brush_length / 2]) difference() {
        cylinder(d=diameter, brush_length, center=true);
        cylinder(d=brush_inner_diameter, brush_length, center=true);
        // motor connector screw
        translate([-diameter/3, diameter/3, 3]) rotate([90, 0, 45]) cylinder(d=screw_diameter, diameter, center=true);
    }
}
//brushConnector();

module side() {
    width = 2;
    depth = 198;
    height = 60;
    connect_holes_diameter = 3;
    led_diameter = 5;
    cable_diameter = 10;
    
    difference() {
        translate([0, 1, 0]) cube([width, depth, height]);
        
        // mount holes
        translate([0, 25, connect_holes_diameter / 2 + 1]) rotate([0, 90, 0]) cylinder(d=connect_holes_diameter, width);
        translate([0, 75, connect_holes_diameter / 2 + 1]) rotate([0, 90, 0]) cylinder(d=connect_holes_diameter, width);
        translate([0, 125, connect_holes_diameter / 2 + 1]) rotate([0, 90, 0]) cylinder(d=connect_holes_diameter, width);
        translate([0, 175, connect_holes_diameter / 2 + 1]) rotate([0, 90, 0]) cylinder(d=connect_holes_diameter, width);
        
        // leds
        translate([0, 50, 50]) rotate([0, 90, 0]) cylinder(d=led_diameter, width);
        translate([0, 150, 50]) rotate([0, 90, 0]) cylinder(d=led_diameter, width);
        
        // cable hole
        translate([0, 100, 15]) rotate([0, 90, 0]) cylinder(d=cable_diameter, width);
    }
}

//side();

module sideEdges() {
    difference() {
        cube([10, 10, 55]);
        translate([6.8, 0, 0]) cube([2.5, 6.5, 55]);
        translate([0, 6.8, 0]) cube([6.5, 2.5, 55]);
    }
}
//sideEdges();

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
            
            
            // plate connection holes
            for (z_rotate = [0: 90: 360]) {
                translate([width / 2, depth / 2, 0]) rotate([0, 0, z_rotate]) translate([- 3 * width / 8, depth / 2 - thickness, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
                translate([width / 2, depth / 2, 0]) rotate([0, 0, z_rotate]) translate([- 1 * width / 8, depth / 2 - thickness, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
                translate([width / 2, depth / 2, 0]) rotate([0, 0, z_rotate]) translate([1 * width / 8, depth / 2 - thickness, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
                translate([width / 2, depth / 2, 0]) rotate([0, 0, z_rotate]) translate([3 * width / 8, depth / 2 - thickness, thickness + connect_holes_diameter / 2 + 1]) rotate([-90, 0, 0]) cylinder(d=connect_holes_diameter, thickness);
            }

            // electronic
            translate([10, 10, 0]) translate([10, 10, 0]) cylinder(d=3, 3);
            translate([10, 10, 0]) translate([170, 10, 0]) cylinder(d=3, 3);
            translate([10, 10, 0]) translate([170, 120, 0]) cylinder(d=3, 3);
            translate([10, 10, 0]) translate([10, 120, 0]) cylinder(d=3, 3);
            
            // layer mounting
            translate([5, 5, 0]) cylinder(d=3, 3);
            translate([195, 5, 0]) cylinder(d=3, 3);
            translate([195, 195, 0]) cylinder(d=3, 3);
            translate([5, 195, 0]) cylinder(d=3, 3);
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
            translate([arm_width, width_part_depth, -1]) cube([width, depth, thickness + border_height + 2]);
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
    diameter = 50;
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

//wheels_connector();

module wheels() {
    diameter = 150; //  170;
    thickness = 7;
    
    border_thickness = 10;
    thickness_inner = 3;
    
    wheel_profile_diameter = 4;
    
    screw_diameter = 4;
    screw_offset = 20;
    
    difference() {
        cylinder(d=diameter, thickness, center=true);
        translate([0, 0, thickness_inner]) cylinder(d=diameter-border_thickness, thickness-thickness_inner, center=true);
        for (z_rotate = [0: 90: 360]) {
            rotate([0, 0, z_rotate]) translate([screw_offset, 0, 0]) cylinder(d=screw_diameter, thickness, center=true);
        }
        for (z_rotate = [0: 4: 360]) {
            rotate([0, 0, z_rotate]) translate([diameter/2, 0, 0]) cylinder(d=wheel_profile_diameter, thickness, center=true);
        }
    }
    
}
//wheels();

module L298N() {
    color("red", 1) {
        difference() {
            cube([42, 42, 2]);
            translate([3, 3, 0]) cylinder(d=3, 2);
            translate([39, 3, 0]) cylinder(d=3, 2);
            translate([39, 39, 0]) cylinder(d=3, 2);
            translate([3, 39, 0]) cylinder(d=3, 2);
        }
    }
    color("black", 1) {
        translate([0, 10, 0]) cube([16, 23, 25]);
    }
    
}

//L298N();

module breadboard() {
    offset = 5;
    mountingHoleRadius = 3.2 / 2;
    color("DarkGoldenrod", 1) difference() {
        cube([140, 100, 2]);
        
        // mounting
        translate([10 + offset, 55 + offset, 0]) cylinder(d=3, 2);
        translate([100, 5, 0]) cylinder(d=3, 2);
        translate([95, 97, 0]) cylinder(d=3, 2);
        
        // arduino
        //translate([10, 60, 0]) rotate([0, 0, -90]) holePlacement(LEONARDO) cylinder(r = mountingHoleRadius, h = 2, $fn=32);
        
        // L298N
        //translate([130, 55, 0]) rotate([0, 0, 180]) translate([3, 3, 0]) cylinder(d=3, 2);
        //translate([130, 55, 0]) rotate([0, 0, 180]) translate([39, 3, 0]) cylinder(d=3, 2);
        //translate([130, 55, 0]) rotate([0, 0, 180]) translate([39, 39, 0]) cylinder(d=3, 2);
        //translate([130, 55, 0]) rotate([0, 0, 180]) translate([3, 39, 0]) cylinder(d=3, 2);
    }
}


module electronic() {
    difference() {
        cube([180, 130, 2]);
        
        // breadboard mounting
        offset = 5;
        translate([20, 5, 0]) translate([10 + offset, 55 + offset, 0]) cylinder(d=3, 2);
        translate([20, 5, 0]) translate([100, 5, 0]) cylinder(d=3, 2);
        translate([20, 5, 0]) translate([95, 97, 0]) cylinder(d=3, 2);
        
        // mounting
        translate([10, 10, 0]) cylinder(d=3, 5);
        translate([170, 10, 0]) cylinder(d=3, 2);
        translate([170, 120, 0]) cylinder(d=3, 2);
        translate([10, 120, 0]) cylinder(d=3, 2);
        
        // cables
        translate([10, 100, 0]) cylinder(d=10, 2);
        translate([170, 100, 0]) cylinder(d=10, 2);
        translate([30, 120, 0]) cylinder(d=10, 2);
        translate([150, 120, 0]) cylinder(d=10, 2);
    }
    
    translate([2, 2, 2]) difference() {
        cube([176, 126, 3]);
        translate([2, 2, 0]) cube([172, 122, 4]);
    }
    translate([20, 5, 4]) {
        breadboard();
        translate([10, 60, 3]) rotate([0, 0, -90]) arduino(LEONARDO);
        
        translate([130, 55, 3]) rotate([0, 0, 180]) L298N();
    }    
}

//backplate();
//translate([10, 10, 10]) electronic();

module platform() {
    // base plate
    backplate();
    translate([10, 10, 10]) electronic();
    
    translate([0, 200, 0]) frontplate();
    
    // left motorHolder
    translate([58 + 2, 40 / 2 + 100 + 3, -2]) rotate([180, 90, 0]) motorHolder();
    
    // right motorHolder
    translate([200 - 58, -40 / 2 + 100 + 3, -2]) rotate([0, 90, 0]) motorHolder();
    
    // brush motorHolder
    translate([0, 250, -3]) rotate([180, 0, 0]) rotate([0, -90, 180]) motorHolder();

    // wheels
    translate([-2 * thickness, wheel_y_offset, wheel_z_offset]) rotate([0, 90, 0]) cylinder(d=wheel_diameter, thickness);
    translate([width + thickness, wheel_y_offset, wheel_z_offset]) rotate([0, 90, 0]) cylinder(d=wheel_diameter, thickness);

    // brush
    translate([70, 267, -31]) rotate([0, 90, 0]) brush();

}

platform();