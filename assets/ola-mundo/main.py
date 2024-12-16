import os
import sys

def main():
    # Obtém o valor da variável de ambiente
    required_var = os.getenv("USER_NAME")
    if not required_var:
        print("Error: A variável de ambiente 'USER_NAME' é obrigatória.", file=sys.stderr)
        sys.exit(1)
    
    print(f"Olá {required_var} !!")

if __name__ == "__main__":
    main()
