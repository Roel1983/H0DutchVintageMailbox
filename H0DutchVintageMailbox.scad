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
        linear_extrude(mm(2.85)) {
            import("views/BaseFrontLayer1.svg");
        }
        linear_extrude(mm(2.95)) {
            import("views/BaseFrontLayer2.svg");
        }
    }
    
    module Base(o = 0) {
        intersection() {
            rotate(90, VEC_X) {
                linear_extrude(
                    mm(7),
                    center = true,
                    convexity = 3
                ) {
                    offset(o) mirror_copy(VEC_X) {
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
                    offset(o) import("views/BaseSide.svg");
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
    Octal(-1) import("views/TopBanner.svg");
}

module MidBanner() {
    Octal(-1) import("views/MidBanner.svg");
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