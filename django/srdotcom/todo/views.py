from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User
from django.db import IntegrityError
from django.contrib.auth import login

def signupuser(request):
    if request.method == 'GET':
        return render(request, 'todo/signupuser.html', {'form': UserCreationForm()}) # dict
    else:
        # Create a new user
        if request.POST['password1'] == request.POST['password2']:
            try:
                user = User.objects.create_user(request.POST['username'], password=request.POST['password1'])
                user.save()
                login(request, user)
                return redirect('currenttodos')
            except IntegrityError:
                return render(request, 'todo/signupuser.html', {'form':UserCreationForm(), 'error': 'That username has already been taken.  Please choose another username!!!'})
        else:
            # Tell user passwords didn't match
            return render(request, 'todo/signupuser.html', {'form':UserCreationForm(), 'error': 'Passwords do not match!!!'})

def currenttodos(request):
    return render(request, 'todo/currenttodos.html')