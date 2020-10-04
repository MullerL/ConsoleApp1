using System;
using System.Collections.Generic;
using System.Text;

namespace ConsoleApp1
{
    public class Credito
    {
        public double ValorCredito { get; set; }
        public string TipoCredito { get; set; }
        public double Taxa { get; set; }
        public int QtdParcelas { get; set; }
        public DateTime DataPrimeiroVencimento { get; set; }
    }
}
