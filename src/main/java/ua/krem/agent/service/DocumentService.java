package ua.krem.agent.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ua.krem.agent.dao.DocumentDAO;
import ua.krem.agent.model.DocHead;
import ua.krem.agent.model.DocHeadFilter;
import ua.krem.agent.model.Document;

@Service
public class DocumentService {

	private DocumentDAO documentDAO;
	
	@Inject
	public DocumentService(DocumentDAO documentDAO){
		this.documentDAO = documentDAO;
	}

	public List<DocHead> selectDoc(DocHeadFilter filter){
		return documentDAO.selectDoc(filter);
	}
	
	public Document getDocumentById(Integer docId){
		return documentDAO.getDocumentById(docId);
	}
	
}
