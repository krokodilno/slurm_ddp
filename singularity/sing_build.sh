VER=1.4.0

IMAGE_NAME=./pytorch_gpu_${VER}_ct_utils.simg

%post
export PATH=/opt/conda/bin:$PATH

#build
sudo singularity build ${IMAGE_NAME} ./Singularity.${VER}

# test pytorch
singularity exec --nv ${IMAGE_NAME} python -c "import torch;print('pytorch version: ' + torch.__version__)"
singularity exec --nv ${IMAGE_NAME} python -c "import torch; print(torch.cuda.is_available())"
# test opencv
singularity exec --nv ${IMAGE_NAME} python -c "import cv2; print('Opencv version: ' + cv2.__version__)"

# test albu
singularity exec --nv ${IMAGE_NAME} python -c "import albumentations as A; print('Albu version: ' + A.__version__)"

# test  dl libs
singularity exec --nv ${IMAGE_NAME} python -c "import pytorch_lightning, segmentation_models_pytorch, pytorch_toolbelt"

# test helper libs
singularity exec --nv ${IMAGE_NAME} python -c "import pandas, numpy, scipy, tqdm, fire, yaml"



echo image: ${IMAGE_NAME}
