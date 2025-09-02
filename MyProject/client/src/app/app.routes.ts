// This file has been removed for a clean slate.


import { Routes } from '@angular/router';

import { CheckSsnComponent } from './check-ssn/check-ssn.component';

export const routes: Routes = [
	{ path: '', redirectTo: 'check-ssn', pathMatch: 'full' },
	{ path: 'check-ssn', component: CheckSsnComponent },
];
