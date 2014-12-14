import os
import tarfile

from utils import download_file

AVALON_URL = (
    'http://downloads.sourceforge.net/project/avalontoolkit/' 
    'AvalonToolkit_1.2/AvalonToolkit_1.2.0.source.tar'
    )

avalon_tarball = download_file(AVALON_URL)

AVALON_SRC_DIR = os.path.join(
    os.environ['SRC_DIR'], 'External', 'AvalonTools', 'src'
    )

os.makedirs(AVALON_SRC_DIR)

tarfile.open(avalon_tarball).extractall(AVALON_SRC_DIR)
