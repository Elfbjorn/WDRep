import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ContactType } from '../../models/contact-type.model';

@Component({
  selector: 'app-contact-info',
  templateUrl: './contact-info.component.html'
})
export class ContactInfoComponent implements OnInit {
  contactTypes: ContactType[] = [];

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.http.get<ContactType[]>('/api/lookup/contacttypes?appliesTo=email')
      .subscribe(data => this.contactTypes = data);
  }
}