// Wedding Drink Name Tags Generator - OpenSCAD

// Parameters
name = "Your Text";
tag_height = 12; // mm
tag_thickness = 2; // mm

// SVG calibration constant
ACTUAL_IMPORT_HEIGHT = 33.52;
scale_factor = tag_height / ACTUAL_IMPORT_HEIGHT;

// Import and extrude the SVG file
module imported_svg() {
    linear_extrude(height = tag_thickness)
        scale([scale_factor, scale_factor])
            import("Clip1.svg", center=false);
}

// Add text with underline
module add_text_with_underline(text_content, size, thickness, x_offset, y_offset, underline_thickness, underline_margin, scale_factor) {
    // Render text
    translate([x_offset, y_offset, 0])
        linear_extrude(height = thickness)
            text(text_content, size = size, valign = "top", halign = "left", font = "STIX Two Text:style=Bold");
    
    // Calculate underline width using textmetrics
    text_metrics = textmetrics(text_content, size = size, font = "STIX Two Text:style=Bold");
    text_width = text_metrics.size[0];
    underline_length = text_width + (2 * underline_margin);
    
    // Render underline
    translate([x_offset, y_offset - (20.5 * scale_factor), 0])
        cube([underline_length, underline_thickness, thickness]);
}

// Generate tag
imported_svg();

// Layout parameters
font_size = 20 * scale_factor;
underline_thickness = 3 * scale_factor;
underline_margin = 4 * scale_factor;
text_x_offset = 20 * scale_factor;
text_y_offset = 33 * scale_factor;

add_text_with_underline(name, font_size, tag_thickness, text_x_offset, text_y_offset, underline_thickness, underline_margin, scale_factor);