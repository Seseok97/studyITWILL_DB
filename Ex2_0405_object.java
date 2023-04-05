package object;

public class Ex2_0405_object {

	public static void main(String[] args) {
		/*
		 * String 객체(문자열) 생성 방법 두가지
		 * 1. 리터럴 할당을 통해 생성하는 방법.	(Constant Pool 메모리 사용)	> String str = "Hello";
		 * 		> 상수풀(Constant Pool) > 문자열에 리터럴을 할당하여 생성하면 리터럴이 상수풀에 담기고, 변수는 해당 리터럴로 향하는 주소값을 할당받는다.
		 * 								> 새로운 변수가 동일한 리터럴을 참조하는 경우, 별도의 주소를 부여하지 않고 같은 주소를 부여한다. > (요 주소값으로 동등비교하는거~)
		 * 		> 상수풀에서 동일한 문자열이 존재하는지 검사 후, 존재하지 않으면 새로 생성하고, 존재하면 해당 주소값을 리턴한다.
		 * 
		 * 2. 일반적인 클래스 인스턴스를 생성하는 방법. (Heap 메모리 사용, 메성비 떨어짐) > String str = new String();
		 * 		> new 연산자에 의해 Heap 공간에 문자열 객체(인스턴스)를 생성하며, 동일한 문자열을 가진 객체가 존재하더라도 무조건 새로 생성한다.
		 * 		
		 */
		
		String s1 = "Hello";
		String s2 = "Hello";
		// 생성된 s1과 s2는 문자열 내용도 같고, 주소값도 같다 !
		
		// 동등비교연산자를 사용한 두 문자열의 주소값 비교!
		if(s1 == s2) {
			System.out.println("s1과 s2는 주소값이 같다!(==)");
		}else {
			System.out.println("s1과 s2는 주소값이 다르다!(==)");
		}// ie end
		
		if(s1.equals(s2)) {
			System.out.println("s1과 s2는 문자열 내용이 같다!");
		}else{
			System.out.println("s1과 s2는 문자열 내용이 다르다!");
		}// ie end
		
		System.out.println("----------------------------------------------------");
		
		String s3 = new String("Hello");
		String s4 = new String("Hello");
		// 생성된 s3과 s4는 값은 같으나 주소값이 다르다!
		
		// 동등비교연산자를 사용한 두 문자열의 주소값 비교.
		if(s3 == s4) {
			System.out.println("s3과 s4는 주소값이 같다!(==)");
		}else {
			System.out.println("s3과 s4는 주소값이 다르다!(==)");
		}// ie end
		
		//String 클래스의 오버라이딩된 equals() 메서드를 사용한 두 문자열의 내용 비교.
		if(s3.equals(s4)) {
			System.out.println("s3과 s4는 문자열 내용이 같다!");
		}else{
			System.out.println("s3과 s4는 문자열 내용이 다르다!");
		}// ie end

	}// main() method end

}// public class end





































