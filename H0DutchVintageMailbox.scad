VEC_X = [1, 0, 0];
VEC_Y = [0, 1, 0];

function mm(x) = x;

Base();

Top();
Roof();
TopBanner();
MidBanner();
BottomBanner();

module Base(o = 0) {
    Base();
    
    rotate(90, VEC_X) {
        linear_extrude(mm(2.85)) import("Front_layer1.svg");
        linear_extrude(mm(2.95)) import("Front_layer2.svg");
    }
    
    module Base(o = 0) {
        intersection() {
            rotate(90, VEC_X) {
                linear_extrude(
                    mm(7),
                    center = true,
                    convexity = 3
                ) {
                    offset(o) import("Base_front.svg");
                }
            }
            rotate(90) rotate(90, VEC_X) {
                linear_extrude(
                    mm(7),
                    center = true,
                    convexity = 3
                ) {
                    offset(o) import("Base_side.svg");
                }
            }
        }
    }
}

module Top() {
    rotate_extrude($fn = 32) import("Top.svg");
}

module Roof() {
    Octal(-.55) import("Roof.svg");
}

module TopBanner() {
    Octal(-1) import("Top_banner.svg");
}

module MidBanner() {
    Octal(-1) import("Mid_banner.svg");
}

module BottomBanner() {
    Octal(-4.0) {
        translate([0, 1.7]) square([2.95, 0.35]);
    }
}

module Octal(a) {
    intersection() {
        project() children();
        rotate( 90) project(.1) children();
        rotate( 45) project(a) children();
        rotate(-45) project(a) children();
    }
    module project(o = 0 ) {
        rotate(90, VEC_X) {
            linear_extrude(
                mm(10),
                center = true,
                convexity = 3
            ) {
                mirror_copy(VEC_X) {
                    if(o < 0) {
                        translate([o,0]) children();
                    }
                    children();
                }
            }
        }
    }
}

module mirror_copy(vec) {
    children();
    mirror(vec) children();
}