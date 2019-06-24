----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:38:58 06/24/2019 
-- Design Name: 
-- Module Name:    hdbshj - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hdbshj is
    PORT(bn0,bn1,bn2,bn3,bn4,bn5,bn7:IN STD_LOGIC;
	clk_50M,reset:IN STD_LOGIC;
   KEY_ROW: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	KEY_COL: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	DOUT7: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	CatL: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	led1,led2,led3,led4:OUT STD_LOGIC
   );

end hdbshj;

architecture Behavioral of hdbshj is

SIGNAL key_val: STD_LOGIC_VECTOR(7 DOWNTO 0);
CONSTANT NO_KEY_PRESSED:STD_LOGIC_VECTOR(5 downto 0):="000001";  --û�а�������  
CONSTANT SCAN_KEY_COL0:STD_LOGIC_VECTOR(5 downto 0):="000010";  -- ɨ���0�� 
CONSTANT SCAN_KEY_COL1:STD_LOGIC_VECTOR(5 downto 0):="000100";  -- ɨ���1�� 
CONSTANT SCAN_KEY_COL2:STD_LOGIC_VECTOR(5 downto 0):="001000";  --ɨ���2�� 
CONSTANT SCAN_KEY_COL3:STD_LOGIC_VECTOR(5 downto 0):="010000";  -- ɨ���3�� 
CONSTANT KEY_PRESSED:STD_LOGIC_VECTOR(5 downto 0):="100000";  -- �а�������
SIGNAL current_state:STD_LOGIC_VECTOR(5 downto 0); --����״̬
SIGNAL next_state:STD_LOGIC_VECTOR(5 downto 0);  --�¸�״̬

SIGNAL  disp0,disp1,disp2,disp4,disp5:STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL  btn0,btn1,btn2,btn3,btn4,btn5,btn7 :STD_LOGIC:='0';
SIGNAL clk_1,clk_1k:STD_LOGIC;
SIGNAL Q:STD_LOGIC_VECTOR(3 downto 0);
SIGNAL temp1:INTEGER RANGE 0 TO 499;
SIGNAL temp:INTEGER RANGE 0 TO 24999;
SIGNAL money0,money1:STD_LOGIC_VECTOR(3 downto 0):="0000";
SIGNAL count_BTN0:INTEGER RANGE 0 TO 20;
SIGNAL count_BTN1:INTEGER RANGE 0 TO 20;
SIGNAL count_BTN2:INTEGER RANGE 0 TO 20;
SIGNAL count_BTN3:INTEGER RANGE 0 TO 20;
SIGNAL count_BTN4:INTEGER RANGE 0 TO 20;
SIGNAL count_BTN5:INTEGER RANGE 0 TO 20;
SIGNAL count_BTN7:INTEGER RANGE 0 TO 20;
BEGIN

p14:PROCESS(clk_1k,reset)------------------------------------------����ģ��
	BEGIN
	IF reset='0' THEN
		current_state<=NO_KEY_PRESSED;
	ELSE
    current_state<= next_state;
	END IF;
END PROCESS p14;

p13:PROCESS(clk_1k,bn0)-------------------------------------------------4x4ģ�鿪ʼ
	BEGIN
	case current_state is
    WHEN NO_KEY_PRESSED=>next_state<=SCAN_KEY_COL0;--                 	  û�а�������	
          		 -- ��ʼɨ���У�����ѭ��
    WHEN SCAN_KEY_COL0=>                        -- ɨ���0��
        if KEY_ROW /="0000"  THEN
          next_state<=KEY_PRESSED;
        else
          next_state <= SCAN_KEY_COL1;
		  end if;
    WHEN SCAN_KEY_COL1=>                        -- ɨ���1�� 
        if KEY_ROW /="0000" THEN
          next_state <= KEY_PRESSED;
        else
          next_state <= SCAN_KEY_COL2;
		  end if;
    WHEN SCAN_KEY_COL2=>                         --ɨ���2��
        if KEY_ROW /="0000" THEN
          next_state <= KEY_PRESSED;
        else
          next_state <= SCAN_KEY_COL3;
		  end if;
    WHEN SCAN_KEY_COL3=>                         --ɨ���3��
        if KEY_ROW /="0000" THEN
          next_state <= KEY_PRESSED;
        else
          next_state <= NO_KEY_PRESSED;
		  end if;
    WHEN KEY_PRESSED=>                       --�а�������
        if KEY_ROW /="0000" THEN
          next_state <= KEY_PRESSED;
        else
          next_state <= NO_KEY_PRESSED; 
        end if	;		 
  end case;
