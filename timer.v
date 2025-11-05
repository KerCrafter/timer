module timer #(
    parameter CLK_COUNT = 1,
    parameter FIRST_TICK_AFTER_DELAY = 0
)(
    input  wire clk,
    input  wire reset,
    input  wire enable,
    output wire tick
);

    reg [$clog2(CLK_COUNT)-1:0] cnt = 0;

    always @(posedge clk) begin
      if (reset) begin
        cnt <= 0;
      end else begin
        if (enable) begin
            if (cnt == 0)
                cnt <= 1;
            else if (cnt == CLK_COUNT - 1)
                cnt <= 0;
            else
                cnt <= cnt + 1'd1;
        end else begin
            cnt <= 0;
        end
      end
    end

    assign tick = (reset) ? 1'b1 :
                  (FIRST_TICK_AFTER_DELAY == 0 && enable && cnt == 1) ? 1'b1 :
                  (FIRST_TICK_AFTER_DELAY == 1 && enable && cnt == CLK_COUNT - 1) ? 1'b1 : 1'b0;

endmodule
