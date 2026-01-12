package javaclasses;

import java.time.LocalDateTime;

public class Message {

    private int message_id;
    private int sender_id;
    private int trip_id;
    private String content;
    private LocalDateTime send_date;

    public Message() {
    }

    public Message(int sender_id, int trip_id, String content, LocalDateTime send_date) {
        this.sender_id = sender_id;
        this.trip_id = trip_id;
        this.content = content;
        this.send_date = send_date;
    }

    public int getMessage_id() {
        return message_id;
    }

    public void setMessage_id(int message_id) {
        this.message_id = message_id;
    }

    public int getSender_id() {
        return sender_id;
    }

    public void setSender_id(int sender_id) {
        this.sender_id = sender_id;
    }

    public int getTrip_id() {
        return trip_id;
    }

    public void setTrip_id(int trip_id) {
        this.trip_id = trip_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getSend_date() {
        return send_date;
    }

    public void setSend_date(LocalDateTime send_date) {
        this.send_date = send_date;
    }

}
