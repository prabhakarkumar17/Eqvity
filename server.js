/**
 * Required -
 * 1. Provider URL - Ip address of blockchain network
 * 2. Deployed smart contract address
 * 3. ABI of smart contract
 * 
 * Possible options for blockchain while application developement
 * 1. Ethereum TestNet - Sepolia, Goerli - Global public testnet
 * 2. Infura - Ethereum provider node
 * 3. Alchemy - Ethereum Provider Node
 * 4. Ganache - Local Blockchain Network
 * 5. Hardhat
 * 6. Truffle
 * 
 * Roles of Wallet - 
 * 1. Wallet initiates transactions
 * 2. Wallet digital sign our tx
 * 3. Wallet act as a node and put our data in main chain
 * 4. We can say that wallet is a "Node as a Service"
 * 5. In return we pay some tx fee to wallet
 * 
 * But in case of backend we have to do all the activity of wallet by our own
 * 
 * send() - When we have to send transaction which will change the state of blockchain
 * call() - When we have to just view the state variable's value
 */

//using package in our code - require()
//using file in our code - import()

const express = require('express')
const app = express();

//Details of smart contract and blockchain network
//const contractAbi = import('./abi.json');

//import contractAbi from './abi.json'

const contractAbi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			}
		],
		"name": "setName",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getName",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
const contractAddress = "0x5fbdb2315678afecb367f032d93f642f64180aa3";
const providerURL = "http://127.0.0.1:8545/";

const {Web3} = require('web3')
const web3 = new Web3(providerURL); //connected server.js file to blockchain network

const contract = new web3.eth.Contract(contractAbi, contractAddress); //connected our server.js file with smart contract

async function getNameFromContract(){
    const result = await contract.methods.getName().call();
    console.log(result);
}
getNameFromContract();

/* getNameFromContract = async() => { //Arrow function
    const result = await contract.methods.getName().call();
    return result;
} */

app.get('/',(req, res) => {
    // const result = getNameFromContract();
    // console.log(getNameFromContract());
})

app.listen(8080, (req, res) => {
    console.log("Server is up and running at http://127.0.0.1:8080")
})

