# 2023-05-01-hsf-india-tutorial

**Quickstart (I'll format this nicely later).**

**Step 1:** log into gpu01.indiacms.res.in with your username and password.

**Step 2:** install Mambaforge (dependency manager for all the software we'll be using).

```bash
wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
bash Mambaforge-Linux-x86_64.sh
```

Accept the license and all of the defaults, including "add startup to your shell."

**Step 3:** log out of gpu01.indiacms.res.in and back in again. _(Unclear if this step is necessary.)_

**Step 4:** clone this repository and `cd` into it.

```bash
git clone https://github.com/jpivarski-talks/2023-05-01-hsf-india-tutorial.git
cd 2023-05-01-hsf-india-tutorial
```

**Step 5:** create an environment from `environment.yml`, which installs all of the software.

```bash
mamba env create -f environment.yml
```

**Step 6:** log into gpu01.indiacms.res.in with port forwarding.

```bash
ssh -L localhost:8889:localhost:8889 YOUR-USERNAME-HERE@gpu01.indiacms.res.in
```

**Step 7:** in the port-forwarding terminal, enter the new software environment.

```bash
mamba activate 2023-05-01-hsf-india-tutorial
```

**Step 8:** in the port-forwarding terminal, start JupyterLab.

```bash
jupyter lab --no-browser --port=8889
```

**Step 9:** copy the `localhost:8889` URL that it provides to you into your laptop's web browser.

You should see JupyterLab appear. Access to files are in the left-bar (top toolbar button if the left-bar is hidden). We'll start with `lesson-1.ipynb`.
