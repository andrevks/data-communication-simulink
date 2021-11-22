clear 
clc 
close all 

% Setar o envio

request = matlab.net.http.RequestMessage;
uri = matlab.net.URI('https://api.chucknorris.io/jokes/random');
response = sendRequest(uri,request)
% body = response.Body.Data.value
body = 	'José Guilherme';

data_bits = text2bin(body);

[x_stairs, y_stairs] = stairs(data_bits);
x_stairs = x_stairs - 1;

time_value = [x_stairs, y_stairs];
lengthVector = length(data_bits);

% Envio - chamada no simulink

sim('Comunicacao_Simulink_R2018b',lengthVector);

delay = 0.2;
delta = 0.8;


data_bits_recebidoBFSK = logicalTimes2VectorValue(databits_simulink_BFSK, delay, delta, lengthVector);
bin2text(data_bits_recebidoBFSK)

delay = 0;
data_bits_recebidoBASK = logicalTimes2VectorValue(databits_simulink_BASK, delay, delta, lengthVector);
bin2text(data_bits_recebidoBASK)

databits_simulink_BPSK = logicalTimes2VectorValue(databits_simulink_BPSK, delay, delta, lengthVector);
bin2text(databits_simulink_BPSK)



