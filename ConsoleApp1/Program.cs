using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            Credito credito = new Credito
            {
                ValorCredito = 15000,
                TipoCredito = "Credito Pessoa Jurídica",
                Taxa = 5,
                QtdParcelas = 5,
                DataPrimeiroVencimento = DateTime.Now.AddDays(40)
            };

            string retorno = ValidarCredito(credito);

            if (String.IsNullOrEmpty(retorno))
            {
                retorno = "Aprovado";
            }
            
            double valorJuros = (credito.Taxa / 100) * credito.ValorCredito;
            double valorTotalComJuros = credito.ValorCredito + valorJuros;

            Console.WriteLine("Status do crédito: " + retorno + "\nValor Total Com Juros: " + valorTotalComJuros.ToString("C2") + 
                "\nValor do juros: " + valorJuros.ToString("C2"));

        }

        public static string ValidarCredito(Credito credito)
        {
            if (credito.ValorCredito > 1000000)
            {
                return "Recusado";
            }
            if (credito.QtdParcelas > 72 || credito.QtdParcelas < 5)
            {
                return "Recusado";
            }
            if (credito.TipoCredito.Equals("Credito Pessoa Jurídica") && credito.ValorCredito < 15000)
            {
                return "Recusado";
            }
            if (credito.DataPrimeiroVencimento < DateTime.Now.AddDays(15) || credito.DataPrimeiroVencimento > DateTime.Now.AddDays(40)) 
            {
                return "Recusado";
            }
            return "";
        }
    }
}
