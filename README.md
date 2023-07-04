# TFG-Jose-Miguel-Montero

-En la carpeta Proyectos:

    -En el archivo Entreno del clasificador se encuentra todo lo referente al entreno del modelo final de evaluacion de la calidad de las imagenes digitales mediante tecnicas de deep learning.
  
    -En la carpeta MATLAB:
    
      -Los dos programas que permiten obtener las medidas de los metodos BRISQUE,PIQE y NIQE de todas las imagenes buenas y malas de los dos conjuntos de entreno y validacion:
            -Metricas Buenas: Obtiene todas las medidas de cada imagen de las de buena calidad y las guarda en dos archivos csv de entreno y de validación.
            -Metricas Malas: Obtiene todas las medidas de cada imagen de las de mala calidad y las guarda en dos archivos csv de entreno y de validación.
      -Imagenes con graficos que muestran las distribuciones de las imagenes por cada método.

    -En la carpeta R se encuentra el pdf obtenido de Rstudio donde se ha realizado los analisis estadiscticos comparativos de los modelos entrenados con las medidas clásicas BRISQUE,PIQE y NIQE.

-En la carpeta Valores de calidad:
    
    -Matlab:
          - Los archivos csv donde se han guardado todos los valores dados por las medidas clásicas tanto a las imágenes de entreno como a las de validación.
    -Python:
          - Los archivos csv donde se han guardado todos los valores dados por los modelos entrenados en los conjuntos de validación.



Como usar el modelo ImT sin entrenarlo previamente, es decir, cargando los pesos obtenidos en este proyecto:

Se debe tener una instancia del modelo creada, para ello primero se tiene que definir el modelo. Con el siguiente codigo se define el modelo utilizado:

    def initialize_model2(num_classes):
        #Los pesos si se entrenan
        model_ft = models.inception_v3(weights=False) #Se carga el modelo inception_v3 sin sus pesos preentrenados.
        # False en las redes convencionales, se entrenaran
        set_parameter_requires_grad(model_ft, False)
        # Se modifica la red auxiliar
        num_ftrs = model_ft.AuxLogits.fc.in_features
        model_ft.AuxLogits.fc = nn.Linear(num_ftrs, num_classes)

        #Se modifica la red principal para que sea de dos clases con una salida softmax y coger la con mas probabilidad.
        model_ft.dropout= nn.Dropout(0.5)
        num_ftrs = model_ft.fc.in_features
        model_ft.fc = nn.Sequential(
            nn.Linear(num_ftrs,num_classes),
            nn.Dropout(0.3),
            nn.Softmax(dim=1)
        )

        input_size=299 #Tamaño que usa la red
        return model_ft,input_size
    


Y con la siguiente funcion:

    def set_parameter_requires_grad(model, feature_extracting):
        if feature_extracting:
            for param in model.parameters():
                param.requires_grad = False
            
            

Y a continuacion se instancia un modelo. Para hacer eso se deben utilizar las siguientes lineas de codigo:
Device cpu si no se dispone de cuda y si no  device = torch.device("cuda:0") con el indice deseado.

    device = torch.device("cpu")
    Modeloft,_= initialize_model2(2)
    Modelo=Modeloft.to(device)

    #Para inutilizar la capa auxiliar.
    Modeloft.aux_logits=False



Para poder cargar los pesos del modelo se hace con la siguiente linea:

    Los .. es la direccion donde se tenga guardada la carpeta de pesos.
    PATH = '..\Pesos\modeltranformaciones.pt'
    Modelo.load_state_dict(torch.load(PATH))
    


Y para finalizar para poder usarlo en modo prediccion hay que ponerlo en modo eval:

    Modelo.eval() y pasar las imagenes que se deseen probar a 299 x 299



Una vez hecho eso se podra utilizar para las imagenes que se deseen.
  
Repositorio de imagenes del proyecto y de los pesos de los modelos que son necesarios cargar:

  -https://drive.google.com/drive/folders/1UwETo5a2imlZXlsy0wvZFKoSmZP1qXlO?usp=sharing
