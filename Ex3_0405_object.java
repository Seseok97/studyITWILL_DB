package object;

public class Ex3_0405_object {

	public static void main(String[] args) {
			/*
			 * toString() 메서드 (public String toString() {})
			 * 
			 * > 어떤 객체의 정보를 문자열로 변환하여 리턴
			 * 
			 * > 기본적으로 Object 클래스의 toString() 메서드는 객체의 정보 (= 주소값)을 
			 *   문자열로 리턴하도록 정의되어 있다.
			 * 
			 * > 일반적으로 객체의 정보는 객체 내의 멤버변수에 저장된 데이터(속성값)를 의미한다 !
			 * 		>> Object 클래스의 toString() 메서드를 오버라이딩 하여, 객체가 가진 멤버변수 값을
			 * 		   문자열로 결합하여 리턴하도록 해야 한다.
			 * 
			 * > 출력문 내에서는 toString() 메서드 생략이 가능하다. (참조변수명만 사용 가능!)
			 * 
			 * > equals() 메서드와 동일하게, 자바에서 제공하는 대부분의 클래스(API)들은 toString() 메서드가
			 * 	 오버라이딩 되어있다 ! 객체에 저장된 값을 문자열로 리턴받을 수 있다.
			 * 		>> ex) String 클래스, ArrayList 클래스 등
			 * 
			 * > equals() 메서드와 마찬가지로, 단축키를 통하여 생성이 가능하다.
			 * 		>> alt + shift + s > s
			 */
		
			String str = new String("자바"); // String타입 = 객체
			System.out.println(str); 		 // >> "자바" 라고 출력됨.
			System.out.println(str.toString());// 동일결과!
			
			System.out.println("---------------------------------------------------------------");
			
			Person2 p = new Person2("홍길동",20,"041010-3123456");
			System.out.println("Person2의 정보: "+ p.toString());
			System.out.println("Person2의 정보: "+ p); // 두 출력문 모두 메모리주소가 출력된다 !!
			
			// >> println() 메서드 내에 p객체정보 출력시 toString() 메서드 생략가능.
			
			System.out.println("---------------------------------------------------------------");
			
			// 출력문이 아닌 결과값을 변수에 저장하는 경우, toString() 메서드는 필수다 !!
			
//			String personInfo = p;
			//Err! Type mismatch: cannot convert from Person2 to String
			String personInfo = p.toString();
			
			//Object 클래스의 toString() 메서드는 "클래스명@주소값" 형태의 문자열을 리턴한다.
			// > 주소값은 16진수로 변환되어 문자열로 결합된다.
			System.out.println("Person2 p 의 클래스명: "+p.getClass().getName());
			System.out.println("Person2 p 의 주소값: "+ p.hashCode());
			
			System.out.println("---------------------------------------------------------------");
			
			Person3 p3 = new Person3("홍길동", 20, "041010-3123456");
			System.out.println("p3 객체의 정보: "+p3.toString());
			
		
		
	}// main() method end

}// public class end

class Person2{
	String name;
	int age;
	String jumin;
	
	public Person2(String name, int age, String jumin) {
		super();
		this.name = name;
		this.age = age;
		this.jumin = jumin;
	}
	// constructor end
	
} // Person2 class end

class Person3{
	String name;
	int age;
	String jumin;
	
	public Person3(String name, int age, String jumin) {
		super();
		this.name = name;
		this.age = age;
		this.jumin = jumin;
	}
	// constructor end


	
	// 일단 직접작성
	@Override
	public String toString() {
		// 현재 인스턴스가 가진 멤버변수들을 모두 문자열로 결합하여 리턴!
		// > 결합하는 형태는 개발자가 알아서 결정 (출력형태 결정)
		return "이름: "+name+", 나이: "+age+", 주민번호: "+jumin;
	}
	// toString() end
	
	
	//toString() 자동생성 : alt + shift + s > s
//	@Override
//	public String toString() {
//		return "Person3 [name=" + name + ", age=" + age + ", jumin=" + jumin + "]";
//	}

} // Person2 class end












































