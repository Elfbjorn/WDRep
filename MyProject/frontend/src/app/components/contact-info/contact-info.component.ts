
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
