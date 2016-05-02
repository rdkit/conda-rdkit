from __future__ import print_function

import os
from datetime import datetime

from rdkit.rdBase import rdkitVersion

if rdkitVersion.endswith(".dev1"):
    pkg_version = rdkitVersion[:-1] + datetime.today().strftime("%Y%m%d")
else:
    pkg_version = rdkitVersion

version_path = os.path.join(os.environ['SRC_DIR'], '__conda_version__.txt')

with open(version_path, "wt") as version_file:
    print(pkg_version, file=version_file)

