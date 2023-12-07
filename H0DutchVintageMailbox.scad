module __Customizer_Limit__ () {}

VEC_X = [1, 0, 0];
VEC_Y = [0, 1, 0];

function mm(x) = x;

Base();

Top();
Roof();
TopBanner();
MidBanner();
BottomBanner();

module Base() {
    Base();
    
    rotate(90, VEC_X) {
        linear_extrude(mm(2.75 + 0.09)) {
            import("views/BaseFrontLayer1.svg");
        }
        linear_extrude(mm(2.75 + 0.18)) {
            import("views/BaseFrontLayer2.svg");
        }
    }
    
    module Base() {
        intersection() {
            rotate(90, VEC_X) {
                linear_extrude(
                    mm(8),
                    center = true,
                    convexity = 3
                ) {
                    mirror_copy(VEC_X) {
                        import("views/BaseFront.svg");
                    }
                }
            }
            rotate(90) rotate(90, VEC_X) {
                linear_extrude(
                    mm(7),
                    center = true,
                    convexity = 3
                ) {
                    import("views/BaseSide.svg");
                }
            }
        }
    }
}

module Top() {
    rotate_extrude($fn = 32) import("views/Top.svg");
}

module Roof() {
    Octal(-.55) import("views/Roof.svg");
}

module TopBanner() {
    difference() {
        Octal(-1) import("views/TopBanner.svg");
        translate([0, 0, 14.5]) difference() {
            union() {
                cube([5.2, 8, .67], true);
                cube([8,5.2, .67], true);
            }
            linear_extrude(1.0, center=true) {
                square(6.4, true);
            }
        }
    }
    translate([0, 0, 14.5]) {
        rotate(90, VEC_X) linear_extrude(3.3) {
            text("Post",
                 size = 0.55,
                 valign="center",
                 halign="center");
        }
    }
}

module MidBanner() {
    difference() {
        Octal(-1) import("views/MidBanner.svg");
        linear_extrude(18) {
            translate([0, -1.3]) rotate(-135) square(10);
        }
    }
}

module BottomBanner() {
    Octal(-1.1) {
        mirror_copy(VEC_X) {
            import("views/BottomBanner.svg");
        }
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
                render() mirror_copy(VEC_X) {
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