package object;

import java.util.Objects;

public class Ex_0405_object {

	public static void main(String[] args) {
		/* 교재 11장
		 * 
		 * Object 클래스
		 * 
		 * > java.lang 패키지에 위치하는 클래스 (import문 없이 사용 가능한 클래스.)
		 * 
		 * > 모든 클래스의 슈퍼클래스! > 최상위 클래스
		 * 	>> 상속을 표현하지 않는 경우, 자동으로 상속되는 클래스이다.
		 * 
		 * > Object 클래스의 모든 멤버는 다른 클래스에서 사용 또는 오버라이딩이 가능하다 !!
		 * 
		 * 1. equals() 메서드( public boolean equals(Object o){} )
		 * 	> "=="의 경우! 두 객체가 같은지, 동등비교(==) 수행
		 * 		>> 두 객체의 "주소값"을 비교하여, 같으면 true, 다르면 false 리턴
		 * 
		 * 	> 실제 '두 객체가 같다'는 의미는 두 객체의 주소값 비교가 아닌, 객체가 가지는 "멤버변수가 같다"는 의미로 사용된다.
		 * 		>> 따라서, 사용자가 정의하는 클래스에 Object 클래스로부터 상속받은 equals() 메서드를 오버라이딩 하여
		 * 		   각 객체의 멤버변수 끼리 비교하도록 수정해서 사용한다!
		 * 
		 * 	> 자바에서 제공하는 대부분의 클래서(API)들은 Object 클래스의 equals() 메서드를 오버라이딩 해 놓았다 !!
		 * 		>> 객체 내용 비교가 가능하다 !! ex) String 클래스, ArrayList 클래스 등
		 * 
		 *	 > equals() 메서드 자동생성(오버라이딩) 기능을 활용하여 쉽게 구현 가능하다.
		 * 		>> alt+shift+s > h
		 * 
		 */
		
		Person p1 = new Person("홍길동", "901010-1234567");
		Person p2 = new Person("홍길동", "901010-1234567");
		
		System.out.println("p1의 객체 정보: "+ p1);
		System.out.println("p2의 객체 정보: "+ p2);
		
		System.out.println("------------------------------------------------");
		
		if(p1 == p2) { // 주소값을 비교한다.
			System.out.println("두 객체의 주소값이 같다!! (==)");
		}else {
			System.out.println("두 객체의 주소값이 다르다! (==)");
		}
		
		// 참조변수에 대한 Object 클래스의 equals() 메서드를 통한 비교 수행!
		
		if(p1.equals(p2)) { // 값을 비교한다.
			System.out.println("두 객체의 주소값이 같다!! (equals())");
		}else {
			System.out.println("두 객체의 주소값이 다르다!! (equals())");
		}
		
		System.out.println("------------------------------------------------");
		
		//Person타입 변수 p3에 p2변수의 주소값을 복사
		Person p3 = p2;
		System.out.println("p2의 객체정보: "+p2);
		System.out.println("p3의 객체정보: "+p3);
		
		if(p2 == p3) { // 주소값을 비교한다.
			System.out.println("두 객체의 주소값이 같다!! (==)");
		}else {
			System.out.println("두 객체의 주소값이 다르다! (==)");
		}
		
		
		if(p2.equals(p3)) { // 값을 비교한다.
			System.out.println("두 객체의 주소값이 같다!! (equals())");
		}else {
			System.out.println("두 객체의 주소값이 다르다!! (equals())");
		}
	
		System.out.println("===================================================");
		
		OverridePerson p10 = new OverridePerson("홍길동", "901010-1234567");
		OverridePerson p11 = new OverridePerson("홍길동", "901010-1234567");
		
		if(p10 == p11) { // 주소값을 비교한다.
			System.out.println("두 객체의 주소값이 같다!! (==)");
		}else {
			System.out.println("두 객체의 주소값이 다르다! (==)");
		}
		
		// 오버라이딩된 equals() 메서드 호출, 객체의 멤버변수 비교 수행.
		if(p10.equals(p11)) { // 값을 비교한다.
			System.out.println("두 객체의 내용(멤버변수값)이 같다!! (equals())");
		}else {
			System.out.println("두 객체의 내용(멤버변수값)이 다르다!! (equals())");
		}
		
		
		
		

	}// main() method end

}// Ex_0405_object class end


class Person{
	String name;
	String jumin;
	
	public Person(String name, String jumin) {
		super();
		this.name = name;
		this.jumin = jumin;
	}// constructor end
	
} //Person class end


class OverridePerson{
	String name;
	String jumin;
	
	public OverridePerson(String name, String jumin) {
		super();
		this.name = name;
		this.jumin = jumin;
	}// constructor end

	@Override
	public int hashCode() {
		return Objects.hash(jumin, name);
	}
	// Object 클래스의 equals() 메서드 오버라이딩!
	// Person 클래스의 모든 멤버변수를 비교하여, 하나라도 다를경우 false, 모두 같으면 true!
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OverridePerson other = (OverridePerson) obj;
		return Objects.equals(jumin, other.jumin) && Objects.equals(name, other.name);
	}

}//OverridePerson class end










































