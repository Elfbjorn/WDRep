import { Routes } from '@angular/router';
import { HelloComponent } from './hello.component';

import { CheckSsnComponent } from './check-ssn/check-ssn.component';
import { CreateIdentityComponent } from './create-identity/create-identity.component';

export const routes: Routes = [
	{ path: '', redirectTo: 'hello', pathMatch: 'full' },
	{ path: 'hello', component: HelloComponent },
	{ path: 'check-ssn', component: CheckSsnComponent },
	{ path: 'create-identity', component: CreateIdentityComponent }
];
