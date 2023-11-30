$fn=64;

VEC_X = [1, 0, 0];
VEC_Y = [0, 1, 0];


a1 = 0.2;
h1 = 1;
h2 = 8;
h3 = 9.5;
h4 = 11;
w1 = 2.3;
w2 = 2;
w3 = .3;
v1 = 0.15;

Base();

eight_side(h1 + 1, .2, w2, 0.2);

eight_side(h2, .2, w2, 0.2);
eight_side(h2 + .2, .4, w2, 0.4);
eight_side(h2 + .5, .8, w2, 0.5);

eight_side(h2 + 1.8, 0.3, w2 - .35, 0.3);

disc(.6, .1, h4);
disc(.4, .2, h4 + .1);
disc(.3, .1, h4 + .35);
disc(.3, .1, h4 + .45);
disc(.3, .2, h4 + .7);
disc(.2, .1, h4 + .85);

module disc(r1, r2, h) {
    hull() rotate_extrude() {
        translate([r1, h]) circle(r2);
    }
}

module eight_side(h1, h, w, a) {
    translate([0, 0, h1]) {
        linear_extrude(h) {
            hull() {
                square(
                    [2 * w, 2 * (w + a)],
                    center = true);
                square(
                    [2 * (w + a), 2 * w],
                    center = true);
            }
        }
    }
}


module Base() {
    rotate(90, VEC_X) four_side(w1) {
        profile();
    }
    
    module profile() {
        base();
        foot();

        module base() {
            hull() mirror_copy(VEC_X) {
                polygon([
                    [0, 0],
                    [w2, 0],
                    [w2, h2],
                    [w3, h4],
                    [0, h4]
                ]);
                translate([w3, h3]) {
                    circle(r = h4-h3);
                }
            }
        }
        module foot() {
            mirror_copy(VEC_X) {
                square([w1, h1]);
                square([w2 + v1, h1 + v1]);
            }
        }
    }
}

module four_side(w1, convexity = 3 ) {
    intersection() {
        a() children();
        rotate(90, VEC_Y) a() children();
    }
    module a() {
        linear_extrude(
            2 * w1,
            center = true,
            convexity=convexity
        ) {
            children();
        }
    }
}

module mirror_copy(vec) {
    children();
    mirror(vec) children();
}