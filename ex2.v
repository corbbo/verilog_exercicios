module multiplier(
    input reset, clock, start,
    input [31:0] A, B,
    output [63:0] mult_prod
);

localparam idle   = 3'b000;
localparam init   = 3'b001;
localparam sum    = 3'b010;
localparam shift  = 3'b011;
localparam finish = 3'b100;

wire [2:0]  EA, PE;
reg  [64:0] reg_p;
wire        cout;

always @(posedge clk, reset ) begin
    if (reset == 1) {
        EA <= idle;
        cout <= 0'b0;
        reg_p <= 63'b0;
    } else EA <= PE;
end

always @(EA) begin
    case EA:
        idle:   if (start == 1) PE <= init;
                else PE <= EA;

        init:   reg_p[:0] <= A;
                PE <= sum;

        sum:    if (reg_p[0]) reg_p[:32] <= reg_p[:32] + b;
                PE <= shift;

        shift:  
    endcase
end