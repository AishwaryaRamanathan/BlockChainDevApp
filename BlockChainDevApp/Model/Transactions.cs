using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlockChainDevApp.Model
{
    public class Transactions
    {
        public int TransactionId { get; set; }
        public int blockId { get; set; }
        [ForeignKey("Blocks")]
        public virtual Blocks Blocks { get; set; }
        public string hash { get; set; }
        public string From {get; set; }
        public string To { get; set; }
        public decimal Value { get; set; }
        public decimal Gas { get; set; }
        public decimal GasPrice { get; set; }
        public int TransactionIndex { get; set; }

        public Transactions (string from,string to,decimal value)
        {
            this.From = from;
            this.To = to;
            this.Value = value;
        }

        public Transactions(string from, string to, decimal value, decimal gas, decimal gasPrice, int transactionIndex)
        {
            this.From = from;
            this.To = to;
            this.Value = value;
            this.Gas = gas;
            this.GasPrice = gasPrice;
            this.TransactionIndex = transactionIndex;
           // this.TransactionId = transactionId;
        }
    }
}
