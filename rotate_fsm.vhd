
---------------- ROTATE FSM-------------------
--------- feito por Luiz (aplausos) ----------
----------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rotate_fsm is
    Port ( 
        clk     : in std_logic;
        reset   : in std_logic; -- coisa padrao de FSM
        enable  : in std_logic;
        
        en      : in std_logic; -- 1 deixa a maquina rodar e 0 trava a maquina
        cw     : in std_logic; -- 0 vai rodar no sentido anti-horario e 1 no sentido horario
        
        sseg    : out std_logic_vector(6 downto 0); --selecionar o display
        an      : out std_logic_vector(7 downto 0) --os segmentos do display
    );
end rotate_fsm;

architecture Behavioral of rotate_fsm is

    -- todos os 8 estados do quadrado no display de 4 digitos    
    type sq_state is (s0, s1, s2, s3, s4, s5, s6, s7);
    signal state_reg, state_next : sq_state;    -- coisas de registrador

begin

   -- registrador
   process(clk, reset)
   begin
        -- flip-flop D (como de sempre) apenas em bordas de subida
      if (reset = '1') then
         --------IMPORTANTE----------
         state_reg <= s0; --<<< ESTADO INICIAL  estamos  comecando no s0
         
      elsif (clk'event and clk = '1') then
         -- o enable fica aqui
         if (enable='1') then
             state_reg <= state_next;
         end if;
         
      end if;
   end process;
   
   
   -- logica do proximo estado
   --(usando apenas as entradas)
   
      process(state_reg, en, cw)
      begin
         case state_reg is
         
        ------------------------------------------
        -------------ESTADO S0 -------------------
        ------------------------------------------
           when s0 =>
            
               if en = '0' then            -- (en')
                     state_next <= s0;
                
                
               elsif cw = '1' then         -- (en) AND (cw) 
                  state_next <= s1;
                  -- sentido horario (proximo)
                
                
               else                        -- (en) AND (cw')
                  state_next <= s7;
                  -- sentido anti-horario (anterior)
               end if;
                
        ------------------------------------------
        -------------ESTADO S1 -------------------
        ------------------------------------------
           when s1 =>
           
               if en = '0' then            -- (en')
                     state_next <= s1;
               
               
               elsif cw = '1' then         -- (en) AND (cw) 
                  state_next <= s2;
                  -- sentido horario (proximo)
               
               
               else                        -- (en) AND (cw')
                  state_next <= s0;
                  -- sentido anti-horario (anterior)
               end if;
               
            when s2 =>
                
                if en = '0' then   -- (en')
                    state_next <= s2;
                    
                elsif cw  = '1' then
                    state_next <= s3;
                    
                else
                    state_next <= s1;
                
                end if;
                
            when s3 =>
                    
                if en = '0' then   -- (en')
                    state_next <= s3;
                    
                elsif cw  = '1' then
                    state_next <= s4;
                    
                else
                    state_next <= s2;
                
               end if;
                    
            when s4 =>
                
                if en = '0' then   -- (en')
                    state_next <= s4;
                    
                elsif cw  = '1' then
                    state_next <= s5;
                    
                else
                    state_next <= s3;
                
                end if;
                        
            when s5 =>
                
                if en = '0' then   -- (en')
                    state_next <= s5;
                    
                elsif cw  = '1' then
                    state_next <= s6;
                    
                else
                    state_next <= s4;
                
                end if;
                            
            when s6 =>
                
                if en = '0' then   -- (en')
                    state_next <= s6;
                    
                elsif cw  = '1' then
                    state_next <= s7;
                    
                else
                    state_next <= s5;
                
                end if;
                                
            when s7 =>
                
                if en = '0' then   -- (en')
                    state_next <= s7;
                    
                elsif cw  = '1' then
                    state_next <= s0;
                    
                else
                    state_next <= s6;
                
                end if;                        
                        --(PREGUICAAAAAAAA)
        ---------------------------------------------------------------------------------------
        -------------BASTA CONTINUAR ATE O ESTADO S7 (EH CHATO) (FOI MESMO) -------------------
        ---------------------------------------------------------------------------------------
        
        --SERA QUE DA PRA USAR UM FOR?? ATEH DA, MAS EU NÂO VOU FAZER ISSO
        --MELHOR AINDA SERA QUE DA TEMPO DE TENTAR FAZER COM UM FOR? NAUM< NAUM DAHHHHH

         end case;
      end process;
   
        -- logica de saida Moore (prque eu acho mais interessante nesse caso)
        
        
        -----PREENCHER ALI OS SEGMENTOS COM AQUILO QUE TEM QUE SEREM CADA ESTADO
      process(state_reg)
      begin
         case state_reg is
            when s0 =>
                sseg <= "0011100";
                an <=   "11110111";
            when s1 =>
                sseg <= "0011100";
                an <=   "11111011";
            when s2 =>
                sseg <= "0011100";
                an <=   "11111101";
            when s3 =>
                sseg <= "0011100";
                an <=   "11111110";
            when s4 =>
                sseg <= "0100011";
                an <=   "11111110";
            when s5 =>
                sseg <= "0100011";
                an <=   "11111101";
            when s6 =>
                sseg <= "0100011";
                an <=   "11111011";   
            when s7 =>
                sseg <= "0100011";
                an <=   "11110111";                                                                           
         end case;
      end process;

end Behavioral;
