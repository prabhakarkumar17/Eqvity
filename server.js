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
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
const providerURL = "http://127.0.0.1:8545/";

const publicKey = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266";
const privateKey = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";

const {Web3} = require('web3')
const web3 = new Web3(providerURL); //connected server.js file to blockchain network

const contract = new web3.eth.Contract(contractAbi, contractAddress); //connected our server.js file with smart contract

function getNameFromContract(){
    const result = contract.methods.getName().call();
    console.log(result);
}
getNameFromContract();

app.get('/',(req, res) => {
    // const result = getNameFromContract();
    // console.log(getNameFromContract());
})

app.get('/setName', async(req, res) => {
	const status = await contract.methods.setName("Ruturaj Gaikwad").send({
		from: publicKey
	})

	const result = await contract.methods.getName().call();
	console.log("Name of Player is ",result)
	
	
})

app.post('/joinDao', async(req, res) => {

	const tx = {
		to: contractAddress,
		value: 0x0,
		gasLimit: 3000000,
		gasPrice: '0x09184e72a000',
		nonce: await web3.eth.getTransactionCount(publicKey),
		data: await contract.methods.joinDAO()
	}
	const signedTx = await web3.eth.signTransaction(tx, privateKey);

	web3.eth.sendSignedTransaction(signedTx.raw, function(error, hash){
		if(error){
			console.log(error)
		}else{
			console.log(hash)
		}
	})
})

app.listen(8080, (req, res) => {
    console.log("Server is up and running at http://127.0.0.1:8080")
})

