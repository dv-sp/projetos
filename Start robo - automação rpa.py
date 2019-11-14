from selenium import webdriver                  #IMPORTA BIBLIOTECA
from selenium.webdriver.common.keys import Keys #IMPORTA BIBLIOTECA
from selenium.webdriver.common.by import By     #IMPORTA BIBLIOTECA

driver = webdriver.Chrome(executable_path=r'C:\CAMINHO DE REDE\chromedriver.exe') #DEFINIDO OBJETO(NAVEGADOR) PROGRAMÁVEL
driver.implicitly_wait(30) #AGUARDA 30 SEGUNDOS ANTES DE CONSIDERAR UMA EXCEÇÃO(ERRO).
driver.maximize_window()   #MAXIMIZA BROWSER

driver.get('https://www.google.com') #NAVEGA PARA O SITE ESPECIFICADO

search_field = driver.find_element_by_name('q') #LOCALIZA O ELEMENTO HTML. NO CASO O TEXTBOX DO GOOGLE PARA DIGITAR O CONTEÚDO DA PESQUISA.
search_field.clear() #LIMPA O ELEMENTO HTML.
search_field.send_keys('Temperatura em São Thomé das Letras') #DIGITA A STRING INFORMADA.
search_field.submit() #PESQUISA
