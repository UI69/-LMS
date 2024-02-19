package kr.or.ddit.entity;

public enum MemRole {
	MEM_ROLE_STUDENT	("ROL001"),
	MEM_ROLE_PROFESSOR	("ROL002"),
	MEM_ROLE_EMPLOYER	("ROL003");

	private String codeValue;

	MemRole(String codeValue) {
		this.codeValue = codeValue;
	}
	
	public String getValue() {
		return this.codeValue;
	}
	
	public static MemRole getCode(String code) {
		for(MemRole role : MemRole.values()) {
            if(role.equals(code)) {
                return role;
            }
        }
		
		//연결된 코드가 없을때
        throw new RuntimeException();
	}
	
}
