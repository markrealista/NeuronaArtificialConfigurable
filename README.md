# Diseño e implementación sobre FPGA de una neurona artificial configurable

_Trabajo de Fin de Grado realizado para el Grado en Ingeniería de Tecnologías y Servicios de Telecomunicación de la Universidad Politécnica de Madrid._

**AUTOR:** Mark Realista Quiocho

**TUTOR:** Pablo Ituero Herrero

**DEPARTAMENTO:** Departamento de Ingeniería Electrónica

## Resumen

Este Trabajo de Fin de grado se enmarca en el ámbito de la Inteligencia Artificial y el Aprendizaje Automático. En concreto, este TFG plantea el diseño, el desarrollo y la implementación de una neurona artificial (elemento básico de una red neuronal artificial) buscando enfocar dicha neurona hacia la configurabilidad entre precisión y latencia. Para ello, los pasos que se han seguido son los siguientes: 

En primer lugar, se ha realizado un estudio de la literatura existente, poniendo un énfasis especial en la búsqueda de multiplicadores configurables y de métodos de implementación de funciones de activación.

A continuación, se ha diseñado e implementado en VHDL un multiplicador serie-paralelo configurable capaz de realizar multiplicaciones en binario y en complemento a 2 entre dos operandos A(m) y B(n) introducidos en serie y en paralelo respectivamente, siendo m un número cualquiera y n = 4, 8 o 16 bits. Este multiplicador se basa en 4 multiplicadores de 4 bits que, o bien se pueden utilizar independientemente, o bien se pueden enlazar mediante la acción de multiplexores dando lugar a 2 multiplicadores de 8 bits o a un multiplicador de 16 bits. Esta propiedad de configurabilidad ofrece un compromiso entre precisión y latencia, dando lugar a una mayor latencia cuanto mayor es la precisión y viceversa. De este multiplicador configurable se ha visto que presenta una latencia de m+n ciclos de reloj, un throughput de 1/(m+n) operaciones/ciclo, una frecuencia de trabajo máxima de 330 MHz y una utilización de LUT y FF inferior al 1%.

Posteriormente, se ha diseñado e implementado en VHDL un módulo que implementa una función sigmoide configurable del cual se pueden obtener 1, 2 o 4 funciones sigmoide con diferentes precisiones y latencias a partir del multiplicador configurable desarrollado anteriormente. Para la implementación de este módulo se ha seguido un proceso de diseño basado en síntesis de alto nivel a partir de la expansión en serie de Taylor por intervalos de la función sigmoide. De este módulo se ha visto que presenta un latencia máxima igual a 6(m+n)+11 ciclos de reloj, un throughput igual a la inversa de la latencia, una frecuencia de trabajo máxima de 175 MHz y una utilización de LUT y FF inferior al 1%.

Finalmente, se ha realizado una primera aproximación de la estructura que tendría una neurona artificial configurable construida a partir del multiplicador configurable y de la función sigmoide desarrollados anteriormente.
