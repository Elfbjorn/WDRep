import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatCardModule } from '@angular/material/card';
import { MatTabsModule } from '@angular/material/tabs';
import { ReactiveFormsModule } from '@angular/forms';
import { FormBuilder, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-create-identity',
  templateUrl: './create-identity.component.html',
  styleUrls: ['./create-identity.component.scss'],
  standalone: true,
  imports: [
    CommonModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatOptionModule,
    MatCheckboxModule,
    MatCardModule,
    MatTabsModule,
    ReactiveFormsModule
  ]
})
export class CreateIdentityComponent implements OnInit {
  form: any;
  prefixOptions: any[] = [];
  suffixOptions: any[] = [];
  sexOptions: string[] = ['Female', 'Male', 'Unspecified'];
  countryOptions: any[] = [];
  stateOptions: any[] = [];
  contactTypeOptions: any[] = [];
  emailTypeOptions: any[] = [];
  phoneTypeOptions: any[] = [];
  postalTypeOptions: any[] = [];
  postalCountryOptions: any[] = [];
  postalStateOptions: any[] = [];
  activeTab = 0;
  middleNameDisabled = false;

  constructor(
    private fb: FormBuilder,
    private http: HttpClient,
    private router: Router
  ) {
    this.form = this.fb.group({
      prefix: [''],
      firstname: ['', Validators.required],
      middlename: [''],
      noMiddleName: [false],
      lastname: ['', Validators.required],
      suffix: [''],
      previouslastname: [''],
      preferredname: [''],
      dob: ['', Validators.required],
      ssn: ['', Validators.required],
      sex: ['', Validators.required],
      country: ['', Validators.required],
      state: [''],
      city: [''],
      contacts: this.fb.group({
        email: this.fb.group({
          value: ['', [Validators.required, Validators.email]],
          type: ['', Validators.required]
        }),
        phone: this.fb.group({
          value: ['', Validators.required],
          type: ['', Validators.required]
        }),
        postal: this.fb.group({
          type: ['', Validators.required],
          line1: ['', Validators.required],
          line2: [''],
          city: ['', Validators.required],
          state: ['', Validators.required],
          zip: ['', Validators.required],
          country: ['', Validators.required]
        })
      })
    });
  }

  ngOnInit(): void {
    this.http.get('/api/lookup/prefixsuffix?type=Prefix').subscribe((data: any) => this.prefixOptions = data);
    this.http.get('/api/lookup/prefixsuffix?type=Suffix').subscribe((data: any) => this.suffixOptions = data);
    this.http.get('/api/lookup/countries').subscribe((data: any) => {
      this.countryOptions = (data as any[]).map(c => ({
        id: c.id,
        name: c.name // previously c.description
      }));
    });
    this.http.get('/api/contacttypes').subscribe((data: any) => {
      this.contactTypeOptions = data;
      this.emailTypeOptions = this.contactTypeOptions.filter((ct: any) => ct.appliesToEmail === true || ct.appliesToEmail === 't');
      this.phoneTypeOptions = this.contactTypeOptions.filter((ct: any) => ct.appliesToPhone === true || ct.appliesToPhone === 't');
      this.postalTypeOptions = this.contactTypeOptions.filter((ct: any) => ct.appliesToPostalAddress === true || ct.appliesToPostalAddress === 't');
    });
    // For postal address country dropdown
    this.http.get('/api/lookup/countries').subscribe((data: any) => {
      this.postalCountryOptions = (data as any[]).map(c => ({
        id: c.id,
        name: c.name // previously c.description
      }));
    });
    // Pre-populate SSN from navigation state
    const nav = this.router.getCurrentNavigation();
    if (nav?.extras?.state && 'ssn' in nav.extras.state) {
      this.form.patchValue({ ssn: nav.extras.state['ssn'] });
    }
  }

  onPostalCountryChange(countryId: string): void {
    const country = this.postalCountryOptions.find((c: any) => c.id === countryId);
    if (country) {
      this.http.get(`/api/lookup/states?countryId=${country.id}`).subscribe((data: any) => {
        this.postalStateOptions = (data as any[]).map((s: any) => ({
          id: s.id,
          name: s.name
        }));
      });
    } else {
      this.postalStateOptions = [];
    }
  }

  onCountryChange(countryName: string): void {
    const country = this.countryOptions.find(c => c.name === countryName);
    if (country) {
      this.http.get(`/api/lookup/states?countryId=${country.id}`).subscribe((data: any) => {
        this.stateOptions = (data as any[]).map(s => ({
          id: s.id,
          name: s.name
        }));
      });
    } else {
      this.stateOptions = [];
    }
  }

  onNoMiddleNameChange(checked: boolean): void {
    this.middleNameDisabled = checked;
    if (checked) {
      this.form.patchValue({ middlename: 'NMN' });
      this.form.get('middlename').disable();
    } else {
      this.form.get('middlename').enable();
      if (this.form.value.middlename === 'NMN') {
        this.form.patchValue({ middlename: '' });
      }
    }
  }

  onSubmit(): void {
    if (this.form.invalid) return;
    this.http.post('/api/coreidentity', this.form.value).subscribe({
      next: () => this.router.navigate(['/check-ssn']),
      error: () => alert('Failed to create identity')
    });
  }
}
