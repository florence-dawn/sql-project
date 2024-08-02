
--DROP SEQUENCE hist_saida_config_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.hist_saida_config_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hist_saida_config_id_seq
    OWNER TO postgres;

--DROP TABLE hist_saida_config;

CREATE TABLE IF NOT EXISTS public.hist_saida_config
(
    id bigint NOT NULL DEFAULT nextval('hist_saida_config_id_seq'::regclass),
    id_filial int4 NOT NULL,
    dh_inc timestamp,
    user_inc varchar(30),
    campo character varying(255),
    valor_antigo text,
    valor_novo text,
    sentenca text,
    mensagem character varying(255),
    CONSTRAINT pk_hist_saida_config PRIMARY KEY (id),
    CONSTRAINT fk_id_filial FOREIGN KEY (id_filial)
        REFERENCES public.filial (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.hist_saida_config
    OWNER to postgres;
   
   