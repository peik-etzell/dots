#!/bin/python

import os
from os import path, system

# const
home: str = os.environ['HOME']
dotfiles_root: str = path.join(home, 'dotfiles')

path_to_pointer_dir = {
    path.join(dotfiles_root, 'config'): f"{home}/.config/",
    path.join(dotfiles_root, 'home'): f"{home}/",
}


def init_omz() -> bool:
    if not path.exists(
            path.join(os.environ['HOME'], '.oh-my-zsh')):
        print('Initializing Oh-my-zsh')
        # curl omz
        system(
            'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')
        # link config
        system(
            'ln -svf $PWD/pegeh.zsh-theme $HOME/.oh-my-zsh/themes/pegeh.zsh-theme')
        return True
    return False


def link(link_value: str, link_pointer: str) -> bool:
    # scary
    if dotfiles_root not in link_value:
        print('not linking to dotfiles?')
        return False
    else:
        try:
            if path.islink(link_pointer) or path.exists(link_pointer):
                if path.islink(link_pointer)\
                        and os.readlink(link_pointer) == link_value:
                    return False
                else:
                    print(f'(Removing {link_pointer})')
                    os.remove(link_pointer)
            print(f"ln -svfT {link_value} {link_pointer}")
            os.symlink(link_value, link_pointer)
            return True
        except Exception:
            print('Check if destination has broken link there')
            return False


def dry_run(link_value: str, link_pointer: str) -> bool:
    print(f"ln -svT {link_value} {link_pointer}")

    if dotfiles_root not in link_value:
        print('not linking to dotfiles?')
        return False
    else:
        if path.exists(link_pointer):
            if not path.islink(link_pointer):
                pass
                # os.remove(link_pointer)
            else:
                return False
        # os.symlink(link_value, link_pointer)
        return True


def main():
    init_omz()
    print(path_to_pointer_dir)

    dirs = 0
    files = 0
    links = 0

    for value_path in path_to_pointer_dir:
        dirs += 1
        pointer_path = path_to_pointer_dir[value_path]
        for file_name in os.listdir(value_path):
            files += 1
            if link(path.join(value_path, file_name),
                    path.join(pointer_path, file_name)):
                links += 1

    print(f'Checked {dirs} dirs, found {files} files')
    print(f'\tNew links: {links}')


if __name__ == "__main__":
    main()
