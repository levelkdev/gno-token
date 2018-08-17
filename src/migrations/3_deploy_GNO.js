const INITIAL_TOKEN_AMOUNT = 10e6 // 10M

function migrate ({
  artifacts,
  deployer,
  network,
  accounts,
  initialTokenAmount = INITIAL_TOKEN_AMOUNT
}) {
  const TokenGNO = artifacts.require('TokenGNO')
  const { SafeMath } = _getDependencies(artifacts, network, deployer)

  return deployer
    .then(() => SafeMath.deployed())
    .then(() => deployer.link(SafeMath, TokenGNO))
    .then(() => {
      const owner = accounts[0]
      console.log('Deploying GNO with owner: %s', owner)
      return deployer.deploy(TokenGNO, initialTokenAmount * 1e18)
    })
}

function _getDependencies (artifacts, network, deployer) {
  let SafeMath
  if (network === 'development') {
    SafeMath = artifacts.require('SafeMath')
  } else {
    const contract = require('truffle-contract')
    SafeMath = contract(require('openzeppelin-solidity/contracts/math/SafeMath.sol'))
    SafeMath.setProvider(deployer.provider)
  }

  return {
    SafeMath
  }
}

module.exports = migrate
