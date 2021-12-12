function data_bits_recebido = logicalTimes2VectorValue(logicalTimes, delay, delta, lengthVector)


    data_bits_recebido = zeros(1,lengthVector);
    for j = 1:lengthVector

       
        valueTime = (j - 1) + delay;
        time2Get = logicalTimes.Time >= valueTime - delta  & logicalTimes.Time <= valueTime + delta;

        bit = 0;
        for i=1:length(time2Get)
            if time2Get(i) == 1
                bit = logicalTimes.Data(i);
            end
        end
        data_bits_recebido(1,j) = bit;
    end



end