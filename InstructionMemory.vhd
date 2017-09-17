 library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use IEEE.NUMERIC_STD.all;

entity InstructionMemory is 
	port(
		clk : in std_logic;
		instruction_load : in std_logic_vector(15 downto 0);	--used by the testbench to load the instructions 
		load_en : in std_logic;	 --used by the testbench to load all the instructions
		instruction_out : out std_logic_vector(15 downto 0)
		
		);
end InstructionMemory;								   

architecture behavioral of InstructionMemory is  
type table_val is array (0 to 15) of std_logic_vector(15 downto 0);
signal buffers: table_val := (others => X"0000");
--signal count1 : integer range 0 to 15 := 0;
--signal count2 : integer range 0 to 15 := 0; 
signal instruction : std_logic_vector(15 downto 0);
signal ProgramCounter : integer := 0; 
begin
	process(clk, instruction_load, load_en, ProgramCounter, instruction)
	variable count1 : integer range 0 to 16 := 0;
	variable count2 : integer range 0 to 16 := 0; 
	begin 
		if rising_edge(clk) then  
			if(count1 >= 16) then 
				count1 := 0;
			end if;			
			if(count2 >= 16) then 
				count2 := 0;	
			end if;
			if load_en = '1' then 
				buffers(count1) <= instruction_load;	
				count1 := count1 + 1;
			else
				instruction <= buffers(count2);
				count2 := count2 + 1;
				ProgramCounter <= ProgramCounter + 1;
			end if;
		end if;
	end process;  
	
	process(instruction)
	begin
		instruction_out <= instruction;
	end process;
	
end behavioral;