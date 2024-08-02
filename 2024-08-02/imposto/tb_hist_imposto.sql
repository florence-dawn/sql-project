
--DROP SEQUENCE hist_imposto_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.hist_imposto_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hist_imposto_id_seq
    OWNER TO postgres;

--DROP TABLE hist_imposto;

CREATE TABLE IF NOT EXISTS public.hist_imposto
(
    id bigint NOT NULL DEFAULT nextval('hist_imposto_id_seq'::regclass),
    id_imposto bigint NOT NULL,
    id_filial int4 NOT NULL,
    ncm varchar(8),
    subtipo char(1),
    uf varchar(2),
    dh_inc timestamp,
    user_inc varchar(30),
    campo character varying(255),
    valor_antigo text,
    valor_novo text,
    sentenca text,
    mensagem character varying(255),
    CONSTRAINT pk_hist_imposto PRIMARY KEY (id),
    CONSTRAINT fk_id_imposto FOREIGN KEY (id_imposto)
        REFERENCES public.imposto (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
        CONSTRAINT fk_id_filial FOREIGN KEY (id_filial)
        REFERENCES public.filial (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.hist_imposto
    OWNER to postgres;
