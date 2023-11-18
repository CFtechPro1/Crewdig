<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crewdig.com - Your Crew Knows What's Good</title>

     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>

    <cfparam name="url.nolog" default=0>
    <cfparam name="url.trylog" default=0>
    <cfparam name="url.misslog" default=0>
    <cfparam name="url.userExists" default=0>

<body>

    <!---Nav Bar Menu--->

    <cfinclude  template="navBarMenu.cfm">

    <!---End Nav Bar Menu---> 

    <div class="container-fluid bg-info" style="--bs-bg-opacity: .3;">
        <div class="row">
            <div class="col-12 text-center">
                <h2 class="display-6">Your Crew Knows What's Good!</h2>
            </div>
        </div>
        <div class="px-4 pt-2 my-2 text-center border-bottom">
            <h3 class="display-4 fw-bold text-body-emphasis">Create a Crew, Get Thier Advice.</h3>
            <div class="col-lg-9 mx-auto">
                <div class="row my-auto">
                    <div class="col text-center bg-info rounded-3 mx-2 p-2 border border-success"
                        style="--bs-bg-opacity: .4;">
                        Create a Crew and invite people to join.
                    </div>
                    <div class="col text-center bg-info rounded-3 mx-2 p-2 border border-success"
                        style="--bs-bg-opacity: .4;">
                        Create Questions and add Text & Pictures for your crew to vote on.
                    </div>
                    <div class="col text-center bg-info rounded-3 mx-2 p-2 border border-success"
                        style="--bs-bg-opacity: .4;">
                        See which option your crew likes best.
                    </div>
                    <div class="col text-center bg-info rounded-3 mx-2 p-2 border border-success"
                        style="--bs-bg-opacity: .4;">
                        Create as many Crews & Questions as you like!
                    </div>
                </div>
            </div>
            <div class="text-center d-flex justify-content-center my-3"> 
                <cfif url.nolog eq 1>
                    <div class="alert alert-danger" role="alert">
                        <strong>Oh snap!</strong> Change a few things up and try logging in again.
                        <br><br>
                        <a href="#" data-bs-toggle="modal"
                    data-bs-target="#passwordModal" class="link-dark">Forgot Password?</a>
                    </div>
                </cfif>
                <cfif url.misslog eq 1>
                    <div class="alert alert-danger" role="alert">
                        <strong>Oh snap!</strong> Something went wrong try signing up again.
                        <br><br>
                        <a href="#" data-bs-toggle="modal"
                    data-bs-target="#passwordModal" class="link-dark">Forgot Password?</a>
                    </div>
                </cfif>
                <cfif url.trylog eq 1>
                    <div class="alert alert-danger col-6" role="alert">
                        <strong>Oh snap!</strong> Your session has expired. Please login again.
                        <br><br>
                        <a href="#" data-bs-toggle="modal" data-bs-target="#passwordModal" class="link-secondary">Forgot Password?</a>
                    </div>
                </cfif>
                <cfif url.userExists eq 1>
                    <div class="alert alert-danger col-6" role="alert">
                        <strong>Oh snap!</strong> There is a user with that email address. Please login.
                        <br><br>
                        <a href="#" data-bs-toggle="modal" data-bs-target="#passwordModal" class="link-secondary">Forgot Password?</a>
                    </div>
                </cfif>
            </div>
            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mb-5">

                <button type="button" class="btn btn-primary btn-lg px-4 me-sm-3" data-bs-toggle="modal"
                    data-bs-target="#signUpModal">Sign Up</button>
                <button type="button" class="btn btn-success btn-lg px-4" data-bs-toggle="modal"
                    data-bs-target="#loginModal">Login</button>
            </div>
            <div>
                <div class="container px-5">
                    <img src="images/homepage_crew_V2.jpg" class="rounded-5" alt="Example image" width="700"
                        loading="lazy">
                </div>
            </div>
        </div>
        <!-- Button trigger modal -->
        <!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#signUpModal">
            Launch demo modal
        </button> -->
    </div>


    <!--  Sign Up Modal -->
    <div class="modal fade" id="signUpModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-info text-center">
                    <h2 class="modal-title w-100" id="signUpModalLabel">Sign Up</h2>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body mx-auto">
                    <form action="components/crewUsers.cfc" method="post">
                        <div class="mb-3 align-items-center">
                            <div class="row mb-3">
                                <div class="col">
                                    <label for="username" class="form-label">Create a Username</label>
                                    <input type="text" class="form-control border border-info" name="username"
                                        id="username" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label for="email" class="form-label">Email address</label>
                                    <input type="email" class="form-control border border-info" name="email" id="email"
                                        aria-describedby="emailHelp" required>

                                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <label for="firstName" class="form-label">First Name</label>
                                <input type="firstName" name="firstName" id="firstName"
                                    class="form-control border border-info" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <label for="lastName" class="form-label">Last Name</label>
                                <input type="lastName" name="lastName" id="lastName"
                                    class="form-control border border-info" required>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <label for="password" class="form-label">Create Password</label>
                                <input type="password" name="password" id="password"
                                    class="form-control border border-info" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="password" class="form-label">Password Confirm</label>
                                <input type="password" name="confirmPassword" id="confirmPassword"
                                    class="form-control border border-info" required>
                            </div>
                        </div>
                    </div>
                
                <div class="modal-footer bg-info" style="--bs-bg-opacity: .5;">

                    <img src="images/crewdigLogo_Login_V1.png" border="0">

                    <input type="hidden" name="Method" value="signUpUser">

                    <button type="submit" class="btn btn-primary">Sign Up</button>

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>

                    </form>
            </div>
        </div>
    </div>
    <!--  End Sign Up Modal -->


    <!--  Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-info text-center">
                    <h2 class="modal-title w-100">Login</h2>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body mx-auto">

                    <form action="components/crewUsers.cfc" id="loginForm" method="post">
                       <div class="mb-3 align-items-center">
                            <!--- <div class="row mb-3">
                                <div class="col">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control border border-info" name="username" required
                                        id="username">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    -OR-
                                </div>
                            </div>--->
                           <div class="row">
                                <div class="col">
                                    <label for="email" class="form-label">Email address</label>
                                    <input type="email" class="form-control border border-info" name="email" id="email" required
                                        aria-describedby="emailHelp">
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" name="password" id="password" required
                                    class="form-control border border-info" id="exampleInputPassword1">
                            </div>
                        </div>
                    </div>
                
                    <div class="modal-footer bg-info" style="--bs-bg-opacity: .5;">
                        <img src="images/crewdigLogo_Login_V1.png" border="0">

                        <input type="hidden" name="action" value="login">
                        <input type="hidden" name="Method" value="loginUser">

                        <input type="submit" value="Submit" class="btn btn-primary"></button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                    </form>
            </div>
        </div>
    </div>
    <!--  End Login Modal -->

    <!--  Forgot Password Modal -->
    <div class="modal fade" id="passwordModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-info text-center">
                    <h2 class="modal-title w-100">Login</h2>

                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body mx-auto">

                    <form action="components/crewUsers.cfc" id="passwordForm" method="post">
                       <div class="mb-3 align-items-center">
                           <div class="row">
                                <div class="col">
                                    <label for="email" class="form-label">Email address</label>
                                    <input type="email" class="form-control border border-info" name="email" id="email" required
                                        aria-describedby="emailHelp">
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col">
                                Forgot Password? We will send you an email with login instructions.
                            </div>
                        </div>
                    </div>
                
                    <div class="modal-footer bg-info" style="--bs-bg-opacity: .5;">
                        <img src="images/crewdigLogo_Login_V1.png" border="0">

                        <input type="hidden" name="Method" value="forgotPassword">

                        <input type="submit" class="btn btn-primary" value="Send Email"></button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                    </form>
            </div>
        </div>
    </div>
    <!--  End Forggot Password Modal -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous"></script>



</body>

</html>