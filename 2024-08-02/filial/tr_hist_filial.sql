
--DROP TRIGGER tr_hist_filial ON filial;

CREATE OR REPLACE TRIGGER tr_hist_filial
    AFTER INSERT OR UPDATE 
    ON public.filial
    FOR EACH ROW
    EXECUTE FUNCTION public.fn_hist_filial();