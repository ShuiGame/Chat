module chatcore::chatroom {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use std::vector;

    public struct ChatRoom has key {
        id: UID,
        name: vector<u8>,
        messages: vector<Message>,
    }

    public struct Message has copy, drop, store {
        sender: address,
        content: vector<u8>,
        timestamp: u64,
        message_type: u8, // 0 for text, 1 for image, 2 for emoji
    }

    public fun create_chatroom(ctx: &mut TxContext, name: vector<u8>): ChatRoom {
        let id = object::new(ctx);
        ChatRoom {
            id,
            name,
            messages: vector::empty(),
        }
    }

    public fun send_message(chatroom: &mut ChatRoom, sender: address, content: vector<u8>, message_type: u8, timestamp: u64) {
        let message = Message { sender, content, timestamp, message_type };
        vector::push_back(&mut chatroom.messages, message);
    }

    public fun get_messages(chatroom: &ChatRoom): &vector<Message> {
        &chatroom.messages
    }
}