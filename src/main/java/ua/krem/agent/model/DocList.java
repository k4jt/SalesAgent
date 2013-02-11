package ua.krem.agent.model;

import java.io.Serializable;

@SuppressWarnings("serial")
public class DocList implements Serializable{
	
	int[] docId;
	
	int[] checked;
	
	public int[] getDocId() {
		return docId;
	}

	public void setDocId(int[] docId) {
		this.docId = docId;
	}

	public int[] getChecked() {
		return checked;
	}

	public void setChecked(int[] checked) {
		this.checked = checked;
	}

}
