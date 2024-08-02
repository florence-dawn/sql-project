
--DROP TRIGGER tr_hist_imposto ON imposto;

CREATE OR REPLACE TRIGGER tr_hist_imposto
    AFTER INSERT OR UPDATE 
    ON public.imposto
    FOR EACH ROW
    EXECUTE FUNCTION public.fn_hist_imposto();