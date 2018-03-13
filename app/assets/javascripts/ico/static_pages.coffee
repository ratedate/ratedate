# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require jquery3
#= require rails-ujs
#= require turbolinks
# require timer
#= require popper
#= require bootstrap
#= require web3
#= require ico/headerBehaviour
#= require velocity.min


set_nav_background = ->
  navbar = $('.navbar')
  scrollPos = $(window).scrollTop()
  if scrollPos>60
    navbar.addClass('navbar-light bg-light')
    navbar.removeClass('navbar-dark bg-fade')
    return
  else
    navbar.removeClass('navbar-light bg-light')
    navbar.addClass('navbar-dark bg-fade')
    return
updateICOProgress = ->
  web3RD = new Web3(new Web3.providers.HttpProvider("https://mainnet.infura.io/wiIsPNBDp9B2SNcyGCgH"))
  abi = [
    {
      "constant": true,
      "inputs": [],
      "name": "rate",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "endTime",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "cap",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "weiRaised",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "wallet",
      "outputs": [
        {
          "name": "",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "startTime",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "owner",
      "outputs": [
        {
          "name": "",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "minAmount",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "contractICO",
          "type": "address"
        }
      ],
      "name": "startICO",
      "outputs": [
        {
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "beneficiary",
          "type": "address"
        }
      ],
      "name": "buyTokens",
      "outputs": [],
      "payable": true,
      "stateMutability": "payable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "hasEnded",
      "outputs": [
        {
          "name": "",
          "type": "bool"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "transferOwnership",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "token",
      "outputs": [
        {
          "name": "",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "name": "_startTime",
          "type": "uint256"
        },
        {
          "name": "_endTime",
          "type": "uint256"
        },
        {
          "name": "_rate",
          "type": "uint256"
        },
        {
          "name": "_cap",
          "type": "uint256"
        },
        {
          "name": "_wallet",
          "type": "address"
        }
      ],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "payable": true,
      "stateMutability": "payable",
      "type": "fallback"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "name": "previousOwner",
          "type": "address"
        },
        {
          "indexed": true,
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "OwnershipTransferred",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "name": "purchaser",
          "type": "address"
        },
        {
          "indexed": true,
          "name": "beneficiary",
          "type": "address"
        },
        {
          "indexed": false,
          "name": "value",
          "type": "uint256"
        },
        {
          "indexed": false,
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "TokenPurchase",
      "type": "event"
    }
  ]
  PreSale = new web3RD.eth.Contract(abi, "0xa52f2e64A0bB1E52524b2c1daCA6Aac1c0eC5DC3")
  PreSale.methods.weiRaised().call (error, result) ->
    if(!error)
      ethRaised = Number(web3RD.utils.fromWei(result, 'ether'))
      percentRaised = ethRaised*100/250
      $('#eth').text(ethRaised.toFixed(4))
      $('#progress').css('width',percentRaised+'%')
  return

ready = ->
  $('header').headerBehaviour()
  $('.btn-link.trigger').on 'click', () ->
    $(this).toggleClass('active')
  $('.anchor').on 'click', (event) ->
    anchorTo = $(this).data('anchorTo')
    $container = $('#' + anchorTo)
    $container.velocity('scroll', { duration: 600, easing: 'linear' })
    event.preventDefault()
    return
  $('.scrollspy').scrollspy({
    nav: '.menu.nav-links > li > a',
    className: 'active'
  })
  return
$(document).on('turbolinks:load', ready)