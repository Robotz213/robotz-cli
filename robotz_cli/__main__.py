import argparse
import os
import subprocess
import sys
from typing import Literal


def mudar_diretorio(path, *args, **kwargs) -> None:
    # Isso não afeta o terminal externo, só o processo atual
    try:
        os.chdir(path)
        print(f"Diretório alterado para: {os.getcwd()}")
    except FileNotFoundError:
        print(f"Diretório '{path}' não encontrado.")


def listar_arquivos(*args, **kwargs) -> None:
    subprocess.run(["ls" if os.name != "nt" else "dir"], shell=True)


def executar_comando_personalizado(comando, *args, **kwargs) -> None:
    subprocess.run(comando, shell=True)


def main(argv: list) -> Literal[0] | Literal[1]:
    parser = argparse.ArgumentParser(description="Meu app de comandos customizados")
    subparsers = parser.add_subparsers(dest="comando")

    # Comando: mudar-diretorio
    parser_cd = subparsers.add_parser("cd", help="Muda para o diretório especificado")
    parser_cd.add_argument("path", help="Caminho do diretório")

    # Comando: listar
    subparsers.add_parser("ls", help="Lista arquivos no diretório atual")

    # Comando: exec
    parser_exec = subparsers.add_parser("exec", help="Executa um comando personalizado")
    parser_exec.add_argument("comando", help="Comando a ser executado")

    args = parser.parse_args(argv)

    comands_list = {
        "cd": mudar_diretorio,
        "ls": listar_arquivos,
        "exec": executar_comando_personalizado,
    }

    if args.comando:
        if args.comando in comands_list:
            comands_list[args.comando](**vars(args))
        return 0

    parser.print_help()
    return 1


if __name__ == "__main__":
    main(sys.argv[1:])
