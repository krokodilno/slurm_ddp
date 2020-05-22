# Multinode ddp training with pytorch_lightning and slurm
1.
    Build your env using Singularuty container.
    Check singularity recipe [singularity/Singularity.1.4.0] 

        ```
        sudo apt-get install -y singularity-container
        cd singularity
        bash sing_build.sh
        ```
2.
    Check slurm configs and paths at submit.sh.\
    Number of nodes and gpus must match lightning Trainer params

    example training 2 nodes X 1 gpu 

    ```bash
    #SBATCH --nodes=2
    #SBATCH --gres=gpu:1
    #SBATCH --ntasks-per-node=1
    ```

    ```python
    from pytorch_lightning import Trainer

    trainer = Trainer(
        gpus=1,
        num_nodes=2,
        distributed_backend="ddp"
    )
    ```

3.
    Run job

    ```bash
    sbatch submit.sh
    ```

4. Basic commands\

    cancel job
    ```bash
    scancel yourJobID
    ```

    check status
    ```
    squeue -j yourJobID
    ```

    get into allocated machine
    ```
    ssh hostname
    ```

    more:\
        https://slurm.schedmd.com/pdfs/summary.pdf

4. 
    The way to get logs on your local machine 
    ```bash
    rsync -avh --info=progress2 /src /dst
    ```