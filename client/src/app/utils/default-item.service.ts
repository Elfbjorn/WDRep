import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface DefaultItem {
  defaultItemId: number;
  defaultItemPage: string;
  defaultItemTab?: string;
  cancelLink?: string;
  cancelLinkText?: string;
  previousLink?: string;
  previousLinkText?: string;
  nextLink?: string;
  nextLinkText?: string;
  recordStatusId: number;
}

@Injectable({ providedIn: 'root' })
export class DefaultItemService {
  constructor(private http: HttpClient) {}

  getDefaultItem(page: string, tab?: string): Observable<DefaultItem> {
    return this.http.get<DefaultItem>(`/api/defaultitems?page=${encodeURIComponent(page)}&tab=${encodeURIComponent(tab || '')}`);
  }
}
