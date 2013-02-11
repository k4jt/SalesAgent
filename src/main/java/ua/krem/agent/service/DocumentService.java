package ua.krem.agent.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import ua.krem.agent.dao.DocumentDAO;
import ua.krem.agent.model.DocHead;
import ua.krem.agent.model.DocHeadFilter;
import ua.krem.agent.model.Document;
import ua.krem.agent.model.DocList;

@Service
public class DocumentService {

	private DocumentDAO documentDAO;
	
	@Inject
	public DocumentService(DocumentDAO documentDAO){
		this.documentDAO = documentDAO;
	}

	public List<DocHead> selectDoc(DocHeadFilter filter, String docDate){
		return documentDAO.selectDoc(filter,0,docDate);
	}
	
	public String exportDocuments(DocList docs, String uid, String path)
	{
		return documentDAO.exportDocuments(docs, uid, path);
	}
	public Document getDocumentById(Integer docId){
		return documentDAO.getDocumentById(docId);
	}

	public List<DocHead> selectExpDoc(DocHeadFilter filter, String docGlobalDate) {
		return documentDAO.selectDoc(filter,1,docGlobalDate);
	}
	
}
