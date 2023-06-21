archivosEntreno = dir('..\..\Imagenes\Entreno\Buena calidad');
archivosValidacion = dir('..\..\Imagenes\Validacion\Buena calidad');


%Imagenes de Entreno
imagenesEntreno = archivosEntreno( endsWith({archivosEntreno.name}, '.png')); %%Coge solo los elementos que acaben en .png

% Array para guardar el numero de imagenes en cada categoria que detecta cada metodo
datosBrisqueEn = zeros(1,2);
datosPIQE_En=zeros(1,2);
datosNIQE_En=zeros(1,5);

nombre_imagenEntreno = cell(1, size(imagenesEntreno, 1)); %%Array de nombres de la imagenes
BRISQUE_scoreEntreno = zeros(1,size(imagenesEntreno, 1)); %%Array de brisque score de la imagenes
PIQE_scoreEntreno = zeros(1,size(imagenesEntreno, 1)); %%Array de PIQE score de la imagenes
NIQE_scoreEntreno = zeros(1,size(imagenesEntreno, 1)); %%Array de NIQE score de la imagenes

%%Metricas de las imagenes de Entreno
for i = 1:length(imagenesEntreno)
    nombre_imagenEntreno{i} = imagenesEntreno(i).name;
    imagen = imread(fullfile(imagenesEntreno(i).folder, nombre_imagenEntreno{i}));
    BRISQUE_score = brisque(imagen);
    PIQEscore = piqe(imagen);
    NIQEscore = niqe(imagen);

    fprintf('BRISQUE score for %s is %0.4f.\n', imagenesEntreno(i).name,BRISQUE_score);
    fprintf('PIQE score for %s is %0.4f.\n', imagenesEntreno(i).name,PIQEscore);
    fprintf('NIQE score for %s is %0.4f.\n', imagenesEntreno(i).name,NIQEscore);

    BRISQUE_scoreEntreno(i) = BRISQUE_score;
    PIQE_scoreEntreno(i) = PIQEscore;
    NIQE_scoreEntreno(i) = NIQEscore;
    
    %Se le suma un valor segun su condicion.
    datosBrisqueEn = Funciones(BRISQUE_score,datosBrisqueEn);
    datosPIQE_En=Funciones(PIQEscore,datosPIQE_En);
    datosNIQE_En=DistanciasNIQE(NIQEscore,datosNIQE_En);

end

% Visualiza los graficos con el numero de imagenes que detecta cada metodo
% categorizados en iamgenes de buena o mala calidad segun su puntacion
Grafico('BRISQUE Imagenes Entreno de Buena Calidad',datosBrisqueEn);
Grafico('PIQE Imagenes Entreno de Buena Calidad' ,datosPIQE_En);
% Grafica y agrupa las diferentes distancias que les aplica a las imagenes
GraficoNIQE('NIQE Imagenes Entreno de Buena Calidad', datosNIQE_En);

% Crear la tablas con los datos recopilados de las imagenes de entreno
tablaUNIDA=table(nombre_imagenEntreno', BRISQUE_scoreEntreno', PIQE_scoreEntreno', NIQE_scoreEntreno', 'VariableNames', {'Nombre_imagen', 'BRISQUE_SCORE','PIQE_SCORE','NIQE_SCORE'});
% Mostrar la tabla en la ventana de comandos

disp(tablaUNIDA);

writetable(tablaUNIDA, '..\..\Valores de calidad\Matlab\MetricasBuenaCalidadEntreno.csv');


imagenesValidacion = archivosValidacion( endsWith({archivosValidacion.name}, '.png')); %%Coge solo los elementos que acaben en .png

nombre_imagenVal = cell(1,size(imagenesValidacion, 1)); %%Array de nombres de la imagenes
BRISQUE_scoreVal = zeros(1,size(imagenesValidacion, 1)); %%Array de brisque score de la imagenes
PIQE_scoreVal = zeros(1,size(imagenesValidacion, 1)); %%Array de PIQE score de la imagenes
NIQE_scoreVal = zeros(1,size(imagenesValidacion, 1)); %%Array de NIQE score de la imagenes

datosBrisqueVal = zeros(1,2);
datosPIQEVal=zeros(1,2);
datosNIQEVal=zeros(1,5);



%%Metricas de las imagenes de Validacion de buena calidad


for i = 1:length(imagenesValidacion)

    
    nombre_imagenVal{i} = imagenesValidacion(i).name;
    imagen = imread(fullfile(imagenesValidacion(i).folder, nombre_imagenVal{i}));
    BRISQUE_score = brisque(imagen);
    PIQEscore = piqe(imagen);
    NIQEscore = niqe(imagen);
    fprintf('BRISQUE score for %s is %0.4f.\n', imagenesValidacion(i).name,BRISQUE_score);
    fprintf('PIQE score for %s is %0.4f.\n', imagenesValidacion(i).name,PIQEscore);
    fprintf('NIQE score for %s is %0.4f.\n', imagenesValidacion(i).name,NIQEscore);
    BRISQUE_scoreVal(i) = BRISQUE_score;
    PIQE_scoreVal(i) = PIQEscore;
    NIQE_scoreVal(i) = NIQEscore;


    datosBrisqueVal = Funciones(BRISQUE_score,datosBrisqueVal);
    datosPIQEVal=Funciones(PIQEscore,datosPIQEVal);
    datosNIQEVal=DistanciasNIQE(NIQEscore,datosNIQEVal);


end




Grafico('BRISQUE Imagenes Validación de Buena Calidad',datosBrisqueVal);
Grafico('PIQE Imagenes Validación de Buena Calidad',datosPIQEVal);
GraficoNIQE('NIQE Imagenes Validación de Buena Calidad', datosNIQEVal);

% Crear la tablas con los datos recopilados de las imagenes de entreno
tablaUNIDAValidacion=table(nombre_imagenVal', BRISQUE_scoreVal', PIQE_scoreVal', NIQE_scoreVal', 'VariableNames', {'Nombre_imagen', 'BRISQUE_SCORE','PIQE_SCORE','NIQE_SCORE'});
% Mostrar la tabla en la ventana de comandos

disp(tablaUNIDAValidacion);

writetable(tablaUNIDAValidacion, '..\..\Valores de calidad\Matlab\MetricasBuenaCalidadValidacion.csv');


fprintf('Programa  acabado');




