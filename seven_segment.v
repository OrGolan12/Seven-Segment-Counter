module seven_seg(
    input logic clk,
    input logic rst_n,
    output logic [6:0] out //abcdefg
);

    parameter FRQ = 13500000; //frq tang nano 9 is 27MHz
    
    typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} state_t;
    state_t current_state;

    logic [31:0] count;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 0;
            current_state <= S0;
        end
        else if (count == FRQ) begin
            count <= 0;
            current_state <= (current_state == S9) ? S0 : state_t'(current_state + 1);
        end
        else
            count <= count + 1;
    end

    always_comb begin
        case(current_state)
            S0: out = 7'b0000001;
            S1: out = 7'b1001111;
            S2: out = 7'b0010010;
            S3: out = 7'b0000110;
            S4: out = 7'b1001100;
            S5: out = 7'b0100100;
            S6: out = 7'b0100000;
            S7: out = 7'b0001111;
            S8: out = 7'b0000000;
            S9: out = 7'b0001100;        
            default: out = 7'b0000000;
        endcase
    end





endmodule