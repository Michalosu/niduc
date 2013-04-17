nazwa = 'dane.txt';
[fid, message] = fopen(nazwa,'r');
if fid==-1
    disp(message)
    return;
end

tmax=fscanf(fid,'%d',1);
liczbaKas=fscanf(fid,'%d',1);
wsp_obslugi=fscanf(fid,'%f',1);
wybor=fscanf(fid,'%d\n',1);
wsp_przybycia=fscanf(fid,'%d',10);

fclose(fid);

stan=zeros(1,liczbaKas);
czas=zeros(1,liczbaKas);
klienci=zeros(1,liczbaKas);
przyjscie=zeros(tmax/2,liczbaKas);
klienciwyj=zeros(1,liczbaKas);
wyjscie=zeros(1,liczbaKas);
czasczekania=zeros(1,liczbaKas);
klient=0;
t=0;
czasZgloszenia=exprnd(wsp_przybycia(1));

nazwa = 'wynik1.txt';
[fid, message] = fopen(nazwa,'w');
if fid==-1
    disp(message)
    return;
end

    while(t<tmax)

        [a,b,c]=MinCzas(czasZgloszenia, czas, stan, liczbaKas);
        t=t+c;

        if(a==1)
            stan(b)=stan(b)-1;
            czas(b)=wblrnd(wsp_obslugi,3);
            czasZgloszenia=czasZgloszenia-c;
            if(wybor==2)
                klienciwyj(b)=klienciwyj(b)+1;
                klient=klient+1;
                czasczekania(b)=t-przyjscie(klienciwyj(b),b);
                fprintf(fid,'%d\t', klient);
                fprintf(fid,'%f\t', czasczekania(b));
                fprintf(fid,'\r\n');
            end
        else
            [d,e]=min(stan);
            stan(e)=stan(e)+1;
            klienci(e)=klienci(e)+1;
            czas=czas-czasZgloszenia;
            przyjscie(klienci(e),e)=t;

            if(stan(e)==1)
                czas(e)=wblrnd(wsp_obslugi,3);
                % if(wybor==2)
                %if(klienci(e)==1)
                %czasczekania(e)=czas(e);
                %fprintf(fid,'%d\t', klient);
                %fprintf(fid,'%f\t', czasczekania(e));
                %fprintf(fid,'\r\n');
                %end
                %end
            end
            g=ceil(t/(tmax/10));
            czasZgloszenia=exprnd(wsp_przybycia(g));
        end
        if(wybor==1)
            fprintf(fid,'%f\t\t',t);
            for j=1:liczbaKas
                fprintf(fid,'%d\t', stan(j));
            end
            fprintf(fid,'\r\n');
        end
    end
    if(wybor==2)
        hist(czasczekania)
    end
fclose(fid);