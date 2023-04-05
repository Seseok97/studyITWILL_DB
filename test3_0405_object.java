package object;

import java.util.Objects;

public class test3_0405_object {

	public static void main(String[] args) {
		Account acc = new Account("11-1111-111","홍길동",20000);
		System.out.println("acc의 계좌 정보: "+ acc.toString());
		Account acc2 = new Account("11-1111-111","홍길동",20000);
		System.out.println("acc2의 계좌 정보: "+ acc2.toString());
		
		if(acc.equals(acc2)) {
			System.out.println("두 계좌는 동일한 계좌입니다.");
		}else {
			System.out.println("두 계좌는 다른 계좌입니다 !");
		}
		

	} // main() method end

}// public class end

/*
 * Account 클래스 정의
 * > 계좌번호 accountNo, String
 * > 예금주명 ownerName, String
 * > 현재잔고 balance,	 int
 * 생성자 - 계좌번호, 예금주명, 현재잔고를 전달받아 초기화.
 * equals() 메서드 오버라이딩, 계좌번호 비교
 * toString() 메서드 오버라이딩, 계좌정보를 문자열로 리턴
 */

class Account {
	String accountNo;
	String ownerName;
	int balance;
	
	// constructor ass > o
	public Account(String accountNo, String ownerName, int balance) {
		super();
		this.accountNo = accountNo;
		this.ownerName = ownerName;
		this.balance = balance;
	}
	// constructor end
	
	// equals() method override ass > h
	@Override
	public int hashCode() {
		return Objects.hash(accountNo, balance, ownerName);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Account other = (Account) obj;
		return Objects.equals(accountNo, other.accountNo) && balance == other.balance
				&& Objects.equals(ownerName, other.ownerName);
	}
	
	// toString() method override ass > s
	@Override
	public String toString() {
		return "Account [accountNo=" + accountNo + ", ownerName=" + ownerName + ", balance=" + balance + "]";
	}
	
} // Account class end
