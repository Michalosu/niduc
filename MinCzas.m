function [zdarzenie, kasa, Tzdarz] = MinCzas(czasZgloszenia, czasObslugi, stan, liczbaKas)
    %Domyslne zdarzenie - zgloszenie sie klienta
    min = czasZgloszenia;
    kasa = 0;
    zdarzenie = 0;
    %Porownywanie czasu zgloszenia z czasami obslugi
    for i=1 : liczbaKas
        %Jezeli ktorys z czasow obslugi mniejszy i w kasie jest kolejka
        if (min > czasObslugi(i) & stan(i) > 0)
            %Najwczesniejszym zdarzeniem - obsluga klienta
            min = czasObslugi(i);
            kasa = i;
            zdarzenie = 1;
        end
    end
%Zwrocenie czasu wystapienia zdarzenia
Tzdarz = min;
end