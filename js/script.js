// ENDEREÇO EHTEREUM DO CONTRATO
var contractAddress = "0x5F408b84B13F470C689311d130396E1dd6Db16B4";

// Inicializa o objeto DappDoodle
document.addEventListener("DOMContentLoaded", onDocumentLoad);
function onDocumentLoad() {
  DappDoodle.init();
}

// Nosso objeto DappDoodle que irá armazenar a instância web3
const DappDoodle = {
  web3: null,
  contracts: {},
  account: null,

  init: function () {
    return DappDoodle.initWeb3();
  },

  // Inicializa o provedor web3
  initWeb3: async function () {
    if (typeof window.ethereum !== "undefined") {
      try {
        const accounts = await window.ethereum.request({ // Requisita primeiro acesso ao Metamask
          method: "eth_requestAccounts",
        });
        DappDoodle.account = accounts[0];
        window.ethereum.on('accountsChanged', DappDoodle.updateAccount); // Atualiza se o usuário trcar de conta no Metamaslk
      } catch (error) {
        console.error("Usuário negou acesso ao web3!");
        return;
      }
      DappDoodle.web3 = new Web3(window.ethereum);
    } else {
      console.error("Instalar MetaMask!");
      return;
    }
    return DappDoodle.initContract();
  },

  // Atualiza 'DappDoodle.account' para a conta ativa no Metamask
  updateAccount: async function() {
    DappDoodle.account = (await DappDoodle.web3.eth.getAccounts())[0];
    atualizaInterface();
  },

  // Associa ao endereço do seu contrato
  initContract: async function () {
    DappDoodle.contracts.Schedule = new DappDoodle.web3.eth.Contract(abi, contractAddress);
    return DappDoodle.render();
  },

  // Inicializa a interface HTML com os dados obtidos
  render: async function () {
    inicializaInterface();
  },
};



// *** MÉTODOS (de consulta - view) DO CONTRATO ** //



function verDia() { //function getScheduleDay(uint timestamp) public view returns (uint8)
  return DappDoodle.contracts.Schedule.methods.verDia().call();
}

function verMes() { //function getScheduleMonth(uint timestamp) public view returns (uint8)
  return DappDoodle.contracts.Schedule.methods.verMes().call();
}

function verHora() { //function getScheduleHour(uint timestamp) public view returns (uint8)
  return DappDoodle.contracts.Schedule.methods.verHora().call();
}

function verMinuto() { //function getScheduleMinute(uint timestamp) public view returns (uint8)
  return DappDoodle.contracts.Schedule.methods.verMinuto().call();
}

function verDiaDaSemana() { //function getWeekDay(uint timestamp) public view returns (uint8)
  return DappDoodle.contracts.Schedule.methods.verDiaDaSemana().call();
}

function ehDono() {
  return DappDoodle.contracts.Schedule.methods.isOwner().call({ from: DappDoodle.account });
}
