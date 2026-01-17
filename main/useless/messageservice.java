package services;

import dao.MessageDAO;
import models.Message;
import java.time.LocalDateTime;
import java.util.List;

public class MessageService {
    private MessageDAO messageDAO = new MessageDAO();

    public boolean sendMessage(int senderId, int tripId, String content) {
        if (content == null || content.trim().isEmpty()) {
            return false;
        }

        if (content.length() > 1000) {
            return false;
        }

        Message message = new Message();
        message.setSender_id(senderId);
        message.setTrip_id(tripId);
        message.setContent(content);
        message.setSend_date(LocalDateTime.now());

        try {
            messageDAO.saveMessage(message);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Message> getTripChatHistory(int tripId) {
        return messageDAO.getMessagesByTrip(tripId);
    }
}
