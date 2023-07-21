import itertools
import json
import math
import os
import sys
from pathlib import Path
import numpy as np
import argparse
import re

import RRUtil.Benchmark as Bench
import RRUtil.Device as Device
import RRUtil.Utilities as Utilities

class liboromp(Bench.MakeBenchmark):
    def __init__(self, prof, **kwargs):
        kwargs.pop("executable", None)
        kwargs.pop('resultsdir', None)
        kwargs.pop('root', None)
        super().__init__(prof, "main", os.path.split(os.path.realpath(__file__))[0], **kwargs)

    def build(self, fn=None, useCase=None):
        if fn is None:
            return super().build({ 'LEFLAGS' : Device.GetCompileOptions(self.Device) }, filename="Makefile.gen")

        leOptions = Device.GetCompileOptions(self.Device) + f' -mllvm --bo-omp-autotune={fn}'
        return super().build({'LEFLAGS' : leOptions}, useCase, filename="Makefile.gen")

    def clean(self):
        pass
        #return super().clean()

    def command(self):
        return  f"{self.executableDir}/main 100"

    def env(self):
        return ''

    def getApplicationTime(self, stdout):
        return 0


