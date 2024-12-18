#%%
import numpy as np
import scipy as sc
import matplotlib.pyplot as plt

#%%
def convolucion(h, u):
    lu=u.shape[0]
    lh=h.shape[0]
    c=np.hstack((h,np.zeros((lu-1,))))
    r=np.hstack((h[0], np.zeros(lu-1,)))
    H=sc.linalg.toeplitz(c,r);
    y=H@u
    nu=np.arange(0,lu);
    nh=np.arange(0,lh);
    ny=np.arange(0,len(y));
    f, ax=plt.subplots(3,1, figsize=(8,10))
    ax[0].stem(nu,u)
    ax[0].set_ylabel("u(n)")
    ax[1].stem(nh,h)
    ax[1].set_ylabel("h(n)")
    ax[2].stem(ny,y)
    ax[2].set_ylabel("y(n)")
    f.show()
# %%
