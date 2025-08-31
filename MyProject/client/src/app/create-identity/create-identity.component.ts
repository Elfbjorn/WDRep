import { Component, OnInit } from '@angular/core';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatCardModule } from '@angular/material/card';
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
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatOptionModule,
    MatCheckboxModule,
    MatCardModule,
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
  cityOptions: any[] = [];
  contactTypeOptions: any[] = [];

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
        email: ['', [Validators.required, Validators.email]],
        phone: ['', Validators.required],
        postal: ['', Validators.required],
        contacttype: ['']
      });
    }

    ngOnInit(): void {
      this.http.get('/api/prefixsuffix?type=Prefix').subscribe((data: any) => this.prefixOptions = data);
      this.http.get('/api/prefixsuffix?type=Suffix').subscribe((data: any) => this.suffixOptions = data);
      this.http.get('/api/countries').subscribe((data: any) => this.countryOptions = data);
      this.http.get('/api/contacttypes').subscribe((data: any) => this.contactTypeOptions = data);
      // Pre-populate SSN from navigation state
      const nav = this.router.getCurrentNavigation();
      if (nav?.extras?.state && 'ssn' in nav.extras.state) {
        this.form.patchValue({ ssn: nav.extras.state['ssn'] });
      }
    }

    onCountryChange(country: string): void {
      if (country === 'United States') {
        this.http.get('/api/geography?country=United States&type=State').subscribe((data: any) => this.stateOptions = data);
      } else {
        this.stateOptions = [];
      }
    }

    onStateChange(state: string): void {
      this.http.get(`/api/geography?state=${state}&type=City`).subscribe((data: any) => this.cityOptions = data);
    }

    onNoMiddleNameChange(checked: boolean): void {
      if (checked) {
        this.form.patchValue({ middlename: 'NMN' });
      } else {
        this.form.patchValue({ middlename: '' });
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
