// ============================================================
// REVOLT — Remote Energy Via Optimized Load Turbine
// V1.0 Savonius Scoop — OpenSCAD Source
// License: CC0 / Public Domain — Build it free, forever.
// ============================================================
// PARAMETERS — edit these to scale your build
// ============================================================

rotor_diameter   = 200;   // mm — total rotor diameter
overlap_ratio    = 0.18;  // 18% center overlap (venting gap)
aspect_ratio     = 2.0;   // height:diameter per segment
wall_thickness   = 3.5;   // mm — scoop shell thickness
shaft_diameter   = 12.7;  // mm — 1/2" stainless rod
hub_od           = 30;    // mm — hub outer diameter
hub_height       = 20;    // mm — hub collar height
snap_tab_width   = 8;     // mm — snap fit tab width
snap_tab_depth   = 2;     // mm — snap fit engagement depth
bearing_od       = 22;    // mm — 608 bearing OD
bearing_id       = 8;     // mm — 608 bearing ID (use shaft_diameter for fit)
bearing_height   = 7;     // mm — 608 bearing height
print_tolerance  = 0.25;  // mm — FDM fit tolerance

// ============================================================
// DERIVED VALUES
// ============================================================

scoop_radius     = rotor_diameter / 2;
scoop_height     = rotor_diameter * aspect_ratio;
overlap_offset   = rotor_diameter * overlap_ratio;
scoop_center_x   = (scoop_radius / 2) - (overlap_offset / 2);

// ============================================================
// MODULES
// ============================================================

// Single Savonius scoop — semi-circular drag surface
module savonius_scoop() {
    difference() {
        // Outer shell — full semi-cylinder
        rotate([90, 0, 0])
        linear_extrude(height = scoop_height, center = true)
        difference() {
            circle(r = scoop_radius);
            circle(r = scoop_radius - wall_thickness);
            // Clip to 180 degrees (semi-circle only)
            translate([-scoop_radius - 1, -scoop_radius - 1])
                square([scoop_radius * 2 + 2, scoop_radius + 1]);
        }
        // Shaft clearance hole through hub zone
        cylinder(h = scoop_height + 2, d = shaft_diameter + print_tolerance * 2, center = true);
    }
}

// Hub collar with keyed slot for stacking
module hub_collar(key_slots = 6) {
    difference() {
        union() {
            // Main collar body
            cylinder(h = hub_height, d = hub_od, center = true);
            // Snap fit tabs — allows CW/CCW flip on Z axis
            for (i = [0 : key_slots - 1]) {
                rotate([0, 0, i * (360 / key_slots)])
                translate([hub_od / 2, 0, 0])
                cube([snap_tab_depth * 2, snap_tab_width, hub_height], center = true);
            }
        }
        // Shaft bore
        cylinder(h = hub_height + 1, d = shaft_diameter + print_tolerance, center = true);
        // Bearing seat — top
        translate([0, 0, hub_height / 2 - bearing_height])
            cylinder(h = bearing_height + 1, d = bearing_od + print_tolerance, center = false);
    }
}

// Full rotor assembly — two scoops + hub, offset by overlap ratio
module rotor_assembly() {
    // Scoop A — primary power stroke side
    translate([scoop_center_x, 0, 0])
        savonius_scoop();

    // Scoop B — returning side, rotated 180 degrees
    // Flip 180° on Z to reverse rotation direction if needed
    rotate([0, 0, 180])
    translate([scoop_center_x, 0, 0])
        savonius_scoop();

    // Central hub
    hub_collar();
}

// Base mount — universal 1" PVC / T-post / roof rack interface
module base_mount() {
    pvc_od = 33.4; // 1" nominal PVC outer diameter mm
    mount_height = 40;
    mount_od = 60;

    difference() {
        union() {
            cylinder(h = mount_height, d = mount_od, center = false);
            // Four bolt flanges at 90 degrees
            for (i = [0:3]) {
                rotate([0, 0, i * 90])
                translate([mount_od / 2, 0, mount_height / 2])
                cube([20, 12, mount_height], center = true);
            }
        }
        // PVC pipe socket
        cylinder(h = mount_height + 1, d = pvc_od + print_tolerance, center = false);
        // Shaft through-hole
        cylinder(h = mount_height + 1, d = shaft_diameter + print_tolerance * 2, center = false);
        // Bolt holes in flanges — M5
        for (i = [0:3]) {
            rotate([0, 0, i * 90])
            translate([mount_od / 2 + 8, 0, mount_height / 2])
            cylinder(h = mount_height + 1, d = 5.5, center = true);
        }
    }
}

// Manual overdrive hand crank attachment
module hand_crank() {
    crank_length = 120;
    crank_grip_d = 25;
    crank_arm_w  = 15;
    crank_arm_h  = 10;

    union() {
        // Crank arm
        cube([crank_length, crank_arm_w, crank_arm_h], center = false);
        // Grip ball
        translate([crank_length, crank_arm_w / 2, crank_arm_h / 2])
            sphere(d = crank_grip_d);
        // Shaft collar
        difference() {
            cylinder(h = crank_arm_h * 2, d = hub_od, center = true);
            cylinder(h = crank_arm_h * 2 + 1, d = shaft_diameter + print_tolerance, center = true);
        }
    }
}

// ============================================================
// RENDER — comment/uncomment to export each part separately
// ============================================================

rotor_assembly();
// translate([0, 0, -60]) base_mount();
// translate([120, 0, 0]) hand_crank();
// translate([0, 80, 0]) hub_collar();

// ============================================================
// PRINT NOTES:
// - Material: PETG or ASA preferred. PLA+ for prototyping only.
// - Layer height: 0.28mm
// - Walls: 4-6 perimeters
// - Infill: 15-20% Gyroid
// - Supports: None required for scoop if printed vertically
// - Flip scoop 180 degrees on Z to reverse rotation direction
// ============================================================
