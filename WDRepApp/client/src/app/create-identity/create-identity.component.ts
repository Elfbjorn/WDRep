import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-create-identity',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './create-identity.component.html',
  styleUrls: ['./create-identity.component.scss']
})
export class CreateIdentityComponent implements OnInit {
  onContactCountryChange() {
    const selected = this.contactCountryList.find((c: any) => c.geographyId === this.contactSelectedCountry);
    if (selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada')) {
      this.http.get<any>(`/api/identity/states/${this.contactSelectedCountry}`).subscribe(
        (data) => {
          this.contactStates = (data || []).map((s: any) => ({
            geographyId: s.geographyId ?? s.geographyid,
            geographyName: s.geographyName ?? s.geographyname
          }));
        },
        () => {
          this.contactStates = [];
        }
      );
    } else {
      this.contactStates = [];
    }
    this.contactSelectedState = null;
    this.contactStateText = '';
  }
  // Contact tab fields
  // Email
  emailTypes: { contactTypeId: number, contactTypeName: string }[] = [];
  selectedEmailType: number | null = null;
  primaryEmail: string = '';
  // Phone
  phoneTypes: { contactTypeId: number, contactTypeName: string }[] = [];
  selectedPhoneType: number | null = null;
  primaryPhone: string = '';
  // Address
  addressTypes: { contactTypeId: number, contactTypeName: string }[] = [];
  selectedAddressType: number | null = null;
  addressLine1: string = '';
  addressLine2: string = '';
  contactCountryList: { geographyId: number, geographyName: string }[] = [];
  contactSelectedCountry: number | null = null;
  contactStates: { geographyId: number, geographyName: string }[] = [];
  contactSelectedState: number | null = null;
  contactStateText: string = '';
  contactCity: string = '';
  contactZip: string = '';
  // Helper for contact country/state/city
  get isContactUsOrCanada(): boolean {
    const selected = this.contactCountryList.find((c: any) => c.geographyId === this.contactSelectedCountry);
    return !!selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada');
  }
  activeTab: 'basic' | 'contact' = 'basic';
  sexes: { sexid: number, description: string }[] = [];
  selectedSex: number | null = null;
  city: string = '';
  get isUsOrCanada(): boolean {
    const selected = this.countries.find((c: any) => c.geographyId === this.selectedCountry);
    return !!selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada');
  }
  states: { geographyId: number, geographyName: string }[] = [];
  selectedState: number | null = null;
  stateText: string = '';
  countries: { geographyId: number, geographyName: string }[] = [];
  selectedCountry: number | null = null;
  dob: string = '';
  ssn: string = '';
  prefixes: { prefixsuffixid: number, description: string }[] = [];
  suffixes: { prefixsuffixid: number, description: string }[] = [];
  selectedPrefix: number | null = null;
  selectedSuffix: number | null = null;
  loading = false;
  error: string | null = null;
    firstName: string = '';
    middleName: string = '';
    lastName: string = '';
    previousLastName: string = '';
    preferredName: string = '';

  constructor(private http: HttpClient) {}

  ngOnInit() {
    this.loading = true;
    this.http.get<any>('/api/identity/dropdowns').subscribe(
      (data) => {
        this.prefixes = (data?.prefixes || []).map((p: any) => ({
          prefixsuffixid: p.prefixsuffixid ?? p.prefixSuffixId,
          description: p.description
        }));
        this.suffixes = (data?.suffixes || []).map((s: any) => ({
          prefixsuffixid: s.prefixsuffixid ?? s.prefixSuffixId,
          description: s.description
        }));
        this.sexes = (data?.sexes || []).map((s: any) => ({
          sexid: s.sexid ?? s.sexId,
          description: s.description
        }));
        this.countries = (data?.countries || []).map((c: any) => ({
          geographyId: c.geographyId ?? c.geographyid,
          geographyName: c.geographyName ?? c.geographyname
        }));
        // Contact dropdowns
        this.emailTypes = (data?.emailTypes || []).map((t: any) => ({
          contactTypeId: t.contactTypeId,
          contactTypeName: t.contactTypeName
        }));
        this.phoneTypes = (data?.phoneTypes || []).map((t: any) => ({
          contactTypeId: t.contactTypeId,
          contactTypeName: t.contactTypeName
        }));
        this.addressTypes = (data?.addressTypes || []).map((t: any) => ({
          contactTypeId: t.contactTypeId,
          contactTypeName: t.contactTypeName
        }));
        this.contactCountryList = (data?.countries || []).map((c: any) => ({
          geographyId: c.geographyId ?? c.geographyid,
          geographyName: c.geographyName ?? c.geographyname
        }));
        this.loading = false;
      },
      () => {
        this.error = 'Failed to load dropdown.';
        this.loading = false;
      }
    );
    // If you have a value from /check-ssn, set this.ssn = value;
  }

  onCountryChange() {
    const selected = this.countries.find((c: any) => c.geographyId === this.selectedCountry);
    if (selected && (selected.geographyName === 'United States' || selected.geographyName === 'Canada')) {
      this.http.get<any>(`/api/identity/states/${this.selectedCountry}`).subscribe(
        (data) => {
          this.states = (data || []).map((s: any) => ({
            geographyId: s.geographyId ?? s.geographyid,
            geographyName: s.geographyName ?? s.geographyname
          }));
        },
        () => {
          this.states = [];
        }
      );
    } else {
      this.states = [];
    }
    this.selectedState = null;
    this.stateText = '';
  }
}
