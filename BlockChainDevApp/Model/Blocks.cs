using BlockChainDevApp.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BlockChainDevApp.Model
{
    public class Blocks : IBlock
    {
        public int blockId { get; set; }
        public int blockNumber { get; set; }

        public string hash { get; set; }

        public string parentHash { get; set; }

        public string miner { get; set; }

        public decimal blockReward { get; set; }
        public decimal gasLimit { get; set; }
        public decimal gasUsed { get; set; }

        public List<Transactions> transactions { get; set; }

        public Blocks()
        {
            this.transactions = new List<Transactions>();
        }

    }
}
