`timescale 1 ns / 1 ps

module PreProcessingGP (input x, y, output G, P);

    assign G = (x & y);
    assign P = (x ^ y);

endmodule

module GrayCell (input Gikp1, Pikp1, Gkj, output Gij);

    assign Gij = (Gikp1 | (Pikp1 & Gkj));

endmodule

module BlackCell (input Gikp1, Pikp1, Gkj, Pkj, output Gij, Pij);

    assign Gij = (Gikp1 | (Pikp1 & Gkj));
    assign Pij = (Pikp1 & Pkj);

endmodule

module EightBitKoggeStoneAdder (input [7:0] A, B, input Cin, output Cout, output [7:0] S);

    wire [7:0] G0, P0, G1, P1, G2, P2, G3, P3;

    // preprocessing layer
    PreProcessingGP GP0 (A[0], B[0], G0[0], P0[0]);
    PreProcessingGP GP1 (A[1], B[1], G0[1], P0[1]);
    PreProcessingGP GP2 (A[2], B[2], G0[2], P0[2]);
    PreProcessingGP GP3 (A[3], B[3], G0[3], P0[3]);
    PreProcessingGP GP4 (A[4], B[4], G0[4], P0[4]);
    PreProcessingGP GP5 (A[5], B[5], G0[5], P0[5]);
    PreProcessingGP GP6 (A[6], B[6], G0[6], P0[6]);
    PreProcessingGP GP7 (A[7], B[7], G0[7], P0[7]);

    // carry lookahead - layer 1
    GrayCell GC10 (G0[0], P0[0], Cin, G1[0]);
    BlackCell BC11 (G0[1], P0[1], G0[0], P0[0], G1[1], P1[1]);
    BlackCell BC12 (G0[2], P0[2], G0[1], P0[1], G1[2], P1[2]);
    BlackCell BC13 (G0[3], P0[3], G0[2], P0[2], G1[3], P1[3]);
    BlackCell BC14 (G0[4], P0[4], G0[3], P0[3], G1[4], P1[4]);
    BlackCell BC15 (G0[5], P0[5], G0[4], P0[4], G1[5], P1[5]);
    BlackCell BC16 (G0[6], P0[6], G0[5], P0[5], G1[6], P1[6]);
    BlackCell BC17 (G0[7], P0[7], G0[6], P0[6], G1[7], P1[7]);

    // carry lookahead - layer 2
    GrayCell GC21 (G1[1], P1[1], Cin, G2[1]);
    GrayCell GC22 (G1[2], P1[2], G1[0], G2[2]);
    BlackCell BC23 (G1[3], P1[3], G1[1], P1[1], G2[3], P2[3]);
    BlackCell BC24 (G1[4], P1[4], G1[2], P1[2], G2[4], P2[4]);
    BlackCell BC25 (G1[5], P1[5], G1[3], P1[3], G2[5], P2[5]);
    BlackCell BC26 (G1[6], P1[6], G1[4], P1[4], G2[6], P2[6]);
    BlackCell BC27 (G1[7], P1[7], G1[5], P1[5], G2[7], P2[7]);

    // carry lookahead - layer 3
    GrayCell GC33 (G2[3], P2[3], Cin, G3[3]);
    GrayCell GC34 (G2[4], P2[4], G1[0], G3[4]);
    GrayCell GC35 (G2[5], P2[5], G2[1], G3[5]);
    GrayCell GC36 (G2[6], P2[6], G2[2], G3[6]);
    BlackCell BC37 (G2[7], P2[7], G2[3], P2[3], G3[7], P3[7]);

    // carry lookahead - layer 4
    GrayCell GC47 (G3[7], P3[7], Cin, Cout);

    // post-processing - sum bits
    assign S[0] = (Cin ^ P0[0]);
    assign S[1] = (G1[0] ^ P0[1]);
    assign S[2] = (G2[1] ^ P0[2]);
    assign S[3] = (G2[2] ^ P0[3]);
    assign S[4] = (G3[3] ^ P0[4]);
    assign S[5] = (G3[4] ^ P0[5]);
    assign S[6] = (G3[5] ^ P0[6]);
    assign S[7] = (G3[6] ^ P0[7]);

endmodule