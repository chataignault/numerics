Require Import Coq.Arith.PeanoNat.
Require Import Lia.

Inductive deck : nat -> Set :=
  | nild : deck 0
  | consd : forall n : nat, bool -> deck n -> deck (S n).

Fixpoint flip {n : nat} (d : deck n) : deck n :=
  match d with
    | nild => nild
    | consd i b d' => consd i (negb b) (flip d')
  end.

Fixpoint count_ups {n : nat} (d : deck n) : nat :=
  match d with 
    | nild => 0
    | consd _ true d' => S (count_ups d')
    | consd _ false d' => (count_ups d')
  end. 

Lemma flip_preserves_length : forall n (d: deck n),
  flip d = flip d :> deck n.
Proof.
  intros n d.
  reflexivity.
Qed.

Lemma flip_involutive : forall n (d: deck n),
  flip (flip d) = d.
Proof.
  intros n d.
  induction d as [| n' b d' IHd].
  - (* nild case *)
    simpl. reflexivity.
  - (* consd case *)
    simpl. rewrite IHd.
    destruct b; reflexivity.
Qed.

Fixpoint split {n : nat} (d : deck n) (m : nat) (H : m <= n) :
  deck m * deck (n - m) :=
  match d in deck n' return forall m', m' <= n' -> deck m' * deck (n' - m') with
  | nild => fun m' H' => 
      match m' as m'' return m'' <= 0 -> deck m'' * deck (0 - m'') with
      | 0 => fun _ => (nild, nild)
      | S m'' => fun H'' => match Nat.nle_succ_0 m'' H'' with end
      end H'
  | consd n' b d' => fun m' H' =>
      match m' as m'' return m'' <= S n' -> deck m'' * deck (S n' - m'') with
      | 0 => fun _ => 
          (nild, consd n' b d')
      | S m'' => fun H'' =>
          let H''' : m'' <= n' := le_S_n m'' n' H'' in
          let (d1, d2) := split d' m'' H''' in
          (consd m'' b d1, d2)
      end H'
  end m H.

Lemma count_ups_flip : forall n (d : deck n),
  count_ups (flip d) + count_ups d = n.
Proof.
  intros n d. induction d as [| n' b d' IHd]; simpl.
  - reflexivity.
  - destruct b; simpl; lia.
Qed.

Lemma split_preserves_count : forall n m (H : m <= n) (d : deck n),
  let (d1, d2) := split d m H in
  count_ups d = count_ups d1 + count_ups d2.
Proof.
  intros n m H d.
  generalize dependent m.
  induction d as [| n' b d' IHd].
  - (* nild case *)
    intros m H.
    destruct m.
    + simpl. reflexivity.
    + exfalso. apply (Nat.nle_succ_0 m H).
  - (* consd case *)
    intros m H.
    destruct m.
    + simpl. reflexivity.
    + simpl.
      destruct (split d' m (le_S_n m n' H)) as [d1 d2] eqn:Hsplit.
      specialize (IHd m (le_S_n m n' H)).
      rewrite Hsplit in IHd.
      destruct b; simpl; lia.
Qed.

Lemma split_sizes : forall n m (H : m <= n) (d : deck n),
  let (d1, d2) := split d m H in
  True.
Proof.
  intros n m H d.
  destruct (split d m H) as [d1 d2].
  trivial.
Qed.

Theorem equal_ups :
  forall (n : nat) (m : nat) (H: m <= n) (d: deck n),
  count_ups d = m ->
  let (d1, d2) := split d m H in
  count_ups (flip d1) = count_ups d2.
Proof.
  intros n m H d Hcount.

  (* First, get the fact about split preserving counts before destructing *)
  assert (Hpreserve: let (d1, d2) := split d m H in count_ups d = count_ups d1 + count_ups d2).
  { apply split_preserves_count. }

  (* Now destruct the split *)
  destruct (split d m H) as [d1 d2] eqn:Hsplit.
  simpl in Hpreserve.

  (* We have: count_ups d = count_ups d1 + count_ups d2 *)
  (* And: count_ups d = m *)
  (* So: m = count_ups d1 + count_ups d2 *)
  rewrite Hcount in Hpreserve.

  (* Use count_ups_flip: count_ups (flip d1) + count_ups d1 = m *)
  (* where m is the length of d1, which has type deck m *)
  pose proof (count_ups_flip m d1) as Hflip.

  (* Now we have:
     Hpreserve: m = count_ups d1 + count_ups d2
     Hflip: count_ups (flip d1) + count_ups d1 = m
     Goal: count_ups (flip d1) = count_ups d2
  *)

  (* From Hflip: count_ups (flip d1) = m - count_ups d1 *)
  (* From Hpreserve: count_ups d2 = m - count_ups d1 *)
  (* Therefore: count_ups (flip d1) = count_ups d2 *)
  lia.
Qed.
