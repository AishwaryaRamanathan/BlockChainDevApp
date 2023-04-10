using BlockChainDevApp.Model;
using Microsoft.Web.Services3.Security.Utility;
using Nethereum.Hex.HexTypes;
using Nethereum.Model;
using Nethereum.RLP;
using Nethereum.RPC.Eth;
using Nethereum.Web3;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Org.BouncyCastle.Utilities;
using Serilog;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Log = Serilog.Log;

namespace BlockChainDevApp
{
    public class Program
    {
        private static string uri = "https://eth-mainnet.g.alchemy.com/v2/oPeFpOXj96ZSVwQPN82grxxuNHlHoYte";
        Web3 web3 = new Web3(uri);
     
        
        public string CalculateHash(string rawData)
        {
            using(SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                StringBuilder str = new StringBuilder();
                for(int i =0; i < bytes.Length; i++)
                {
                    str.Append(bytes[i].ToString("x2"));

                }
                return str.ToString();
            }
        }

        public int getLatestBlock()
        {
            var response = web3.Eth.Blocks.GetBlockNumber.SendRequestAsync();
            var json = JsonConvert.SerializeObject(response);
            
           var details = JObject.Parse(json.ToString());
          
            var url = (string)details.SelectToken("Result");
            Console.WriteLine(url);

            return Convert.ToInt32(url, 16);

            
        }

           

        public List<Blocks> GetBlockByNumber(int blockNum)
        
        {
            
            var response = web3.Eth.Blocks.GetBlockWithTransactionsByNumber.SendRequestAsync(new HexBigInteger(blockNum));
            var json = JsonConvert.SerializeObject(response);
            var details = JObject.Parse(json.ToString());
            Console.WriteLine(details);
            
            
            Blocks b = new Blocks();
            IBlock bList = new IBlock();

         
         
            
            b.hash = (string)details.SelectToken("Result.transactions[0].hash");
            b.parentHash = (string)details.SelectToken("Result.transactions[0].blockHash");
            b.blockNumber = Convert.ToInt32((string)details.SelectToken("Result.transactions[0].blockNumber"), 16);
            b.gasLimit = Convert.ToDecimal(30000000);
            
            b.gasUsed = Convert.ToDecimal(Convert.ToInt32((string)details.SelectToken("Result.transactions[0].gas"), 16));
            b.blockReward = Convert.ToDecimal(Convert.ToInt32((string)details.SelectToken("Result.transaction[0].nonce"), 16));
            b.miner = CalculateHash((string)details.SelectToken("Result.transactions[0].from"));
           
            

            bList.blockChain.Add(b);

           foreach(var c in bList.blockChain)
            {
                Console.WriteLine("Hash:{0}",c.hash);
                Console.WriteLine( "BlockNumber: {0}",c.blockNumber);
                Console.WriteLine("ParentHash: {0}",c.parentHash);
                Console.WriteLine("GasLimit:{0}",c.gasLimit);
                Console.WriteLine("BlockReward: {0}",c.blockReward); 
                Console.WriteLine("GasUsed: {0}",c.gasUsed);
                Console.WriteLine("Miner: {0}",c.miner);
                
            }

            return bList.blockChain;

        }

        public int GetBlockTransactionCountByNum(int blockNumber)
        {

                       
            var response = web3.Eth.Blocks.GetBlockTransactionCountByNumber.SendRequestAsync(new HexBigInteger (blockNumber));

            var json = JsonConvert.SerializeObject(response);
           
            var details = JObject.Parse(json.ToString());

            Console.WriteLine(details);

            var tranCount = Convert.ToInt32((string)details.SelectToken("Result"), 16);

            return tranCount;
            
           
        }

        public List<Blocks> GetTransactionByBlockNumberAndIndex(int blockNumber, int count)
        {
            var uncleIndex =0;
            if (count != 0)
            {
                var index = web3.Eth.Uncles.GetUncleCountByBlockNumber.SendRequestAsync(new HexBigInteger(blockNumber));
                var json = JsonConvert.SerializeObject(index);
                var details = JObject.Parse(json.ToString());
                var UncleCount = Convert.ToInt32((string)details.SelectToken("Result"), 16);
               
                if(UncleCount != 0)
                {
                    uncleIndex = UncleCount - 1;
                }
                else
                {
                    uncleIndex = 0;
                }

            }

            var response = web3.Eth.Transactions.GetTransactionByBlockNumberAndIndex.SendRequestAsync(new HexBigInteger(blockNumber), new HexBigInteger(uncleIndex));
            var jso1 = JsonConvert.SerializeObject(response);
            var details1 = JObject.Parse(jso1.ToString());
            Console.WriteLine(details1);
            Blocks b = new Blocks();
            IBlock bList = new IBlock();

            var From = (string)details1.SelectToken("Result.from");
            var To = (string)details1.SelectToken("Result.to");
            var Value = Convert.ToDecimal(Convert.ToUInt64 ((string)details1.SelectToken("Result.value"), 16));
            var gas = Convert.ToDecimal(Convert.ToInt32((string)details1.SelectToken("Result.gas"), 16));
            var gasPrice = Convert.ToDecimal(Convert.ToInt64((string)details1.SelectToken("Result.gasPrice"), 16));
            var transactionIndex = Convert.ToInt32((string)details1.SelectToken("Result.transactionIndex"), 16);
            //var transactionId = Convert.ToInt32((string)details1.SelectToken("Result.v"), 16);

            Transactions t = new Transactions(From, To, Value, gas, gasPrice, transactionIndex);
            b.hash = (string)details1.SelectToken("Result.hash");

            b.transactions.Add(t);

            bList.blockChain.Add(b);

            foreach(var c in bList.blockChain)
            {
                Console.WriteLine("hash: {0}", c.hash);
                foreach (var c1 in c.transactions)
                {
                    //Console.WriteLine("transactionId: {0}", c1.TransactionId);
                   
                    Console.WriteLine("from: {0}", c1.From);
                    Console.WriteLine("to: {0}", c1.To);
                    Console.WriteLine("value: {0}", c1.Value);
                    Console.WriteLine("gas: {0}", c1.Gas);
                    Console.WriteLine("gasPrice: {0}", c1.GasPrice);
                    Console.WriteLine("transactionIndex : {0}", c1.TransactionIndex);
                }
            }
            return bList.blockChain;

        }
            
       

