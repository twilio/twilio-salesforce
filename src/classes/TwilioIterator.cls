/*
Copyright (c) 2012 Twilio, Inc.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
global class TwilioIterator {

    /**
     * The Class ObjectIteratorSupport
     */
    global abstract class ObjectIteratorSupport {

        /** The itr. */
        private Iterator<Object> itr;
        
        private TwilioResource.TwilioListResource twlist;

        protected ObjectIteratorSupport(TwilioResource.TwilioListResource twlist) {
            this.itr = twlist.getObjectPageData().iterator();
            this.twlist = twlist;
        }

        global boolean hasNext() {
            return itr.hasNext() || twlist.hasNextPage();
        }

        protected Object getNext() {
            // If we still have results on this page
            if (itr.hasNext()) {
                return itr.next();
            }

            // Otherwise fetch the next page
            twlist.fetchNextPage();
            
            itr = twlist.getObjectPageData().iterator();
            return itr.next();
        }
    }
    
    
    global class AccountIterator extends ObjectIteratorSupport implements Iterator<TwilioAccount> {
        global AccountIterator(TwilioAccountList twlist) {
            super(twlist);
        }
        
        global TwilioAccount next() {
            return (TwilioAccount)getNext();
        }
    }
    
    global class ApplicationIterator extends ObjectIteratorSupport implements Iterator<TwilioApplication> {
        global ApplicationIterator(TwilioApplicationList twlist) {
            super(twlist);
        }
        
        global TwilioApplication next() {
            return (TwilioApplication)getNext();
        }
    }
    
    global class AuthorizedConnectAppIterator extends ObjectIteratorSupport implements Iterator<TwilioAuthorizedConnectApp> {
        global AuthorizedConnectAppIterator(TwilioAuthorizedConnectAppList twlist) {
            super(twlist);
        }
        
        global TwilioAuthorizedConnectApp next() {
            return (TwilioAuthorizedConnectApp)getNext();
        }
    }
    
    global class AvailablePhoneNumberIterator extends ObjectIteratorSupport implements Iterator<TwilioAvailablePhoneNumber> {
        global AvailablePhoneNumberIterator(TwilioAvailablePhoneNumberList twlist) {
            super(twlist);
        }
        
        global TwilioAvailablePhoneNumber next() {
            return (TwilioAvailablePhoneNumber)getNext();
        }
    }
    
    global class CallIterator extends ObjectIteratorSupport implements Iterator<TwilioCall> {
        global CallIterator(TwilioCallList twlist) {
            super(twlist);
        }
        
        global TwilioCall next() {
            return (TwilioCall)getNext(); 
        }
    }
    
    global class ConferenceIterator extends ObjectIteratorSupport implements Iterator<TwilioConference> {
        global ConferenceIterator(TwilioConferenceList twlist) {
            super(twlist);
        }
        
        global TwilioConference next() {
            return (TwilioConference)getNext(); 
        }
    }
    
    global class ConnectAppIterator extends ObjectIteratorSupport implements Iterator<TwilioConnectApp> {
        global ConnectAppIterator(TwilioConnectAppList twlist) {
            super(twlist);
        }
        
        global TwilioConnectApp next() {
            return (TwilioConnectApp)getNext(); 
        }
    }
    
    global class IncomingPhoneNumberIterator extends ObjectIteratorSupport implements Iterator<TwilioIncomingPhoneNumber> {
        global IncomingPhoneNumberIterator(TwilioIncomingPhoneNumberList twlist) {
            super(twlist);
        }
        
        global TwilioIncomingPhoneNumber next() {
            return (TwilioIncomingPhoneNumber)getNext(); 
        }
    }
    
    global class NotificationIterator extends ObjectIteratorSupport implements Iterator<TwilioNotification> {
        global NotificationIterator(TwilioNotificationList twlist) {
            super(twlist);
        }
        
        global TwilioNotification next() {
            return (TwilioNotification)getNext(); 
        }
    }
    
    global class OutgoingCallerIdIterator extends ObjectIteratorSupport implements Iterator<TwilioOutgoingCallerId> {
        global OutgoingCallerIdIterator(TwilioOutgoingCallerIdList twlist) {
            super(twlist);
        }
        
        global TwilioOutgoingCallerId next() {
            return (TwilioOutgoingCallerId)getNext(); 
        }
    }
    
    global class ParticipantIterator extends ObjectIteratorSupport implements Iterator<TwilioParticipant> {
        global ParticipantIterator(TwilioParticipantList twlist) {
            super(twlist);
        }
        
        global TwilioParticipant next() {
            return (TwilioParticipant)getNext(); 
        }
    }
    
    global class RecordingIterator extends ObjectIteratorSupport implements Iterator<TwilioRecording> {
        global RecordingIterator(TwilioRecordingList twlist) {
            super(twlist);
        }
        
        global TwilioRecording next() {
            return (TwilioRecording)getNext(); 
        }
    }
    
    global class ShortCodeIterator extends ObjectIteratorSupport implements Iterator<TwilioShortCode> {
        global ShortCodeIterator(TwilioShortCodeList twlist) {
            super(twlist);
        }
        
        global TwilioShortCode next() {
            return (TwilioShortCode)getNext(); 
        }
    }
    
    global class SmsIterator extends ObjectIteratorSupport implements Iterator<TwilioSms> {
        global SmsIterator(TwilioSmsList twlist) {
            super(twlist);
        }
        
        global TwilioSms next() {
            return (TwilioSms)getNext(); 
        }
    }
    
    global class MessageIterator extends ObjectIteratorSupport implements Iterator<TwilioMessage> {
        global MessageIterator(TwilioMessageList twlist) {
            super(twlist);
        }
        
        global TwilioMessage next() {
            return (TwilioMessage)getNext(); 
        }
    }
    
    global class MediaIterator extends ObjectIteratorSupport implements Iterator<TwilioMedia> {
        global MediaIterator(TwilioMediaList twlist) {
            super(twlist);
        }
        
        global TwilioMedia next() {
            return (TwilioMedia)getNext(); 
        }
    }
    
    global class MemberIterator extends ObjectIteratorSupport implements Iterator<TwilioMember> {
        global MemberIterator(TwilioMemberList twlist) {
            super(twlist);
        }
        
        global TwilioMember next() {
            return (TwilioMember)getNext(); 
        }
    }
    
    global class QueueIterator extends ObjectIteratorSupport implements Iterator<TwilioQueue> {
        global QueueIterator(TwilioQueueList twlist) {
            super(twlist);
        }
        
        global TwilioQueue next() {
            return (TwilioQueue)getNext(); 
        }
    }
    
    global class TranscriptionIterator extends ObjectIteratorSupport implements Iterator<TwilioTranscription> {
        global TranscriptionIterator(TwilioTranscriptionList twlist) {
            super(twlist);
        }
        
        global TwilioTranscription next() {
            return (TwilioTranscription)getNext();
        }
    }
    
    global class TRWorkspaceIterator extends ObjectIteratorSupport implements Iterator<TwilioTRWorkspace> {
        global TRWorkspaceIterator(TwilioTRWorkspaceList twlist) {
            super(twlist);
        }
        
        global TwilioTRWorkspace next() {
            return (TwilioTRWorkspace)getNext();
        }
    }

    global class TRTaskIterator extends ObjectIteratorSupport implements Iterator<TwilioTRTask> {
        global TRTaskIterator(TwilioTRTaskList twlist) {
            super(twlist);
        }
        
        global TwilioTRTask next() {
            return (TwilioTRTask)getNext();
        }
    }

     global class TRTaskQueueIterator extends ObjectIteratorSupport implements Iterator<TwilioTRTaskQueue> {
        global TRTaskQueueIterator(TwilioTRTaskQueueList twlist) {
            super(twlist);
        }
        
        global TwilioTRTaskQueue next() {
            return (TwilioTRTaskQueue)getNext();
        }
    }   
    
    global class TRWorkflowIterator extends ObjectIteratorSupport implements Iterator<TwilioTRWorkflow> {
        global TRWorkflowIterator(TwilioTRWorkflowList twlist) {
            super(twlist);
        }
        
        global TwilioTRWorkflow next() {
            return (TwilioTRWorkflow)getNext();
        }
    }   

    global class TRWorkerIterator extends ObjectIteratorSupport implements Iterator<TwilioTRWorker> {
        global TRWorkerIterator(TwilioTRWorkerList twlist) {
            super(twlist);
        }
        
        global TwilioTRWorker next() {
            return (TwilioTRWorker)getNext();
        }
    } 

    global class TRActivitiesIterator extends ObjectIteratorSupport implements Iterator<TwilioTRActivities> {
        global TRActivitiesIterator(TwilioTRActivitiesList twlist) {
            super(twlist);
        }
        
        global TwilioTRActivities next() {
            return (TwilioTRActivities)getNext();
        }
    } 

     global class TRReservationIterator extends ObjectIteratorSupport implements Iterator<TwilioTRReservation> {
        global TRReservationIterator(TwilioTRReservationList twlist) {
            super(twlist);
        }
        
        global TwilioTRReservation next() {
            return (TwilioTRReservation)getNext();
        }
    }     
         
    global class TwilioUnsupportedOperationException extends Exception {}
}