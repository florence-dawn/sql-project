
--DROP TRIGGER tr_hist_saida_config ON saida_config;

CREATE OR REPLACE TRIGGER tr_hist_saida_config
    AFTER INSERT OR UPDATE 
    ON public.saida_config
    FOR EACH ROW
    EXECUTE FUNCTION public.fn_hist_saida_config();