        static async Task Main(string[] args)
        {


            Log.Logger = new LoggerConfiguration()
                .WriteTo.Console()
                .WriteTo.File
                (path: "C:\\Users\\tas\\source\\repos\\BlockChainDevApp\\BlockChainDevApp\\log\\logfile.txt", rollingInterval: RollingInterval.Minute)
                .CreateLogger();


            

            Program p = new Program();
            Log.Information("Getting the Latest Block");
            var blockNum =  p.getLatestBlock();
            Log.Information("The Latest Block Number is {0}", blockNum.ToString());
            Log.Information("Getting the Block Details using the retrieved block number.");
            var blockList = p.GetBlockByNumber(blockNum);
            foreach(var c in blockList)
            {
                Log.Information("The Block details are {0}", c);
            }

            Log.Information("Getting the Transactions count for that block number.");
            var tranCount = p.GetBlockTransactionCountByNum(blockNum);
            Log.Information("The Transaction count is {0}", tranCount);
            Log.Information("Getting the transaction List using blocknumber and uncleindex position.");
            var TransactionList = p.GetTransactionByBlockNumberAndIndex(blockNum, tranCount);
            foreach(var c in TransactionList)
            {
                Log.Information("The Transaction Lists are {0}", c);
            }

            string strconn = ConfigurationManager.ConnectionStrings["BlockChainDB"].ConnectionString;
                SqlConnection conn = new SqlConnection(strconn);
                
                String Query = "INSERT INTO BLOCKS (blockNumber, hash, parentHash, miner, blockReward, gasLimit, gasUsed) " +
                    "VALUES(@blockNumber, @hash, @parentHash, @miner, @blockReward, @gasLimit, @gasUsed)";
                SqlCommand cmd = new SqlCommand(Query, conn);
                foreach (var c in blockList)
                {
                    cmd.Parameters.AddWithValue("@blockNumber", c.blockNumber);
                    cmd.Parameters.AddWithValue("@hash", c.hash);
                    cmd.Parameters.AddWithValue("@parentHash", c.parentHash);
                    cmd.Parameters.AddWithValue("@miner", c.miner);
                    cmd.Parameters.AddWithValue("@blockReward", c.blockReward);
                    cmd.Parameters.AddWithValue("@gasLimit", c.gasLimit);
                    cmd.Parameters.AddWithValue("@gasUsed", c.gasUsed);
                        }

            string Query2 = "INSERT INTO TRANSACTIONS( hash,From_, To_, value_, gas, gasPrice, transactionIndex) " +
            "VALUES (@hash, @from, @to, @value, @gas, @gasPrice, @transactionIndex)";
            SqlCommand cmd2 = new SqlCommand(Query2, conn);
            foreach(var c in TransactionList)
            {
                cmd2.Parameters.AddWithValue("@hash", c.hash);

                foreach (var c1 in c.transactions)
                {
                    //cmd2.Parameters.AddWithValue("@transactionId", c1.TransactionId);
                   
                    cmd2.Parameters.AddWithValue("@from", c1.From);
                    cmd2.Parameters.AddWithValue("@to", c1.To);
                    cmd2.Parameters.AddWithValue("@value", c1.Value);
                    cmd2.Parameters.AddWithValue("@gas", c1.Gas);
                    cmd2.Parameters.AddWithValue("@gasPrice", c1.GasPrice);
                    cmd2.Parameters.AddWithValue("@transactionIndex", c1.TransactionIndex);

                }
            }

                
            try
            {
                Log.Information("Trying to connect to database.");
                conn.Open();
                Log.Information("Databsae Connection is Successful.");
                cmd.ExecuteNonQuery();
                Log.Information("Records are inserted Sucessfully.");
                cmd2.ExecuteNonQuery();
                Log.Information("records areinserted successfully.");
               // Console.WriteLine("Records Inserted Successfully.");
            }
               

            
            catch (SqlException e)
            {
                Log.Error(e.ToString());
                Console.WriteLine(e.ToString());

            }
            finally
            {
                Log.Information("Trying to close the sql connection.");
                conn.Close();
                Log.Information("Connection Closed");
            }
       
         }

        
    }
}
