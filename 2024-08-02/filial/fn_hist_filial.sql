
--DROP FUNCTION fn_hist_filial();

CREATE OR REPLACE FUNCTION public.fn_hist_filial()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
	
	AS $BODY$
		DECLARE
			nome_coluna character varying(255);
			coluna character varying(255);
			sentenca text;
			valor_a text;
			valor_n text;
		BEGIN
		
			IF (TG_OP = 'INSERT') THEN

				INSERT INTO hist_filial
				(id_filial, dh_inc, user_inc, sentenca, mensagem)
				VALUES
				(NEW.id , CURRENT_TIMESTAMP, NEW.user_inc, CURRENT_QUERY(), 'Inclusão do Registro');

				RETURN NEW;

			ELSIF (TG_OP = 'UPDATE') THEN

				FOR nome_coluna IN SELECT column_name FROM information_schema.columns WHERE table_schema = TG_TABLE_SCHEMA AND table_name = TG_TABLE_NAME LOOP
				
					EXECUTE 'SELECT $1.' || quote_ident(nome_coluna) INTO valor_a USING OLD;
					EXECUTE 'SELECT $1.' || quote_ident(nome_coluna) INTO valor_n USING NEW;
					sentenca := format('SELECT campo_nome FROM bd WHERE campo = ''%s''', nome_coluna);
					EXECUTE sentenca INTO coluna;
 
					IF valor_a IS DISTINCT FROM valor_n AND nome_coluna NOT IN ('id', 'dh_inc', 'dh_alt', 'user_inc', 'user_alt', 'excluido') THEN

						INSERT INTO hist_filial
						(id_filial, dh_inc, user_inc, campo, valor_antigo, valor_novo, sentenca, mensagem)
						VALUES
						(NEW.id, CURRENT_TIMESTAMP, NEW.user_alt, coluna, valor_a, valor_n, CURRENT_QUERY(), 'Alteração do Registro');

					END IF;

				END LOOP;

				RETURN NEW;

			END IF;
			
		END $BODY$;