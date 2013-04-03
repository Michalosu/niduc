t=0;
nazwa = 'c:\\niduc\\dane.txt';
[fid, message] = fopen(nazwa,'r');
if fid==-1
    disp(message)
    return;
end

tmax=fscanf(fid,'%d',1);
liczbaKas=fscanf(fid,'%d',1);
wsp_przybycia=fscanf(fid,'%d',1);
wsp_obslugi=fscanf(fid,'%d',1);
fclose(fid);

stan=zeros(1,liczbaKas);
czas=zeros(1,liczbaKas);
czasZgloszenia=exprnd(wsp_przybycia);

nazwa = 'c:\\niduc\\wynik.txt';
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
    else
        [d,e]=min(stan);
        stan(e)=stan(e)+1;
        czas=czas-czasZgloszenia;
        t=t+czasZgloszenia;
        if(stan(e)==1)
            czas(e)=wblrnd(wsp_obslugi,3);
        end
        czasZgloszenia=exprnd(wsp_przybycia);
    end

    fprintf(fid,'%f\t\t',t);
    for j=1:liczbaKas
        fprintf(fid,'%d\t', stan(j));
    end
    fprintf(fid,'\r\n');

end
fclose(fid);
