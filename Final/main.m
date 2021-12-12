clear 
clc 
close all 

% Request random text by API
request = matlab.net.http.RequestMessage;
uri = matlab.net.URI('https://api.chucknorris.io/jokes/random');
response = sendRequest(uri,request);
body = response.Body.Data.value

% Transform text to binary
% https://github.com/Nikeshbajaj/Text-to-Binary
data_bits = text2bin(body);

% Transform binary to signal
[x_stairs, y_stairs] = stairs(data_bits);
x_stairs = x_stairs - 1;
time_value = [x_stairs, y_stairs];
lengthVector = length(data_bits);

% Send signal to simulink for transmission and receive 
sim('Comunicacao_Simulink_R2018b',lengthVector);

% Transform signal to binary and binary to text - BFSK
delay = 0.2;
delta = 0.08;
data_bits_received_BFSK = logicalTimes2VectorValue(databits_simulink_BFSK, delay, delta, lengthVector);
BFSK_text = bin2text(data_bits_received_BFSK)

% Transform signal to binary and binary to text - BASK
delay = 0;
data_bits_received_BASK = logicalTimes2VectorValue(databits_simulink_BASK, delay, delta, lengthVector);
BASK_text = bin2text(data_bits_received_BASK)

% Transform signal to binary and binary to text - BPSK
data_bits_received_BPSK = logicalTimes2VectorValue(databits_simulink_BPSK, delay, delta, lengthVector);
BPSK_text = bin2text(data_bits_received_BPSK)