from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import os.path

ext_modules=[
    Extension("rtdADIO.ADIO",
              ["rtdADIO/rtdADIO.pyx"],
              extra_objects=['../lib/librtd-aDIO.a'],
              include_dirs=['../include'])
]

setup(
  name = "rtdADIO",
  cmdclass = {"build_ext": build_ext},
  ext_modules = ext_modules
)
