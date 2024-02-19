package kr.or.ddit.entity;

public class BusinessLogicException extends Exception {
	public BusinessLogicException(ExceptionCode code) {
		printStackTrace();
		if (code.equals(ExceptionCode.PAY_CANCEL)) {
			System.out.println("PAY_CANCEL....");
		} else if (code.equals(ExceptionCode.PAY_FAILED)) {
			System.out.println("PAY_FAILED....");
		}
	}
}
