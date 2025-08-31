import { ComponentFixture, TestBed } from '@angular/core/testing';
import { CheckSsnComponent } from './check-ssn.component';


describe('CheckSsnComponent', () => {
  let component: CheckSsnComponent;
  let fixture: ComponentFixture<CheckSsnComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [CheckSsnComponent],
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CheckSsnComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
