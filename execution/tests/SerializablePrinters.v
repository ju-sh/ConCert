From ConCert.Execution Require Import Blockchain.
From ConCert.Execution Require Import Serializable.
From QuickChick Require Import QuickChick.
From ConCert.Execution.QCTests Require Import ChainPrinters CongressPrinters EIP20TokenPrinters FA2Printers DexterPrinters EscrowPrinters iTokenBuggyPrinters.
Local Open Scope string_scope.

Existing Instance EIP20TokenPrinters.showMsg.
Existing Instance CongressPrinters.showMsg.
Existing Instance showFA2TokenMsg.
Existing Instance showDexterMsg.
Existing Instance showDexterMsgMsg.
Existing Instance showFA2ClientContractMsg.
Existing Instance showTransferHookMsg.
Existing Instance iTokenBuggyPrinters.showMsg.
(* Existing Instance showEscrowMsg. *)
(* Currently we hack it to always deserialize to some known Msg types *)

Global Instance showSerializedValue : Show SerializedValue :=
{|
  show v := match @deserialize FA2Token.Msg _ v with
    | Some v => show v
    | None =>
    match @deserialize Dexter.Msg _ v with
    | Some v => show v
    | None =>
    match @deserialize TestContracts.ClientMsg _ v with
    | Some v => show v
    | None =>
    match @deserialize TestContracts.TransferHookMsg _ v with
    | Some v => show v
    | None =>
    match @deserialize EIP20Token.Msg _ v with
    | Some v => show v
    | None =>
    match @deserialize Escrow.Msg _ v with
    | Some v => show v
    | None =>
    match @deserialize iTokenBuggy.Msg _ v with
    | Some v => show v
    | None =>
    match @deserialize Congress.Msg _ v with
    | Some v => show v
    | None => "<FAILED DESERIALIZATION>"
    end
    end
    end
    end
    end
    end
    end
    end
|}.
Close Scope string_scope.

Instance showChainTraceSigT : Show {to : ChainState & ChainTrace empty_state to} :=
{|
  show a := show (projT2 a)
|}.