END PROCESS p13;-------------4x4ģ�����

p1:PROCESS(clk_50M,reset)---------------------------------��Ƶģ��
	BEGIN
	IF reset='0' THEN
		temp<=0;
	ELSIF clk_50M'event AND clk_50M='1' THEN
		IF temp=24999 THEN
			temp<=0;clk_1k<=NOT clk_1k;
		ELSE
			temp<=temp+1;
		END IF;
	END IF;
END PROCESS p1;------------------------------------------��Ƶ����
p2:PROCESS(clk_1k,bn0)-------------------------------------------------��������ģ�鿪ʼ
	BEGIN
		IF(clk_1k'event AND clk_1k = '1') THEN
			IF(bn0 = '1') THEN
				IF count_BTN0 = 20 THEN
					count_BTN0 <= count_BTN0;
				ELSE
					count_BTN0 <= count_BTN0+ 1;
				END IF;
				IF count_BTN0= 19 THEN 
					btn0<= '1';
				ELSE
					btn0<= '0';
				END IF;
			ELSE
				count_BTN0<= 0;------------------------������������жϽ���
			END IF;
		ELSE
		END IF;
END PROCESS p2;
p3:PROCESS(clk_1k,bn1)
	BEGIN
		IF(clk_1k'event AND clk_1k = '1') THEN
			IF(bn1= '1') THEN
				IF count_BTN1 = 20 THEN
					count_BTN1 <= count_BTN1;
				ELSE
					count_BTN1 <= count_BTN1+ 1;
				END IF;
				IF count_BTN1= 19 THEN 
					btn1<= '1';
				ELSE
					btn1<= '0';
				END IF;
			ELSE
				count_BTN1<= 0;
			END IF;
		ELSE
		END IF;
END PROCESS p3;
p4:PROCESS(clk_1k,bn2)
	BEGIN
		IF(clk_1k'event AND clk_1k = '1') THEN
			IF(bn2= '1') THEN
				IF count_BTN2= 20 THEN
					count_BTN2 <= count_BTN2;
				ELSE
					count_BTN2 <= count_BTN2 + 1;
				END IF;
				IF count_BTN2= 19 THEN 
					btn2<= '1';
				ELSE
					btn2<= '0';
				END IF;
			ELSE
				count_BTN2<= 0;
			END IF;
		ELSE
		END IF;
END PROCESS p4;
p5:PROCESS(clk_1k,bn3)
	BEGIN
		IF(clk_1k'event AND clk_1k = '1') THEN
			IF(bn3 = '1') THEN
				IF count_BTN3= 20 THEN
					count_BTN3 <= count_BTN3;
				ELSE
					count_BTN3 <= count_BTN3 + 1;
				END IF;
				IF count_BTN3= 19 THEN 
					btn3<= '1';
				ELSE
					btn3<= '0';
				END IF;
			ELSE
				count_BTN3<= 0;
			END IF;
		ELSE
		END IF;
END PROCESS p5;
p6:PROCESS(clk_1k,bn4)
	BEGIN
		IF(clk_1k'event AND clk_1k = '1') THEN
			IF(bn4 = '1') THEN
				IF count_BTN4 = 20 THEN
					count_BTN4 <= count_BTN4;
				ELSE
					count_BTN4 <= count_BTN4 + 1;
				END IF;
				IF count_BTN4= 19 THEN 
					btn4<= '1';
				ELSE
					btn4<= '0';
				END IF;
			ELSE
				count_BTN4<= 0;
			END IF;
		ELSE
		END IF;
END PROCESS p6;
p7:PROCESS(clk_1k,bn5)
	BEGIN
		IF(clk_1k'event AND clk_1k = '1') THEN
			IF(bn5 = '1') THEN
				IF count_BTN5 = 20 THEN
					count_BTN5 <= count_BTN5;
				ELSE
					count_BTN5 <= count_BTN5 + 1;
				END IF;
				IF count_BTN5= 19 THEN 
					btn5<= '1';
				ELSE
					btn5<= '0';
				END IF;
			ELSE
				count_BTN5<= 0;
			END IF;
		ELSE
		END IF;
END PROCESS p7;
p8:PROCESS(clk_1k,bn7)
	BEGIN
		IF(clk_1k'event AND clk_1k = '1') THEN
			IF(bn7 = '1') THEN
				IF count_BTN7 = 20 THEN
					count_BTN7 <= count_BTN7;
				ELSE
					count_BTN7<= count_BTN7 + 1;
				END IF;
				IF count_BTN7= 19 THEN 
					btn7<= '1';
				ELSE
					btn7<= '0';
				END IF;
			ELSE
				count_BTN7<= 0;
			END IF;
		ELSE
		END IF;
END PROCESS p8;--------------------------------------------------------��������ģ�����
P9:process(clk_1k,btn0,btn1,btn2,btn3,btn4,btn5,btn7)------------------�߼��ж�ģ��
   BEGIN
IF(clk_1k'event AND clk_1k = '1') THEN--------------------------------����ģ��
   IF btn0='1' THEN
      
      IF money0 >"1000" THEN--------------------------------ʮλ�н�λ���
         money0<="0000";money1<=money1+1;
      ELSE money0<=money0+1;--------------------------------ʮλ����λ���
      END IF;
      IF money1>"1001"THEN----------------------------------����99�ⶥ
         money1<="1001";money0<="1001";
      ELSE NULL;
      END IF;
   ELSIF btn1='1'THEN 
         
         IF money0>"0100" THEN
            money0<=money0-5;money1<=money1+1;
         ELSE money0<=money0+5;
         END IF;
         IF money1>"1001"THEN
            money1<="1001";money0<="1001";
         ELSE NULL;
         END IF;
   ELSIF btn2='1'THEN
         
         IF money1>"1000" THEN
            money0<="1001";money1<="1001";
         ELSE money1<=money1+1;
         END IF;------------------------------------------����ģ�����
   ELSIF btn3='1'THEN-------------------------------------����ģ��
         IF money1>"0000" or money0>"0010" THEN-----------Ǯ�����ڹ�����ƷǮ��
            led1<='1';led2<='0';led3<='0';
            disp2<="11111001";-----------------------------��ʾ������Ʒ����
            IF money0>"0010"THEN
               money0<=money0-3;
            ELSE money1<=money1-1;
                 money0<=money0+7;
            END IF;
            IF money1="0000" and money0<"0011"THEN--------------Ǯ��С���������
             CASE money0 IS
             WHEN "0000"=>disp0<="11000000";
             WHEN "0001"=>disp0<="11111001";
             WHEN "0010"=>disp0<="10100100";
             WHEN OTHERS=>disp0<="11111111";
             END CASE;
             money0<="0000";
            ELSE NULL;
            END IF;
         ELSE---------------------------------------------Ǯ������
                led4<='1';
                CASE money1 IS
         WHEN "0000"=>disp1<="11000000";
         WHEN "0001"=>disp1<="11111001";
         WHEN "0010"=>disp1<="10100100";
         WHEN "0011"=>disp1<="10110000";
         WHEN "0100"=>disp1<="10011001";
         WHEN "0101"=>disp1<="10010010";
         WHEN "0110"=>disp1<="10000010";
         WHEN "0111"=>disp1<="11111000";
         WHEN "1000"=>disp1<="10000000";
         WHEN "1001"=>disp1<="10010000";
         WHEN OTHERS=>disp1<="11111111";
         END CASE;
         CASE money0 IS
         WHEN "0000"=>disp0<="11000000";
         WHEN "0001"=>disp0<="11111001";
         WHEN "0010"=>disp0<="10100100";
         WHEN "0011"=>disp0<="10110000";
         WHEN "0100"=>disp0<="10011001";
         WHEN "0101"=>disp0<="10010010";
         WHEN "0110"=>disp0<="10000010";
         WHEN "0111"=>disp0<="11111000";
         WHEN "1000"=>disp0<="10000000";
         WHEN "1001"=>disp0<="10010000";
         WHEN OTHERS=>disp0<="11111111";
         END  CASE;
         money1<="0000";
         money0<="0000";
         disp2<="11000000"; 
         
         END IF;
   ELSIF btn4='1'THEN
         IF money1>"0000" or money0>"1000" THEN
            led2<='1';led1<='0';led3<='0';
            disp2<="10100100";
            IF money0>="1000"THEN
               money0<=money0-8;
            ELSE money1<=money1-1;
                 money0<=money0+2;
            END IF;
            IF money1="0000" and money0<"0011"THEN
             CASE money0 IS
             WHEN "0000"=>disp0<="11000000";
             WHEN "0001"=>disp0<="11111001";
             WHEN "0010"=>disp0<="10100100";
             WHEN OTHERS=>disp0<="11111111";
             END CASE;
             money0<="0000";
            ELSE NULL;
            END IF;
         ELSE 
led4<='1';
CASE money1 IS
         WHEN "0000"=>disp1<="11000000";
         WHEN "0001"=>disp1<="11111001";
         WHEN "0010"=>disp1<="10100100";
         WHEN "0011"=>disp1<="10110000";
         WHEN "0100"=>disp1<="10011001";
         WHEN "0101"=>disp1<="10010010";
         WHEN "0110"=>disp1<="10000010";
         WHEN "0111"=>disp1<="11111000";
         WHEN "1000"=>disp1<="10000000";
         WHEN "1001"=>disp1<="10010000";
         WHEN OTHERS=>disp1<="11111111";
         END CASE;
         CASE money0 IS
         WHEN "0000"=>disp0<="11000000";
         WHEN "0001"=>disp0<="11111001";
         WHEN "0010"=>disp0<="10100100";
         WHEN "0011"=>disp0<="10110000";
         WHEN "0100"=>disp0<="10011001";
         WHEN "0101"=>disp0<="10010010";
         WHEN "0110"=>disp0<="10000010";
         WHEN "0111"=>disp0<="11111000";
         WHEN "1000"=>disp0<="10000000";
         WHEN "1001"=>disp0<="10010000";
         WHEN OTHERS=>disp0<="11111111";
         END  CASE;
         money1<="0000";
         money0<="0000";
         disp2<="11000000";
         
         END IF;
   ELSIF btn5='1'THEN
         IF money1>"0001" or (money1="0001" and money0>"0001") THEN
            led3<='1';led1<='0';led2<='0';
            disp2<="10110000";
            IF money0>"0001"THEN
               money0<=money0-2;
               money1<=money1-1;
            ELSE money1<=money1-2;
                 money0<=money0+8;
            END IF;
            IF money1="0000" and money0<"0011"THEN
             CASE money0 IS
             WHEN "0000"=>disp0<="11000000";
             WHEN "0001"=>disp0<="11111001";
             WHEN "0010"=>disp0<="10100100";
             WHEN OTHERS=>disp0<="11111111";
             END CASE;
             money0<="0000";
            ELSE NULL;
            END IF;
         ELSE 
led4<='1';
CASE money1 IS
         WHEN "0000"=>disp1<="11000000";
         WHEN "0001"=>disp1<="11111001";
         WHEN "0010"=>disp1<="10100100";
         WHEN "0011"=>disp1<="10110000";
         WHEN "0100"=>disp1<="10011001";
         WHEN "0101"=>disp1<="10010010";
         WHEN "0110"=>disp1<="10000010";
         WHEN "0111"=>disp1<="11111000";
         WHEN "1000"=>disp1<="10000000";
         WHEN "1001"=>disp1<="10010000";
         WHEN OTHERS=>disp1<="11111111";
         END CASE;
         CASE money0 IS
         WHEN "0000"=>disp0<="11000000";
         WHEN "0001"=>disp0<="11111001";
         WHEN "0010"=>disp0<="10100100";
         WHEN "0011"=>disp0<="10110000";
         WHEN "0100"=>disp0<="10011001";
         WHEN "0101"=>disp0<="10010010";
         WHEN "0110"=>disp0<="10000010";
         WHEN "0111"=>disp0<="11111000";
         WHEN "1000"=>disp0<="10000000";
         WHEN "1001"=>disp0<="10010000";
         WHEN OTHERS=>disp0<="11111111";
         END  CASE;
         money1<="0000";
         money0<="0000";
         disp2<="11000000";
         
         END IF;------------------------------------------����ģ�����
   ELSIF btn7='1'THEN-------------------------------------����ģ��
         led1<='0';
         led2<='0';
         led3<='0';
         led4<='0';
         CASE money1 IS------------------------------------��������
         WHEN "0000"=>disp1<="11000000";
         WHEN "0001"=>disp1<="11111001";
         WHEN "0010"=>disp1<="10100100";
         WHEN "0011"=>disp1<="10110000";
         WHEN "0100"=>disp1<="10011001";
         WHEN "0101"=>disp1<="10010010";
         WHEN "0110"=>disp1<="10000010";
         WHEN "0111"=>disp1<="11111000";
         WHEN "1000"=>disp1<="10000000";
         WHEN "1001"=>disp1<="10010000";
         WHEN OTHERS=>disp1<="11111111";
         END CASE;
         CASE money0 IS
         WHEN "0000"=>disp0<="11000000";
         WHEN "0001"=>disp0<="11111001";
         WHEN "0010"=>disp0<="10100100";
         WHEN "0011"=>disp0<="10110000";
         WHEN "0100"=>disp0<="10011001";
         WHEN "0101"=>disp0<="10010010";
         WHEN "0110"=>disp0<="10000010";
         WHEN "0111"=>disp0<="11111000";
         WHEN "1000"=>disp0<="10000000";
         WHEN "1001"=>disp0<="10010000";
         WHEN OTHERS=>disp0<="11111111";
         END  CASE;
         money1<="0000";
         money0<="0000";
         disp2<="11000000";
       
   ELSE  null;
   END   IF;
  


 CASE money0 IS------------------------------------------------��ʾģ��
   WHEN "0000"=>disp5<="11000000";
   WHEN "0001"=>disp5<="11111001";
   WHEN "0010"=>disp5<="10100100";
   WHEN "0011"=>disp5<="10110000";
   WHEN "0100"=>disp5<="10011001";
   WHEN "0101"=>disp5<="10010010";
   WHEN "0110"=>disp5<="10000010";
   WHEN "0111"=>disp5<="11111000";
   WHEN "1000"=>disp5<="10000000";
   WHEN "1001"=>disp5<="10010000";
   WHEN OTHERS=>disp5<="11111111";
   END CASE;
   CASE money1 IS
   WHEN "0000"=>disp4<="11000000";
   WHEN "0001"=>disp4<="11111001";
   WHEN "0010"=>disp4<="10100100";
   WHEN "0011"=>disp4<="10110000";
   WHEN "0100"=>disp4<="10011001";
   WHEN "0101"=>disp4<="10010010";
   WHEN "0110"=>disp4<="10000010";
   WHEN "0111"=>disp4<="11111000";
   WHEN "1000"=>disp4<="10000000";
   WHEN "1001"=>disp4<="10010000";
   WHEN OTHERS=>disp4<="11111111";
   END CASE;
ELSE NULL;
END IF;
END PROCESS p9;
p10:PROCESS(clk_50M,reset)
	BEGIN
	IF reset='0' THEN
		temp1<=0;
	ELSIF clk_50M'event AND clk_50M='1' THEN
		IF temp1=499 THEN
			temp1<=0;clk_1<=NOT clk_1;
		ELSE
			temp1<=temp1+1;
		END IF;
	END IF;
END PROCESS p10;
p11:PROCESS(clk_1,reset)-------------------------------------------Ϊɨ������ܼ���
	BEGIN
	IF reset='0' THEN
		Q <= "1111";
	ELSIF(clk_1'event and clk_1='1')THEN
		IF Q = "0100" THEN
			Q <= "0000";
		ELSE
			Q <= Q+1;
		END IF;
	END IF;
END PROCESS p11;	
p12:PROCESS(Q)----------------------------------------------------ɨ�������
	BEGIN
		CASE Q IS
			WHEN "0000"=>DOUT7<=disp0;CatL<="000";            
			WHEN "0001"=>DOUT7<=disp1;CatL<="001";           
			WHEN "0010"=>DOUT7<=disp2;CatL<="111";             
			WHEN "0011"=>DOUT7<=disp4;CatL<="101";            
			WHEN "0100"=>DOUT7<=disp5;CatL<="100";            
			WHEN OTHERS=>DOUT7<="11000000";CatL<="011";
		END CASE;
END PROCESS p12;



end Behavioral;

