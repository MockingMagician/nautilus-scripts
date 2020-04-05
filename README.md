# WHAT IS THIS ABOUT ?

Here you find a set of usefull script for nautilus

## How to install

git clone that repository where you want and open your terminal

let's say you cloned into the directory '~/cloned-repositories/nautilus-script'

Now you have two way :

* First way : Sync with nautilus script repository, only if you don't have personal script

```bash
rm ~/.local/share/nautilus/scripts
ln -s ~/cloned-repositories/nautilus-script/src ~/.local/share/nautilus/scripts
```

So now your scripts are the same as those in the repository and can be updated directly with git pull command

* Second way : Copy src in nautilus scripts directory

```bash
cp -r ~/cloned-repositories/nautilus-script/src ~/.local/share/nautilus/scripts/nautilus-scripts
```

## Dependencies

Some script require the installation of some package

A none full list :

* tesseract
* pdftotext
* zenity

Install them in accordance with your favourite package manager (aptitude ...)
