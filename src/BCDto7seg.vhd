library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package BCDto7segDec is
  component BCDto7seg is
    generic(n : integer := 1);
    port(bcd : in std_logic_vector(n*4-1 downto 0);
        hex : out std_logic_vector(n*7 - 1 downto 0));
  end component;
end package;
  

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--input is bcd formatted vector representing "n" decimal digits, or n*4 bits
--out is hex aggregate containing n sets of 7 bits, or n*7 bits in the same digit order as bcd
entity BCDto7seg is
  generic(n : integer := 1);
  port(bcd : in std_logic_vector(n*4-1 downto 0);
       hex : out std_logic_vector(n*7 - 1 downto 0));
end entity;

architecture impl of BCDto7seg is
  
  type bcdLUT is array (0 to 9) of std_logic_vector(6 downto 0);
  
  constant LUT : bcdLUT := 
    ("1111110", 
     "0110000", "1101101", "1111001",
     "0110011", "0110011", "1011111",
     "1110000", "1111111", "1111011");
  
  begin
    
    process(all) begin
      
      for I in 0 to n-1 loop
        hex(I*7+6 downto I*7) <= LUT(to_integer(unsigned(bcd(I*4+3 downto I*4))));
        --report(to_string(bcd(I*4+3 downto I*4)) & " is : " & to_string(LUT(to_integer(unsigned(bcd(I*4+3 downto I*4))))));
      end loop;
      
    end process;
  
end impl;