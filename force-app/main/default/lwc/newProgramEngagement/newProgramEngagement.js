import { LightningElement, wire, api, track } from "lwc";
import { CurrentPageReference } from "lightning/navigation";
import getFieldSet from "@salesforce/apex/FieldSetController.getFieldSetForLWC";
import PROGRAMENGAGEMENT_OBJECT from "@salesforce/schema/ProgramEngagement__c";
import CONTACT_FIELD from "@salesforce/schema/ProgramEngagement__c.Contact__c";

import { handleError, showToast } from "c/util";
import newProgramEngagement from "@salesforce/label/c.New_Program_Engagement";
import cancel from "@salesforce/label/c.Cancel";
import success from "@salesforce/label/c.Success";
import saveMessage from "@salesforce/label/c.SaveMessage";
import save from "@salesforce/label/c.Save";

export default class NewProgramEngagement extends LightningElement {
    fields = {
        contact: CONTACT_FIELD,
    };
    @api recordId;
    @api contactId;
    @api fieldSet;
    @track localFieldSet = [];

    @wire(CurrentPageReference) pageRef;

    @wire(getFieldSet, {
        objectName: "ProgramEngagement__c",
        fieldSetName: "CreateProgramEngagement",
    })
    wiredFields({ error, data }) {
        if (data) {
            this.fieldSet = data;
        } else if (error) {
            handleError(error);
        }
    }

    labels = { newProgramEngagement, cancel, success, saveMessage, save };
    objectApiName = PROGRAMENGAGEMENT_OBJECT;

    @api
    showModal() {
        this.template.querySelector("c-modal").show();
        this.getContactId();
    }

    @api
    hideModal() {
        this.template.querySelector("c-modal").hide();
        this.clearAllValues();
    }

    handleClose() {
        this.hideModal();
    }

    handleSave() {
        this.template.querySelector("lightning-record-edit-form").submit();
        showToast(this.labels.success, this.labels.saveMessage, "success", "dismissible");
        this.hideModal();
    }

    handleSuccess(event) {
        this.dispatchEvent(new CustomEvent("save", { detail: event.detail.id }));
    }

    clearAllValues() {
        this.template.querySelectorAll("lightning-input-field").forEach(element => {
            element.value = "";
        });
    }

    getContactId() {
        this.localFieldSet = [];
        this.fieldSet.forEach(element => {
            element = Object.assign({}, element);
            if (element.apiName === this.fields.contact.fieldApiName) {
                element.value = this.contactId;
            }
            this.localFieldSet.push(element);
        });
    }
}
