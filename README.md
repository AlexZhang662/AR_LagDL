# AR_LagDT model

In this example, we will show in detail the application steps of AR_LagDT model, and publish the corresponding original dataset and MATLAB code.

### @main.m is the main program.

### @Test_series.xlsx is the test data set.


We give the expression of AR-LagDT $\left(p, s, l_{1}, l_{2}\right)$ model:
                                                         $$Y_{t}=\varphi_{1} Y_{t-1}+\cdots+\varphi_{p} Y_{t-p}+\varepsilon_{t}+L E(t).$$                          
Where $\boldsymbol{\Phi}=\left[\varphi_{1}, \ldots, \varphi_{p}\right]$, is the coefficient of the AR part. The vector $\textbf{LE}$ indicates the distributed lag impact of interventions on $Y_t$ and is the estimation of intervention impact. In this study, our most important purpose is to calculate the value of $\boldsymbol{LE}$ that gives estimations of intervention impact. For the lag of interventions effect, we assume that $LE(t)$, which is the value of vector $\boldsymbol{LE}$ at a specific point $t$, is influenced by intervention effects at the time point $t$ and at the previous s-1 time point, i.e., $L E(t)=\omega_{1} * F(t)+\cdots+\omega_{s} * F(t-s+1)$.  $\omega_{1}$,…, $\omega_{s}$ estimates the (lag) impact of intervention effect on the outcome time series. 

![image](https://github.com/user-attachments/assets/21975129-11a8-4dda-a8a0-53cfe02c8168)
### Fig 1. Schematic diagram of each component for AR-LagDT model.

## The demo video shows the software operation process, allowing users to gain a more intuitive understanding of its usage and workflow.

![image](https://github.com/user-attachments/assets/dd34bfb8-362f-4b7f-a3f4-ad13d82acf59)

![image](https://github.com/user-attachments/assets/fbd4323e-212d-4607-860e-e9c74e4b3845)

## The fold “MATLAB App Designer” contains the MATLAB's App Designer ".mlapp" document.
## The fold “App exe” contains AR_LagDT software, which is implemented based on MATLAB's App Designer technology and generated using MATLAB's Application Compiler package.
