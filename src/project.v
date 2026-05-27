module tt_um_secure_packet_auth (
    input  wire [7:0] ui_in,
    input  wire [7:0] uio_in,
    output wire [7:0] uo_out,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

reg [7:0] packet;
reg [7:0] key;
reg [7:0] auth_out;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        packet <= 8'd0;
        key <= 8'd0;
        auth_out <= 8'd0;
    end
    else if (ena) begin
        packet <= ui_in;
        key <= uio_in;

        // Simple authentication logic
        auth_out <= packet ^ key;
    end
end

assign uo_out = auth_out;

assign uio_out = 8'b00000000;
assign uio_oe  = 8'b00000000;

endmodule
