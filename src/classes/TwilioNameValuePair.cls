/**
 * This class is used to hold a key/value POST param.
 */
global class TwilioNameValuePair {

        private String name;

        private String value;

        public TwilioNameValuePair(String name, String value) {
                this.name = name;
                this.value = value;
        }

        public String getName() {
                return this.name;
        }

        public String getValue() {
                return this.value;
        }

}