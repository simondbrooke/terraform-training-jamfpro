# tactiq.io free youtube transcript
# HashiCorp Terraform Associate Certification Course (003) - Pass the Exam!
# https://www.youtube.com/watch/SPcwo0Gq9T8

00:00:00.359 hey this is Andrew Brown over here on
00:00:02.520 free cocam bringing you another free
00:00:04.380 Cloud certification and this time it's
00:00:07.560 the hashicorp terraform associate
00:00:09.120 version three and the way we're going to
00:00:11.219 achieve certification is through lecture
00:00:14.280 content Hands-On labs and as always I
00:00:17.520 provide you a free practice exam and so
00:00:20.220 at the end of the day you're going to
00:00:21.359 get that certification and you could put
00:00:23.220 it on your resume on your LinkedIn to
00:00:25.019 demonstrate that devops skills and try
00:00:27.000 to go get that cloud or devops role
00:00:29.039 you've been looking for or trying to
00:00:31.380 upgrade to so if you like the materials
00:00:35.640 here a great way to support more content
00:00:37.980 like this is to look at the paid
00:00:39.780 additional materials it will also help
00:00:42.239 you increase the odds on your exam and
00:00:45.059 it also really does help out and support
00:00:47.160 the production of more of this kind of
00:00:49.559 content and if you are not familiar with
00:00:52.379 me I produce a lot of different kinds of
00:00:54.539 cloud certification courses like AWS
00:00:57.420 Azure kubernetes you name it I've taught
00:01:00.840 it and so you're in really good hands
00:01:03.000 and we'll see you in class soon ciao
00:01:06.119 foreign
00:01:06.480 [Music]
00:01:11.340 everybody it's Andrew Brown and welcome
00:01:13.560 to the start of our journey and we're
00:01:15.240 asking the most important question first
00:01:17.100 which is what is terraform and I just
00:01:19.560 want to tell you that I'm on screen now
00:01:21.479 but I'm going to vanish here shortly and
00:01:23.880 stay out of the way so that you can see
00:01:25.799 the full content but I just wanted to
00:01:27.659 know you to know that I'm here with you
00:01:29.700 the entire way okay so the terraform
00:01:32.880 associate certification is a specialty
00:01:34.979 certification in terraform terraform is
00:01:37.740 a technology produced by hashicorp and
00:01:40.439 it's specifically for infrastructures of
00:01:42.299 code and it's a declarative
00:01:44.220 infrastructure as a code and it's a
00:01:45.780 cloud agnostic infrastructure as a code
00:01:47.700 we will dive into all of this in great
00:01:50.340 detail in the introduction section and
00:01:52.860 just notice that I put an asterisk there
00:01:54.360 on declarative because there is
00:01:56.820 something special about terraform that
00:01:58.439 we will discover if you are considering
00:02:01.439 the terraform associate then you most
00:02:03.600 likely are looking for a devops role you
00:02:07.259 want to automate infrastructure or
00:02:08.880 writing scripts you want to work with
00:02:10.979 multiple Cloud providers or you know you
00:02:14.220 enjoy designing iterating on end-to-end
00:02:16.560 infrastructure life cycle so if this
00:02:18.000 sounds like anything that you are
00:02:19.379 interested in then you would probably
00:02:21.840 want to take this certification I want
00:02:24.660 to tell you that terraform is one of the
00:02:27.000 most in-demand skills for devops rules
00:02:29.640 today and it's becoming quickly the
00:02:32.400 industry standard just because it is so
00:02:34.680 flexible and works with all providers
00:02:36.660 and goes beyond a lot of these other
00:02:39.120 tools and the terraform associate exam
00:02:42.180 itself isn't that difficult
00:02:44.819 uh but I would say that the concept of
00:02:47.580 learning terraform is a bit tricky
00:02:49.379 because uh you know it's not something
00:02:51.239 that you can just go do the lecture
00:02:53.519 content uh and and do the lab content I
00:02:56.940 had to do a mix of it uh so in this
00:02:58.980 course you'll see me do lecture lab
00:03:00.720 lecture lab because I'm trying to
00:03:02.519 solidify the knowledge as soon as we do
00:03:04.920 that this is not the format that I use
00:03:06.720 for my other courses it's just because
00:03:08.400 with terraform it requires patience it
00:03:11.400 is a silical learning process to
00:03:13.860 understand so just uh stick with it and
00:03:16.739 by the end of it you will be really good
00:03:18.300 with terraform uh you know and so that's
00:03:21.060 that there so let's talk about our
00:03:23.099 multi-cloud roadmap I'm going to get out
00:03:24.840 of the way so we have a little bit more
00:03:26.700 room
00:03:27.840 um and so you know what I would
00:03:29.459 recommend uh is that you start with an
00:03:32.280 Associate certification so just getting
00:03:34.140 my pen tool out here uh if I can get it
00:03:36.780 here here we have the Google's Ace
00:03:40.019 um the cloud engineer or maybe some
00:03:42.480 level of AWS uh associate certification
00:03:46.260 I personally think the sysops is the
00:03:48.480 best pairing for terraform or the Azure
00:03:51.180 administrator if you're going for Azure
00:03:53.519 and quite possibly learning more than
00:03:56.340 two would be very beneficial but of
00:03:58.319 course whatever your primary provider
00:03:59.760 you're using is where you're going to
00:04:01.200 benefit with uh terraform and you really
00:04:04.500 should learn this stuff before you do
00:04:06.420 terraform it is super hard to learn both
00:04:09.360 cloud and terraform at the same time you
00:04:12.060 should have that Foundation before you
00:04:13.799 tackle onto terraform and so there's a
00:04:16.199 lot of different paths for multi-cloud
00:04:18.060 and just to kind of give you an idea of
00:04:19.798 all the different ways you can go you
00:04:22.260 know you can go from associate to either
00:04:24.180 Vault and to the Vault professional if
00:04:26.160 you're looking at a security background
00:04:28.320 but it's very common for people to get
00:04:30.660 the terraform and then go for
00:04:32.699 uh Vault afterwards but you know it's up
00:04:35.520 to you to which path you want to take
00:04:37.800 how long do you have to study to pass
00:04:40.440 this exam well uh it's a spectrum based
00:04:43.020 on where your background is so let's
00:04:44.639 take a look at beginners first so a
00:04:46.560 beginner to me would be someone that's
00:04:48.000 never written IC uh they have not
00:04:50.340 previously focused on automating
00:04:51.600 infrastructure they might may not hold
00:04:54.000 an associate level certification so
00:04:55.740 you're adding those additional hours or
00:04:57.300 trying to make up the difference you
00:04:59.460 could be looking at 30 hours or more if
00:05:02.880 you're already experienced with writing
00:05:05.460 IAC but maybe just not terraform maybe
00:05:07.500 you know Azure bicep or cloud formation
00:05:09.680 you already work in devops you're
00:05:12.660 already comfortable writing scripts and
00:05:14.400 you hold associate level certification
00:05:16.380 knowledge of you know a major cloud
00:05:18.900 provider then you're looking at
00:05:20.520 something like 12 hours but you know if
00:05:22.979 you're looking for a general study guide
00:05:24.840 somewhere in between I would recommend
00:05:26.699 between one to two hours a day for 14
00:05:29.100 days and you'll be in a really good
00:05:31.380 place by then you know what does it take
00:05:33.840 to pass this exam well there is a
00:05:36.000 lecture content and I have a lot of it
00:05:39.120 um you know the thing is that
00:05:41.220 the exam itself is very practical it's
00:05:44.340 not like AWS aws's exams where it's very
00:05:49.199 um uh Theory based at a conceptual level
00:05:51.660 this one is very much how do we use this
00:05:54.600 technology and so the lecture content is
00:05:57.600 there to really support the lab content
00:05:59.759 and you really really need to do the lab
00:06:02.039 content uh because that's the nature of
00:06:04.620 this exam
00:06:06.060 um and to make this a lot easier I do
00:06:08.759 recommend taking some practice exams we
00:06:11.100 have a free practice exam and we also
00:06:13.199 have uh many more practice exams if you
00:06:17.039 take all these Pax exams and you've done
00:06:18.840 the labs prior to that you're going to
00:06:20.759 be in really good shape to pass in terms
00:06:23.340 of the content outline
00:06:25.740 um I can't remember how many domains
00:06:26.759 we'll see how many there are but we have
00:06:28.259 one so understand infrastructure as code
00:06:30.479 so I see Concepts understand the purpose
00:06:32.819 of terraform
00:06:34.020 understand terraform Basics the use of
00:06:36.479 terraform outside core workflows
00:06:38.039 interact with terraform modules
00:06:40.500 use the core terraform workflow
00:06:42.300 Implement and maintain State regenerate
00:06:45.060 and modify configuration
00:06:46.860 and understand terraform Cloud
00:06:48.900 capabilities so yeah nine domains uh
00:06:52.080 something that's different about uh the
00:06:53.819 hashicorp certifications is they do not
00:06:55.800 provide distribution of domains what do
00:06:58.440 I mean by that well they're not weighted
00:07:00.180 right so it's not like uh we know that
00:07:03.180 uh like eight is I'm going to have a
00:07:07.319 particular weighting that's higher but
00:07:08.940 we can look at the exam guide outline to
00:07:11.340 see generally how many questions we
00:07:12.780 probably would so we could kind of infer
00:07:14.759 our own waiting but they do not provide
00:07:16.680 it so I would just say it's not known
00:07:18.539 but we'll take our best guess when we
00:07:20.099 look at the full exam guide outline
00:07:23.099 where do you take this exam well you can
00:07:25.319 take it in an in-person test center or
00:07:27.599 online from the convenience of your own
00:07:28.919 home I do believe that the test center
00:07:31.259 that hashicorp is using is PSI or PSI
00:07:34.860 online and understand that this is a
00:07:37.319 proctored exam so someone is supervising
00:07:39.660 you watching you monitoring you as you
00:07:41.639 take the exam so that you uh that
00:07:43.500 there's no funny business happening
00:07:44.940 there's no cheating and to ensure that
00:07:47.460 uh you know that you gain gain that
00:07:50.639 knowledge in a reputable way so just
00:07:52.919 understand that in terms of the grading
00:07:55.020 you need to get about 70 percent to pass
00:07:57.599 or round that it uses scaled scoring uh
00:08:01.080 is it possible for you to fail if you've
00:08:02.699 got exactly 70 percent it might be so
00:08:06.000 always aim to get higher than 70 percent
00:08:10.440 um and so I always say aim for a target
00:08:12.300 of you know 10 to 15 above what the
00:08:15.419 score is if you're getting that on your
00:08:17.220 prax exams then you're going to be in
00:08:19.620 good shape in terms of the response
00:08:21.120 types they don't tell you exactly how
00:08:23.460 many questions there are but I've always
00:08:25.199 observed there's 57 questions and so you
00:08:28.620 know based on that calculation I feel
00:08:30.000 that you have 70 17 questions you can
00:08:32.279 get wrong there are no penalties for
00:08:34.380 wrong questions so always answer your
00:08:37.260 questions do not leave any blank the
00:08:39.120 format of the questions is multiple
00:08:40.500 choice and multiple answer and then
00:08:43.140 sometimes you get a fill in the blank so
00:08:44.940 type a one word answer most likely it's
00:08:48.660 going to be a command right so or a flag
00:08:50.760 for a command so you definitely have to
00:08:53.160 know the technical components of
00:08:55.200 terraform okay the duration of the exam
00:08:57.779 is one hour so that means you get about
00:08:59.580 a minute to answer per questions the
00:09:01.260 questions are very short format so it's
00:09:04.019 not like you have to read a ton of text
00:09:06.180 to figure out what's going on the exam
00:09:08.640 time is 60 Minutes the seat time is
00:09:11.100 actually 90 minutes so when we say C
00:09:13.860 time referring to the amount of time you
00:09:15.600 should allocate for the exam so that
00:09:18.120 means that would include things like
00:09:19.800 time to review the instructions show uh
00:09:22.620 show the online proctored your workspace
00:09:24.660 to make sure there's nothing going funny
00:09:26.700 on with your environment read and accept
00:09:29.940 the NDA complete the exam provide
00:09:32.880 feedback at the end and I'm going to
00:09:34.980 tell you you really do want to get for
00:09:38.100 your exam much sooner than you think
00:09:40.260 because it is a very stressful process
00:09:42.480 and things tend to always go wrong when
00:09:45.140 when you uh when you don't show up early
00:09:47.700 enough okay so just make sure you do
00:09:49.380 that if you do pass this exam it's going
00:09:51.899 to be valid for 24 months so that's two
00:09:54.000 years before recertification and the
00:09:56.399 last thing I just want to talk about is
00:09:58.980 um well maybe not the last thing I got
00:10:00.180 two more slides here for you but this
00:10:01.500 course is going to be designed around
00:10:02.640 the
00:10:04.700 1.1.6.0 specification of terraform
00:10:07.760 and even when I'm making this course as
00:10:10.980 of today 1.60 is an alpha this will be
00:10:13.860 in the future so 1.60 will be out but I
00:10:17.399 like to try to give you more knowledge
00:10:19.560 in the future even if it's not an exam
00:10:22.200 just so that you are prepared and this
00:10:24.779 course does not go stale sooner
00:10:26.940 terraform is always incrementing
00:10:29.060 inversion so you know when you study you
00:10:31.560 always want to go back three minor
00:10:33.120 versions since I'm showing 1.60 it
00:10:35.640 doesn't make a whole lot of sense but if
00:10:36.959 you're let's say you're on 1.54 you'd
00:10:40.320 want to do one you want to make sure you
00:10:41.940 know terraform for a range of versions
00:10:44.399 going a few versions back and so so you
00:10:47.459 know I will be showing you things that
00:10:49.320 may be deprecated but are still uh but
00:10:52.140 might still be in use based on the
00:10:53.459 version that people are using so just
00:10:55.560 understand that
00:10:58.019 um and again you know these these
00:10:59.459 certifications are or the terraform
00:11:01.620 certification is heavily dependent on
00:11:03.360 your practical knowledge so if you are
00:11:05.279 taking the time to apply the knowledge
00:11:07.079 uh this version difference differencing
00:11:09.480 is not going to make a big difference
00:11:10.680 okay
00:11:12.180 um so just make sure you know you put
00:11:14.339 the time in with the labs
00:11:16.380 um now this is the third version of the
00:11:19.500 certification and so I just kind of want
00:11:21.600 to tell you that not a whole lot has
00:11:24.060 changed between version zero zero two
00:11:26.399 and zero zero three uh the one of the
00:11:29.220 big differences is they change the badge
00:11:31.079 design why I don't know uh is it better
00:11:34.440 who cares
00:11:36.540 um but uh it is a different looking
00:11:38.579 badge
00:11:39.959 um one thing is that there were
00:11:41.519 superficial name changes to the outlines
00:11:43.440 of the domain so basically all the
00:11:45.540 domains are the same they just kind of
00:11:47.100 did some tweaks there they did kind of
00:11:50.100 cut some content out in the uh the like
00:11:52.500 first uh first first two domains because
00:11:55.320 those ones were just more General
00:11:56.700 concept of knowledge and so they slim
00:11:58.500 those down I'm leaving that content in
00:12:01.440 this course because I think it's very
00:12:03.240 valuable to know more rounded knowledge
00:12:06.240 there so you're going to be over
00:12:07.320 prepared for those first two domains
00:12:09.620 there used to be this thing called
00:12:12.240 provisioners it's still in terraform but
00:12:14.820 the thing is that it's just no longer
00:12:16.740 needed to know in the exam so this is
00:12:19.019 about doing remote execution annoying
00:12:21.360 all the provisioners and so I mean local
00:12:25.260 execute and remote execute are things
00:12:26.880 you need to learn and definitely
00:12:28.380 something that you will use on the job
00:12:30.060 but knowing how to provision and use a
00:12:32.579 lot of Provisions is no longer a focus
00:12:34.440 there
00:12:35.180 there's this thing called null resource
00:12:37.980 that we learn about and now they have a
00:12:40.320 new thing called terraform data so that
00:12:42.000 is a evolution of terraform data so
00:12:44.700 we'll still learn about null resource
00:12:46.560 but we'll also learn terraform data
00:12:48.839 where it makes more sense to use
00:12:51.180 uh you know terraform Tate had taint has
00:12:53.519 been replaced with uh just a flag uh
00:12:56.220 called hyphen hyphen uh uh replace uh on
00:12:59.880 the terraform plan and we have a few
00:13:01.680 more others like that so refresh has a
00:13:03.779 flag
00:13:05.100 um and uh the thing was is that when I
00:13:07.200 made this exam the first time they were
00:13:09.300 already talking about doing this so This
00:13:10.980 exam is already
00:13:12.779 um my previous one is up to date with
00:13:15.000 the current version of zero zero three
00:13:18.300 if that if that's surprising here uh
00:13:21.360 terraform workspace is no longer part of
00:13:23.459 the exam
00:13:25.079 um I would still cover terraform
00:13:26.579 workspace uh you know if we come across
00:13:28.680 it because I still think again it's
00:13:30.959 practical knowledge that you should know
00:13:33.540 um connecting to terraform Cloud now
00:13:35.579 uses its own cloud block instead of
00:13:37.260 remote block
00:13:38.820 um I believe that we can still use
00:13:40.200 remote block here and I will definitely
00:13:41.820 test that in the in the
00:13:45.060 um in the uh the labs in this course so
00:13:48.060 you know it's good to know both of them
00:13:49.560 but the focus will be using uh Cloud
00:13:51.720 block
00:13:53.040 um we have the lock file so the lock.hcl
00:13:56.040 files are new
00:13:58.019 um I mean they weren't new when I made
00:14:00.360 the previous exam so they were already
00:14:01.860 in there so again I already had this
00:14:03.839 content here
00:14:05.220 um but I'm just pointing out that that's
00:14:07.260 something that they're focusing on uh
00:14:08.880 within the certification here
00:14:11.160 um you need to know how to Mark data as
00:14:12.779 being sensitive again that's something I
00:14:14.760 had in the older exam but one major
00:14:17.339 thing is terraform cloud has a new UI
00:14:19.800 and it looks like there's a lot more
00:14:20.820 functionality so in terms of the old
00:14:23.820 exam or a course that I produce and this
00:14:26.160 one I'm definitely going to have to
00:14:28.260 reshoot all of terraform cloud and go
00:14:30.720 deeper into it there's obviously a few
00:14:32.639 different functionalities that have been
00:14:34.019 added like the terraform Cloud block the
00:14:35.339 terraform data block
00:14:37.260 um but you know for the most part
00:14:38.639 there's not a whole lot that has changed
00:14:40.680 so the majority of this will be very
00:14:42.360 similar to the last one but I'm just
00:14:43.800 touching up and improving lab content
00:14:46.860 where we can and hopefully adding a lot
00:14:49.380 more additional content to expand the
00:14:51.959 terraform knowledge that I wasn't able
00:14:53.459 to do the first time around so hopefully
00:14:55.560 that gives you a good idea of what
00:14:57.300 you're getting yourself into uh but yeah
00:14:59.519 we will proceed forward to looking at
00:15:01.560 the exam guide
00:15:03.060 foreign
00:15:07.399 Brown and welcome back as we are taking
00:15:10.079 a look at the exam guide uh for the
00:15:13.440 hashicorp terraform associate
00:15:15.300 certification I want to tell you uh
00:15:18.360 throughout this course I'm going to show
00:15:20.519 you where I get things so I will be
00:15:23.220 going to Google I will be typing in
00:15:25.620 where things are it's not because I
00:15:28.199 don't know where things are I'm doing
00:15:29.639 that for your benefits so that you build
00:15:31.680 up the skill to know how to find things
00:15:33.420 just the way that I would go find things
00:15:35.040 and I'll be very transparent about that
00:15:37.019 so for this one all I did was go into
00:15:38.880 Google and type in terraform exam guide
00:15:42.839 and so I found it here this is also the
00:15:45.060 place where you can register for the
00:15:46.920 exam so if you click this it should load
00:15:49.139 up certain metrics I'll make a pop-up
00:15:50.880 you have to authenticate it I'm not
00:15:52.500 showing that here right now but when you
00:15:54.120 are ready to register for the exam you
00:15:56.399 can go ahead and do that you'll notice
00:15:58.320 they also have this button here called
00:16:00.060 prepare for the exam they have their own
00:16:02.579 study guide here it's very text based
00:16:05.279 heavy I do believe that somewhere in
00:16:07.199 here there is a way to launch tutorials
00:16:10.800 and this will launch sandbox
00:16:13.079 environments I think through instruct at
00:16:14.760 least the last time I checked those are
00:16:17.579 great if you don't have an environment
00:16:19.260 set up what I want to do with you is I
00:16:21.720 want I want you to set everything up in
00:16:24.300 your own environment because I want you
00:16:26.339 to have those Real World skills so you
00:16:28.440 can use this stuff adjacent to this
00:16:31.139 course I've gone through all this
00:16:32.399 material here I'm trying to cover things
00:16:34.260 that aren't in here and try to make sure
00:16:37.440 that we are doing things without guard
00:16:39.060 rails without the bowling bumpers
00:16:41.880 because I want you get that Real World
00:16:43.259 Experience okay but I do want to point
00:16:45.420 out that this is here and you can use it
00:16:48.180 um and it's okay so let's scroll down
00:16:50.759 and take a look at our exam guide here
00:16:54.720 and so here they say we have some
00:16:56.639 prerequisites so they say basic terminal
00:16:58.680 skills that makes sense we're going to
00:17:00.899 be doing a lot of stuff uh in terminal
00:17:03.300 basic understanding of on-premise and
00:17:05.280 Cloud architecture uh I think what they
00:17:07.799 really mean is do you know how to use
00:17:09.900 AWS you know how to use Azure gcp what
00:17:11.819 is your major uh cloud provider or or
00:17:14.819 stuff like that um now I keep talking or
00:17:17.459 focusing on AWS Azure gcp but understand
00:17:20.220 that terraform can be used for anything
00:17:22.500 as long as there is a provider for it it
00:17:25.079 can provision on almost anything okay
00:17:27.660 and that's why they're being very
00:17:29.760 generic in their description this says
00:17:32.220 the product version tested is terraform
00:17:33.900 1.00 and higher so it shows you that
00:17:38.100 this is still even though it's the zero
00:17:40.200 zero three it's still really the zero
00:17:41.940 zero two exam with some minor tweaks but
00:17:44.700 just understand in this course we're
00:17:46.020 going to go well beyond this because I'm
00:17:48.000 just future proofing you and making sure
00:17:49.799 you have Real World skills let's scroll
00:17:51.960 on down here
00:17:53.299 and let's just it's about renewing your
00:17:55.679 certification so if you hold an
00:17:57.960 unexpired terraform associate 002
00:18:00.299 certification
00:18:01.559 uh you can take the new one starting 18
00:18:04.440 months after your previous exam if you
00:18:06.480 hold an unexpired one you can take the
00:18:07.980 new exam starting 18 months after your
00:18:10.140 previous exam uh if you hold an expired
00:18:12.900 one you're eligible to recertify at any
00:18:14.640 time I really like this because what
00:18:16.500 happens for me with certifications not a
00:18:18.780 problem for you but problem for me is
00:18:20.039 that I will sit a certification and then
00:18:23.100 nine months later the new one comes out
00:18:24.720 and I can't sit the new one and tell you
00:18:26.220 about it so it looks like we've gotten a
00:18:28.559 bit of flexibility there and again I'm
00:18:30.480 on video here I will get out of the way
00:18:32.820 um it's just that we're in the uh these
00:18:34.620 earlier videos and I want to just hang
00:18:35.940 out here with you okay going down below
00:18:38.280 we can confirm it's the one hour
00:18:40.140 duration this is seventy dollars it
00:18:43.020 might vary based on your location and
00:18:44.520 other stuff you I just don't want to
00:18:46.440 tell you that 70 I want you to go
00:18:48.720 through the process and find out
00:18:49.740 yourself but that's probably what it's
00:18:51.240 going to cost you
00:18:53.760 um there is no free retake included
00:18:56.160 um some certifications like CompTIA you
00:18:58.799 are basically or uh the kubernetes ones
00:19:01.020 from looks Foundation you basically get
00:19:03.600 a retake so you're basically paying a
00:19:06.179 love for two and they call it a free
00:19:08.400 retake which it really isn't free but uh
00:19:10.799 I think this is okay
00:19:12.720 um I think it's fine there's no retake
00:19:14.039 it's in English expires in two years we
00:19:16.140 covered that before let's take a look at
00:19:18.179 the exam objectives so the first one is
00:19:19.919 understand infrastructure as a code and
00:19:21.600 Concepts they used to have a bunch of
00:19:23.400 junk in here
00:19:24.840 um and honestly I didn't even know what
00:19:26.640 they were talking about when they said
00:19:27.900 that I remember I had to comb through uh
00:19:31.200 the study guide and try to watch uh
00:19:33.419 articles and stuff like that but I think
00:19:35.220 they realized
00:19:36.660 that it was junk uh that they were
00:19:39.179 trying to uh impart too much conceptual
00:19:41.880 stuff and they cut back this one here
00:19:43.860 same thing with two
00:19:45.960 it doesn't show us the comparison of the
00:19:47.520 old one at some point on this website
00:19:49.559 they showed the comparative between zero
00:19:51.360 zero two and zero zero three
00:19:53.280 but all I'm saying is that they cut back
00:19:55.020 here I have a bit more content on this
00:19:57.240 in the course it's not going to hurt you
00:19:58.740 to watch it it's just going to help you
00:19:59.880 understand it but you're not going to be
00:20:01.140 tested 100 on this stuff the other thing
00:20:04.020 I want to note is that for each point
00:20:05.760 that is here each subdomain or or Point
00:20:08.580 whatever you want to call it they're
00:20:10.140 going to ask you a question on this is
00:20:11.820 very different uh way of Designing uh an
00:20:15.299 exam uh other exams like AWS they will
00:20:18.299 they will list a bunch of stuff but they
00:20:20.880 say it might not be on the exam or it
00:20:22.799 might have stuff that are that's outside
00:20:24.480 of it so you just have to broadly study
00:20:26.780 and uh you'll over over study for the
00:20:31.380 content because you just don't know what
00:20:32.760 you're going to get uh get on the exam
00:20:34.919 for hashicorp exams they're very fair if
00:20:38.580 you know each of these points you can
00:20:40.740 expect to see them generally on the exam
00:20:42.780 and that's how you're going to know that
00:20:45.360 you are ready if you if you know all
00:20:46.799 these things in this course we're going
00:20:48.480 to go beyond that because again I want
00:20:49.919 you to have those Real World skills but
00:20:51.240 just feel confidence in knowing every
00:20:52.919 single point Point here going down here
00:20:55.260 understand terraform Basics install and
00:20:58.140 version terraform providers so that is
00:21:00.360 what we will be doing a lot of in this
00:21:02.400 because we're going to at least touch
00:21:04.700 more than one provider in this course
00:21:07.559 I'm not going to go in great detail on
00:21:09.740 uh the cloud infrastructure part of it
00:21:12.660 because you're already supposed to know
00:21:13.860 it
00:21:14.820 um and I'm going to leave that for other
00:21:16.140 things doing future projects for
00:21:17.580 specific uh for for specific Cloud
00:21:20.039 providers we're focused here on
00:21:21.960 terraform in this course not the
00:21:23.340 underlying providers but we do use
00:21:25.320 multiple ones here describe plug-in
00:21:27.539 based architecture write terraform
00:21:29.400 configuration using multiple providers
00:21:31.679 describe how terraform finds and fetches
00:21:33.900 providers so you can see there is a a
00:21:36.659 lot of stuff about providers not to be
00:21:39.059 confused with provisioners I said
00:21:40.620 earlier that provisioners is no longer
00:21:42.480 covered in this certification course but
00:21:44.880 again the materials here so you can
00:21:46.260 learn it for real world practice use
00:21:49.140 terraform outside of core of core
00:21:51.419 workflows I think this used to be like
00:21:52.980 you use terraform CLI outside of core
00:21:55.620 workflows so they made a small tweak
00:21:57.419 there so it says destroy describe when
00:21:59.820 to use terraform import to import
00:22:01.200 existing infrastructure into your
00:22:02.640 terraform State terraform import is
00:22:04.799 super super powerful going over to other
00:22:07.740 providers uh you know for a long time
00:22:09.480 AWS did not have an import option and so
00:22:12.299 the idea is that by having this import
00:22:14.520 we can bring an infrastructure that was
00:22:17.400 not necessarily there before we have
00:22:19.679 terraform state to view our terraform
00:22:21.419 State something that you're going to
00:22:22.679 find unique to terraform is State
00:22:25.559 Management it's something that's super
00:22:27.179 important and it's probably the hardest
00:22:28.919 Concept in terraform because when you
00:22:31.380 use something like cloud formation or
00:22:33.720 Azure bicep the state is managed by
00:22:37.220 services on those providers
00:22:40.220 there isn't a managed service
00:22:42.919 managed service on those providers and
00:22:45.840 so you have to decide where you want to
00:22:48.240 put your State uh and one example would
00:22:50.880 be terraform cloud and that's one that
00:22:52.919 we do use in this in this course here
00:22:54.960 describe one to enable verbose logging
00:22:57.299 and what the outcome is so you have to
00:22:59.700 know how to debug things here which is
00:23:01.500 great interact with terraform module so
00:23:03.720 contrast and use different module Source
00:23:05.880 options including public terraform
00:23:07.679 module registry interact with modules
00:23:10.080 inputs and outputs describe variable
00:23:12.179 scope and module child modules set
00:23:14.640 module versions modules is a way of
00:23:16.919 creating reusable code
00:23:19.260 uh we are going to use uh public
00:23:22.500 libraries as well as uh make our own
00:23:25.380 modules making modules is not as hard as
00:23:27.539 you would imagine but they can get very
00:23:30.000 complex uh so you know we're not going
00:23:31.860 to go super Advanced into modules but we
00:23:33.659 are going to make sure we can write our
00:23:35.700 own and and use public ones use the
00:23:38.700 terraform uh use the terraform workflow
00:23:41.159 so this is something we're going to have
00:23:43.919 to know a lot about which is just the
00:23:46.440 general life cycle workflow of working
00:23:48.179 with infrastructure as code so we have a
00:23:50.700 knit validate plan apply destroy format
00:23:53.100 plan it apply are the ones we're going
00:23:54.900 to be using a lot of there is a lot of
00:23:57.240 trickery with the init so that's
00:23:59.100 something else that we'll do there as
00:24:00.720 well Implement and maintain state so
00:24:03.179 maintaining State working with State
00:24:05.159 super super important so we'll look at
00:24:07.980 how it works with local state state
00:24:10.380 locking handling back-end Cloud
00:24:12.179 Integrations authentication methods uh
00:24:14.880 you know they're talking about managed
00:24:16.080 providers like terraform Cloud
00:24:18.020 the different between remote State
00:24:20.340 back-end options manage resource drift
00:24:22.620 and terraform State terraform is super
00:24:24.960 good at drift and fixing drift it's so
00:24:29.280 good at remediation compared to other
00:24:33.140 IEC tools and that's why it is such a
00:24:36.120 popular tool to use describe back-end
00:24:38.940 block and Cloud integration
00:24:40.020 configuration understand secret
00:24:41.580 management and state files then we have
00:24:43.620 regenerate modify configuration so
00:24:45.299 demonstrate the use of variable
00:24:47.340 variables and outputs describe secure
00:24:49.380 secret injection best practices
00:24:50.940 understand the use of collection and
00:24:52.980 structural types create and
00:24:54.720 differentiate resource and data
00:24:56.520 configuration use resource addressing
00:24:58.860 and resource parameters to connect
00:25:00.240 resources together
00:25:01.740 use HCL and terraform functions to write
00:25:03.960 configuration describe built-in
00:25:05.880 dependency management
00:25:07.380 and the last one here is understand
00:25:09.059 terraform Cloud capabilities so explain
00:25:11.220 how terraform clouds helps to manage
00:25:12.780 infrastructure describe how terraform
00:25:14.340 Cloud enables collaboration government
00:25:15.720 governance I'm going to tell you right
00:25:18.059 now we're going to probably do more
00:25:19.380 terraform Cloud than we we need to it's
00:25:21.840 just because when I made this course the
00:25:23.940 first time I I just lightly did
00:25:25.980 terraform Cloud just enough to pass the
00:25:27.779 exam I have the time to do a little bit
00:25:29.760 more there I would like to do that for
00:25:31.679 your own benefit and so we will expand
00:25:33.840 on that a bit more but you can see this
00:25:35.940 is mostly about terraform the technology
00:25:38.059 not necessarily terraform Cloud the uh
00:25:40.980 the service if you're confused about
00:25:42.600 terraform and terraform Cloud uh again
00:25:45.360 we'll explain that in this course and
00:25:46.740 make sure it's very clear what the
00:25:48.059 difference is one other thing I wanted
00:25:50.039 to notice that you do have some sample
00:25:51.480 questions here so you can go through
00:25:53.100 here and you can just see that the
00:25:55.500 questions are very straightforward and
00:25:58.799 they're just like this they're very
00:26:00.360 simple uh but you know you do have to
00:26:03.360 know
00:26:04.380 you do have to know what you're looking
00:26:05.580 at and see like here they're showing
00:26:06.779 code so you can see you have to choose
00:26:08.779 code and you might get a code block so
00:26:11.039 it is very focused on the Practical
00:26:12.600 component of it it's less about the
00:26:15.659 conceptual okay but yeah hopefully that
00:26:18.900 gives you an idea of what we're getting
00:26:20.220 into and we'll see in the next one okay
00:26:21.779 ciao foreign
00:26:27.360 hey this is Andrew Brown from exam Pro
00:26:29.220 and what I want to do is walk you
00:26:30.960 through a few of our practices and
00:26:32.400 questions just to give you an idea of
00:26:34.620 what it will be like on the real exam
00:26:36.299 and where we might have had to make some
00:26:37.919 adjustments to help your study so what
00:26:40.140 you'd have to do to access this prax
00:26:42.120 exam is you'd have to be signed up and
00:26:44.100 logged in to the exam Pro platform make
00:26:46.919 a way over to the hashicorp terraform
00:26:49.080 course except the free tier or pay for
00:26:51.779 full access but once you go there you'll
00:26:54.120 scroll all the way down to the bottom
00:26:55.500 and you should see three or four
00:26:57.240 products exams at the time of writing
00:26:58.740 this we're still writing the questions
00:26:59.640 so that's why they're not shown in the
00:27:01.260 video here but what I want you to do is
00:27:02.880 to go to the first practice exam and
00:27:04.799 notice that there are 57 questions you
00:27:06.720 get an hour on on the exam here and we
00:27:10.020 have a breakdown based on domain now the
00:27:12.000 percentage is not something that uh
00:27:13.679 terraform or hashicorp provides so we
00:27:16.320 just had to break it down based on the
00:27:18.120 coverage of questions that we saw in the
00:27:20.400 exam guide outline and so that should be
00:27:22.140 accurate enough and that's kind of what
00:27:23.700 it felt like on the exam so I don't
00:27:25.440 think that's going to be a problem if we
00:27:27.120 click into here we're just going to look
00:27:28.980 at some of the questions I'll talk
00:27:30.120 around them so the first one here is we
00:27:31.620 have how do you create a workspace and
00:27:33.419 it's showing us a bunch of CLI commands
00:27:35.340 and so on the exam you do need to know
00:27:38.220 um uh you know CLI commands and the
00:27:40.020 difference of them and the questions can
00:27:41.640 be as simple as this where you're just
00:27:43.260 choosing the option and some are obvious
00:27:45.600 distractors like there isn't there is no
00:27:47.640 one called terraform workspace Branch
00:27:49.500 okay so just understand that you not
00:27:51.539 just need to know the conceptual ideas
00:27:53.820 behind terraform but also it in practice
00:27:56.400 okay
00:27:57.539 another one here would be the terraform
00:27:59.279 registry can search based on the
00:28:00.720 following Search terms we have an option
00:28:02.340 to choose multiple questions and so this
00:28:04.980 is something that you will see on the
00:28:06.179 exam where you're choosing multiples of
00:28:08.100 something I didn't get a lot on my exam
00:28:10.080 but I cannot say for certain like how
00:28:11.940 many questions would show up like this
00:28:14.279 um but you know they're not really that
00:28:15.900 hard to figure out okay and this
00:28:18.240 question is about
00:28:19.679 um a tool or sorry uh the public
00:28:22.260 terraform registry website and that is
00:28:24.779 just a uh a public-facing website if we
00:28:28.260 go to
00:28:29.000 registry.terraform.io here it's this
00:28:30.840 website here so it's not just the
00:28:33.059 tooling of terraform itself but it's the
00:28:35.039 ecosystem around it so terraform Cloud
00:28:36.720 the terraform registry things like that
00:28:39.179 another type of question you will see
00:28:40.980 and I think it's over here is what they
00:28:43.500 will do is they'll ask you to fill in
00:28:45.120 the blank now we don't have that support
00:28:46.559 in our platform just as of yet but the
00:28:48.600 idea is they'll say like okay uh we'll
00:28:51.059 ask you a question or we'll even give
00:28:52.620 you
00:28:53.400 um maybe they'll have like underscores
00:28:55.080 they'll say fill in this thing and
00:28:56.760 you'll literally have to type type the
00:28:58.020 answer in but the answer is going to be
00:28:59.940 like a one word answer so on the exam I
00:29:02.520 literally had a question which was like
00:29:03.779 where is the API stored and it was
00:29:05.760 actually terraformed at TF state but I
00:29:07.740 did not know I could not recall the name
00:29:09.779 of it which is kind of embarrassing but
00:29:11.640 uh you know that is the level of
00:29:13.500 fill-ins that you'll have to do and
00:29:15.539 you're very likely to see some code on
00:29:17.700 the on the exam two so if I just click
00:29:20.100 through here really quickly you may see
00:29:22.140 a code block okay and you might have to
00:29:24.659 decipher it so that's the difficulty
00:29:26.820 exam I would not say this is a heart
00:29:28.919 exam but you just have to understand the
00:29:31.020 scope of those kind of questions and
00:29:32.640 make sure that you have well-rounded
00:29:34.200 study in both practical and conceptual
00:29:37.020 concepts of terraform so hopefully that
00:29:38.940 helps you out okay
00:29:40.020 [Music]
00:29:43.980 everybody there it's Andrew Brown and I
00:29:46.140 just wanted to tell you about the
00:29:48.960 content that you're going through
00:29:50.039 because honestly between the zero zero
00:29:52.799 two and zero zero three there was not
00:29:54.419 much to update
00:29:56.220 um and so you know the key differences
00:29:57.960 is the versions of terraform and the
00:30:00.659 versions of the providers that you are
00:30:02.220 using
00:30:03.419 um and for the most part everything
00:30:04.860 worked out perfectly fine I thought that
00:30:07.620 I'd have to reshoot all of the lab
00:30:09.299 content but it turns out nope barely
00:30:12.840 nothing has changed what has changed and
00:30:15.779 I want to point this out early on is
00:30:17.520 that when you are specifying a version
00:30:20.039 for the provider just go use at least
00:30:22.559 version five zero you can use an older
00:30:25.140 version if you want to follow along but
00:30:27.059 uh you know I think it's better to be
00:30:29.399 more um up to date if you can the
00:30:32.640 version that we were using prior in the
00:30:34.919 follow alongs was version three again
00:30:37.080 there are no major changes that will
00:30:39.720 break anything
00:30:41.039 um so at least there shouldn't be but I
00:30:43.380 ran through these Labs my cloud support
00:30:45.299 engineer ran through these Labs so we're
00:30:47.159 pretty confident you're going to be in
00:30:48.539 good shape otherwise if they weren't I
00:30:50.640 would go re-record them but I just
00:30:52.679 wanted to point out those two things uh
00:30:55.020 there so hopefully you know that makes
00:30:57.840 sense and you're going to be in good
00:30:59.520 shape okay now I did say that we're
00:31:02.340 scoping things around terraform 1.6.0
00:31:05.240 and again there's not much to call out
00:31:07.559 for that the biggest thing that I think
00:31:09.299 that 1.6.0 might bring would be testing
00:31:12.600 and even if I looked into it and it just
00:31:15.179 wasn't where I thought it was going to
00:31:16.860 be so I did not include it at least at
00:31:18.840 this time in uh this uh this this course
00:31:21.539 and again this is me going uh above and
00:31:24.179 beyond because I'm trying to just future
00:31:25.679 proof the contents of this course and
00:31:27.659 future proof uh stuff that I believe
00:31:29.460 that is coming to terraform form but
00:31:31.799 yeah you should be in good shape and you
00:31:34.140 know if there are any changes on exam
00:31:36.059 Pro we're very proactive of having those
00:31:38.279 differences there so if you do run into
00:31:39.899 anything that's giving you any kind of
00:31:42.059 issue they're going to be on the the
00:31:43.799 main learning platform there okay if if
00:31:45.899 for whatever reason there's minor
00:31:47.399 updates or things that are found out but
00:31:49.500 yeah you'll be in good shape and have
00:31:51.840 fun on your journey learning terraform
00:31:54.000 ciao
00:31:55.130 [Music]
00:31:59.520 hey this is Andrew Brown from exam Pro
00:32:01.440 and we are looking at what is
00:32:02.820 infrastructure as code and before we
00:32:04.500 talk about that we need to talk about
00:32:05.820 the problem with manual configuration so
00:32:08.399 manually configuring your Cloud
00:32:09.659 infrastructure allows you to easily
00:32:11.460 start using new cloud service offerings
00:32:13.440 to quickly prototype architectures
00:32:15.000 however it comes with a few downsides so
00:32:17.640 it's easy to misconfigure a service
00:32:19.380 through human error it's hard to manage
00:32:21.659 the expected state of the configuration
00:32:23.220 for compliance it's hard to transfer
00:32:25.380 configuration knowledge to other team
00:32:27.059 members and so this is why
00:32:29.100 infrastructure code is going to really
00:32:30.899 help us out so infrastructure is code
00:32:33.299 commonly abbreviated to IAC and you'll
00:32:35.580 see that a lot in this course allows you
00:32:37.799 to write a configuration script to
00:32:39.840 automate creating updating or destroying
00:32:42.240 Cloud infrastructure notice I gave great
00:32:44.340 emphasis on automate or automation
00:32:46.200 because that is really key to
00:32:48.380 infrastructure as code IEC could also be
00:32:51.120 thought of as a blueprint of your
00:32:52.740 infrastructure IEC allows you to easily
00:32:55.380 share version or inventory your Cloud
00:32:57.899 infrastructure and just to kind of get
00:32:59.520 your visualization imagine you write a
00:33:01.740 script and that's going to provision and
00:33:04.980 launch a bunch of cloud services that
00:33:06.960 are all interconnected okay
00:33:08.920 [Music]
00:33:14.039 all right so we're taking a look at
00:33:15.480 popular IAC tools and so of course this
00:33:18.600 course is about terraform but by
00:33:20.039 understanding um all the options out
00:33:22.260 there if you understand why we're using
00:33:23.940 terraform uh and one thing that is very
00:33:26.340 important to understand is the
00:33:27.539 difference between declarative and
00:33:28.679 imperative IAC tools those are the broad
00:33:31.080 categories that we see for IAC so let's
00:33:34.980 start with declarative so the idea here
00:33:37.140 is what you see is what you get
00:33:38.460 everything's explicit it's more verbose
00:33:40.860 but there's zero chance of
00:33:42.179 misconfiguration and this all relies on
00:33:44.340 the fact that they use a scripting
00:33:45.659 language such as Json yaml XML in the
00:33:48.600 case of terraform they have their own
00:33:49.980 language called HCL but the way these
00:33:52.980 languages are structured is that they're
00:33:54.360 very verbose and there's not a lot of
00:33:56.760 programming logic involved so for Azure
00:33:59.519 we have arm templates and Azure
00:34:01.080 blueprints for AWS we have cloud
00:34:03.179 formation for Google we have Cloud
00:34:05.039 deployment manager and there there is of
00:34:07.380 course terraform which has many cloud
00:34:08.879 service providers such as AWS Azure gcp
00:34:11.159 kubernetes and a lot more
00:34:13.739 but these are all in the declarative
00:34:15.418 category
00:34:16.679 on the right hand side we have
00:34:18.000 imperative so you say what you want and
00:34:20.099 the rest is filled in everything here is
00:34:21.659 implicit it's less verbose but you could
00:34:24.418 end up with misconfiguration and when I
00:34:26.280 say that it's that like if you were to
00:34:28.260 find
00:34:29.099 um let's say a virtual machine you might
00:34:30.780 not have to provide every single uh
00:34:33.000 option that you would normally do and it
00:34:35.099 would fill in the rest but if you
00:34:36.300 weren't aware of what it was doing
00:34:37.619 that's where you could end up with
00:34:38.940 misconfiguration uh though I would say
00:34:41.280 that imperative tools generally try to
00:34:43.440 always uh have their defaults as best
00:34:46.800 practices so you're not usually in a bad
00:34:48.480 position uh but you know you might end
00:34:50.580 up with something you don't expect
00:34:52.339 imperative can do more than declarative
00:34:54.719 so there's just some very hard
00:34:56.820 limitations with declarative languages
00:34:59.520 so there's just cases where you want to
00:35:01.740 do imperative and the idea here is
00:35:04.740 imperative languages use programming
00:35:06.660 language you know like python Ruby
00:35:08.400 JavaScript golang you know whatever it
00:35:10.859 is uh there's likely an SDK for it and
00:35:14.220 so it's just a lot more programmer
00:35:16.619 friendly a lot of developers like
00:35:18.060 imperative tools so AWS has their own
00:35:21.240 called Cloud development kit cdk and it
00:35:24.420 technically only supports AWS I say
00:35:27.000 technically because hashicorp has a very
00:35:29.160 cool library that allows you to generate
00:35:31.260 out terraform HCL files which allows you
00:35:33.839 to work with anything but when we're
00:35:35.460 just talking about cdk on its own it's
00:35:36.960 just for AWS then you have plumy it
00:35:39.660 supports AWS Azure gcp and kubernetes so
00:35:43.859 it can do a lot so why would you choose
00:35:45.720 with your team to use declarative over
00:35:47.700 imperative well it just really depends
00:35:49.920 on your your team right so like if
00:35:52.500 they're all used to if they're all
00:35:53.700 administrators and they're used to using
00:35:55.020 Json yaml and they're not good with
00:35:56.280 programming languages that is one reason
00:35:58.859 why you might want to use declarative
00:36:00.180 over imperative the other thing is just
00:36:02.579 you know you prefer to know exactly
00:36:05.280 every single thing that was defined
00:36:07.020 right you don't want anything left up to
00:36:09.920 a chance and so that is another reason
00:36:12.839 why you might want to use declarative
00:36:14.339 but both are great options it's just
00:36:16.200 really depends depends on your team's
00:36:17.940 knowledge and what your goals are okay
00:36:20.300 [Music]
00:36:24.240 so we just looked at imperative and
00:36:26.040 declarative but I just want to clarify
00:36:27.599 that terraform even though it's a
00:36:28.920 declarative language it has
00:36:30.180 imperative-like features so I've coined
00:36:31.800 the phrase declarative plus and so
00:36:33.720 terraform kind of gives you the best of
00:36:35.339 both worlds so you have declarative and
00:36:37.200 imperative and then the three types so
00:36:38.820 our yaml Json XML we have terraform
00:36:41.579 language which actually utilizes HCL
00:36:43.500 underneath and then you have programming
00:36:45.480 languages on the right hand side like
00:36:46.859 Ruby python JavaScript what it have you
00:36:49.380 right so when we're looking at yaml or
00:36:51.839 Json these are very limited languages or
00:36:55.320 scripting languages where uh you know
00:36:57.839 you don't really have any kind of
00:36:59.400 complex data types you probably don't
00:37:01.200 have a whole lot of robust functions but
00:37:04.680 in some cases you can extend That Base
00:37:06.839 Behavior so in the case of cloud
00:37:08.400 formation which uses yaml or Json files
00:37:11.040 they have a concept called macros so you
00:37:13.200 can extend it a bit but again it's very
00:37:15.660 inflexible and so a lot of people are
00:37:18.060 led to go and use cdk so terraform is
00:37:21.180 great because it kind of has a lot of
00:37:23.220 stuff you'd see in programming languages
00:37:24.780 like for Loops Dynamic blocks locals it
00:37:28.140 also has complex data structures and a
00:37:30.420 lot of functions around using those data
00:37:32.640 structures and so it allows you to stay
00:37:34.920 in that declarative world but having the
00:37:36.780 stuff that you generally need when
00:37:37.980 you're in the parative world when you're
00:37:39.720 in the imperative side the idea is that
00:37:42.000 the language is what you're utilizing so
00:37:44.579 you can do anything that the program
00:37:45.839 language allows you to do but I just
00:37:48.180 wanted to kind of show you that
00:37:49.260 terraform sits in the middle okay
00:37:51.250 [Music]
00:37:55.500 hey it's Andrew Brown from exam Pro and
00:37:57.540 we are looking at infrastructure life
00:37:59.579 cycle so what is infrastructure
00:38:01.440 lifecycle it's the idea of having
00:38:03.780 clearly defined and distinct work phases
00:38:05.760 which are used by devops Engineers to
00:38:07.859 plan design build test deliver maintain
00:38:10.320 and retire Cloud infrastructure where
00:38:12.900 we're talking about like sdlc so
00:38:15.119 software development life cycle there's
00:38:16.980 usually a really great visual that I can
00:38:18.780 show for you but for infrastructure
00:38:20.220 lifecycle especially Cloud
00:38:21.900 infrastructure lifecycle there isn't
00:38:23.880 something that is well defined which is
00:38:26.040 weird by the definition but I think that
00:38:28.619 there's just nobody's agreed up on one
00:38:31.020 yet or nobody's made the graphic yet so
00:38:33.180 I just don't have anything to show you
00:38:34.680 for that but I just want you to get
00:38:36.060 familiar with the term infrastructure
00:38:37.800 life cycle because you're likely to hear
00:38:39.780 it again but one particular
00:38:41.700 infrastructure life cycle that is pretty
00:38:43.619 common is ones that talk about day zero
00:38:46.380 day one and day two so the idea here is
00:38:49.440 this is a simplified way to describe
00:38:51.000 phases of infrastructure life cycle so
00:38:53.220 when we say we are on day Zero we are
00:38:55.440 planning and designing our
00:38:57.660 infrastructure on day one we are
00:39:00.240 developing and iterating it so we might
00:39:01.920 be uh you know deploying or provisioning
00:39:04.619 it and actually testing it uh in the
00:39:06.180 cloud and then day two is actually when
00:39:08.040 we go live with real production users
00:39:10.140 and maintain it and the idea of
00:39:12.660 mentioning day zero one and two is to
00:39:14.400 say Well when does IAC start and the
00:39:17.460 idea is it starts on Day Zero okay the
00:39:20.280 days do not literally mean a 24 hour day
00:39:22.680 it's just a broad way of defining where
00:39:25.200 in the infrastructure project we would
00:39:27.000 be okay
00:39:28.420 [Music]
00:39:33.480 so after defining what infrastructure
00:39:36.000 life cycle is what advantage or what an
00:39:39.359 advancement are we going to have when we
00:39:41.040 add IAC to our infrastructure lifecycle
00:39:43.320 well the first thing we're going to get
00:39:44.460 is reliability so IC makes changes
00:39:47.339 impotent consistent repeatable and
00:39:50.040 predictable I'm going to give extra
00:39:51.540 attention here to impotent because it is
00:39:53.280 a very strange English word but no
00:39:56.160 matter how many times you run your IC
00:39:58.380 you will always end up with the same
00:40:00.420 state that is expected that is a very
00:40:02.640 important concept of IEC whereas if you
00:40:05.160 use configuration management there's no
00:40:06.839 guarantee of that that's why you use
00:40:08.579 terraform over something like ansible
00:40:10.980 okay you have manageability so enable
00:40:13.859 mutation via code revise with minimal
00:40:16.740 changes and then you have sensibility so
00:40:18.660 avoid financial and reputational losses
00:40:21.060 to even loss of life when considering
00:40:23.820 government and Military dependencies on
00:40:25.800 infrastructure so there you go
00:40:27.700 [Music]
00:40:32.400 okay so it impotent is a very important
00:40:35.760 concept to infrastructure as code and so
00:40:38.640 we're going to give it a little bit more
00:40:39.599 attention I wouldn't stress out about
00:40:41.220 the pronunciation uh there's more than
00:40:43.440 one way to pronounce it in English and
00:40:45.180 I've probably even said it wrong uh in
00:40:47.760 the previous slide so uh just be uh
00:40:51.000 forgiving on that part okay but the idea
00:40:53.880 is that let's stage a scenario between a
00:40:57.180 non-itipotent example and an independent
00:40:59.820 example so when I deploy my IAC config
00:41:03.480 file it will provision and launch two
00:41:05.520 virtual machines that is what I'm
00:41:06.960 expecting okay and that is what I get
00:41:09.599 but what happens when I go and I update
00:41:12.240 this infrastructure code file saying
00:41:14.160 maybe I want to increase the size of the
00:41:16.020 VMS or some of the configuration I
00:41:18.480 deploy that again when it's
00:41:20.480 non-edepotent what will end up happening
00:41:23.099 is I will end up with two additional
00:41:25.200 virtual machines with the new
00:41:26.460 configuration and the old ones will be
00:41:28.560 there and so this is something you might
00:41:30.660 not want because you just want to have a
00:41:33.240 file that says exactly the state that
00:41:35.460 you expect okay
00:41:37.440 so when we have something that is Idi
00:41:39.420 potent the idea is we will go and we
00:41:42.480 will Define our two virtual machines and
00:41:45.240 we will get our two virtual machines but
00:41:46.980 we go and we update that file and we
00:41:49.380 deploy again and what happens this time
00:41:51.420 is it just ends up modifying the
00:41:53.880 original virtual machines or if it
00:41:56.040 really can't and it has to it might
00:41:57.660 delete them and recreate them but the
00:41:59.700 idea is that we end up in a state of
00:42:01.740 exactly what we want so in the first
00:42:03.000 case we expect it to but we ended up
00:42:05.280 with four but with the independent uh
00:42:08.339 case we expected to and we always end up
00:42:10.920 with two so hopefully that makes that
00:42:13.380 very clear okay
00:42:14.540 [Music]
00:42:19.619 hey this is Andrew Brown from exam Pro
00:42:21.599 and what I want to do here is concretely
00:42:23.760 Define the difference between
00:42:24.900 provisioning deployment and
00:42:26.400 orchestration now in practice sometimes
00:42:29.220 these have overlapping responsibility so
00:42:31.980 you might say provisioning when you
00:42:33.839 really mean deployment or vice versa
00:42:35.579 it's not a big deal uh we all get kind
00:42:38.460 of mixed up about it but I did want to
00:42:40.440 just take the time to make sure that we
00:42:42.060 understand what these things are
00:42:43.500 supposed to mean okay so the First on
00:42:45.599 our list here is provisioning so to
00:42:47.220 prepare a server with systems data and
00:42:49.260 software and then make it ready for
00:42:51.060 Network operation if you're using a
00:42:53.040 configuration management tool you are
00:42:55.140 most likely provisioning because that's
00:42:56.880 what these tools do so puppet ansible
00:42:58.740 Chef bash scripts Powershell or cloudnit
00:43:01.200 so you can provision a server when you
00:43:03.480 launch a cloud service and configure it
00:43:05.640 you are provisioning it okay then you
00:43:08.460 have deployments the deployment is the
00:43:10.140 act of delivering a version of your
00:43:12.540 application to run a provision server
00:43:15.000 deployment could be performed via AWS
00:43:17.520 code pipeline harness which is a
00:43:19.579 third-party deployment tool Jenkins
00:43:22.260 GitHub action Circle CI there's a lot
00:43:24.599 more other providers out there then you
00:43:26.880 have orchestration so orchestration is
00:43:28.740 the active coordinating multiple systems
00:43:30.599 or Services orchestration is a common
00:43:33.060 term when working with microservices
00:43:34.560 containers and kubernetes so
00:43:36.720 orchestration could be done with
00:43:38.460 kubernetes salt or fabric so if you're
00:43:40.680 working with containers generally like
00:43:42.900 you use the word orchestration
00:43:44.160 especially with kubernetes because
00:43:45.359 you're working with thousands of
00:43:47.480 microservices okay so you know hopefully
00:43:50.220 that helps you know the difference
00:43:52.319 between the three again it's not a big
00:43:53.880 deal if you don't perfectly know them
00:43:55.740 but there you go
00:43:57.350 [Music]
00:44:01.680 hey this is Andrew Brown from exam Pro
00:44:03.660 and we are taking a look at
00:44:04.980 configuration drift so this is when
00:44:06.960 provision infrastructure has an
00:44:08.880 unexpected configuration change due to
00:44:11.579 team members manually adjusting
00:44:13.079 configuration options malicious actors
00:44:15.540 so maybe they're trying to cause
00:44:17.280 downtime or breach data or side effects
00:44:20.339 from apis sdks or CLI so you've written
00:44:24.180 some code that uses a CLI and a bash
00:44:26.099 script and it does something you did not
00:44:28.440 expect to happen so here an example
00:44:31.200 could be imagine you have a server like
00:44:33.720 a database and a junior developer turns
00:44:36.240 off delete on termination for your
00:44:38.640 production database this could be a
00:44:40.440 problem where let's say there's an
00:44:42.119 accidental deletion of the database this
00:44:45.480 feature would protect the database from
00:44:47.220 deletion but if it's turned off you
00:44:48.660 don't have that right so configuration
00:44:50.700 drift going unnoticed could be a loss or
00:44:53.520 breach of cloud services and residing
00:44:55.980 data will result in Interruption of
00:44:57.420 services or unexpected downtime so
00:44:59.160 there's a lot of
00:45:00.440 downsides to to neglecting or not
00:45:03.359 noticing configuration drift so what can
00:45:05.460 we do about this so how to detect so
00:45:08.400 there's three things detect
00:45:10.079 um we can fix it and then prevent it
00:45:12.540 okay so to detect configuration drift if
00:45:14.940 you have a compliance Tool uh it can
00:45:17.099 detect misconfiguration so it was config
00:45:19.260 can do that as your policies can do that
00:45:21.480 gcp security health analytics can do
00:45:23.700 that some of these are constrained to
00:45:26.420 security things not just configuration
00:45:29.640 in general but there are tools there for
00:45:32.760 all the cloud service providers there is
00:45:35.160 built-in support for drift detection for
00:45:37.079 it was cloud formation it's called cloud
00:45:38.940 formation drift detection other
00:45:41.700 providers don't necessarily have that if
00:45:44.220 you're using terraform which is this
00:45:45.900 which is all this course is about you
00:45:48.000 have the terraform State files which
00:45:50.099 says what the state of things should be
00:45:52.140 so that's how you could detect
00:45:53.819 configuration drift how to correct
00:45:56.579 configuration drift well compliance
00:45:58.619 tools can remediate so again it is
00:46:00.839 config you can create a custom Lambda to
00:46:02.819 say hey when this happens then do this
00:46:05.579 so set the configuration back into place
00:46:07.500 with terraform you can use the refresh
00:46:09.780 and plan command which we'll look at in
00:46:12.300 detail in this course or you can
00:46:14.579 manually correct it so if the option was
00:46:16.859 changed you could do that not
00:46:18.240 recommended to do that
00:46:19.800 another thing would be tearing down and
00:46:21.599 setting up the infrastructure again
00:46:22.800 because that would bring it back into
00:46:24.300 its original state that could be a risky
00:46:27.060 thing to do depending on how you have
00:46:29.579 things set up or could be it could be
00:46:31.740 fine right then there's prevention so
00:46:34.380 um this is a the important thing and
00:46:36.480 kind of why we're talking about
00:46:37.380 configuration drift which is all about
00:46:39.180 immutable infrastructure so always
00:46:40.740 create and just destroy never reuse so
00:46:43.560 that might be blue green deployment
00:46:44.940 strategies servers are never modified
00:46:47.760 they are all they're just always
00:46:49.560 deployed with a new version the way you
00:46:51.720 would do that would be baking Ami images
00:46:53.700 or containers via AWS image Builder or
00:46:56.880 hashicor Packer or a build server like
00:46:59.040 gcp Cloud run or code build like AWS but
00:47:03.300 the idea is that you're not modifying
00:47:05.099 after they're deployed you'd have that
00:47:06.960 image already ready to go another thing
00:47:09.180 you could use is git Ops so you would
00:47:11.940 Version Control your IAC like within
00:47:14.760 GitHub or something like that and you
00:47:16.560 would peer review every single uh change
00:47:19.560 the a pull request to the infrastructure
00:47:21.780 so hopefully that gives you an idea of
00:47:23.400 things we can do to tackle configuration
00:47:26.400 drift okay
00:47:27.200 [Music]
00:47:31.500 we were just talking about immutable
00:47:33.359 infrastructure but I just want to give
00:47:35.099 it a bit more attention here so the idea
00:47:38.400 is
00:47:39.480 um we are going to first develop our
00:47:42.359 infrastructure as a code file terraform
00:47:44.220 cloudformation what have you and then
00:47:46.260 we're going to go ahead and deploy that
00:47:48.240 so we'll end up with our own virtual
00:47:50.339 machine and that virtual machine needs
00:47:52.440 to be configured so you need to install
00:47:53.640 packages and things like that that's
00:47:55.500 where Cloud init would come into play
00:47:57.000 ansible puppet Chef salt whatever
00:47:59.400 configuration management tool you want
00:48:01.020 to use the problem here is that there's
00:48:04.200 no guarantee that that configuration is
00:48:05.760 going to stay in place so that's where
00:48:08.640 immutable infrastructure comes into play
00:48:10.140 so we develop our infrastructure as a
00:48:13.260 code file terraform cloud formation and
00:48:16.079 then we're going to go ahead and do our
00:48:17.940 configuration by building a virtual
00:48:20.400 machine or building a container so we
00:48:22.500 can use something like Packer and then
00:48:24.599 the idea is once we are happy with our
00:48:26.460 configuration what we're going to do is
00:48:29.099 bake that image and put it in an image
00:48:31.500 repository and then that image is going
00:48:34.260 to be referenced when we do our deploy
00:48:36.540 and so that's going to make sure that
00:48:37.859 our infrastructure is always immutable
00:48:39.599 okay
00:48:40.680 [Music]
00:48:44.880 hey this is Andrew Brown from exam Pro
00:48:46.859 and we are taking a look at the concept
00:48:48.780 or methodology of git Ops so this is
00:48:51.119 when you take infrastructure as code and
00:48:53.400 you use a git repository to introduce a
00:48:56.220 formal process to review and accept
00:48:58.020 changes to infrastructure code and once
00:49:00.480 that code is accepted it automatically
00:49:02.040 triggers a deploy and changes that
00:49:04.500 infrastructure so here's my illustration
00:49:07.020 through it so the idea is you would have
00:49:08.940 a terraform file and you would place
00:49:11.400 that in something like GitHub you would
00:49:13.380 apply your commits and when you're ready
00:49:15.119 you'd make a pull request you would
00:49:17.099 merge that pull request into the main
00:49:19.200 branch or whichever branch is set up for
00:49:21.240 production and that could trigger
00:49:23.339 something like GitHub actions and GitHub
00:49:26.040 actions would then trigger a terraform
00:49:28.579 plan and and accept it or maybe you have
00:49:31.619 to manually intervene to say Okay I
00:49:33.359 accept these changes but then it would
00:49:35.400 roll out those changes now terraform
00:49:37.740 does have their own and it's pretty darn
00:49:39.359 similar but I thought mine was a bit
00:49:40.980 easier to read but the idea is you have
00:49:42.839 your git repository you have your pull
00:49:45.060 request this is pulling from terraform
00:49:47.400 Cloud because you can have files and
00:49:50.579 state managed there so that is another
00:49:53.280 means to do it but that's generally how
00:49:55.380 it works okay
00:49:58.140 foreign
00:49:59.540 [Music]
00:50:00.839 so we were just looking at immutable
00:50:02.520 infrastructure but what I want to do is
00:50:04.319 just kind of cement in your head things
00:50:05.940 that you should be asking yourself as a
00:50:08.700 devops engineer so that you kind of lean
00:50:10.980 towards that immutable uh kind of way of
00:50:14.579 thinking and so this is mostly going to
00:50:16.680 be applicable for virtual machines but
00:50:18.960 let's just ask some questions of things
00:50:20.460 we should be thinking about so what's
00:50:22.619 going to happen if we deploy our virtual
00:50:24.599 machine and there is a physical failure
00:50:26.700 of the hardware by the provider so this
00:50:29.040 can sometimes happen on AWS where they
00:50:30.839 have two status checks that have to
00:50:32.760 complete before a virtual machine is
00:50:34.619 ready sometimes they fail and so you
00:50:36.839 know your infrastructure is not ready to
00:50:38.819 graded or damaged right then you have
00:50:41.520 application failure so you have this
00:50:43.859 post installation script maybe to
00:50:45.960 install your application and there's
00:50:48.599 either a bug so introduced by developer
00:50:50.900 or maybe there's just a dependency and
00:50:54.119 it's changed and so it's breaking your
00:50:56.040 app what happens when you need to deploy
00:50:58.559 in a hurry what have happens in worst
00:51:01.559 case scenarios where you have accidental
00:51:03.059 deletion compromised by malicious actor
00:51:05.220 need to change regions maybe there's a
00:51:06.960 region outage and so the thing is is
00:51:09.720 that when you look at these things what
00:51:11.040 happens when multiples of these happen
00:51:13.319 at the same time because that's the
00:51:14.940 problem where you know it's like okay I
00:51:16.800 have something wrong with my application
00:51:18.240 code but I also have uh you know now we
00:51:21.960 also have a region down and so you don't
00:51:24.059 want to be dealing with more than one
00:51:25.500 problem at the same time and so that's
00:51:26.940 we're going to have an issue of agility
00:51:28.500 in terms of deployment another thing
00:51:30.839 that is overlooked is there's no
00:51:32.400 guarantee of one to one if you are
00:51:34.280 configuring your code after deployment
00:51:36.800 because if you were to deploy a virtual
00:51:40.859 machine
00:51:41.760 and installed all the dependencies and
00:51:45.059 then you to were to deploy a virtual
00:51:46.920 machine literally a minute later one of
00:51:48.599 those dependencies could have a minor
00:51:50.640 revision and so that would be deployed
00:51:52.680 with that one minor revision so they
00:51:54.359 would look very similar but they aren't
00:51:55.859 one to one so by introducing golden
00:51:57.839 images which is an immutable
00:51:59.220 infrastructure idea you get a guarantee
00:52:01.200 of one one to one with your Fleet you
00:52:03.240 have increased Assurance of consistency
00:52:04.740 security you have you can speed up your
00:52:07.200 deployments the reason why you have an
00:52:08.579 improvement of security is because at
00:52:10.740 that stage you could
00:52:12.240 um you could perform kind of Security
00:52:14.099 checks and things like that there on
00:52:15.720 that image before you roll it out so I
00:52:18.900 don't know um I would just say that I
00:52:20.760 would recommend that you go with the
00:52:22.680 immutable infrastructure or baking your
00:52:24.119 images when you can if you're using VMS
00:52:25.859 okay
00:52:26.240 [Music]
00:52:30.599 hey this is Andrew Brown from exam Pro
00:52:32.520 and we're going to take a look here at
00:52:33.720 what is hashicorp so hashicorp is who
00:52:36.359 creates terraform and they are a company
00:52:38.280 specializing in managed open source
00:52:40.140 tools used to support the deployment and
00:52:41.940 development of large-scale service
00:52:43.619 oriented software installations and they
00:52:45.720 have their own cloud platform called the
00:52:47.819 hashicorp cloud platform hcp and it's a
00:52:50.160 unified platform to access hashicorp
00:52:52.140 various products so uh the main thing is
00:52:55.020 that it's Cloud agnostic so hashicorp
00:52:57.240 makes it really easy to build across
00:52:58.800 cloud and they have support for all the
00:53:01.079 three main providers so AWS gcp Azure
00:53:03.660 I'm sure they have more support like
00:53:05.520 kubernetes and things like that they're
00:53:07.559 highly suited for multi-cloud workloads
00:53:09.960 or cross-cloud workloads and they have a
00:53:12.300 lot of products that will help you out
00:53:13.920 there so let's go through them quickly
00:53:15.240 so first we have boundary this is secure
00:53:17.220 remote access to systems based on
00:53:19.079 trusted identity this is console this is
00:53:21.420 a full featured service mesh for secure
00:53:23.220 service segmentation across any cloud or
00:53:25.200 runtime environment you have Nomad this
00:53:27.420 is scheduling and deployment of tasks
00:53:29.160 across worker nodes in a cluster you
00:53:31.319 have Packer which is a tool for building
00:53:33.000 virtual machine images that will be
00:53:35.280 later deployed or they will place them
00:53:37.200 in a image repository then you have
00:53:39.420 terraform which is infrastructure as
00:53:41.339 code software which enables provisioning
00:53:43.500 and adapting virtual infrastructure
00:53:45.180 across all major providers then you have
00:53:47.400 terraform cloud and this is just a place
00:53:49.740 to store and manage your IAC State files
00:53:53.099 and things like that with a team or just
00:53:55.200 in the cloud by yourself we have vagrant
00:53:57.300 so building and building and maintenance
00:53:59.579 of reproducible software development
00:54:01.260 environments via virtualization
00:54:03.000 technology we have Vault so secret
00:54:05.700 management identity based access
00:54:07.619 encrypting application data auditing of
00:54:09.960 Secrets for application systems and
00:54:11.520 users and lastly we have Waypoint a
00:54:14.220 modern workflow to build deploy and
00:54:15.839 release across multiple platforms so
00:54:19.200 there you go
00:54:20.080 [Music]
00:54:24.420 hey this is Andrew Brown from exam Pro
00:54:26.280 and we are looking at what is terraform
00:54:28.380 so terraform is an open source and Cloud
00:54:30.660 agnostic infrastructure as a code tool
00:54:32.700 and terraform uses declarative
00:54:34.800 configuration files and the
00:54:36.780 configuration files are written in the
00:54:38.400 hashicorp configuration language HCL and
00:54:41.700 so that's what you can see on the right
00:54:43.200 hand side we'll generally call it the
00:54:45.300 terraform language which we'll talk
00:54:46.680 about later but notable features of
00:54:48.900 terraform are installable modules plan
00:54:51.240 and predict changes dependency graphing
00:54:53.339 State Management and provisioning
00:54:55.440 infrastructure in familiar languages
00:54:57.000 that's something you could do via AWS
00:54:59.460 cdk so I wouldn't say it's core to
00:55:02.579 terraform but that's what they listed on
00:55:04.020 their websites that's why I put in there
00:55:05.220 and terraform registry which has over 1
00:55:07.800 000 plus providers okay so there we go
00:55:11.150 [Music]
00:55:15.780 so we were just looking at terraform but
00:55:18.059 what is terraform Cloud well it's a
00:55:20.040 software as a service offering for
00:55:21.780 remote State Storage Version Control
00:55:23.579 Integrations flexible workflows and
00:55:26.280 allows you to collaborate on
00:55:27.300 infrastructure changes within a single
00:55:29.460 unified web portal and this is all
00:55:31.380 accessible via terraform.io and the
00:55:35.160 first thing you'll have to do is create
00:55:36.300 yourself an account on terraform i o but
00:55:38.400 it's free to start with and they
00:55:39.839 actually have a very generous free tier
00:55:41.640 that allows for team collaboration for
00:55:43.740 the first five users of your
00:55:45.059 organization that's not part of the
00:55:46.500 team's plan that's part of the free plan
00:55:48.300 and in the majority of cases you really
00:55:50.700 should be using terraform Cloud as your
00:55:52.859 remote backend even if you are an
00:55:54.839 individual just because you know it
00:55:57.059 makes experience so much better the only
00:55:59.280 case that you might not want to use
00:56:00.780 terraform cloud is if you have a very
00:56:03.119 large company that's trying to meet
00:56:04.980 particular regulatory requirements and
00:56:07.200 it's not that terraform Cloud does not
00:56:09.359 meet them but sometimes there's just a
00:56:11.460 long procurement process so in the
00:56:13.920 meantime you would have to use something
00:56:15.059 like standard remote back end or
00:56:16.859 Atlantis or maybe you need to
00:56:18.300 investigate terraform Enterprise I do
00:56:20.579 want to note that terraform cloud and
00:56:22.980 terraform Enterprise is the underlying
00:56:24.960 software known as terraform platform
00:56:26.760 it's not something you're going to ever
00:56:27.960 have direct access to but just to
00:56:30.480 clarify that terminology okay
00:56:32.880 [Music]
00:56:37.319 so what I want to do is just set you up
00:56:39.660 with understanding the terraform life
00:56:41.819 cycle this is not necessarily uh
00:56:44.160 described in the documentation anywhere
00:56:45.900 but it's something that is inherently
00:56:47.940 known when you're working with terraform
00:56:50.160 uh and it's definitely not uh inclusive
00:56:53.220 with every single command that can be
00:56:55.079 ran but the ones that you're going to
00:56:56.640 counter most often so at the start
00:56:58.619 you're going to be writing or updating
00:57:00.599 your terraform configuration file okay
00:57:02.640 and from there the first thing you'll
00:57:04.859 want to do is initialize your projects
00:57:07.559 and or if you need to pull the latest
00:57:10.260 providers and modules you're going to
00:57:11.880 use terraform indit to do that as well
00:57:13.500 from there you're going to use plan so
00:57:15.599 plan allows you to speculate what will
00:57:17.760 change or generate a saved execution
00:57:19.800 plan that you could use later on when
00:57:22.079 you run plan validate happens
00:57:23.700 automatically but you could also run
00:57:25.440 this separately and ensures types and
00:57:27.540 values are valid ensures the required
00:57:29.700 attributes are present within your
00:57:31.140 configuration file from there if
00:57:33.300 everything is good you're going to
00:57:34.740 execute your execution plan by running
00:57:37.920 terraform apply you can also from this
00:57:40.980 point use terraform apply to destroy
00:57:42.780 infrastructure so if you have things set
00:57:44.160 up there's actually a flag for it or you
00:57:45.960 can use the Alias the terraform destroy
00:57:47.760 command and then you know as you work
00:57:50.339 you're just going to keep updating your
00:57:51.480 code and that is the terraform life
00:57:53.460 cycle so you know hopefully this gives
00:57:55.380 you kind of a a snapshot of what the
00:57:58.200 workflow will be and I mean we'll be
00:58:00.720 covering it tons and tons of times over
00:58:02.760 in this course okay foreign
00:58:04.400 [Music]
00:58:08.880 hey this is Andrew Brown from exam Pro
00:58:10.859 and we are taking a look at change
00:58:12.660 automation but to understand that we
00:58:14.760 need to first talk about change
00:58:15.960 management so this is a standard
00:58:17.760 approach to apply change and resolving
00:58:19.440 conflicts brought about by change in the
00:58:21.839 context of IAC change management is the
00:58:24.059 procedure that will be followed when
00:58:25.859 resources are modified and applied via
00:58:27.720 configuration scripts so what is change
00:58:29.940 automation then it is a way of
00:58:31.619 automatically creating a consistent
00:58:33.059 systematic and predictable way of
00:58:35.160 managing change requests via control and
00:58:37.559 policies notice and I should have
00:58:39.540 probably emphasized this is change
00:58:40.859 requests saying I'm going to change
00:58:42.599 these resources terraform uses change
00:58:45.119 Automation in the form of execution
00:58:46.920 plans and resource graphs which will
00:58:48.960 look at detail those two things in
00:58:51.000 upcoming slides and apply review complex
00:58:53.400 change sets so a change set is a
00:58:55.920 collection of commits that represents
00:58:57.540 changes made to a versioning repository
00:58:59.700 and for IEC uses change sets so you can
00:59:03.299 see what has changed by who over time so
00:59:06.960 when I say versioning repository that
00:59:08.700 doesn't necessarily mean get and if
00:59:11.099 you're using get Ops I suppose you could
00:59:12.720 consider your chain sets being committed
00:59:14.520 to that but something like cloud
00:59:16.200 formation when you apply a change you
00:59:19.619 actually have to accept a change Set uh
00:59:21.839 and so the version repository is part of
00:59:23.640 AWS and so um it will terraform you just
00:59:26.760 kind of accept it in place it's not
00:59:28.200 necessarily on your local machine but I
00:59:31.260 guess reflecting your state file okay so
00:59:33.299 change automation allows you to know
00:59:34.980 exactly what terraform will change and
00:59:36.720 in what order avoiding many possible
00:59:38.460 human errors a change automation is
00:59:40.980 essential to any IAC tool they all have
00:59:43.380 it okay so there we go
00:59:44.900 [Music]
00:59:49.920 this is Andrew Brown from exam Pro and
00:59:51.540 we are taking a look at execution plans
00:59:53.579 so this is a manual review of what will
00:59:55.799 add change or destroy before you apply
00:59:57.720 changes and so let's say you type in
00:59:59.940 terraform apply it's not just going to
01:00:01.619 go ahead and do that it's going to have
01:00:03.240 you uh type in yes or accept the value
01:00:05.640 but what you can do is see the resources
01:00:08.099 or configuration settings that will be
01:00:09.660 added changed or destroyed and it will
01:00:11.640 summarize them at the bottom and then
01:00:13.440 you'll have to type something like yes
01:00:15.119 in order to accept the changes okay
01:00:17.560 [Music]
01:00:21.900 something else I want to show you is
01:00:23.640 that you can actually visualize your
01:00:25.200 execution Plans by using the terraform
01:00:27.599 graph command and terraform will output
01:00:29.520 a graph of his file you'll have to have
01:00:31.559 graph Vis installed but Graphics is an
01:00:33.960 open source tool for drawing graphs
01:00:35.640 specified in the dot language scripts
01:00:37.559 having the file name extension of GV so
01:00:41.099 I believe this is cross-platform it's
01:00:42.960 open source but once it's installed in
01:00:45.000 your machine you can run terraform graph
01:00:47.040 and here this is Linux so we're using a
01:00:49.319 pipe to say okay pass it over to graphis
01:00:51.540 which is Dot and that is going to then
01:00:54.180 create an SVG file you can just open
01:00:56.280 that in your browser and the idea is
01:00:58.200 you're going to get this graph which
01:00:59.220 kind of shows you the relationship of
01:01:00.780 the resources here but we'll talk about
01:01:03.059 the these relationships in the next
01:01:05.040 slide here which is a resource graph
01:01:07.020 okay
01:01:07.550 [Music]
01:01:12.119 let's take a look here at the resource
01:01:14.220 graph so terraform builds a dependency
01:01:16.140 graph from the terraform configurations
01:01:17.940 and walks this graph to generate plans
01:01:20.280 refresh rate and more when you use
01:01:22.380 terraform graph this is a visual
01:01:24.599 representation or presentation of the
01:01:26.819 dependency graph if you're wondering
01:01:28.140 what a dependency graph is in
01:01:29.700 mathematics it's a directed graph
01:01:31.319 representing dependencies of several
01:01:33.119 objects towards each other so it's
01:01:34.980 pretty much like nodes with
01:01:37.079 relationships between other nodes so
01:01:39.540 that is one that I generate out from
01:01:41.880 terraform and so there's a few different
01:01:43.680 types here we have a resource node that
01:01:45.359 represents a single resource a resource
01:01:47.819 meta node represents a group of
01:01:49.680 resources but does not represent any
01:01:51.480 action on its own and provider
01:01:53.220 configuration nodes that represents the
01:01:54.960 time to fully configure a provider will
01:01:57.660 you need to know this for the exam
01:01:58.740 probably not do you need to know this in
01:02:00.720 great detail probably not because
01:02:02.040 there's a lot to the resource graph but
01:02:04.319 the idea here is just kind of like
01:02:05.700 terraform saying just so you know we're
01:02:07.740 using a graph database and graph
01:02:09.599 databases are very well suited for this
01:02:11.880 kind of stuff and that's why terraform
01:02:14.640 is very good at figuring out conflicts
01:02:17.460 and things like that okay
01:02:19.440 foreign
01:02:22.750 [Music]
01:02:24.319 from exam Pro and we are taking a look
01:02:26.819 at terraform use cases and the idea here
01:02:28.920 is not necessarily because it's going to
01:02:30.599 show up in the exam but the idea is to
01:02:32.339 give you a business use case or to
01:02:33.839 highlight the features as to why you'd
01:02:35.520 want to be using terraform and the first
01:02:37.559 one here is that it has exotic providers
01:02:39.839 so terraform supports a variety of
01:02:42.059 providers outside of gcp AWS and Azure
01:02:44.520 and sometimes is the only provider
01:02:46.200 terraform is open source and extendable
01:02:48.299 so any API could be used to create IC
01:02:51.000 tooling of any kind of cloud platform or
01:02:52.920 technology so you can make your own
01:02:54.119 provider there's some interesting ones
01:02:55.980 that they have like Heroku or even
01:02:57.480 Spotify playlists I have my own platform
01:02:59.400 called teacher seat and I want to have
01:03:01.200 IAC for my platform and so this is what
01:03:04.680 I'm going to be using terraform for for
01:03:06.720 multi-tier applications terraform by
01:03:08.400 default makes it easy to divide large
01:03:10.319 and complex applications into isolate
01:03:12.240 configuration script modules you'll
01:03:13.920 notice in this course that when you have
01:03:16.260 a bunch of terraform files they're all
01:03:17.460 treated as one so that makes it really
01:03:19.559 easy to split up your uh your projects
01:03:22.020 or your your infrastructure so so it has
01:03:24.720 a complexity advantage over Cloud native
01:03:26.579 IC tools for its flexibility while
01:03:28.200 retaining Simplicity over imperative
01:03:30.299 tools then we have disposable
01:03:32.280 environments this is not unique to
01:03:34.079 terraform it's any kind of ISE tool but
01:03:36.359 easily stand up an environment for a
01:03:37.859 software demo or a temporary developer
01:03:39.839 environment resource schedulers so
01:03:41.819 terraform is not just defined to
01:03:43.799 infrastructure of cloud resources but
01:03:45.420 can be used to set Dynamic schedules for
01:03:48.780 Docker containers Hadoop spark and other
01:03:51.359 software tools you can provision your
01:03:53.339 own scheduling grid and the last one
01:03:55.619 here is multi-cloud deployment terraform
01:03:57.480 is cloud agnostic and allows a single
01:04:00.240 configuration to be used to manage
01:04:02.099 multiple writers and to even handle
01:04:04.140 cross-cloud dependencies and that is a
01:04:06.299 big deal and is a very unique offering
01:04:08.640 to terraform okay
01:04:10.230 [Music]
01:04:14.880 let's take a look here at terraform core
01:04:16.740 and terraform plugins so terraform is
01:04:19.200 logically split into two main parts
01:04:21.180 terraform core which uses remote
01:04:23.400 procedure calls RPC to communicate with
01:04:25.559 terraform plugins and terraform plugins
01:04:27.839 so expose an implementation for a
01:04:30.059 specific service or provisioner
01:04:32.220 something that's interesting to know is
01:04:34.440 just terraform core is written in go
01:04:37.799 um you know you probably will never
01:04:39.059 encounter it but it's just a fact okay
01:04:41.880 and so here's the graphic that terraform
01:04:43.980 uses to kind of like explain terraform
01:04:46.440 core versus terraform plugins and how
01:04:49.079 they all relate so here's the terraform
01:04:51.599 core and here are the plugins notice we
01:04:54.480 have providers here which will cover
01:04:56.480 provisioners uh and there's just this is
01:04:59.460 the group for plugins overall
01:05:01.859 um but yeah that's about it we'll show
01:05:03.900 up an exam probably not but it's good to
01:05:05.700 understand from a top level view the
01:05:08.160 split between these two things okay
01:05:09.590 [Music]
01:05:14.040 if you are new to terraform I just
01:05:16.260 wanted you to be aware of an additional
01:05:18.599 resource that you can use Beyond this
01:05:20.280 course which is called terraform up and
01:05:22.559 running so it's a a book and it has a
01:05:26.099 deep dive into the internal workings of
01:05:27.780 terraform and this is really great if
01:05:29.460 you want to go beyond this course Beyond
01:05:31.319 certification beyond the basics because
01:05:33.540 what it will do is teach you about
01:05:34.920 testing with terraform Cloud zero
01:05:37.319 downtime deployment common terraform
01:05:39.780 gotchas and compositions of production
01:05:42.359 grade terraform code there's a lot more
01:05:44.160 to it and this book in particular is
01:05:46.380 written by Jim who's the co-founder of
01:05:48.240 grunt work and we do have a whole
01:05:50.160 section just on grunt work and the thing
01:05:53.099 is I just want you to know about this
01:05:54.839 resource you definitely don't need it to
01:05:57.000 pass a certification or to have a good
01:05:59.819 understanding or working of terraform
01:06:01.559 but you know at some point you if you
01:06:03.420 want more I just want to point you to
01:06:04.980 that resource okay
01:06:06.500 [Music]
01:06:10.740 there's one other resource I want you to
01:06:12.780 check out for terraform and this one is
01:06:14.760 free and just online and it's the
01:06:16.680 terraform best practices so it's an open
01:06:18.900 book it's a get book so it's essentially
01:06:21.480 a Wiki and it basically covers the best
01:06:24.059 practices that are being used in the
01:06:25.980 industry and so this is stuff that is
01:06:27.599 separate from the terraform
01:06:28.980 documentation it's just good practices
01:06:31.680 you know if you're going to be using
01:06:33.599 terraform professionally within the
01:06:35.819 industry so I just wanted to make you
01:06:37.200 aware of this resource and to go check
01:06:39.000 it out okay
01:06:40.260 foreign
01:06:43.580 [Music]
01:07:24.180 foreign
01:07:27.480 [Music]
01:07:41.280 hey this is Andrew Brown from exam Pro
01:07:43.140 and we are taking a look at terraform
01:07:44.760 provisioners so provisioners install
01:07:46.619 software edit files and provision
01:07:48.299 machines created with terraform and
01:07:50.280 terraform allows you to work with two
01:07:51.720 different provisioners we have Cloud net
01:07:53.339 and Packer so Cloud init is an industry
01:07:55.799 standard for cross-platform cloud
01:07:57.900 instance initialization when you launch
01:08:00.059 a VM on a cloud service provider you'll
01:08:02.280 provide either a yaml or Bass script and
01:08:05.160 so for the case of AWS what you'll have
01:08:07.980 is this box called user data and so you
01:08:09.900 can either put your yaml or Bass script
01:08:11.640 in there it's the same if you're using
01:08:13.319 Google or Azure they both have this box
01:08:15.599 it might just not be called user data
01:08:17.339 but that is using Cloud init underneath
01:08:19.859 then you have Packer this is an
01:08:21.600 automated image Builder service you
01:08:23.219 provide a configuration file to create
01:08:24.719 and provision the machine image and the
01:08:26.399 image is then delivered to repository
01:08:28.259 for use if you've ever heard of ec2
01:08:30.779 image Builder it's a very similar
01:08:32.160 service except that one's just for AWS I
01:08:34.799 suppose for Google you can use Google
01:08:36.479 Cloud run and even on AWS you could use
01:08:39.660 um
01:08:40.259 code build but uh Packer is great
01:08:42.420 because it's Cloud agnostic so you're
01:08:44.160 going to just build the image and then
01:08:45.420 you can deliver it
01:08:47.160 to any provider provisioners should be
01:08:49.859 used as a last resort for the for more
01:08:52.560 common situations there are better
01:08:53.939 Alternatives this is a warning that
01:08:55.560 hashnode puts out in their terraform
01:08:57.299 provisioner section and so I wasn't
01:08:59.580 really sure why they were saying this so
01:09:01.560 I reached out to Anton and Anton uh if
01:09:04.259 you don't know him he's an as Community
01:09:05.460 hero just like myself and so he
01:09:08.698 specializes in terraform like he wrote
01:09:11.040 so many modules for the terraform AWS so
01:09:13.859 he knows it pretty well and he says here
01:09:15.420 the main reason is that provisioners
01:09:17.279 will do something that won't be
01:09:18.779 reflected in the terraform State and the
01:09:20.939 better alternative for that one is to
01:09:23.040 use cloud provider features like Cloud
01:09:24.899 init scripts I think this comes back to
01:09:27.540 immutability when we're looking at the
01:09:30.359 fact that we want to
01:09:32.120 lean towards doing an approach with
01:09:34.500 Packer right we want to
01:09:36.779 um uh bake our Baker machines or virtual
01:09:39.660 machines and then deploy because that's
01:09:41.339 going to be probably the better
01:09:43.140 alternative so if we wanted to use cloud
01:09:45.899 init the idea is we'd have to provide a
01:09:48.600 cloudinet yaml file which is a a very
01:09:51.060 particular format you can find them on
01:09:52.560 the cloudinet website and the idea here
01:09:54.900 is we have these run commands so this
01:09:56.219 just like bash commands here to start
01:09:57.660 and stop Apache we can install our
01:09:59.400 packages here do an update do an upgrade
01:10:01.620 we'll have to pass along our SSH key
01:10:04.320 here that's a very important component
01:10:06.660 to that once we have that file
01:10:08.580 configured we can reference it as a
01:10:11.340 template file over here call it user
01:10:13.500 data and then we're going to pass it on
01:10:15.300 to this section here for user data so
01:10:17.040 that when we launch up this VM and this
01:10:19.199 one in particular is for AWS that's
01:10:21.060 going to pass it to that user data okay
01:10:23.159 now you might be asking well where's all
01:10:25.860 these other provisioners because there's
01:10:27.600 a lot of other tools out there so
01:10:28.739 terraform used to directly support
01:10:30.120 third-party provisioning tools in the
01:10:32.400 terraform language but they were
01:10:34.199 deprecated because it was considered to
01:10:36.780 be poor practice suggesting better
01:10:38.280 Alternatives as we were just talking
01:10:39.540 about so you might be asking where is
01:10:41.520 Chef where is puppet where is salt and
01:10:44.340 the thing is is that you can technically
01:10:45.840 still use chef and puppet through Cloud
01:10:48.480 init because cloudinit actually supports
01:10:50.340 some dsls in there I've never used this
01:10:52.800 before myself but it doesn't look too
01:10:54.840 complicated but the idea is that there's
01:10:56.520 just not direct support so you're not
01:10:58.679 going to use it directly in the language
01:10:59.640 you can use it through cloud in it if
01:11:01.560 you really need it one thing I didn't
01:11:03.239 see mentioned anywhere was ansible and
01:11:05.460 this one's a little bit confusing
01:11:06.540 because there's a lot a lot of videos
01:11:08.640 online about terraform and ansible
01:11:10.739 working very well together and they're
01:11:13.020 complementary Technologies so ansible is
01:11:16.679 a little bit different than these other
01:11:17.699 ones because it does more than just
01:11:19.320 configuration management so maybe that's
01:11:21.060 the reason there
01:11:22.560 um but anyway the point is is that
01:11:23.760 there's no direct support for these
01:11:25.020 anymore you got to use cloud in it and
01:11:27.060 generally if you can use Packer instead
01:11:28.860 when you're working with virtual
01:11:29.820 machines okay
01:11:30.910 [Music]
01:11:35.219 hey this is Andrew Brown from exam Pro
01:11:37.260 and we are taking a look at local exec
01:11:39.239 which allows you to execute local
01:11:40.980 commands after a resource is provisioned
01:11:43.739 so the machine that is executing
01:11:45.300 terraform so what's doing the terraform
01:11:47.219 apply is where the command will execute
01:11:49.739 and a local environment could be your
01:11:52.140 local machine so your laptop or
01:11:54.060 workstation a build server like gcp
01:11:56.880 Cloud build a business code Builder
01:11:58.320 Jenkins or terraform Cloud run
01:12:00.360 environment so that is a single use
01:12:02.340 Linux virtual machine so just an example
01:12:05.699 and there's a lot of cases where you
01:12:07.920 might want to automate but the idea here
01:12:09.540 is after your provision a VM you need to
01:12:11.880 supply the public IP to a third-party
01:12:14.159 security service to add the VM IP
01:12:16.020 address and you can accomplish this by
01:12:17.820 using locally installed third-party
01:12:19.560 cli's on your build server and so there
01:12:22.380 is a bit of an overlapping
01:12:23.400 responsibility between terraform outputs
01:12:25.440 versus local exec because the idea is
01:12:27.659 that by getting by getting data out
01:12:30.900 after something is provisioned or
01:12:32.820 something like that you can do something
01:12:34.199 pragmatic but the idea here is terraform
01:12:36.060 outputs allow you to Output results
01:12:38.100 after running terraform apply local exec
01:12:40.860 allows you to run any arbitrary commands
01:12:42.840 on your local machine commonly used to
01:12:44.520 trigger configuration management like
01:12:46.199 ansible Chef or puppet okay
01:12:48.620 [Music]
01:12:52.800 let's take a look at some example code
01:12:54.719 for a local exec so here we have a bunch
01:12:57.000 of examples on the right hand side and
01:12:59.040 so I just kind of want to walk through
01:13:00.300 some of the commands that we can use but
01:13:02.040 before we do that just let's take a
01:13:03.420 quicker look here at the code so notice
01:13:05.340 we have a resource like Ava's instance
01:13:07.020 in web and then we are specifying a
01:13:09.780 provisioner being a local exec and then
01:13:12.420 we have a command that is being executed
01:13:14.400 under there okay so hopefully that makes
01:13:16.440 it pretty clear but let's just kind of
01:13:17.940 work through the options we have
01:13:19.140 available to us so the first is we have
01:13:20.640 a command and this is required and this
01:13:22.620 is the command you want to execute so
01:13:24.420 notice that we are doing an echo there
01:13:27.540 so it's whatever is possible uh there
01:13:30.840 and I think by default it's using bash
01:13:32.940 okay so if you're using Linux that's
01:13:34.500 what it would be using we could also set
01:13:36.540 a working directory we don't see an
01:13:37.980 example there on the right hand side but
01:13:39.360 if you wanted to say where the command
01:13:41.880 will be executed that's something you
01:13:43.140 could do so maybe you want it over here
01:13:45.179 another thing is The Interpreter so this
01:13:47.580 is the entry point for the command I
01:13:49.260 think by default again it would probably
01:13:50.699 use bash if you're on Linux machine but
01:13:52.500 you could say use bash Ruby it was CLI
01:13:55.140 Powershell whatever you want okay
01:13:57.719 if you needed to pass environment
01:13:59.219 variables in maybe you need a key and
01:14:01.739 secret so the example here is you know
01:14:04.620 we are printing out those keys and then
01:14:06.540 putting them into a credentials XML file
01:14:09.360 so that could be an example there okay
01:14:12.040 [Music]
01:14:16.199 hey this is Andrew Brown from exam Pro
01:14:18.120 and we're taking a look at remote exec
01:14:20.100 so this allows you to execute commands
01:14:22.140 on a Target resource after a resources
01:14:24.900 provision so the idea is you have a
01:14:26.640 local machine executing terraform and so
01:14:29.699 the idea is that when remote exact
01:14:31.260 happens it has a script and it's sending
01:14:33.300 that off to the Target so this case it
01:14:36.179 could be a provision virtual machine and
01:14:38.340 this is where the command is going to
01:14:39.719 run so a remote execute is useful for
01:14:41.940 provisioning a virtual machine with a
01:14:43.500 simple set of commands for more complex
01:14:45.840 tasks it's recommended to use cloud init
01:14:48.000 and strongly recommended in all cases to
01:14:50.400 bake golden images via Packer or uc2
01:14:52.800 image Builder if you want to use
01:14:53.820 something more complex like ansible or
01:14:55.920 something
01:14:56.370 [Music]
01:15:00.900 let's take a look at an example of a
01:15:03.239 remote exec script so here we have a
01:15:05.699 couple and just to quickly go through it
01:15:07.440 the idea is you define your resource so
01:15:09.900 here it's just a virtual machine on AWS
01:15:12.540 and we are provisioning our provisioner
01:15:14.880 is going to be remote exact and so we're
01:15:17.040 able to put these inline commands and
01:15:18.659 say okay let's run puppet apply and then
01:15:21.000 we'll use console join which is the CLI
01:15:22.920 for hashicorp console so there are three
01:15:26.699 different modes for a remote exec the
01:15:29.040 first is inline list of command strings
01:15:30.900 which is what we are seeing over here
01:15:33.679 and then the other option is we can
01:15:36.659 provide a script or scripts so the idea
01:15:39.659 is that you would
01:15:41.580 um well you just specify those locations
01:15:44.040 and it would run it what's interesting
01:15:46.080 here is that it doesn't say
01:15:49.020 um like because we saw with local exec
01:15:51.000 that we could use an interpreter and so
01:15:53.820 it's my assumption that it's just going
01:15:55.800 to use bash or it's going to use a
01:15:58.739 script that is executable right where
01:16:00.719 you have a shebang in the top there and
01:16:03.179 so that's something you know I might
01:16:04.560 test out it's not something that's going
01:16:06.120 to be on the exam but maybe we'll just
01:16:08.159 test out that theory because it's not in
01:16:09.960 the documentation as of the time I'm
01:16:11.820 recording this
01:16:12.590 [Music]
01:16:16.860 let's take a look at the file
01:16:18.300 provisioner and this is used to copy
01:16:19.980 files or directories from our local
01:16:21.659 machine to the newly created resource so
01:16:24.120 here we have some on the right as an
01:16:26.760 example so again we have a virtual
01:16:28.800 machine that we're deploying to AWS
01:16:30.840 we've set the provisioner as file and we
01:16:33.659 are specifying a source file and a
01:16:35.400 destination so source is going to be the
01:16:37.860 file that's on your local machine or
01:16:39.360 whoever is the considered the local you
01:16:43.380 might also want to provide content
01:16:44.699 directly so in this example here you see
01:16:47.280 that we're literally just giving it a
01:16:48.719 string and then there's the destination
01:16:50.760 where you want that file to be I don't
01:16:53.340 have it shown in the code example here
01:16:55.679 but there's a high chance that you would
01:16:57.239 have to provide a connection block so
01:16:59.520 that you could say okay I need to use
01:17:01.199 SSH or
01:17:03.560 winrm to gain access to that machine
01:17:06.239 okay
01:17:07.120 [Music]
01:17:11.460 so we just mentioned that there's a
01:17:13.380 connection block so it tells the
01:17:15.540 provisioner or resource how to establish
01:17:17.219 a connection so here is a big example on
01:17:20.040 the right hand side so this is using the
01:17:22.260 example for a provisioner file and here
01:17:25.320 we are specifying our connection block
01:17:27.239 and this one in particular is for SSH as
01:17:30.000 you can see and there's a bunch of
01:17:31.260 different parameters like the user the
01:17:33.179 password the host you could also use a
01:17:36.840 Bastion host I don't I'm not showing it
01:17:38.640 here but if you're using SSH you could
01:17:40.320 specify a bunch of keys in order to do
01:17:42.900 that because maybe you need to go
01:17:43.920 through a Bastion first
01:17:45.900 for Windows Remote Management you also
01:17:48.719 have that option down below okay
01:17:50.900 [Music]
01:17:55.199 hey this is Andrew Brown from exam Pro
01:17:57.120 and we are taking a look at null
01:17:58.679 resources so this is a placeholder for
01:18:00.659 resources that have no specific
01:18:02.460 Association to a provider it's a bit
01:18:05.640 confusing but it makes sense once you
01:18:07.260 run into some use cases for it so here
01:18:09.600 is a big example where we have an AWS
01:18:13.140 instance and we're defining a cluster
01:18:15.719 and so we need a null resource here
01:18:18.020 because we want to run this trigger and
01:18:21.540 that's generally why you're going to be
01:18:22.860 using null resources is to trigger a
01:18:25.739 resource so triggers is a map of values
01:18:27.540 which should cause this set of
01:18:28.980 Provisions to re-run so values are meant
01:18:31.739 to be interpolated references to
01:18:33.540 variables or attributes of other
01:18:35.760 resources and triggers are interesting
01:18:38.400 because I think we also see them in
01:18:39.480 terraform Cloud I'm not sure if this is
01:18:41.640 the same kind of functionality but yeah
01:18:44.340 that's in all resources okay
01:18:45.900 [Music]
01:18:49.920 all right let's take a look at terraform
01:18:51.659 data so this is very very similar to
01:18:54.239 null resource but the key difference
01:18:56.640 here is that it does not require or the
01:18:59.219 configuration of Provider because when
01:19:00.780 you install null resource it actually
01:19:03.060 installs a provider called null and so
01:19:07.199 now it's just with this dare terraform
01:19:09.540 data you can do something very similar
01:19:11.400 like this with null resource and
01:19:13.380 literally replace it with terraform data
01:19:15.179 and for more or less it will do the same
01:19:17.340 thing now it's not one to one because uh
01:19:20.159 some of those parameters are a little
01:19:22.679 bit different so instead of triggers we
01:19:24.719 have triggers replace but more or less
01:19:27.360 you know you can almost replace it and
01:19:31.080 get the exact same result and you know I
01:19:34.800 would recommend it over using null I was
01:19:37.620 trying to figure out if there was a case
01:19:39.900 where you'd want to use an all resource
01:19:41.760 but I really could not determine that it
01:19:45.239 did not seem like there was anything
01:19:46.320 additional so yeah there you go it's as
01:19:49.199 simple as that
01:19:50.000 [Music]
01:20:01.860 foreign
01:20:05.170 [Music]
01:20:22.380 hey this is Andrew Brown from exam Pro
01:20:23.940 and we are taking a look at terraform
01:20:25.440 providers so providers are terraform
01:20:27.540 plugins that allow you to interact with
01:20:29.520 cloud service providers like AWS Azure
01:20:31.679 gcp software as a service provider so
01:20:34.320 GitHub and Golia stripe or other apis
01:20:38.040 such as kubernetes or postgres servers
01:20:40.320 there's a lot there there's like over a
01:20:42.300 thousand providers so providers are
01:20:44.340 required for your terraform
01:20:45.480 configuration file to work so you have
01:20:46.860 to have at least one provider and
01:20:48.900 providers can come in three different
01:20:50.219 tiers we have the official one so
01:20:51.780 published by the company that owns the
01:20:53.219 provider technology or service verified
01:20:55.260 so actively maintained up to date and
01:20:57.000 compatible with both terraform provider
01:20:59.040 communities so published by Community
01:21:00.840 member but no guarantee of Maintenance
01:21:02.340 up to date or compatibility providers
01:21:04.260 are distributed separately from
01:21:05.640 terraform and the plugin must be
01:21:07.440 downloaded before use so if we do
01:21:09.300 terraforming knit this will download the
01:21:11.219 necessary plugin provided plugins listed
01:21:13.080 in the terraform configuration file so
01:21:14.940 there you go
01:21:15.880 [Music]
01:21:20.520 hey this is Andrew Brown from exam Pro
01:21:22.320 and we are taking a look at the
01:21:23.580 terraform registry so this is a website
01:21:26.100 portal to browse download or publish
01:21:28.320 available providers and modules and just
01:21:31.020 remember providers and modules are
01:21:33.060 plugins within terraform both of them
01:21:34.800 okay so to get to this website we go to
01:21:38.840 registry.terraform.io and everything
01:21:40.739 published to the terraform registry is
01:21:42.420 public facing so let's just distinguish
01:21:44.460 between providers and modules and I feel
01:21:47.580 that I should have given providers a
01:21:49.080 little bit more attention in the uh in
01:21:51.420 its own slide but I'll give it a clear
01:21:53.340 distinction between providers and
01:21:54.780 modules here so a provider is a plug-in
01:21:57.960 that is a mapping to a cloud service
01:22:00.000 provider's API so if you wanted to call
01:22:03.000 individual API actions that is what the
01:22:05.699 provider is providing to you when we're
01:22:08.520 talking about modules a module actually
01:22:10.199 relies on a provider plugin but a module
01:22:13.380 is a group of configuration files that
01:22:15.060 provide common configuration
01:22:16.500 functionality this is going to help you
01:22:18.300 enforce best practices reduce amount of
01:22:20.340 code code reduced time to develop
01:22:22.500 scripts so the way to think about it is
01:22:25.080 imagine that you have to do something in
01:22:27.300 your CSP like AWS and there's just
01:22:29.400 common things that would go along with
01:22:31.020 it so let's say you're launching a load
01:22:33.179 bouncer Auto scaling group with ec2
01:22:34.800 instances that's a bunch of services
01:22:36.659 that you are just very common you'd have
01:22:38.460 to configure it together so there could
01:22:39.900 be a module that allows you to do all
01:22:42.719 that with writing very little amount of
01:22:44.640 code it will choose best practices when
01:22:46.440 doing that okay
01:22:47.790 [Music]
01:22:52.140 let's take a look here at providers and
01:22:54.120 modules within terraform registry really
01:22:55.679 quickly so um here is the AWS one here
01:22:58.980 and so I just want to point out that
01:23:00.600 this official one is by hashicorp it's
01:23:02.340 not by AWS but it does mean that it has
01:23:04.920 uh proper support so you know it's going
01:23:06.780 to have pretty much one-to-one mapping
01:23:08.219 to the AWS API
01:23:10.440 um and so it has really really good
01:23:12.360 documentation now I complain about
01:23:14.600 terraform not having great documentation
01:23:17.699 for learning like their language but for
01:23:19.980 the actual documentation of doing things
01:23:21.480 practically they're really really good
01:23:23.040 and here's just an example where we see
01:23:25.320 app mesh and they just give you full
01:23:26.760 examples for basically everything it's
01:23:28.620 really great and if you need a code
01:23:31.020 sample to get going like to actually
01:23:33.360 install it within your configuration
01:23:35.520 file it's right there over here so you
01:23:37.980 can just go ahead and grab that for
01:23:39.780 terraform modules it looks pretty
01:23:42.900 similar so the idea is you get your
01:23:44.159 module code on the right hand side here
01:23:46.020 you want to check out the examples it's
01:23:48.060 going to be dependent on who is
01:23:50.219 developing these modules this one is
01:23:51.900 made by Anton so he has lots and lots of
01:23:55.500 really great examples and then you can
01:23:57.239 see a list of dependent modules here
01:23:58.620 under sub modules so it's not too
01:24:00.780 complicated so there you go
01:24:02.180 [Music]
01:24:06.360 so we're taking a look at terraform
01:24:07.920 registry which is a public registry but
01:24:10.560 let's talk about private registry how
01:24:12.060 would we do that well that's where we
01:24:13.320 use terraform Cloud it allows you to
01:24:15.239 publish private modules for your
01:24:16.800 organization within the terraform Cloud
01:24:18.900 private registry when creating a module
01:24:21.360 you need to connect to a Version Control
01:24:22.800 System of VCS and choose a repository so
01:24:25.920 here you can see
01:24:27.540 we can be using something like GitHub
01:24:29.460 gitlab betbucket or azure devops
01:24:32.940 and of course we're going to cover
01:24:34.380 terraform Cloud a lot more further on in
01:24:37.380 the course and it does definitely does
01:24:38.820 more than just act as a private registry
01:24:41.280 but I figured this is the best place to
01:24:43.380 put it against the terraform registry
01:24:45.120 okay
01:24:45.780 [Music]
01:24:49.980 let's take a look at how we would get a
01:24:51.960 list of the current providers you are
01:24:53.460 using so all you'd have to do is type in
01:24:55.080 terraform providers and you'd get a full
01:24:56.940 list this command is useful if you have
01:24:59.640 a very complex
01:25:01.699 architecture where you're using a lot of
01:25:03.960 files and modules within terraform I
01:25:07.860 wanted to just show this command just
01:25:09.360 because I saw it on the exam and so it's
01:25:11.580 just an easy point if you happen to get
01:25:13.260 that question okay
01:25:14.320 [Music]
01:25:18.719 so we know we can set multiple providers
01:25:21.239 of in our terraform configuration file
01:25:23.820 but there are some variations here that
01:25:25.980 you should know so one thing is is that
01:25:28.020 if you need to have an alternate
01:25:29.460 provider you can use this thing called
01:25:31.380 Alias so if you just notice here there's
01:25:33.840 the Alias this is useful if let's say
01:25:35.940 you want to have resources within
01:25:38.040 different regions of AWS is a very
01:25:40.320 common use case when you want to
01:25:42.060 reference uh what resource should use
01:25:45.300 with provider you're going to have that
01:25:47.040 little provider attribute and then
01:25:48.780 you're just going to do what the name is
01:25:51.719 of the provider followed by the Alias
01:25:54.000 you can also set an alias provider for a
01:25:57.060 parent module so notice here in the
01:26:00.659 required providers we have this
01:26:02.880 attribute here and we're using this
01:26:04.560 configuration Alias and then if you need
01:26:07.260 to set an alias provider for a child
01:26:09.060 module but more or less you just need to
01:26:11.340 remember these two up here okay for
01:26:12.960 setting an alias
01:26:14.200 [Music]
01:26:18.900 hey this is Andrew Brown from exam Pro
01:26:20.820 and we're giving closer attention to
01:26:22.679 modules so a terraform module is a group
01:26:24.780 of configuration files that provide
01:26:26.280 common configuration functionality to
01:26:28.500 enforce best practices reduce the amount
01:26:30.540 of code and reduce the time to develop
01:26:32.100 scripts I definitely had a lot of
01:26:34.260 confusion understanding the difference
01:26:35.520 between a provider and a module
01:26:37.199 initially but the clear thing is that a
01:26:39.780 provider is just an API mappings to the
01:26:43.860 service okay so on the example here on
01:26:46.199 the left we have AWS as a provider and
01:26:48.659 the example is to show you if you had to
01:26:50.219 create a VPC you'd have to specify many
01:26:52.679 networking resources and just notice
01:26:55.440 that I have the three ellipses there to
01:26:57.179 suggest there is a lot more that you'd
01:26:58.739 have to configure but by using a module
01:27:01.199 and there's one called the AWS VPC
01:27:03.060 module it basically has this short
01:27:05.100 domain specific language
01:27:07.080 that allows you to quickly provision a
01:27:10.020 VPC so the easy way to remember modules
01:27:13.139 is Imagine clicking a wizard that
01:27:14.699 creates many Cloud resources like it
01:27:17.159 able to have the VPC wizard that's
01:27:19.260 basically the idea behind modules just
01:27:21.420 to kind of give a better contrast to the
01:27:24.000 value that modules have we'll look at
01:27:25.800 the Azure provider so imagine you had to
01:27:27.600 provision an Azure virtual machine this
01:27:29.760 is how much code you'd have to write so
01:27:31.560 it's going to vary based on providers so
01:27:33.659 AWS does not require this much work it's
01:27:35.699 very short gcp requires a little bit
01:27:38.100 more work and for some reason Azure
01:27:39.540 requires a lot so this is a case where
01:27:41.520 you'd want to use a module so there's a
01:27:43.980 module called compute and network module
01:27:45.659 and it reduces the code to amount of
01:27:47.340 this still a bit long but that's just
01:27:49.620 what it is okay
01:27:51.900 thank you
01:27:54.050 [Music]
01:27:55.500 all right let's talk about the fine line
01:27:57.179 and this is understanding the gray areas
01:27:59.340 of responsibility between terraform
01:28:00.960 infrastructure as code and third-party
01:28:03.300 configuration management tools like
01:28:05.219 ansible so there are cases where when
01:28:08.699 you get outside of AWS as your gcp you
01:28:11.520 might see providers like for postgres
01:28:14.100 database and you might say okay well
01:28:16.260 what part of terraform should be
01:28:18.900 automating it and so that's a little bit
01:28:21.060 more complicated question because
01:28:22.500 terraform does more than one thing so
01:28:24.780 terraform has providers modules and
01:28:27.000 provisioners and then on outside of that
01:28:29.040 if we're not even using terraform we
01:28:30.840 have third-party configuration
01:28:31.980 management tools that we can use like
01:28:33.600 ansible and the thing is is that you
01:28:36.179 could have ansible do everything but
01:28:38.100 that does not mean that you should have
01:28:39.600 it do everything and with terraform at
01:28:42.659 more or less most of these levels you
01:28:44.159 can have them do everything but that
01:28:45.600 doesn't mean that they should right so
01:28:47.639 the idea is to try to figure out what
01:28:49.679 should be where and how to define that
01:28:51.300 so let's talk about creating a database
01:28:53.100 so if we created a database that is like
01:28:55.440 setting up a new service so that is
01:28:58.320 going to be under the providers and so
01:29:00.780 you'd use the postgres terraform
01:29:02.460 provider to set up a database now you
01:29:04.560 have users and so users are an entity
01:29:08.100 they're not just like loose data so
01:29:10.440 there's something that you can add
01:29:11.580 remove add permissions to and we would
01:29:13.560 treat them as entities and so it
01:29:15.480 wouldn't necessarily be under the
01:29:16.500 providers but that's a great place to
01:29:17.940 put it under modules okay then you have
01:29:21.360 your data so where would the data go
01:29:23.400 well data is not necessarily an entity
01:29:26.280 it's just a bunch of data so I would say
01:29:29.340 that that is for provisioners that can
01:29:30.960 run random scripts and then when we want
01:29:33.659 to do things like backup tables to data
01:29:36.300 warehouses or truncate data daily tables
01:29:40.020 things that are repetitive tasks that is
01:29:42.360 what we're going to use ansible for or a
01:29:44.699 third-party configuration management
01:29:45.659 tool outside of terraform you wouldn't
01:29:47.760 have terraform to that stuff at all so
01:29:49.380 when you have a task done one time to
01:29:51.840 set up the database like seating data
01:29:53.760 it's going to go to provisioners what
01:29:55.440 you have repeatable tasks for ongoing
01:29:57.480 maintenance it's going to be out as a
01:29:59.460 third party provider and if you have
01:30:01.139 something that is like identified as an
01:30:03.600 identity like as a resource that you
01:30:05.340 want to manage like Asset Management
01:30:07.040 which are these things these are going
01:30:09.000 to be over here in providers and modules
01:30:11.340 I do want to point out that a
01:30:13.440 provisioner can be using ansible but we
01:30:15.960 would still want to use ansible or
01:30:17.520 third-party configuration management
01:30:18.840 tool isolate or separate to do these
01:30:21.659 kind of things you do not want terraform
01:30:23.400 running these okay
01:30:25.139 foreign
01:30:28.440 [Music]
01:30:37.739 hey this is Andrew Brown from exam Pro
01:30:39.480 and we are looking at Hashi Corp
01:30:41.040 configuration files also known as
01:30:43.080 terraform files that which contain the
01:30:45.179 configuration information about
01:30:46.260 providers and resources this is
01:30:48.840 basically core to terraform and that's
01:30:50.520 what we're doing so terraform files and
01:30:52.560 in the extension of dot TF or TF Json
01:30:56.040 and we'll talk about the Json case a
01:30:58.800 little bit later but terraform files are
01:31:00.659 written in the terraform language and so
01:31:03.600 here is kind of an abstract way of
01:31:05.639 looking at the language I know it's
01:31:06.960 confusing here but don't worry we're
01:31:08.159 going to reiterate on it to make more
01:31:09.540 sense but terraform language consists of
01:31:11.580 only a few basic elements you have
01:31:13.800 blocks and so these are containers for
01:31:16.199 other content and they represent an
01:31:18.179 object so I'll have a block type which
01:31:20.159 can have zero or more labels and a body
01:31:22.139 you have a block label it's a name of a
01:31:24.719 block you have arguments which is which
01:31:27.420 is what you assign a value to a name so
01:31:29.639 notice like we have assignments so we
01:31:31.440 have identifier to an expression okay
01:31:33.179 they will appear within block so here it
01:31:35.760 is within a block as you can see
01:31:37.440 um Expressions represent a value either
01:31:40.199 literally or by referencing and
01:31:42.179 combining other values they appear as
01:31:44.639 values for arguments or within other
01:31:46.380 Expressions you might come across
01:31:48.659 hashicorp configuration language so HCL
01:31:50.880 and this is the low level language for
01:31:52.739 both the terraform language and
01:31:54.239 alternative Json syntax I don't know if
01:31:56.699 we'll be getting into it in this course
01:31:59.280 um or if there's even an easy way to
01:32:00.840 distinguish it because it's basically
01:32:01.860 terraform language but just if you see
01:32:03.840 HCL just think terraform language it's
01:32:05.760 the easiest way to think about it okay
01:32:07.800 [Music]
01:32:12.300 let's take a look here at the alternate
01:32:14.040 Json syntax so terraform supports
01:32:16.199 alternate syntax that is Json compatible
01:32:18.480 terraform expects Json syntax files to
01:32:20.880 be named dot tf.json so we mentioned
01:32:23.219 that earlier and so this is generally
01:32:24.840 what it would look like okay the syntax
01:32:28.020 is useful when generating portions of a
01:32:29.940 configuration pragmatically since
01:32:31.500 existing Json libraries can be used to
01:32:33.360 prepare the generate configuration files
01:32:35.219 and that's pretty much it would you want
01:32:37.920 to work on this it's up to you
01:32:40.199 um but uh yeah so that's the reason for
01:32:42.719 this alternate syntax
01:32:43.790 [Music]
01:32:47.880 all right let's take a look at terraform
01:32:49.620 settings so the terraform configuration
01:32:51.840 block type terraform curly braces you'll
01:32:54.360 see this within your configuration file
01:32:56.219 is used to configure some behaviors of
01:32:58.739 terraform itself so here is what it
01:33:01.139 looks like and what's very common is
01:33:02.639 you're going to see those required
01:33:03.659 providers so there are different things
01:33:05.880 that we can put in here so we can put
01:33:07.380 the required version so this expects us
01:33:09.840 to match to a particular version of
01:33:11.340 terraform required providers this is the
01:33:14.400 providers that will be pulled during the
01:33:16.199 terraform init we can also do
01:33:18.000 experiments here so these are
01:33:19.440 experimental language features that the
01:33:21.239 community can try and provide feedback
01:33:22.920 on and then we have provider metadata so
01:33:25.860 this is module specific information for
01:33:27.900 providers okay
01:33:29.490 [Music]
01:33:33.840 hey this is Andrew Brown from exam Pro
01:33:35.880 and we are taking a look at the
01:33:37.380 hashicorp configuration language also
01:33:39.600 known as HCL I'm going to tell you I was
01:33:42.060 really confused at the start working
01:33:43.920 with terraform because sometimes they
01:33:45.540 mention things like hashicorp
01:33:47.159 configuration files hashicorp
01:33:48.960 configuration language terraform
01:33:50.639 language and I could not discern you
01:33:52.800 know what the difference was but so this
01:33:54.659 is the idea here is to give you that
01:33:56.460 Clarity okay so HCL is an open source
01:33:58.920 toolkit for creating structured
01:34:00.780 configuration languages that are both
01:34:02.760 human and machine friendly for use of
01:34:05.520 command line tools and it's an open
01:34:07.020 source project so you can find it at
01:34:08.760 github.com
01:34:10.040 HCL so the idea is that they have this
01:34:12.960 Baseline language that you can extend
01:34:15.300 for your own use case so uh terraform is
01:34:18.600 using it and so it uses a good like it
01:34:22.020 uses the language itself but then it
01:34:23.699 goes ahead and extends it by adding
01:34:25.739 additional functionality for its
01:34:27.540 specific use case and this HCL based
01:34:30.900 language is not just for terraform it's
01:34:33.300 used for hacker templates Vault policies
01:34:36.139 boundary controllers and workers console
01:34:39.480 configuration Waypoint application
01:34:41.820 configuration Nomad job specification
01:34:44.900 and this one isn't a hash Accord product
01:34:47.340 but this is an open source project
01:34:48.540 called Shipyard and you can use it for
01:34:50.760 Shipyard blueprints surprisingly
01:34:52.440 Sentinel which is a Hachi Corp policy as
01:34:55.860 code server service does not use HCL but
01:35:00.000 it has its own HC ACL custom language
01:35:03.719 but the idea is that you know we're
01:35:06.000 looking at mostly the use case is for
01:35:09.380 hashicorp services but if you wanted to
01:35:12.420 extend this language for your own use
01:35:14.280 case you totally could and so I think
01:35:16.739 that's really cool but hopefully that
01:35:18.000 kind of distinguishes between HCL and
01:35:20.219 terraform language okay
01:35:21.740 [Music]
01:35:26.040 hey this is Andrew Brown from exam Pro
01:35:28.020 and we are taking a look at input
01:35:29.880 variables so also known as terraform
01:35:32.040 variables or just variables are
01:35:34.199 parameters for terraform modules that is
01:35:36.360 the way we get data in to our
01:35:38.880 configuration scripts is via input
01:35:41.159 variables so you can declare variables
01:35:43.560 in either the root module or child
01:35:45.780 modules and the way you define them is
01:35:48.659 via this variables block there at the
01:35:51.120 top and just to kind of go over the
01:35:53.880 possible fields for that block we have
01:35:56.159 the default option so the default option
01:35:58.500 which is here is going to be the default
01:36:00.000 variable if you do not set it
01:36:03.120 for type this is an argument that
01:36:04.920 specifies the value types that are
01:36:06.300 accepted for the variable so this case
01:36:08.580 up here we can see string and this one
01:36:10.560 is a list
01:36:12.060 for description this specifies the input
01:36:14.100 variables documentation we don't see an
01:36:16.500 example there I believe that is optional
01:36:18.179 but it's always great to put a
01:36:19.620 description in when you can there is a
01:36:21.600 validation block so a block to Define
01:36:23.400 validation rules usually in addition
01:36:25.620 addition to type constraints so we don't
01:36:28.199 see that here on the right hand side but
01:36:30.239 the idea is that you know let's just
01:36:31.620 make sure that there's less of a human
01:36:33.600 error entering the wrong information you
01:36:35.880 can also have sensitive this limits
01:36:37.980 terraform UI output when the variable is
01:36:40.199 used in the configuration and we will
01:36:42.120 cover sensitive a lot more in this
01:36:44.280 course outside of just this one slide
01:36:45.900 okay
01:36:46.370 [Music]
01:36:50.520 let's take a look here at variable
01:36:52.139 definition files and these allow you to
01:36:54.179 set the values for multiple variables at
01:36:56.100 once so variable definition files are
01:36:58.320 named with the dot TF vars extension or
01:37:01.139 if you want to use the alternative
01:37:02.400 syntax it's the
01:37:03.920 tfbars.json file by default if you have
01:37:07.679 a file called
01:37:09.020 terraform.tfrs within your project
01:37:11.100 directory this will be automatically
01:37:12.659 loaded so it's pretty common to make
01:37:14.340 that file to create a definition file it
01:37:18.900 just uses the terraform language so you
01:37:20.580 would just assign
01:37:22.040 values here you wouldn't make variable
01:37:24.480 blocks but you just Define these um
01:37:27.620 identifiers and give them values okay
01:37:30.730 [Music]
01:37:35.460 another way of loading input variables
01:37:38.100 is via environment variables and this is
01:37:40.440 very common uh way of loading them if
01:37:43.080 you have your own CI CD process for
01:37:45.600 terraform so if you're using terraform
01:37:46.980 cloud or you're using some kind of build
01:37:49.080 server that's going to be the primary
01:37:50.699 way you're going to get variables into
01:37:53.480 those build servers probably won't be
01:37:57.060 doing this much locally but the way it
01:37:59.040 works is that terraform will watch for
01:38:01.620 any environment variable starting with
01:38:02.940 TF underscore VAR underscore followed by
01:38:05.880 the name this is very important to
01:38:07.620 remember because it definitely will show
01:38:09.000 up on the exam so let's say we want to
01:38:12.120 do set a variable for an image ID so we
01:38:15.659 do TF underscore VAR and then image ID
01:38:18.840 probably most cases when you follow the
01:38:21.179 name it's going to be a lowercase
01:38:22.760 underscore I don't think you'd probably
01:38:24.540 want to uppercase that stuff and you
01:38:26.040 just set the value okay
01:38:27.690 [Music]
01:38:32.100 so there's a lot of ways for us to load
01:38:34.199 input variables we just saw two so we
01:38:36.360 saw terraform tfrs and environment
01:38:38.880 variables but there's a lot more caveats
01:38:41.580 to this so let's just run through them
01:38:42.960 so we already covered uh terraform.tfrs
01:38:45.780 the idea here is that if you create this
01:38:47.280 file and it's in your project it will
01:38:49.020 automatically be loaded when running
01:38:50.639 terraform apply you can name other TFR
01:38:53.760 files uh so I just called them use
01:38:55.679 additional TFR files but they won't be
01:38:57.540 loaded by default you'll have to use a
01:38:59.460 command line to load them this is useful
01:39:01.080 if you have like a Dev and prod
01:39:02.400 environment and you want to swap those
01:39:04.980 out now if you want to have files that
01:39:08.760 auto load then you can just put the dot
01:39:10.920 Auto here and give it any name you want
01:39:12.540 this would be useful if let's say you
01:39:14.100 had a very large terraform tfrs file and
01:39:16.440 you wanted to break it up to make it
01:39:17.699 more human readable you could do that
01:39:20.460 then you have the hyphen VAR file flag
01:39:23.699 when you're doing terraform apply or or
01:39:26.159 plan and this is actually how you load
01:39:28.080 up these additional variable files if
01:39:30.360 you need to override a single value you
01:39:32.040 you can use hyphen VAR so here I'm
01:39:34.199 overriding the ec2 type to be T2 medium
01:39:36.420 and then lastly here we have environment
01:39:38.340 variables we covered this this is where
01:39:40.139 it starts with TF underscore VAR
01:39:42.480 underscore followed by the name and this
01:39:44.699 is going to be very common when you are
01:39:46.620 using Code build servers or runtimes to
01:39:49.620 run this in a CI CD automated way now
01:39:52.679 there's a precedence to which these get
01:39:54.120 loaded meaning that that certain
01:39:57.179 configurations of or input of variables
01:39:59.460 will override other ones so as we go
01:40:01.560 down this list these ones will override
01:40:03.239 the previous one so at the top you have
01:40:04.800 environment variables if you have a
01:40:06.540 terraform tfrs file that will override
01:40:08.460 the environment variables if you have
01:40:10.800 the Json one that will override that one
01:40:12.719 if you have auto files that will
01:40:14.880 override the default tfrs file and then
01:40:18.300 on the last list you have hyphen VAR and
01:40:19.920 hyphen VAR file will override the rest
01:40:21.719 so there you go in terms of the exam
01:40:24.300 they're not going to ask you the
01:40:25.739 president's here but you're going to
01:40:27.060 need to know what VAR VAR file are
01:40:28.980 environment variables are in this
01:40:30.540 default line okay
01:40:32.040 thank you foreign
01:40:34.840 [Music]
01:40:36.360 let's take a look here at output values
01:40:38.520 which are computed values after a
01:40:40.080 terraform apply is performed output
01:40:41.880 values allow you to obtain information
01:40:43.679 after resource provisioning such as a
01:40:46.080 public IP address I'll put a file of
01:40:48.300 values for chromatic integration
01:40:49.800 cross-reference Stacks via outputs in a
01:40:52.020 state file via terraform remote State
01:40:53.760 and so here's an example of an outputs
01:40:56.960 block so notice that there's a block and
01:41:00.000 you specify some stuff there you can
01:41:01.739 optionally provide a description it's
01:41:03.480 not necessary but generally with outputs
01:41:05.760 I would recommend putting that in there
01:41:07.199 you can also Mark it as sensitive so it
01:41:09.600 does not show in your terminal this is
01:41:12.120 important if you're doing like logging
01:41:13.500 stuff you don't want to compromise those
01:41:15.239 values there but understand that output
01:41:18.600 values even though they might not be
01:41:21.420 outputted to your terminal or SD out
01:41:23.480 they will be visible within the state
01:41:25.679 file so if somebody opens up the state
01:41:27.300 file they're going to be plainly visible
01:41:29.040 there so just understand that sensitive
01:41:31.380 does not protect the values there okay
01:41:34.560 now in terms of how we would use the CLI
01:41:36.840 with the output values if we type
01:41:38.820 terraform output it's just going to
01:41:40.199 print out all the values that are within
01:41:41.940 the state file I don't show this in the
01:41:44.159 example here but if you wanted to use a
01:41:47.400 um a like bash command to parse Json you
01:41:52.199 could extract them out and see they're
01:41:53.340 just plainly in the Json okay if you
01:41:55.619 need to get exactly a particular field
01:41:58.320 you type in terraform output and Then
01:42:00.179 followed by the name if you wanted an
01:42:02.340 adjacent format all the output then you
01:42:04.679 could give that flag I don't know if it
01:42:07.020 would work with this one I actually
01:42:08.100 didn't test I just thought about that
01:42:09.360 here for this one here if you want the
01:42:12.060 raw output of it meaning like if you
01:42:14.340 output a string and you want it to be
01:42:16.380 escaped or what have you then you could
01:42:18.300 use it pragmatically by passing it to
01:42:20.400 something like curl to do something but
01:42:22.199 the idea with all these output values is
01:42:23.820 that it's one way of inspecting but you
01:42:25.500 could also use this in a configuration
01:42:27.600 script or or something to do kind of
01:42:29.880 like an after action okay
01:42:31.480 [Music]
01:42:36.000 all right so we're taking a look at
01:42:37.440 local values also known as locals that
01:42:39.900 assigns a name to an expression so you
01:42:41.820 can use it multiple times within a
01:42:43.739 module without repeating it so here what
01:42:46.080 we're going to do is Define our local
01:42:47.699 block up here and then the idea is that
01:42:50.460 we're assigning these names or IDs
01:42:52.860 expressions or values so that we can
01:42:55.080 reuse them throughout our code notice
01:42:57.719 that we can Define multiple local blocks
01:42:59.639 in the same file and I just say this
01:43:02.159 because like when you use required
01:43:03.420 providers you're only allowed to have a
01:43:04.679 single block but this case like with
01:43:06.239 variables or locals you can have many
01:43:08.360 and you could even Nest them within each
01:43:10.619 other so notice down here we're
01:43:12.000 referencing local within a local so
01:43:14.699 that's totally possible and I imagine
01:43:16.380 it's in the order to which it is
01:43:18.780 specified we can do static values or
01:43:21.179 computed values so we can actually
01:43:22.679 here's a function write an expression
01:43:24.900 and then it will output a value
01:43:27.260 once a local value is declared you can
01:43:29.639 reference it via the dot as local dot
01:43:33.000 the name so here notice within our it
01:43:35.580 was resource we have local and common
01:43:37.980 tags I have to point this out but when
01:43:40.080 you're referencing you use the singular
01:43:42.060 local because you might get an exam
01:43:44.639 question which shows you local dot or
01:43:46.560 locals Dot and the trick here is you got
01:43:49.139 to remember which one it is locals help
01:43:51.719 can help dry up your code it is best
01:43:54.960 practice to use local sparingly since
01:43:56.940 it's uh in terraform it's intended to be
01:43:59.159 declarative and overuse of locals can
01:44:01.679 make it difficult to determine what the
01:44:04.020 code is doing this call comes back to
01:44:06.000 describing terraform as declarative plus
01:44:08.400 where they give you functionality that's
01:44:10.199 imperative like but the idea is that you
01:44:12.900 know if you overuse these you can run
01:44:14.639 into trouble okay
01:44:15.950 [Music]
01:44:20.280 hey it's Andrew Brown from exam Pro and
01:44:22.380 we are taking a look at data sources for
01:44:25.380 terraform so the idea here is you want
01:44:27.420 information to find outside of terraform
01:44:29.699 and it's defined by another separator
01:44:32.580 from configuration or Modified by
01:44:34.679 functions so the idea here is we are
01:44:37.199 going to Define ourselves a data block
01:44:39.020 and we have an external resource we're
01:44:41.580 looking for so we're saying hey I want
01:44:43.500 to see if I have an AWS Ami we're going
01:44:46.320 to use these filters as a way of of kind
01:44:49.139 of selecting it within our AWS account
01:44:51.960 so we'd have a provider set up and so
01:44:53.880 it'd be looking within that account to
01:44:55.320 find it and it's even saying look for
01:44:57.119 the most recent Ami okay and once we
01:45:00.780 have found that data source we can just
01:45:03.600 reference it so notice we're using data
01:45:05.940 to reference it there so data AWS
01:45:08.480 ami.web ID so there you go
01:45:11.700 [Music]
01:45:16.260 we're taking a look here at name values
01:45:18.119 and these are built-in Expressions that
01:45:19.800 reference uh various values you'll find
01:45:21.960 your configuration scripts we do cover
01:45:23.760 these in their respected sections but I
01:45:26.280 wanted to consolidate them here in one
01:45:27.900 place just so that you get a second
01:45:30.840 chance to reinforce this information
01:45:32.280 because Crux of questions of the exam
01:45:34.800 could be based on knowing how the name
01:45:37.320 values work so let's go through them the
01:45:39.420 first is resources I'm going to get up
01:45:40.800 my pen tool here and so the way
01:45:42.600 resources work is that you start with
01:45:44.580 the resource type so AWS instance and
01:45:47.460 then you're going to do the name of it
01:45:48.900 so there's nothing that uh
01:45:51.060 starts before the left hand side of it
01:45:53.340 so just remember it just starts with
01:45:54.540 that resource type then you have input
01:45:56.460 variables and that starts with VAR
01:45:58.020 period so that's the singular VAR then
01:46:00.239 we have local values and again that's
01:46:01.739 singular so local period for child
01:46:04.020 modules it starts with module period
01:46:05.639 again singular for data sources it's
01:46:08.100 going to be data singular just remember
01:46:09.900 singular because they can have a matchup
01:46:12.960 on the on the exam questions whether
01:46:14.820 it'll be like data or datas for file
01:46:17.040 system and workspace info we have
01:46:18.659 path.module this is the path of module
01:46:20.760 where the expression is placed we have
01:46:22.440 path.root this is the path of the root
01:46:24.360 module of the configuration we have path
01:46:26.520 CWD this is the path of the current
01:46:28.320 working directory and in practice the
01:46:31.800 default CWD is the same as the roots so
01:46:33.600 those would be technically the same we
01:46:35.639 have terraform.workspace this is the
01:46:37.260 name of the currently selected workspace
01:46:38.880 then we have block local values these
01:46:41.460 are things that appear within a body of
01:46:43.500 a blocks so this could be within a
01:46:45.780 resource provisioners things like that
01:46:47.400 so we have if we're using the count meta
01:46:50.460 argument we're going to get count and
01:46:51.840 with that we'll have count dot index so
01:46:53.580 we can say okay this is the fourth
01:46:56.280 iteration of you know uh this this
01:46:59.520 account Loop then we have for each and
01:47:02.159 this allows us to have the key and the
01:47:04.020 value so we can access that during our
01:47:05.580 iterations we have self uh so selfless
01:47:08.400 uh references information within
01:47:10.619 provisioners or connections so it's just
01:47:13.260 like a self-referencing thing name
01:47:14.940 values resemble the attribute notation
01:47:17.040 of map or object values but are not
01:47:19.139 objects and do not act as objects you
01:47:21.300 cannot use square brackets to access
01:47:22.679 attributes of name values like an object
01:47:24.840 so there you go
01:47:25.650 [Music]
01:47:33.480 foreign
01:47:36.770 [Music]
01:47:54.239 hey this is Andrew Brown from exam Pro
01:47:56.159 and we are taking a look at resource
01:47:57.960 meta arguments so the terraform language
01:47:59.699 defines several meta-arguments which can
01:48:01.560 be used with any resource type to change
01:48:03.480 the behavior of resources and so we'll
01:48:06.179 quickly go through the list here and
01:48:07.440 then we will Deep dive on each so the
01:48:09.119 first is depends on so this is for
01:48:10.619 specifying explicit dependencies we have
01:48:12.960 count which is for creating multiple
01:48:14.520 resource instances according to account
01:48:16.380 we have four each which is used to
01:48:18.600 create multiple instances according to a
01:48:20.520 map or set of strings provider so this
01:48:23.159 is for selecting a non-default provider
01:48:24.960 configuration life cycle this is for
01:48:27.420 life cycle customizations provisioner
01:48:30.000 this is and also for connections for
01:48:31.980 taking extra actions after resource
01:48:34.260 creation so there's the Quick List now
01:48:36.360 let's jump into them
01:48:37.250 [Music]
01:48:41.280 all right the First Resource meta
01:48:43.139 argument we want to look at here is
01:48:44.400 called depends on and this is the order
01:48:46.080 of which resources are provisioned and
01:48:47.940 is important when resources depend on
01:48:49.619 others before they are provisioned
01:48:51.480 terraform implicitly can determine the
01:48:53.639 order of provision of resources but
01:48:55.920 there may be some cases where it cannot
01:48:57.840 be determined or like the correct order
01:49:00.119 so this is where you can be a bit more
01:49:01.980 explicit so here we have some terraform
01:49:04.920 configuration where we have an AWS
01:49:06.780 instance and it relies on a policy and
01:49:09.119 so what we're doing is we're setting an
01:49:10.920 explicit depends on here so that it
01:49:13.199 knows that it requires that now in a
01:49:15.300 normal use case you would not have to do
01:49:16.679 this but it's hard to find use cases
01:49:18.960 where this happens but when it does
01:49:21.239 become a problem you'll know because
01:49:22.619 your resources will not provision
01:49:24.179 correctly you'll get an error so there
01:49:25.739 you go
01:49:26.480 [Music]
01:49:30.719 let's take a look here at the count
01:49:32.639 resource meta argument and this is when
01:49:34.679 you're managing a pool of objects so an
01:49:36.600 example here would be a fleet of virtual
01:49:38.280 machines where you want to use count so
01:49:41.400 here on the right hand side we have an
01:49:43.440 example of us using that in terraform so
01:49:45.719 we can specify the amount of instances
01:49:47.400 we want so here it is four and then
01:49:49.739 we'll have access to this name value
01:49:51.420 called count dot index so the tags will
01:49:55.020 start at zero so it'll be server zero
01:49:57.540 one two and three then just down below
01:50:01.380 here I just want to show you that with
01:50:03.420 count you can accept a numeric
01:50:05.100 expression so you know if you had a
01:50:07.619 variable that you had set as the subnet
01:50:09.480 IDs or even just an arbitrary number
01:50:11.159 like you want to have X amount of
01:50:12.600 servers this would allow you to do that
01:50:15.239 okay but just so you know those numbers
01:50:17.460 must be whole and a number must be known
01:50:20.400 before the configuration which you'd put
01:50:22.679 in your input variables okay
01:50:24.150 [Music]
01:50:29.159 all right so let's take a look here at
01:50:30.719 four each which is for iterating over
01:50:32.820 resource meta arguments but it's
01:50:34.800 slightly different because it allows you
01:50:37.080 to map over Dynamic values giving you a
01:50:39.239 little bit more flexibility so here's an
01:50:41.159 example of us defining A4 each and
01:50:44.100 notice that we have defined a map
01:50:45.900 sometimes I call it an object because
01:50:47.100 they're so similar but this is a map and
01:50:50.040 the idea is that once you have your map
01:50:52.320 defined with your 4-H you will now have
01:50:54.659 access to these name values so you can
01:50:55.980 do each dot key or each dot value to
01:50:57.960 extract that out
01:50:59.420 you can also just use it like with an
01:51:02.460 array so here we have an array and then
01:51:04.920 we use two set to turn it into a set
01:51:07.320 which it will accept as well and then we
01:51:10.320 can just pull out the key because there
01:51:11.880 will be no value so just an example of
01:51:14.280 with a map and then with something that
01:51:15.840 looks like an array okay
01:51:17.370 [Music]
01:51:21.719 to understand the resource meta argument
01:51:24.780 life cycle we need to understand how
01:51:27.300 resource Behavior works and so when you
01:51:29.340 execute your execution order via
01:51:31.440 terraform apply it will perform one of
01:51:33.780 the following to a resource so the most
01:51:36.360 common one you'll see is a create so
01:51:38.820 these are resources that exist in the
01:51:40.440 configuration but are not associated
01:51:41.880 with a real infrastructure object in the
01:51:44.100 state the way you can tell it's creating
01:51:46.020 it will have this nice little green plus
01:51:47.820 sign the next one is destroy so
01:51:51.000 resources that exist in the state but no
01:51:53.520 longer exist in the configuration and so
01:51:55.920 that's going to tear down your resources
01:51:57.719 out of your Cloud providers this is
01:51:59.280 represented by a minus symbol then you
01:52:01.920 have update in place so the resources
01:52:04.020 who arguments have changed so the idea
01:52:06.480 here is that if you have a virtual
01:52:08.100 machine and let's say you change the
01:52:09.480 size of it it's not going to destroy it
01:52:11.760 it's just going to modify its settings
01:52:13.619 this is represented with a tilde and the
01:52:17.340 last one here is destroy and recreate so
01:52:20.159 resources who arguments have change but
01:52:22.619 which cannot be updated in place due to
01:52:24.840 remote API limitations so there are just
01:52:26.940 some Cloud resources that always require
01:52:28.619 destroy and recreate and this is
01:52:30.960 something very easy to trigger if you
01:52:32.639 are using the replace command or the
01:52:36.119 older terraform tank command in order to
01:52:38.699 replace a degraded or damaged instance
01:52:41.699 so let's talk about life cycle so
01:52:44.100 lifecycle blocks allow you to change
01:52:45.659 what happens to resources on the create
01:52:47.400 update and Destroy lifecycle blocks are
01:52:49.619 nested within resources so here is a
01:52:52.199 resource which is just an Azure Resource
01:52:54.360 Group and within it we have a life cycle
01:52:56.580 block and we're setting our first option
01:52:58.260 here that's possible called the create
01:53:00.179 before destroy so this is a Boolean and
01:53:02.760 when replacing a resource first create
01:53:04.380 the new resource before deleting it so
01:53:06.300 the default is destroyed old first so
01:53:08.400 this is more about just the order of How
01:53:09.900 It's destroyed prevent destroy so
01:53:12.179 ensures a resource is not destroyed then
01:53:14.760 we have ignore changes and this is based
01:53:16.920 off a list of attributes that you feed
01:53:18.239 to it so don't change the resource on
01:53:20.820 create update to store right if a change
01:53:22.920 occurs for the listed attributes so
01:53:24.360 maybe
01:53:25.440 um maybe you uh you're just changing a
01:53:28.260 tag and you say don't don't change uh
01:53:30.600 like don't tear down create or do
01:53:32.880 anything strange if we change a tag okay
01:53:34.679 so there you go that's uh life cycles
01:53:37.420 [Music]
01:53:41.760 so we're looking at our last meta
01:53:43.380 argument here which are resource
01:53:44.639 providers and this goes along with the
01:53:46.199 idea of an alias so here we are defining
01:53:48.900 ourselves a provider in Google Cloud but
01:53:51.360 there's a case where we might need to
01:53:52.800 override the provider uh at a at a per
01:53:56.460 resource level and the way we do that is
01:53:58.260 by creating an additional provider and
01:54:00.300 setting an alias and then here we could
01:54:02.520 change something like the region and
01:54:04.080 then once we have that set we can then
01:54:05.699 reference our provider explicitly under
01:54:08.100 a resource and so that's all there is to
01:54:10.739 it definitely on your exam you will see
01:54:12.780 a question about Alias or you'll see
01:54:14.340 that example so definitely want to know
01:54:16.020 how to do that okay
01:54:17.320 [Music]
01:54:22.100 thank you
01:54:24.300 [Music]
01:54:41.460 all right so we're starting our
01:54:43.139 introduction here into terraform
01:54:44.760 Expressions because there's a lot we can
01:54:46.560 talk about here so expressions are used
01:54:48.659 to refer to or Com or compute values
01:54:51.060 within a configuration so terraform
01:54:53.460 Expressions is a large topic and we'll
01:54:55.380 be covering types and values strings and
01:54:57.659 templates reference to values operators
01:54:59.940 function calls conditional Expressions
01:55:02.400 four Expressions Splat Dynamic blocks
01:55:06.360 type constraints actually I don't think
01:55:08.100 we covered type constraints just because
01:55:09.420 there's nothing really to say about it
01:55:11.040 but we definitely cover version
01:55:12.300 constraints so yeah let's start off the
01:55:14.400 section and go to it
01:55:15.490 [Music]
01:55:19.560 so we're taking a look here at types and
01:55:21.540 values for expressions and so the result
01:55:23.580 of an expression is a value and all
01:55:25.560 values have types and so we have
01:55:27.179 primitive types no type and complex
01:55:29.580 structural collection types that last
01:55:31.139 one is a bit more complicated than what
01:55:33.360 we are presenting here we're going to
01:55:35.219 simplify it and then cover it later okay
01:55:37.139 so for primitive types we have strings
01:55:39.360 so you have your double quotations which
01:55:42.060 represent your string then you have
01:55:43.860 numbers so it's going to be integers or
01:55:45.840 floats then you have booleans so this is
01:55:48.360 either true or false for no types we
01:55:50.520 have null and so null is different in
01:55:53.639 all different types of languages so it's
01:55:55.199 very important to understand how it
01:55:56.460 works and so null represents absence or
01:55:58.679 Omission when you want to use the
01:56:00.900 underlying default of a provider's
01:56:02.639 resource configuration option so when
01:56:04.440 you're saying null doesn't mean it's
01:56:05.580 nothing it's going to be whatever the
01:56:07.139 default is and the default also could be
01:56:09.960 nothing it's just depending on what that
01:56:11.460 is on the provider so for collection or
01:56:13.860 for a collection types complex
01:56:15.360 structural types we have list or Tuple
01:56:17.340 and this generally looks like an array
01:56:19.260 the then you have map and object and
01:56:21.540 this looks like basically like a Json
01:56:23.340 object or a ruby hash or I think they
01:56:26.639 call it in Python a dictionary so that
01:56:29.280 gives you an idea of the basic types but
01:56:31.320 for this last one here because this I
01:56:33.780 found really confusing list tuples map
01:56:35.699 object we definitely explain this more
01:56:37.260 in the course okay
01:56:38.430 [Music]
01:56:42.540 okay so we're giving a little bit more
01:56:43.980 attention to the string type because
01:56:45.960 there's a little bit more going on here
01:56:47.280 so when quoting strings you got to use
01:56:49.199 double quotes uh at one point terraform
01:56:51.600 I believe supported single quotes I
01:56:53.159 think it only Sports double quotes now
01:56:54.659 and honestly you generally want to just
01:56:56.639 use double quotes because double quotes
01:56:58.020 always support Escape sequences this is
01:57:00.360 pretty much standard across all
01:57:01.739 programming languages but the idea here
01:57:04.080 is you can do things like new line
01:57:05.699 carriage return tab literal quotes
01:57:08.340 literal backslashes Unicode characters
01:57:10.800 both basic multilingual plane and
01:57:13.320 supplementary planes there are some
01:57:15.719 special Escape sequences this makes
01:57:17.460 sense when we look at the next slide for
01:57:18.840 string templates but there's these
01:57:21.179 things where you can do interpolation
01:57:22.679 and so you might not want to actually do
01:57:25.380 them you might want to do it without and
01:57:28.320 so if you just use double of the symbol
01:57:30.599 that will allow you to do it then there
01:57:33.179 is also the ability to have multi-line
01:57:34.860 strings and we use hear DOC for that and
01:57:37.500 so here Doc is a little bit different in
01:57:39.000 all languages but here we're using Unix
01:57:40.739 style so that means that we're going to
01:57:42.000 start with these two two angled brackets
01:57:43.679 to the left our opening angle brackets
01:57:46.260 followed by some word that is all in
01:57:48.780 uppercase it doesn't have to be eot it
01:57:51.119 could be whatever you want I always like
01:57:53.159 to type here Doc and then it has to end
01:57:55.080 at the same indentation level with the
01:57:57.360 same word all uppercase and then
01:57:59.639 everything in between will be treated as
01:58:03.300 um
01:58:04.020 as multi-line the nice thing about this
01:58:05.820 is that when you have this you can
01:58:07.139 actually just use double quotes wherever
01:58:08.460 you want because you don't have to
01:58:09.480 escape them okay let's take a look at
01:58:11.400 string templates because this is the
01:58:12.900 real power of strings so the first is
01:58:15.360 string interpolation and this allows you
01:58:17.520 to evaluate an expression between the
01:58:19.739 markers so the idea is instead of having
01:58:21.840 to do double quotations and do plus
01:58:23.639 signs to stitch together uh strings what
01:58:26.639 you do is just do a dollar sign uh curly
01:58:29.460 braces and then put the the expression
01:58:31.500 or variable that you want uh to be
01:58:34.099 converted okay then you have string
01:58:36.719 directives and these are slightly
01:58:38.040 different this allows you to evaluate an
01:58:40.199 expression for a conditional logic
01:58:42.060 between the markers so let's say we want
01:58:44.820 to have an if else statement so if the
01:58:46.800 name is blank
01:58:48.619 then use VAR name or sorry if it's not
01:58:52.739 blank then use the name provided
01:58:54.719 otherwise put it as unnamed okay you can
01:58:58.440 also use interpolation directives with
01:59:00.300 hear docs so you know just to show that
01:59:03.239 you can do it and then the last one
01:59:05.400 thing here is you can strip out white
01:59:07.980 space that would normally be left by
01:59:09.360 directors blocks by providing a trailing
01:59:12.060 tilde so just notice this little tilde
01:59:15.000 here on the end because these do take up
01:59:16.739 space so if you were to view it there'd
01:59:18.540 just be an empty space there if you want
01:59:19.860 that space to vanish then you just put
01:59:21.420 that tilde on the end so there you go
01:59:24.239 foreign
01:59:27.300 let's take a look here at the possible
01:59:29.400 operators that we can use within
01:59:31.020 terraform expressions and so just a
01:59:33.119 refresher operators are mathematical
01:59:34.920 operations you can perform two numbers
01:59:36.840 within Expressions I'm not going to show
01:59:39.360 full examples here and the outputs of
01:59:41.699 them because this is pretty common for
01:59:43.500 programming or scripting languages and
01:59:45.300 also the exam is not really going to
01:59:46.560 focus on the use cases for these so it's
01:59:49.380 just more so to tell you what is
01:59:51.119 available too so you know what you can
01:59:52.739 use the first is multiplication so you
01:59:55.080 take two numbers and times them to get a
01:59:57.360 larger number division so it uses a
02:00:00.000 forward slash modulus and if you've
02:00:02.639 never used modulus I really like this it
02:00:04.139 allows you to see if something is
02:00:06.000 divisible by a certain amount and then
02:00:07.260 you get the remainder you have addition
02:00:09.119 subtraction if you need to flip to a
02:00:12.060 negative number you can just put a minus
02:00:13.860 sign in front of it if you need to do
02:00:16.040 equals its doubles if you want to do
02:00:18.659 does not equal its exclamation equals
02:00:21.659 then we have a less than so that's a
02:00:25.020 open angled bracket less than or equal
02:00:27.840 so that will be followed by an equal
02:00:29.940 sign greater than is a closing angle
02:00:32.280 bracket and Then followed by an equal
02:00:33.780 sign for greater than or equal you have
02:00:35.880 or which uses the double pipes you have
02:00:38.159 n which uses the double ampersands if
02:00:40.440 you need to flip a Boolean you can just
02:00:42.420 put an exclamation in front of it so if
02:00:44.280 it was true now it is false if it was
02:00:45.900 false now is true I'm not sure what it
02:00:47.760 would do for an all I would think that
02:00:49.020 it would turn it to true but uh yeah so
02:00:52.739 there you go
02:00:53.699 foreign
02:00:58.139 we're taking a look here at conditional
02:01:00.060 expressions and this is pretty much the
02:01:01.800 only way that you can do if-el
02:01:03.119 statements within terraform but it works
02:01:05.219 out fine and so it's actually using the
02:01:07.380 ternary style of ill if else so what
02:01:09.840 that looks like it's a single line so
02:01:11.580 the it starts with a question mark so
02:01:13.260 that's the if and then it's the True
02:01:15.179 Value and then the colon represents the
02:01:17.400 else and then you have your false value
02:01:19.139 it's ternary because there's three
02:01:21.179 things one two and three okay so that's
02:01:23.699 the way I remember this thing it's not a
02:01:27.119 a preferred way of doing Ethel
02:01:28.739 statements in other languages because it
02:01:31.739 is a little bit condensed but it makes
02:01:33.659 sense when you're using scripting
02:01:34.800 language and you're really restricted on
02:01:36.719 per line actions so this is what it
02:01:38.820 would look like in action so we'd have a
02:01:40.500 variable that is a if a does not equal a
02:01:44.219 blank then use the variable or set it to
02:01:47.460 default a as a string so that's kind of
02:01:49.380 an example there
02:01:50.760 I'll just wipe that away there the
02:01:52.619 return type of it of of the if and else
02:01:55.320 must be the same type so if you have a
02:01:58.800 number okay and the one if statement and
02:02:02.099 then you have a string they have to be
02:02:03.960 the same so uh obviously we want a
02:02:07.080 string to be returned in both cases so
02:02:08.580 what we'll do is use this built-in
02:02:10.199 function to string to turn this into a
02:02:12.179 string so that we're not going to run
02:02:14.159 into any problems so there you go
02:02:16.220 [Music]
02:02:20.460 all right we're taking a look here at
02:02:22.080 four expressions and so these allow you
02:02:24.599 to iterate over a complex type and apply
02:02:26.460 Transformations a four expression can
02:02:28.320 accept as input list set Tuple map or an
02:02:31.139 object I want to distinguish this
02:02:32.820 between four each which is a resource
02:02:35.520 meta argument which allows you to
02:02:36.900 iterate over a a resource or a
02:02:40.020 collection of resources that are similar
02:02:42.540 but four expressions are for these
02:02:45.119 primitive types or not these primitive
02:02:46.920 types but these collection structural
02:02:48.659 types that we talked about in types and
02:02:50.699 values okay so here's an example of
02:02:53.219 something we might want to do imagine we
02:02:54.840 have a list of names and we want to
02:02:56.280 iterate through our list and make them
02:02:58.560 all uppercase so we could do that with
02:03:00.540 this four so we have the four with the n
02:03:02.400 and then we're providing the value of
02:03:04.020 each item in our list it's easy to think
02:03:06.719 of list or Tuple as an array so I'll
02:03:08.760 just call it an array okay
02:03:10.320 then you have a map and so this is where
02:03:13.440 it has a key and value this is going to
02:03:14.760 be for maps or objects and the idea is
02:03:17.159 that we can then go apply
02:03:18.420 Transformations and notice that we are
02:03:20.340 returning only a single string so we're
02:03:22.380 actually going to get back something
02:03:23.460 like a tuple and so how does it decide
02:03:25.920 whether it returns a um a array or
02:03:29.639 something that looks like an object
02:03:30.480 we'll explain that here in a moment the
02:03:32.280 last one here is we have a list with an
02:03:34.199 index so it's very similar to the first
02:03:35.940 one but in this case we want to know the
02:03:38.940 index here so imagine this says zero is
02:03:41.880 Andrew one is Cindy two is Peter and it
02:03:46.500 would come back as an array or list so
02:03:48.540 let's talk about the return types the
02:03:49.800 return types are defined by the um uh
02:03:52.800 the braces or brackets that are around
02:03:55.080 the actual expression so if you have
02:03:56.639 square braces we're going to go back to
02:03:57.900 Tuple so it's just think that array so
02:03:59.820 for in this case where we had our list
02:04:02.599 it was returning back a tuple okay
02:04:06.119 if we have curly braces it's going to
02:04:07.679 return an object so here we have a list
02:04:10.860 so it's like an array that's coming in
02:04:12.119 here and then we were specifying as the
02:04:14.040 return uh this kind of object structure
02:04:16.679 and so that's how we're going to get
02:04:18.300 that so that's that there's one other
02:04:20.880 thing we want to mention which has to do
02:04:22.619 with
02:04:23.520 um reducing or ordering so an if
02:04:25.980 statement can be used to reduce the
02:04:27.900 amount of elements returned so in this
02:04:30.599 case what we're doing is we're using an
02:04:32.040 if statement
02:04:33.300 and so we're saying unless this is true
02:04:35.460 so if this is true then return if it's
02:04:37.920 not then return less of what is there so
02:04:41.280 if there's any blank names that are in
02:04:43.380 our list they just won't show up it'll
02:04:45.599 just only show names that are actually
02:04:47.219 there
02:04:48.360 um then we have implicit element
02:04:49.560 ordering so since terraform can convert
02:04:51.780 an unordered type so map objects and
02:04:53.820 sets to an order type list or tuples it
02:04:56.219 will need to choose an implied ordering
02:04:58.260 so for maps and objects they're stored
02:05:00.480 by key A to Z set of strings stored by a
02:05:04.080 strings A to Z everything else is going
02:05:06.540 to be arbitrary ordering so there you go
02:05:08.980 [Music]
02:05:12.960 all right we're taking a look here at
02:05:14.099 spy expressions and these provide a
02:05:15.960 shorter expression for the four
02:05:17.639 expression which we just looked at so
02:05:19.320 what is the Splat operator a Splat
02:05:21.179 operator is represented by an asterisk
02:05:22.920 it originates from the Ruby language and
02:05:24.900 Splats in terraform are used to roll up
02:05:27.000 or soak up a bunch of iterations in a
02:05:29.580 for expression so here is an example
02:05:32.460 where it's for list sets or tuples so
02:05:34.920 here we have a list and the idea is that
02:05:37.139 we're iterating over this ID or in this
02:05:40.080 game we're iterating over
02:05:42.360 um its objects or sorry a array and then
02:05:46.199 that array is containing a bunch of
02:05:48.060 objects and so we're accessing the name
02:05:49.560 within it and so instead of writing it
02:05:51.480 like that we don't even have to use it
02:05:53.099 for at all what we can do is put this
02:05:55.199 asterisk here and this is going to
02:05:56.460 equate to the same thing so here this is
02:05:58.860 going to return all the IDS and in this
02:06:00.659 case it's going to return a all the
02:06:02.760 lists and allow us to access the
02:06:04.920 interfaces along to the name okay
02:06:08.099 so let's take a look at spy Expressions
02:06:10.980 uh when we're applying them to lists so
02:06:13.380 if the value is anything other than a
02:06:15.300 null value then the Splat expression
02:06:16.679 will transform it into a single element
02:06:18.239 list if the value is null then the
02:06:20.639 expression uh the then the Splat
02:06:22.080 expression will return an empty Tuple
02:06:24.000 and so this behavior is useful for
02:06:25.980 modules that accept optional input
02:06:27.780 variables whose default value is null to
02:06:30.300 represent the absence of any value to
02:06:32.099 adapt the variable value to work with
02:06:33.900 other terraform language features that
02:06:35.760 are designed to work with collections so
02:06:37.980 I know that's a big mouthful it's just
02:06:39.599 kind of like an edge case to these Spa
02:06:42.119 Expressions this is not going to show up
02:06:43.260 in the exam but I just wanted to show it
02:06:44.760 to you in case you're interested here
02:06:46.619 and just notice the spots being used
02:06:48.480 over here okay
02:06:49.920 foreign
02:06:53.300 [Music]
02:06:54.540 so we're taking a look here at Dynamic
02:06:56.099 blocks and this allows you to
02:06:57.540 dynamically construct repeatable nested
02:06:59.280 blocks so I want to emphasize that this
02:07:00.900 is a very powerful feature that can lead
02:07:03.239 to abuse where your code becomes uh
02:07:05.159 difficult to read but it's also very
02:07:07.139 flexible it will absolutely show up in
02:07:08.820 the exam so pay close attention on how
02:07:10.739 this works so let's say you needed to
02:07:12.960 create a bunch of Ingress rules for your
02:07:14.820 ec2 security group and so this would
02:07:17.520 lead to a lot of repeatable elements for
02:07:19.739 rules within your resource and so what
02:07:22.500 you can do with Dynamic blocks is you
02:07:24.360 can Define objects locally so here I
02:07:26.880 have my Ingress rules as an object so
02:07:28.980 here's one and here is two and then
02:07:31.440 using Dynamic block what I can do is use
02:07:34.020 a 4-H to reference those Ingress rules
02:07:36.500 and within this Dynamic Ingress block
02:07:39.420 we'll have our content and this will
02:07:41.280 specify the things that we're swapping
02:07:43.380 out so the idea is that it will iterate
02:07:45.599 over this and apply all those values
02:07:47.280 there so it's something you can't do
02:07:49.380 with a 4-H or account this is basically
02:07:51.780 the the most advanced iteration but just
02:07:55.080 understand if you remember this use case
02:07:56.460 and it's very easy to understand or
02:07:58.199 remember how to use it when you're doing
02:08:01.199 an exam okay
02:08:02.030 [Music]
02:08:05.820 we're looking at version constraints so
02:08:08.159 terraform utilizes semantic version for
02:08:10.380 specifying terraform providers and
02:08:12.360 module versions so semantic versioning
02:08:14.340 is an open standard on how to define
02:08:16.679 versioning for software management so
02:08:18.239 you have your major minor and your patch
02:08:21.300 and so here are examples or variants on
02:08:23.880 this here so we have
02:08:25.679 um you know where you see major minor
02:08:27.119 then you can have this RC this rc1 or
02:08:30.960 you could not have it or you can have
02:08:32.159 beta and this can all be read about on
02:08:34.619 the samver.org but just to quickly go
02:08:36.960 through it
02:08:37.860 major version is when you want to make
02:08:39.960 incompatible API changes minor is when
02:08:42.780 you add functionality that is backwards
02:08:44.699 compatible in matter
02:08:46.320 patch is when you make backwards
02:08:48.300 compatible bug fixes there are
02:08:50.159 additional labels for pre-release build
02:08:51.960 metadata that are available as
02:08:53.699 extensions so that's where we see those
02:08:56.880 little additions there at the top a
02:08:59.460 version straight is a string containing
02:09:01.199 one or more conditions separated by
02:09:02.699 commas so you have your equals or no
02:09:06.480 operators or sorry your equals or no
02:09:09.540 operators so match exact version of the
02:09:12.239 number so it's either with the equals or
02:09:14.520 not with the operator at all okay that's
02:09:17.099 what I'm trying to write there excludes
02:09:18.960 an exact number uh version so if we just
02:09:21.599 said does not or will not be uh 1.0.0
02:09:26.040 then you have a comparative ones so they
02:09:28.739 have the version has to be greater or
02:09:30.239 equal to 1.0.0
02:09:33.840 um and then we have one with the tilde
02:09:35.520 so allows only the rightmost version of
02:09:37.920 the last number to increment so what
02:09:39.420 this means is that the the last number
02:09:41.639 here is only allowed to increment okay
02:09:45.300 so let's talk about Progressive
02:09:46.560 versioning because this kind of ties
02:09:47.639 into semantic uh versioning but
02:09:50.099 Progressive version is the practice of
02:09:51.599 using the latest version to keep a
02:09:53.340 proactive stance of security modernity
02:09:56.099 and development agility and we like to
02:09:59.099 describe this as practicing good hygiene
02:10:00.599 when we're uh working with our code okay
02:10:03.179 so by being up to date you're always
02:10:05.820 pushing left on things that need to stay
02:10:08.880 fixed or compatible you'll have to deal
02:10:11.520 with smaller problems instead of dealing
02:10:12.960 with a big problem later on run nightly
02:10:15.659 builds is a good example where you might
02:10:17.460 have golden images and the idea is to
02:10:19.619 provide a warning signal just to kind of
02:10:21.659 elaborate on that a nightly build is an
02:10:23.699 automated workflow that occurs at night
02:10:25.739 when developers are asleep so if the
02:10:27.599 build breaks because A change is
02:10:29.099 required for the code the developers
02:10:30.360 will see this upon arrival in the
02:10:32.340 morning and be able to budget
02:10:33.420 accordingly so what I'm trying to get at
02:10:35.040 is that when you are like
02:10:38.400 putting in your providers especially if
02:10:40.679 you copy from the terraform
02:10:42.599 um
02:10:43.320 the terraform website to get the
02:10:45.360 providers and modules what they'll do is
02:10:47.340 they'll actually have it set as the I'm
02:10:48.900 just going to roll back here for a
02:10:49.980 second but they'll actually have it set
02:10:51.119 as the equals what I'm saying to you is
02:10:53.040 you want to use something like a tilde
02:10:55.679 or a greater than or equal sign so that
02:10:57.780 you are staying Progressive okay so
02:11:00.360 that's just one thing I want you to
02:11:01.500 watch out for and we will talk about
02:11:02.699 that when we go through the follow
02:11:04.080 alongs okay
02:11:04.900 [Music]
02:11:09.179 hey it's Andrew Brown from exam Pro and
02:11:11.099 we are moving on to our expression
02:11:12.420 section starting with string templates
02:11:14.460 let's learn all about that and we are
02:11:16.199 going to have to CD into a new folder
02:11:18.119 here
02:11:19.020 so I have one called expressions and we
02:11:21.780 will make ourselves a new file called
02:11:23.960 main.tf we'll Define a local back end
02:11:28.139 and I'm going to just Define a new
02:11:30.119 variable
02:11:31.320 I'm going to call this variable hello
02:11:34.500 and I'm going to give it a type of
02:11:36.780 string
02:11:39.179 okay and that's all I'm going to do
02:11:41.340 there and then what we're going to do is
02:11:42.599 create ourselves a TF VAR file so we'll
02:11:45.540 say
02:11:46.500 terraform Dot tfvars and in there we'll
02:11:50.340 just set hello
02:11:51.960 to world
02:11:53.580 and so what I want to do is enter
02:11:55.020 terraform console
02:11:56.639 okay this is going to allow us to just
02:11:58.440 run arbitrary Expressions I want to show
02:11:59.940 you how you quit it you just type exit
02:12:01.440 and so we'll do is make a string so
02:12:03.480 we'll just first do a Hello World
02:12:05.880 I want to show you that you can put a uh
02:12:08.460 a new line there and we'll get back a
02:12:10.139 multi-line document this is a
02:12:12.659 um this console doesn't allow for
02:12:13.980 multiple lines so we can't write our own
02:12:15.540 here doc but I can show you what it
02:12:16.739 looks like
02:12:17.639 and then we can interpolate a uh a
02:12:20.639 variable there so we'll just say hello
02:12:23.760 and notice we get hello world so that's
02:12:26.159 how interpolation works it's not super
02:12:28.320 complicated directives is a little bit
02:12:31.260 different
02:12:32.119 where we have string right so we can do
02:12:35.460 instead this
02:12:37.260 but the control word is a bit different
02:12:39.179 because you're using the uh this um
02:12:43.199 percentage sign the directives when
02:12:44.940 you're doing something like an if else
02:12:46.080 statement so what we could do
02:12:49.219 is say something like
02:12:52.679 um barsoon here
02:12:56.699 okay
02:12:59.119 and what I'm going to do is just exit
02:13:01.679 out here clear because I don't know if
02:13:04.139 it um it reloads the uh the variables
02:13:06.540 there if you just change them on the Fly
02:13:08.940 but what we'll do is we'll just say
02:13:10.440 hello and we will write ourselves an if
02:13:14.880 statement so we're going to say if VAR
02:13:16.800 dot hello equals
02:13:21.179 bar soon
02:13:23.040 what it's going to do is then print out
02:13:26.760 um
02:13:27.719 it's going to instead print out Mars
02:13:30.659 okay
02:13:33.239 otherwise
02:13:36.119 what we're going to get is
02:13:40.500 um
02:13:41.639 world okay
02:13:43.679 you know what's really interesting is
02:13:45.540 we're using the if and else
02:13:47.940 here
02:13:49.679 but I I could have swore that the only
02:13:51.420 thing you had was ternary operators so
02:13:53.400 like if you look at the conditional
02:13:55.920 expressions
02:13:57.659 notice here that it's doing this and
02:13:59.460 it's not showing the documentation the
02:14:01.320 FL so you know maybe maybe that's just
02:14:04.800 for a one-liner and if else does exist
02:14:06.659 for expressions and I might have missed
02:14:08.400 that in the course but you cannot blame
02:14:10.739 me if the documentation shows it like
02:14:12.480 that okay
02:14:13.860 so what I'm going to do here is just go
02:14:16.500 ahead and hit enter
02:14:18.119 and here we get hello Mars so that
02:14:20.159 pretty much
02:14:21.179 uh shows you how string interpolation
02:14:24.719 works for both interpolation and
02:14:27.239 directives we'll just type in exit and
02:14:29.639 so that's all we want to do there okay
02:14:31.580 [Music]
02:14:35.760 all right so let's learn about four
02:14:37.079 Expressions so four Expressions allow us
02:14:38.820 to kind of iterate over something and do
02:14:40.500 something fun with it and so what we're
02:14:43.139 going to do is create ourselves some
02:14:46.260 more complex types here so how about
02:14:49.020 instead of like this was just hello a
02:14:50.520 second ago but we'll change this over to
02:14:52.380 Worlds and what I'm going to do is just
02:14:54.360 list out a bunch of Worlds here from the
02:14:56.760 uh the book uh John Carter books so we
02:14:59.940 have bar soon we have
02:15:03.619 jasum
02:15:05.340 we have things like sesum
02:15:09.540 okay and then we have whoops
02:15:13.560 so assume and then we have something
02:15:16.199 like cosume okay
02:15:18.719 and so the idea here is now that we've
02:15:21.480 defined that there we've got to go back
02:15:22.980 to our main TF I'm just going to update
02:15:24.900 this to the worlds this will just be a
02:15:28.139 list
02:15:29.699 all right and so what we'll do is make
02:15:32.040 our way over to terraform cloud or sorry
02:15:34.079 terraform console
02:15:35.940 and we will try to do a four Loop here
02:15:38.460 so I'm going to do Square braces four
02:15:41.040 and we'll just say w in VAR dot worlds
02:15:46.040 and then what we can do here is
02:15:50.219 make a colon whoops
02:15:54.119 okay and then type upper
02:15:57.540 W and so that returns them all in
02:16:00.659 uppercase there
02:16:02.340 and if we were to use the Splat operator
02:16:04.920 and technically this is something we
02:16:06.179 want to move on to the next part
02:16:08.040 but
02:16:09.300 um yeah we'll leave it for the next
02:16:11.280 video I'll just keep that separate so
02:16:12.960 that is for just if we had a list
02:16:15.000 imagine if we had this as the as an
02:16:18.300 index here
02:16:23.040 um or we'll say map
02:16:26.159 because what we can do is actually map
02:16:27.719 these two names
02:16:31.380 so bring this down here
02:16:35.218 and this would be Earth
02:16:38.519 now you can use the colon or the equals
02:16:40.978 it's just whatever you want to use here
02:16:42.359 they're both supported actually this is
02:16:44.519 an Earth this is Mars and then this one
02:16:46.799 here is Earth
02:16:48.620 and this one here would be
02:16:52.260 Jupiter
02:16:54.898 and then this one here would be Venus
02:16:59.099 okay
02:17:01.439 um and so I think we still need to
02:17:03.299 Define it over here
02:17:05.760 so I'm just going to say world's map
02:17:08.580 and then what we can do here instead of
02:17:10.799 having list we can say map
02:17:13.920 and we'll try to iterate over this so
02:17:16.558 it's going to be very similar except the
02:17:18.898 difference is now we have a key and we
02:17:20.939 have a value
02:17:23.160 and so if we just want to return the
02:17:25.799 names in capital we can just do K here
02:17:30.000 oh that's the index uh what if we do
02:17:34.379 oh you know why it's because
02:17:36.240 um
02:17:36.840 we have to do Worlds Map
02:17:39.540 okay
02:17:40.978 so reference to Undeclared variable map
02:17:43.500 so we do have to exit and restart
02:17:50.340 and oh sorry the input was complaining
02:17:52.620 there so I'll just copy the one up here
02:17:54.299 so I have to type it again
02:17:57.179 nope it did not work as we thought okay
02:17:59.519 so I do have to type it by hand
02:18:01.500 kind of a pain but I guess that's just
02:18:03.179 how it works so we'll say 4K V invar Dot
02:18:07.439 worlds
02:18:08.700 map
02:18:09.898 and then we say upper
02:18:11.879 B here
02:18:13.379 okay or we could just say take the K
02:18:15.179 here and get the other values now I
02:18:17.459 didn't show you this a moment ago but if
02:18:19.080 we do worlds here we can specify an
02:18:22.320 index and an index would come first so
02:18:24.718 it would be the value like the world the
02:18:27.660 second and the index is first so notice
02:18:30.058 that I is all a number the index of it
02:18:33.420 and then the that is the value there
02:18:36.540 um
02:18:37.138 we could probably also return this as a
02:18:39.840 map so notice that square braces are
02:18:41.459 going to give you a list or and then
02:18:44.280 curlers are going to give you map which
02:18:45.780 kind of correspond to their actual data
02:18:47.280 structure so if we wanted to turn this
02:18:49.379 into the opposite here what we could do
02:18:52.138 is just say uh we probably do string
02:18:54.478 interpolation
02:18:56.160 like this here and do I
02:18:58.379 and then do equals or even maybe a colon
02:19:01.500 here
02:19:02.638 and then do the world like that
02:19:05.040 and it didn't like the way I specified
02:19:06.780 it so I'll try it like this instead
02:19:10.439 extra characters after the line four
02:19:15.859 so I don't see that wrong there just
02:19:19.439 give me a moment I think um
02:19:23.160 oh you know what it's we need to use in
02:19:25.500 this case I think we have to do it this
02:19:27.120 way
02:19:28.260 okay so we use use the hash rocket so in
02:19:30.840 that particular case you have to use the
02:19:32.398 hash rocket that's what that symbol is
02:19:33.660 called the equal zero
02:19:35.820 um and so that's how we can get that
02:19:37.679 value there so that pretty much outlines
02:19:40.138 how to use
02:19:41.820 um the for loops and next we're going to
02:19:43.859 go probably look at the Splats okay so
02:19:46.379 I'll see you back here in a moment I'm
02:19:48.359 just going to exit this actually before
02:19:50.340 we move on to Splats I just want to add
02:19:52.380 one more thing to four Expressions which
02:19:53.760 is filtering so we'll just go back here
02:19:56.280 and get back into
02:19:58.500 our terraform console here
02:20:01.380 and what I'm going to do is just write
02:20:03.120 another four
02:20:04.439 and it probably would make sense to use
02:20:06.899 the uh the the world's list we just did
02:20:09.120 there so I'm going to do KV type in VAR
02:20:12.620 world's map
02:20:14.880 and so the idea here is that I only want
02:20:17.880 the let's say we'll say the upper I only
02:20:21.420 want the
02:20:22.939 key value here but I would just say at
02:20:26.580 the end here I can say if the V the
02:20:29.820 value equals I can't remember what we
02:20:31.859 set these as
02:20:33.240 so this is key in value so if it is Mars
02:20:38.939 I think it's double equals so if it is
02:20:40.859 Mars
02:20:43.620 then only return it that way or we could
02:20:45.720 say the opposite say
02:20:47.399 give me everything but Mars okay so I
02:20:50.280 just wanted to show you you could use
02:20:51.359 that if to do that filtering so I'm
02:20:53.880 going to exit there and we'll move on to
02:20:55.740 spots okay
02:20:56.650 [Music]
02:21:00.899 all right so we're moving on to Splats
02:21:02.700 and what we'll have to do is create
02:21:04.020 ourselves a new variable here I'm going
02:21:07.319 to call this one world's
02:21:09.740 Splat and this one is going to be a list
02:21:12.540 and so if we go back up here to tfvars
02:21:15.060 we'll make ourselves a new variable down
02:21:17.460 here and we'll just call this one splat
02:21:19.800 and it's going to be a list but it's
02:21:22.080 going to contain inside of it a bunch of
02:21:24.120 maps
02:21:25.080 okay so we'll do pretty much this up
02:21:27.960 here
02:21:30.359 okay but what's going to happen here
02:21:32.880 it's going to be slightly different
02:21:33.720 where we are going to
02:21:36.240 set what is the name
02:21:44.340 so we'll just say like
02:21:46.140 um
02:21:47.160 Earth name
02:21:49.439 that's actually Mars name so it's a Mars
02:21:51.420 name here
02:21:53.280 for all these
02:22:01.200 and then over here these are going to be
02:22:07.020 the Earth name
02:22:24.540 so I think that is valid and what we're
02:22:27.479 going to do here is just type in
02:22:29.040 terraform console
02:22:31.200 and if we wrote that correctly oh no we
02:22:33.420 got an error so it says expected an
02:22:35.160 equal sign to Mark the beginning of a
02:22:36.960 new attribute value
02:22:39.600 so I mean this should be okay
02:22:45.840 uh oh you know what I think this Colon's
02:22:48.840 just missing here
02:22:50.160 put it up again
02:22:52.500 there we go we're fine so if we just
02:22:54.660 want to look at that variable I think we
02:22:55.920 just type it in here and it might print
02:22:57.120 it out if we're lucky
02:22:58.859 yes so there it is
02:23:00.960 um so what we're going to do here is use
02:23:04.020 a Splat to get maybe the Mars name or
02:23:05.880 something so if we used a for Loop what
02:23:07.979 we'd have to probably write we could try
02:23:09.420 this
02:23:10.140 but we'd have to do four and then it
02:23:12.300 would be for the actual map so say m for
02:23:16.080 map in world's splat
02:23:19.920 and then we would have to do m
02:23:23.340 Dot Mars name
02:23:27.420 and so a reference to the attribute
02:23:31.200 by one axis treatment specifying the
02:23:33.180 resource name
02:23:35.520 so I mean that looks oh you know it's
02:23:37.080 because we didn't write VAR okay
02:23:39.780 I say we but it was really me so you
02:23:42.600 know that's that but we could write this
02:23:43.920 in a more concise way
02:23:49.859 okay and so we use a splat
02:23:52.439 Mars name
02:23:54.420 okay so you know that's a lot more
02:23:56.760 convenient if we're just trying to
02:23:58.200 access variables like that
02:24:00.060 um I think that if you're trying to do
02:24:01.760 things like
02:24:04.200 if you want to do upper here
02:24:07.740 I think you still have to use A4
02:24:10.260 expression
02:24:12.660 okay I don't think you can do this we
02:24:14.819 can try it but I really don't think that
02:24:16.200 will work
02:24:24.720 no and if we look at the documentation
02:24:26.819 they don't show an example like that so
02:24:28.740 you know it's not that bad but you can
02:24:31.020 see that it's for a particular use case
02:24:32.700 you can't use that for uh Maps or
02:24:35.160 whatever the equivalent the other map is
02:24:37.620 object but it's useful for this one
02:24:40.920 particular use case okay
02:24:43.060 [Music]
02:24:47.340 hey it's Andrew Brown from exam Pro and
02:24:49.260 we are on to the dynamic blocks follow
02:24:50.819 along so this one should be uh pretty
02:24:52.680 fun because it's uh quite a powerful
02:24:54.600 feature so what I've done is I've
02:24:56.880 created a new folder here called Dynamic
02:24:59.220 blocks I'm going to make a new file here
02:25:00.780 as always it's going to be main.tf and a
02:25:03.899 really good example for this would
02:25:05.220 probably be a database Security Group
02:25:07.080 just because there's all those Ingress
02:25:08.520 and out outgress or egress rules so what
02:25:13.020 we're going to do is just Define our
02:25:14.280 terraform settings block and I'm just
02:25:16.560 going to pull up over here and make our
02:25:19.260 way over to the registry for terraform
02:25:21.120 and what we're going to do is go over to
02:25:23.100 the AWS provider and go to the
02:25:26.040 documentation and actually I first want
02:25:28.560 to grab the provider itself because that
02:25:30.720 is something very easy that we can do
02:25:32.280 here we'll just move that on over so we
02:25:34.920 can see what we're doing and paste that
02:25:37.020 on in and we're going to have to Define
02:25:39.120 our provider of course so we'll name
02:25:41.640 that as AWS the profile is going to be
02:25:45.319 defaults and our region will be us East
02:25:49.140 one
02:25:50.819 okay and so now what we need is to
02:25:53.300 co-create ourselves a security group
02:25:56.280 so we have of course done that
02:25:57.899 previously here but
02:25:59.939 let's pull up the uh documentation here
02:26:02.100 I believe it was actually under VPC so
02:26:04.560 let's just go down to VPC here and we
02:26:06.899 will expand that and then underneath
02:26:08.340 here there should be a AWS Security
02:26:10.140 Group
02:26:11.040 uh there it is and if we scroll on down
02:26:14.100 there's the thing okay so what I'm going
02:26:17.100 to do is copy uh this code here and go
02:26:20.160 over and we'll just paste that on in and
02:26:23.640 there is our security group so I
02:26:26.340 remember that we had to have the
02:26:27.899 description if you remember it
02:26:29.700 complained about that
02:26:31.620 so outgoing
02:26:34.080 for everyone
02:26:36.000 and we need to also have a few
02:26:39.780 additional things
02:26:41.460 we will just scroll on down here because
02:26:43.439 it wanted the prefix list IDs
02:26:47.160 okay
02:26:50.220 remember we needed that I think there
02:26:53.220 was like self false
02:26:56.280 and there was like security groups
02:26:59.340 I think it was actually AWS security
02:27:00.479 groups in particular let's just double
02:27:02.399 check to make sure that is the case
02:27:04.800 it is called
02:27:08.280 uh oh it's just security groups okay
02:27:15.180 so
02:27:18.479 we'll say self equals false
02:27:21.660 we do not need cider block four here or
02:27:25.620 six
02:27:27.300 um we do not need this one here and it
02:27:30.120 doesn't really matter what we set this
02:27:31.500 to so it could be set to the main side
02:27:33.300 or block that's totally fine but we are
02:27:35.640 going to need to add a data source just
02:27:38.280 like last time for the VPC
02:27:42.000 so we'll say VPC we'll call that Main
02:27:44.479 and I think it just needed the VPC ID it
02:27:47.819 was as simple as that
02:27:50.460 and so we will go over to AWS over to
02:27:54.960 VPC
02:28:00.660 and from there we are going to go to
02:28:04.040 rvbcs and I will go grab that VPC ID
02:28:12.240 Okay so we've grabbed our VPC ID and
02:28:15.540 then we just need to name this as data
02:28:18.180 and then we're going to name this as
02:28:19.560 data we don't really care what the cider
02:28:21.060 block is it's just again for
02:28:23.700 um this demo purposes we don't need tags
02:28:26.040 we'll take those out
02:28:27.740 and
02:28:29.700 um
02:28:30.240 yeah everything else is fine okay so
02:28:33.560 this now comes to the fact that we want
02:28:36.359 to use Dynamic blocks before we do that
02:28:39.180 let's just well I think I didn't leave
02:28:41.160 the console there last but what we'll do
02:28:43.560 here is
02:28:45.660 just to our terraform inits
02:28:48.540 and as that is pulling that stuff we're
02:28:51.359 going to look up Dynamic blocks
02:28:55.740 uh terraform
02:28:59.340 so we'll go here and so Dynamic blocks
02:29:01.439 is like way more powerful than um the
02:29:03.780 four each where what we can do I'm just
02:29:06.540 trying to
02:29:08.100 find that example there but we have
02:29:11.220 uh we have to set the dynamic part the
02:29:14.280 4-H you know what I'm pretty sure I have
02:29:15.960 these in my slides so let's just use my
02:29:17.460 slides as the reference here
02:29:22.140 dynamic
02:29:23.700 ah here it is okay so the idea is that
02:29:26.160 we'll just set up a locals with all of
02:29:27.840 our information here and then we will
02:29:29.280 create this Dynamic block and then
02:29:30.720 provide the content okay so I'm just
02:29:33.060 going to move that off screen so I can
02:29:34.680 see what I am doing here as we type it
02:29:36.780 in and we'll see if we run into any
02:29:39.479 problems
02:29:41.280 um failed to query the available product
02:29:43.140 for packages could not retrieve the list
02:29:44.520 of the available versions for the
02:29:46.020 provider uh not have a provider registry
02:29:49.620 terraform name all models should specify
02:29:51.300 the required providers so I'm not sure
02:29:54.000 why it's complaining here but we'll
02:29:55.500 scroll all the way to the top and the
02:29:57.960 required providers is correctly set here
02:30:01.260 so it shouldn't be a problem
02:30:06.060 not sure what it doesn't like
02:30:12.060 um so let's just type in terraform
02:30:13.740 providers here
02:30:18.300 the VPC
02:30:20.340 um is VPC a module
02:30:22.979 you know what it's probably because I
02:30:24.240 didn't do AWS VPC that's probably my
02:30:26.100 problem here
02:30:28.560 terraforming net
02:30:30.720 and as that's thinking there we'll just
02:30:32.580 pull this on down and we'll start to
02:30:34.260 make our locals block okay so we can go
02:30:37.200 here make some locals and we'll do our
02:30:40.680 Ingress
02:30:42.840 and we'll just
02:30:45.300 go like that
02:30:47.040 and the idea is we can say Port whoops
02:30:50.040 we can set the port like that 443
02:30:53.880 we have to always have a description so
02:30:56.160 we'll just set that as well so port
02:30:59.000 443 we can set
02:31:03.060 as much as we want here so I'll just go
02:31:05.160 ahead enter
02:31:08.160 okay
02:31:10.020 and
02:31:13.200 I think that looks right yeah so we have
02:31:18.240 one Ingress here and then we'll just
02:31:19.920 copy this and make a comma
02:31:25.560 vs code is not really formatting the way
02:31:27.180 I wanted to and so we'll do port 80.
02:31:31.020 and then down below we will need to
02:31:32.939 specify
02:31:35.700 hour
02:31:38.520 um
02:31:39.120 for each okay so that's going to be
02:31:42.000 within our Dynamic block so what we're
02:31:43.800 going to do is tab in here I'm going to
02:31:45.720 say dynamic
02:31:48.319 and we'll type it Ingress because that's
02:31:51.300 a match for what we're doing
02:31:55.620 um and then from there we can do our
02:31:57.300 four each equals local Ingress
02:32:01.680 and then we need to specify our content
02:32:03.600 I don't really understand why it's
02:32:06.000 called content and things like that but
02:32:07.439 I just know that that's what we have to
02:32:08.939 do and it's not really that big of a
02:32:10.920 deal so
02:32:13.200 we'll go here and paste that in we can
02:32:15.600 take out our Ingress block there we know
02:32:18.180 we're going to need self these all here
02:32:20.040 but what's going to change
02:32:22.200 are these ports so
02:32:25.200 we will go here it will say Ingress
02:32:28.080 Value Port and this will also be Ingress
02:32:31.020 Value Port
02:32:32.580 and then this will be Ingress value
02:32:35.880 description
02:32:37.920 if we really wanted to we could also set
02:32:39.660 the protocol
02:32:42.600 protocol Pro
02:32:45.600 Tove call
02:32:47.280 and this could be then TCP
02:32:57.540 and so we would just say Ingress value
02:32:59.880 protocol
02:33:05.220 so it just saves us from repeating these
02:33:07.260 over and over again if they're all the
02:33:08.819 same
02:33:09.899 there's a lot you can do with Dynamic
02:33:11.819 blocks but honestly you shouldn't do
02:33:13.200 anything
02:33:14.160 too crazy
02:33:16.140 we'll do our terraform plan and see if
02:33:17.939 this works whoops
02:33:23.939 bring that up there
02:33:26.580 um an argument VPC ID as not expected
02:33:28.920 here okay so
02:33:30.420 that was me just guessing from memory
02:33:32.939 and I guess I guessed wrong
02:33:35.520 uh so what we'll do
02:33:38.399 is we'll just look that up
02:33:42.359 AWS VPC data source terraform
02:33:50.760 oh it's just ID okay
02:33:54.240 so what we'll do is just set ID here
02:33:58.859 and then we'll just hit plan again
02:34:01.620 and that should resolve our issue there
02:34:05.300 uh inappropriate value for a tribute
02:34:08.220 egress security groups is required okay
02:34:11.580 that's fine
02:34:17.220 well this one says doesn't say uh Syria
02:34:21.660 groups
02:34:22.920 and this one doesn't say Security Group
02:34:24.479 so that's probably our problem here so
02:34:25.979 we'll just hit terraform plan again
02:34:32.880 and here it says this VPC ID does not
02:34:36.180 exist probably what happened is they
02:34:37.800 might be in the wrong region
02:34:39.600 it's very common problem
02:34:41.280 on AWS just because of the way their UI
02:34:43.560 works
02:34:45.180 if I can get this window over here and
02:34:48.060 so this is because we're in USC's we're
02:34:50.280 supposed to be in U.S east one here
02:35:00.060 and I'm going to go up
02:35:02.580 to here
02:35:04.620 we'll save that
02:35:06.359 let me hit terraform plan
02:35:17.700 and we could probably like use the
02:35:19.620 filter and also just say choose the
02:35:21.180 default but it's just so easy to put
02:35:22.560 that in like that so
02:35:26.460 doesn't seem like we have any problems
02:35:27.899 here so let's go ahead and execute let's
02:35:29.760 just double check to make sure these
02:35:30.780 values are correct
02:35:32.040 so for the Ingress
02:35:36.300 um Port 443 Port 443 it's probably just
02:35:38.939 because I didn't update the description
02:35:41.220 probably because of a copy paste job yep
02:35:44.580 okay and let's just make sure this works
02:35:46.260 so we'll say terraform apply Auto
02:35:48.960 approve
02:36:01.859 and we'll give it a moment
02:36:04.260 and it's already created so it's that
02:36:06.540 fast we can go here and take a look at
02:36:08.399 it if we like
02:36:09.660 it's not that big of a deal
02:36:13.560 um so we should see it in here I just
02:36:16.380 have so many
02:36:18.000 uh junk security groups here this is a
02:36:20.100 bit hard to find
02:36:21.840 oh allow TLS is what we called it so
02:36:24.240 here it is
02:36:25.920 go to our inbound rules
02:36:28.460 80443 and that's pretty much it so
02:36:32.399 terraform apply
02:36:35.899 destroy Auto approve
02:36:39.780 okay
02:36:46.920 there we go
02:36:48.970 [Music]
02:36:53.220 all right so I want to talk about
02:36:54.300 versioning very quickly here and so I
02:36:56.399 have a new folder called versions I'm
02:36:58.200 going to just make a new file called
02:36:59.840 main.tf and we're going to create a
02:37:02.640 terraform block but what we're also
02:37:04.260 going to do is set required
02:37:07.200 uh providers or sorry required uh we're
02:37:10.500 not providers required version and so
02:37:13.319 what this is going to do is say
02:37:14.760 explicitly what version of terraform we
02:37:16.920 want to use and I'm sending it this as
02:37:18.500 1.0.0 and I'm using this tilde Arrow if
02:37:21.780 you're wondering you know what is the
02:37:23.280 logic behind all those things I think
02:37:24.720 it's all explained in the semantic or
02:37:26.899 semver.org so if you want to learn more
02:37:28.920 I strongly recommend you read through
02:37:30.660 this to understand all the stuff inside
02:37:32.399 and out highly applicable across the
02:37:34.380 devosphere not just to terraform
02:37:37.140 um but you know if we go over to
02:37:38.880 terraform GitHub repository and we drop
02:37:41.520 down the branches and go to tags here we
02:37:43.260 can see all the versioning we are using
02:37:45.120 version 1.0.0 and it all goes up to
02:37:49.280 1.1.0 Alpha which is not out yet and if
02:37:52.319 you wanted to really know what's going
02:37:53.520 on here you go to releases and you can
02:37:55.920 read what they have done so here 1.0.7
02:37:58.620 remove check for computer attribute
02:38:00.300 prevent object types with optional
02:38:02.280 attributes for ETC empty containers so
02:38:05.700 when you're looking at the patch the
02:38:07.740 patch which is the third number the the
02:38:09.540 rightmost number that's going to keep
02:38:11.280 you up to date in terms of security for
02:38:13.560 the the major minor version that you
02:38:16.020 have for the 1.0 and you absolutely
02:38:18.120 always want to be using the latest and
02:38:19.979 so that's what this tilde does it says
02:38:21.660 take the far Road uh the the farthest
02:38:25.020 number to the right and make sure that
02:38:26.880 it's the latest version that has been
02:38:28.380 published
02:38:29.640 um and you know this comes back to my
02:38:31.200 Progressive versioning slide which is if
02:38:33.180 you want to have really good hygiene in
02:38:35.520 terms of your devops we should be doing
02:38:37.859 is at least setting the tilde for sure
02:38:39.899 like this the tilde Arrow or I would
02:38:42.660 even go as far as saying equals arrow
02:38:44.939 and if you're really concerned about
02:38:47.460 um you know not using the next major
02:38:48.899 version you could say you will less than
02:38:50.540 you know like less than
02:38:54.780 um less than you know one point
02:38:57.780 2.0 even if it's not out that's a good
02:39:00.600 indicator to say okay well I don't want
02:39:01.979 to go too far ahead of time but if you
02:39:03.899 want to have Progressive versioning you
02:39:05.160 should really be setting it like this
02:39:06.479 okay
02:39:07.920 and this is going to be applicable for
02:39:10.080 your image providers anything else so
02:39:12.660 you know if we go over to
02:39:16.080 if we go over to the registry
02:39:20.160 and we choose
02:39:23.220 whoops
02:39:25.319 AWS and we drop this down here we have
02:39:28.380 that required version as well so as you
02:39:30.780 copy it in you're going to notice that
02:39:31.859 it's actually hard coded but I would
02:39:33.300 strongly recommend again
02:39:35.280 if we go here
02:39:38.460 and take this and at least at least do
02:39:41.520 this
02:39:42.620 and if you're really really being clever
02:39:45.840 you could do that okay and these are
02:39:48.120 also all in GitHub repositories as
02:39:50.220 that's how everything works so you can
02:39:51.780 go here and click and you can go over to
02:39:55.260 the tags and see the versioning and you
02:39:57.420 can go over to the releases and it's the
02:40:00.479 same thing you can read about all the
02:40:01.800 things that have changed okay and that's
02:40:04.200 something that you should uh you know
02:40:05.880 consider doing all right so that's all
02:40:08.040 there really is to this I might want to
02:40:09.960 show you one more thing and this one is
02:40:11.399 with terraform Cloud so I'm going to go
02:40:12.899 to terraform IO and we're going to open
02:40:15.120 up our terraform cloud and I'm going to
02:40:17.160 sign in I probably haven't signed in a
02:40:18.540 while so probably ask oh nope no
02:40:19.800 username password that's great what we
02:40:21.359 can do is in a workspace we go to
02:40:22.859 settings
02:40:23.720 and is it Version Control no it is
02:40:26.939 general and under here we can actually
02:40:29.399 set the terraform version so if you
02:40:31.080 happen to be working with a particular
02:40:32.460 version you can go and say okay only use
02:40:35.819 this version for terraform cloud and
02:40:38.280 that will
02:40:39.240 um that will not upgrade it'll just keep
02:40:41.399 you there if you need for legacy reasons
02:40:43.140 but again you know what you really
02:40:44.520 should be doing is using that
02:40:47.100 Progressive versioning doing nightly
02:40:49.859 builds and discovering overnight that
02:40:51.960 things are breaking so you can go fix
02:40:54.060 those in the morning okay and that's it
02:40:57.310 [Music]
02:41:01.380 hey this is Andrew Brown from exam Pro
02:41:03.120 and we are taking a look at terraform
02:41:05.040 state so what is State well it's a
02:41:07.260 particular condition of cloud resources
02:41:09.359 at a specific time so give an example
02:41:12.180 imagine we expect to have a virtual
02:41:14.220 machine running Centos on AWS with a
02:41:16.859 compute type of T2 micro that would be
02:41:19.020 the state that we are expecting okay so
02:41:21.660 how does terraform preserve State well
02:41:23.580 when you provision infrastructure via
02:41:25.319 terraform it will create a state file
02:41:27.240 named terraform TF State it's very
02:41:30.120 important to remember that name because
02:41:31.620 it literally is an exam question the
02:41:33.600 exact naming of that okay this state
02:41:35.640 file is a Json data structure with a
02:41:37.740 one-to-one mapping from resource
02:41:39.359 instances to resource or to remote
02:41:41.280 objects and if you're wondering what is
02:41:43.800 a remote object versus a resource
02:41:46.020 instance I cannot tell you I would
02:41:48.359 imagine one is the representation of
02:41:50.340 things that are deployed in the cloud
02:41:52.080 and the other one are objects or or
02:41:55.020 things represented in the state file but
02:41:57.120 they don't clarify it so I just have to
02:41:58.620 take a guess so this is kind of what the
02:42:00.479 Json structure looks like like you can
02:42:02.040 see you see resources this is describing
02:42:04.680 like a type of instance and stuff like
02:42:06.300 that there's not really any case for you
02:42:09.120 to ever go through the terraform State
02:42:10.979 file and look at it but we might take a
02:42:13.500 peek just so that we get familiar as to
02:42:15.120 what it is doing
02:42:16.620 so just to kind of give it a diagram to
02:42:18.479 help you visualize this imagine you have
02:42:20.819 your configuration file so you have your
02:42:22.680 main TF maybe a variables TF a TF bars
02:42:25.859 to load in your variables and then you
02:42:27.720 run a terraform apply command what it's
02:42:30.240 doing is using the terraform API and
02:42:32.340 it's going to create what we'll say
02:42:33.840 these we'll call these remote objects
02:42:35.220 but maybe these are resource instances
02:42:38.100 um but it will go ahead and create those
02:42:40.260 things and then those will get
02:42:41.520 represented within a state file so the
02:42:44.100 idea is that whatever is in the cloud is
02:42:47.700 going to match what's in that file okay
02:42:50.520 now there is a CLI commands for
02:42:53.220 terraform State and it's good just to
02:42:55.020 quickly go through them so we have
02:42:56.640 terraform State list this will list
02:42:58.200 resources in the state terraform State
02:43:00.180 move this will move an item in the state
02:43:02.160 terraform State pull pull current remote
02:43:04.380 State and outputs to St out terraform
02:43:06.960 State push so update remote States from
02:43:09.120 a local state terraform State replace
02:43:11.580 provider so replace a provider in the
02:43:13.740 state terraform State removed so remove
02:43:15.780 instances from the state terraform State
02:43:18.240 shows so show a resource in the state
02:43:20.640 some of these are a little bit
02:43:22.260 interesting so we'll definitely look in
02:43:24.420 Greater detail to move and some of these
02:43:26.819 people just explore through our follow
02:43:28.859 alongs okay
02:43:30.600 foreign
02:43:33.900 [Music]
02:43:35.300 special attention to terraform State
02:43:37.380 move because it's definitely on the exam
02:43:39.180 uh and it is a little bit interesting to
02:43:42.000 what it can do so terraform State moves
02:43:44.220 allow you to rename existing resources
02:43:46.439 move a resource into a module move a
02:43:49.140 module into a module so if you were just
02:43:51.300 to rename a resource or move it to
02:43:52.800 another module and run terraform apply
02:43:54.600 terraform will destroy and create that
02:43:56.520 resource but State move allows you to
02:43:58.680 just change the reference so you can
02:44:00.120 avoid a create and Destroy action so an
02:44:02.880 example for renaming a resource we would
02:44:04.680 have terraform State move and then we
02:44:06.899 would have the we would identify the old
02:44:08.939 one so here we have packet device dot
02:44:11.880 worker and we are renaming it to helper
02:44:14.760 so it's we that's just how we're doing
02:44:16.920 it okay if we wanted to move a resource
02:44:19.319 into a module what we do is say
02:44:21.899 something like packet device dot worker
02:44:24.240 and then do
02:44:27.560 module.worker.packetdevice.worker okay
02:44:28.740 so the idea here is that we're moving it
02:44:30.660 into this module here
02:44:33.479 uh and I think we could probably even
02:44:35.760 rename it at the same time but uh we're
02:44:37.500 not doing that okay so move module into
02:44:39.780 a module so here we have module app and
02:44:42.240 then we're moving it into the parent one
02:44:44.819 so we go module.parent module.app okay
02:44:47.280 so what's important to remember for the
02:44:49.800 exam is that terraform State move is
02:44:51.780 when you want to rename existing
02:44:53.460 resources they're not going to get into
02:44:54.780 these more complicated use cases but
02:44:57.000 that's how you rename a a resource okay
02:44:59.850 [Music]
02:45:03.840 okay let's talk about how we back up our
02:45:06.120 state file so all terraform state
02:45:07.859 subcommands that modify state will write
02:45:10.200 a backup file so read-only commands will
02:45:12.540 not modify it so imagine listen show
02:45:14.399 will not cause a backup file to be
02:45:16.380 created terraform will take the current
02:45:18.359 state and store it in a file called
02:45:22.160 terraform.tsstate.backup so this is what
02:45:24.060 it would look like backups cannot be
02:45:26.280 disabled this is by Design to enforce
02:45:28.319 best practices for Recovery to get rid
02:45:30.359 of the backup file you would need to
02:45:31.800 manually delete the files so there you
02:45:34.020 go
02:45:34.560 [Music]
02:45:38.340 foreign
02:45:42.380 from exam Pro and we are taking a look
02:45:44.880 at terraforming knit so it initializes
02:45:46.740 your terraform project by downloading
02:45:48.600 plug-in dependencies so providers and
02:45:50.580 modules creating a DOT terraform
02:45:52.680 directory so that's a hidden directory
02:45:54.180 and creating a dependency lock file to
02:45:56.220 enforce the expected versions for
02:45:57.479 plugins in terraform itself so on the
02:45:59.580 right hand side here we can see we have
02:46:01.080 that hidden directory but also notice
02:46:03.600 here that we have a DOT terraform
02:46:05.240 lock.hcl that is our dependency lock
02:46:07.620 file and so our dependencies are all
02:46:10.500 going to end up within this sewers as
02:46:13.080 providers that's the provider version
02:46:14.520 there okay so terraform in it is
02:46:16.740 generally the First Command you will run
02:46:18.180 for a new terraform project if you
02:46:20.340 modify or change dependencies run
02:46:22.080 terraform in it again to have it apply
02:46:24.120 the changes you need to know that for
02:46:26.040 the exam because they will absolutely
02:46:27.300 ask you that the First Command here is
02:46:29.939 and these are ones with flags so you can
02:46:32.100 just do terraform in it but we have some
02:46:33.540 extra options so terraforming it hyphen
02:46:35.819 upgrade upgrade all plugins to the
02:46:37.439 latest version that complies with the
02:46:39.180 configuration version constraint
02:46:40.439 terraforma knit hyphen get plugins and I
02:46:44.280 think it's supposed to be equals false
02:46:45.960 there but skip plugin installation
02:46:47.580 terraform init plug-in hyphen dir equals
02:46:51.960 pass so Force plugin installation to
02:46:53.460 read plugins from only target directory
02:46:55.439 and then we have terraform init hyphen
02:46:57.060 lock file so you can change the lock
02:46:58.859 file mode it actually doesn't say what
02:47:00.960 the modes are so I don't even know what
02:47:02.760 you'd do in that case and I could not
02:47:04.380 find any examples but it is an option I
02:47:07.200 just want to make it very clear that
02:47:09.479 there is a dependency lock file but
02:47:11.040 there's also a state lock file and the
02:47:13.140 way you know that they're different is
02:47:14.760 that one has Dot Lock in it and the
02:47:16.380 other one has dot TF State this one up
02:47:18.660 here is for dependencies this one of
02:47:20.100 course is for State a terraform and it
02:47:22.080 does not create a state lock file that
02:47:23.760 is going to happen when you do a
02:47:24.960 terraform apply okay
02:47:27.420 [Music]
02:47:31.500 let's take a look at terraform get so
02:47:33.240 terraform get command is used to
02:47:34.740 download and update modules in the root
02:47:36.240 module so when you're a developer you
02:47:38.160 own terraform modules and you may need
02:47:40.260 to frequently pull updated modules but
02:47:42.720 you do not want to initialize your state
02:47:44.460 or pull new provider binaries and so the
02:47:47.399 idea here is terraform get is a
02:47:48.960 lightweight way it's because it's only
02:47:51.960 updating the modules it's not pulling
02:47:53.460 providers in most cases you want to use
02:47:55.439 terraform init with the exception of
02:47:56.939 local module development this will not
02:47:59.040 show up on the exam but I saw terraform
02:48:01.080 getting I was just so confused about it
02:48:02.460 so I just wanted to make sure I included
02:48:04.200 it here okay
02:48:05.200 [Music]
02:48:09.060 okay so we're going to be looking at
02:48:10.620 three CLI commands that are used to
02:48:12.479 improve debugging configuration scripts
02:48:14.280 the first is going to be terraform
02:48:15.479 format this rewrites terraform
02:48:17.220 configuration files to a standard format
02:48:19.200 and style terraform validate this
02:48:21.120 validates the syntax and arguments of
02:48:22.620 terraform configuration files in a
02:48:24.240 directory and then you have terraform
02:48:26.100 console an interactive shell for
02:48:27.540 evaluating terraform expressions and so
02:48:29.220 let's go jump into these three okay
02:48:30.830 [Music]
02:48:34.979 all right let's take a look at terraform
02:48:36.479 format so this command applies a subset
02:48:39.600 of terraform language style conventions
02:48:41.340 along with other minor adjustments for
02:48:43.859 readability so terraform format will be
02:48:46.319 by default look in the current directory
02:48:48.720 and apply formatting to all your dot TF
02:48:51.060 files so let's look at some examples of
02:48:53.220 what it would format so the first is
02:48:54.600 adjusting spacing two spaces indent so
02:48:57.300 here we have something and it's over
02:48:58.920 indented and so by running terraform
02:49:01.080 format it fixes the indentation we can
02:49:04.319 also get syntax errors so notice here
02:49:06.600 that we have a problem and so what it's
02:49:09.960 saying is is that this bracket okay
02:49:13.979 is supposed to be up here okay but it's
02:49:16.380 all it's down here uh and the last one
02:49:18.660 here is we can do terraform format
02:49:20.280 hyphen hyphen diff that's going to show
02:49:22.319 what it would change okay so there you
02:49:24.600 go
02:49:25.500 [Music]
02:49:29.580 let's take a look at terraform validate
02:49:31.620 so this runs checks that verify whether
02:49:33.479 configuration is syntactically valid and
02:49:36.660 internally consistent regardless of the
02:49:38.819 provided variables in existing state
02:49:40.500 validate is useful for General
02:49:42.300 verification of reusable modules
02:49:44.340 including correctness of attribute names
02:49:45.720 and value types so here's an example
02:49:48.420 where I just had some code and there was
02:49:50.880 a problem it's just saying you're
02:49:51.899 missing your argument because for an AWS
02:49:53.520 instance you always have to specify an
02:49:55.439 instance type so when you run terraform
02:49:57.660 plan or terraform ply validate will
02:49:59.220 automatically be performed one thing I
02:50:01.620 need to mention about terraform validate
02:50:03.899 is that it does not go to external
02:50:06.060 resources to check things are valid so
02:50:08.520 if you have a a value and it's expecting
02:50:12.600 a string that's all it's going to check
02:50:14.040 for it's not going to check that the
02:50:15.240 string is actually a proper uh like type
02:50:18.479 of size so if it's supposed to be like a
02:50:20.100 t2.micro and you write you know
02:50:22.439 gobblegoop in there it's not going to
02:50:24.780 know that that's not a valid type so but
02:50:27.600 we do cover that in the follow along so
02:50:29.520 I think we have like some practice exam
02:50:31.020 questions that cover that use case okay
02:50:32.850 [Music]
02:50:36.720 we're taking a look here at terraform
02:50:38.399 console and this is an interactive shell
02:50:40.560 where you can evaluate expressions so
02:50:42.420 the idea is you type in terraform
02:50:43.920 console and what I can do is I can you
02:50:46.800 know use like built-in functions and
02:50:49.260 expressions so there I'm using Min and
02:50:51.780 I've actually entered it in incorrectly
02:50:53.640 so there it's throwing an error and here
02:50:55.680 I'm using the correct way of using it so
02:50:57.899 I get the output so this is a great way
02:50:59.640 just to kind of test very simple things
02:51:01.260 you can't do things like Define
02:51:02.880 variables or or resources or Define
02:51:05.819 providers but you if you need to figure
02:51:08.220 out how the Expressions work before you
02:51:09.780 apply them in your code this is a great
02:51:11.460 place to do that okay
02:51:12.810 [Music]
02:51:17.220 all right let's talk about terraform
02:51:18.960 plans so this command creates an
02:51:21.300 execution plan also known as a terraform
02:51:23.640 plan and it consists of reading the
02:51:26.880 current state of an already existing
02:51:28.500 remote object to make sure that the
02:51:30.479 terraform state is up to date comparing
02:51:32.640 the current configuration to the prior
02:51:34.380 State and noting any differences
02:51:36.020 proposing a set of change actions that
02:51:39.000 should if applied make the remote
02:51:41.100 objects match the configuration and so
02:51:43.920 this is an example of one that's
02:51:45.600 generated you're going to see it uh
02:51:47.220 throughout this course multiple times so
02:51:49.080 it's not going to be unique that's why I
02:51:50.939 don't have to make that too big for you
02:51:52.200 there terraform plan does not carry out
02:51:55.560 the proposed changes that's going to be
02:51:57.060 the responsibility of terraform apply
02:51:59.160 and a terraform plan file if you happen
02:52:01.800 to generate one out is a binary file so
02:52:03.779 if you open it up it's just machine code
02:52:05.460 you cannot make sense of it okay so when
02:52:08.340 you run terraform apply you have
02:52:10.020 speculative plans and save plans and so
02:52:13.080 speculative plan plans is what's going
02:52:14.700 to happen when you run terraform apply
02:52:16.380 so the tear so terraform will output the
02:52:19.200 description of the effect of the plan
02:52:21.060 but without any intent to actually apply
02:52:24.000 it when you have a save plan you're
02:52:26.399 going to have this hyphen out flag to
02:52:29.279 save it and you can name that file
02:52:30.479 whatever you like and it will generate
02:52:33.180 out that save plan file and again that's
02:52:34.920 a binary file so you're not going to be
02:52:36.420 able to see what it does and what you
02:52:37.979 can do is then pass it along to
02:52:39.660 terraform apply so you do terraform
02:52:41.160 apply whatever the file name is and when
02:52:44.040 you are using terraform apply what you
02:52:46.020 have to understand is that it will not
02:52:48.000 allow it will not ask to manually
02:52:51.779 approve it as you normally would it
02:52:53.939 would just be Auto approved so that's
02:52:56.160 one thing you have to watch out when
02:52:57.540 using those safe plans but you know I
02:52:59.819 just wanted to make it concretely
02:53:00.960 understood that terraform plan can
02:53:02.580 generate at a file uh and it's not
02:53:04.800 actually the one that's doing the apply
02:53:06.540 okay I don't have it written in here but
02:53:09.240 when you do terraform apply it also is
02:53:11.580 running terraform validate as well okay
02:53:16.880 thank you
02:53:19.040 [Music]
02:53:20.279 let's talk about terraform apply here so
02:53:22.319 terraform apply command executes the
02:53:24.600 actions proposed in an execution plan
02:53:27.060 and it has two modes the automatic plan
02:53:29.939 mode and the saved plan mode so for
02:53:32.460 automatic plan mode that's just when you
02:53:33.960 run terraform apply what it's going to
02:53:35.880 do is execute the plan validate and then
02:53:38.279 the apply uh you can or you have to
02:53:41.779 manually approve the plan by writing yes
02:53:44.840 but if you want to skip that process you
02:53:47.640 can use the hyphen Auto approve flag to
02:53:50.160 automatically approve the plan
02:53:52.140 we just saw save plan mode like how it
02:53:54.660 worked in the previous slide but let's
02:53:56.220 cover it again so when you provide a
02:53:58.080 file name to terraform to the save plan
02:53:59.819 file it's going to be terraform apply
02:54:01.740 file
02:54:02.939 and it's going to perform exactly the
02:54:04.620 steps specified by that plan file it
02:54:07.080 does not prompt for approval so if you
02:54:08.939 want to inspect a plan file before
02:54:10.380 applying it you can use terraform show
02:54:13.020 okay
02:54:14.680 [Music]
02:54:22.500 all right let's talk about managing
02:54:24.000 resource drift so drift or configuration
02:54:26.160 or infrastructure drift is when you're
02:54:28.200 expected uh resources are in different
02:54:30.840 state than your expected State and the
02:54:33.180 way we can resolve drift are in three
02:54:34.859 different ways in terraform we can
02:54:36.540 replace resources so when a resource has
02:54:38.580 become damaged or degraded that cannot
02:54:40.920 be detected by terraform we can use the
02:54:43.020 hyphen replace flag we can import
02:54:45.060 resources so when an approved manual
02:54:47.760 edition of a resource needs to be added
02:54:50.100 to our state file so we use the import
02:54:52.140 command and refresh state so when an
02:54:54.359 approved manual configuration of a
02:54:56.760 resource has been changed or removed
02:54:58.500 we're going to use the refresh only flag
02:55:00.420 to reflect the changes in our state file
02:55:02.220 it's very important to know these three
02:55:04.140 different ways they will all show up an
02:55:05.520 exam and in practice you're going to
02:55:07.200 need to know them okay
02:55:08.460 foreign
02:55:12.479 let's first here take a look at
02:55:14.100 replacing resources so we can use the
02:55:16.680 terraform tank command it is used to
02:55:18.300 Mark a resource for replacement the next
02:55:19.859 time you run apply and why would you
02:55:22.020 want to Mark a resource for replacement
02:55:23.520 well the idea is that um you know and
02:55:26.100 here's the command here but a cloud
02:55:27.240 resource becomes damaged or degraded and
02:55:29.160 you just want to return the expected
02:55:31.080 resource to a healthy state so that's
02:55:32.760 the idea behind it and the unfortunate
02:55:34.920 thing is that terraform taint was
02:55:36.240 deprecated in version
02:55:38.359 0.152 however there is a better way of
02:55:41.580 doing it now and so it is recommended to
02:55:43.500 use the hyphen replace flag and
02:55:45.800 providing it a resource address when
02:55:48.120 you're doing a terraform apply so it's
02:55:50.220 basically the exact same thing the
02:55:51.899 reason why they made this change was so
02:55:54.060 that
02:55:54.960 um you actually have an opportunity to
02:55:56.700 confirm your change beforehand because
02:55:58.140 terraform tank would just run and this
02:56:00.540 one down below will actually prompt you
02:56:02.340 to say are you sure you want to do this
02:56:04.200 okay but it's not complicated you just
02:56:06.300 do a hyphen replace and then you use the
02:56:08.340 resource address of the thing that you
02:56:10.020 want to
02:56:11.060 use that for and this can be used for
02:56:13.859 both plan and apply the replace flag
02:56:16.439 appears to only work for a single
02:56:18.300 resource so you can't use multiple
02:56:19.680 resources it's just one at a time and
02:56:21.899 that's something that you should
02:56:22.740 remember okay
02:56:23.870 [Music]
02:56:27.660 so we just saw a resource address and
02:56:30.060 resource addressing is very important to
02:56:32.340 know for the upcoming commands let's
02:56:34.020 just give it a bit more attention here
02:56:35.340 so resource address is a string that
02:56:37.319 identifies zero or more resource
02:56:38.880 instances in your configuration an
02:56:40.859 address is composed of two parts so the
02:56:42.779 module path and the resource path and
02:56:45.000 just expand out that module path it
02:56:46.680 would be module.module name module index
02:56:48.899 and then on the resource spec this is
02:56:51.359 resource type.resource name and then if
02:56:53.220 there's multiple instances you give it
02:56:54.540 an index so module path addresses a
02:56:57.180 module within a tree of modules a
02:56:59.640 resource spec address is a specific
02:57:01.620 resource instance in the selected module
02:57:03.420 so a module is the namespace of the
02:57:05.700 module module name is user defined name
02:57:08.340 of the module module index when the
02:57:11.899 multiple so when there's multiple
02:57:14.580 specifying index on the other side
02:57:16.140 that's your resource type your resource
02:57:17.700 name an instance ID most of the times
02:57:20.580 you're going to be just working with
02:57:21.899 resources but once you start getting to
02:57:24.060 modules it becomes pretty simple it's
02:57:26.279 always going to be module period because
02:57:30.779 that's just I think that's the name of
02:57:32.819 the name value so it's always going to
02:57:34.020 be module Dot and then the module name
02:57:35.939 but here we have a very simple example
02:57:37.859 just for resource type so here if we had
02:57:40.560 a resource called Abus instance and it
02:57:42.540 was web and there was four of them and
02:57:44.819 we wanted to select the third one we do
02:57:46.260 AWS instance dot web Square braces three
02:57:49.140 and that would get us the third virtual
02:57:50.700 machine so there you go
02:57:52.380 foreign
02:57:55.710 [Music]
02:57:57.380 terraform import and this is a command
02:57:59.819 that is used to import existing
02:58:01.500 resources into terraform so this is how
02:58:03.660 you define it so you'd say what resource
02:58:06.000 you want and you can just leave it blank
02:58:08.100 so do you define a placeholder for your
02:58:09.779 imported resource and configuration file
02:58:11.279 and you can leave the body blank and
02:58:13.439 fill it in after importing but it will
02:58:15.540 not be autofilled so you do have to
02:58:17.160 specify all the values okay so the idea
02:58:20.760 here is you're going to do terraform
02:58:22.080 import AWS instance dot example and then
02:58:24.899 the name of the ID so that Maps over to
02:58:26.880 the resource address and the ID okay the
02:58:29.399 command can only import one resource at
02:58:31.319 a time this sounds very similar to that
02:58:33.779 other command we saw for replace not all
02:58:36.060 resources are importable you need to
02:58:37.560 check the bottom of the resource
02:58:38.819 documentation for support okay
02:58:40.830 [Music]
02:58:44.580 okay so we're going to look at
02:58:45.899 refreshing and so we're going to break
02:58:47.279 this between the old command refresh and
02:58:49.200 the new command refresh only across two
02:58:51.240 slides so terraform refresh command
02:58:53.220 reads the current settings from all
02:58:55.260 managed remote objects and updates the
02:58:56.880 terraform state to match so here we have
02:58:59.220 the terraform refresh and I just want to
02:59:00.960 point out that the terraform refresh is
02:59:04.080 basically the Alias for terraform apply
02:59:05.819 hyphen refresh only hyphen Auto auto
02:59:08.100 approved so you technically have this
02:59:10.740 functionality in the latest version it's
02:59:12.600 just that you can't use the old Alias
02:59:14.939 terraform refresh terraform refresh will
02:59:17.279 not modify your real remote objects but
02:59:19.620 will modify the terraform state so
02:59:22.020 terraform refresh has been deprecated
02:59:23.700 and the refresh only uh and with the
02:59:25.560 refresh only flag like it's been
02:59:27.660 replaced with it because it's not safe
02:59:29.220 since it did not give you the
02:59:30.779 opportunity to review proposed changes
02:59:32.340 before updating the state file so that's
02:59:33.840 why the reason they got rid of it let's
02:59:35.760 take a look here at the refresh only
02:59:37.319 mode so hyphen refresh only flag for
02:59:40.740 terraform planner apply allows you to
02:59:42.540 refresh and update your state file
02:59:43.979 without making changes to your remote
02:59:45.779 infrastructure just to really make this
02:59:48.660 clear I want to give you a scenario and
02:59:51.120 I want you to pay close attention here
02:59:52.680 to understand the difference because
02:59:54.000 this is so important on the exam and
02:59:55.920 also extremely useful for your
02:59:57.840 day-to-day operations so here's a
02:59:59.580 scenario imagine you create a terraform
03:00:02.220 script that deploys a virtual machine to
03:00:04.140 AWS you ask an engineer to terminate the
03:00:07.080 server and instead of updating the
03:00:09.060 terraform script they mistakenly
03:00:10.319 terminate the server via the AWS console
03:00:12.300 because they don't know any better so
03:00:14.640 what happens if you were to run a
03:00:16.800 terraform apply versus with a refresh
03:00:19.260 only flag so that's what we'll do with
03:00:21.420 and without the flag so without the flag
03:00:23.399 first terraform will notice that the VM
03:00:25.740 is missing terraform will propose to
03:00:27.840 create a new VM so the state file is
03:00:30.600 going to be what's considered as correct
03:00:33.120 and the changes and so changes to the
03:00:35.520 infrastructure will be made to match the
03:00:37.920 state file okay if we use terraform
03:00:40.140 apply hyphen refresh only terraform will
03:00:42.479 notice that the vmu provision is missing
03:00:45.319 but with the refresh only flag it's
03:00:48.479 going to know that the that the VM is
03:00:51.060 missing it's an intentional okay so I
03:00:53.160 have a couple spelling mistakes there
03:00:55.200 but the idea is that it knows that the
03:00:57.359 VM is supposed to not be there so
03:00:59.399 terraform will propose to delete the VM
03:01:01.260 from the state file so just the Json
03:01:03.240 code from the state file so the state
03:01:05.520 file is considered wrong and changes to
03:01:07.620 the state file will be made to match the
03:01:09.600 infrastructure so hopefully that makes
03:01:10.979 it clear okay
03:01:12.020 [Music]
03:01:15.840 foreign
03:01:19.110 [Music]
03:01:24.680 how we would actually go about
03:01:26.819 troubleshooting terraform so there are
03:01:28.920 four types of Errors you can encounter
03:01:30.600 with terraform uh the first is language
03:01:32.939 error so terraform encounters a syntax
03:01:35.040 error in your configuration for the
03:01:37.020 terraform or HCL language you have state
03:01:39.660 error so your resources States has
03:01:42.540 changed from the expected state in your
03:01:44.520 configuration file core errors so a bug
03:01:47.040 that has occurred with the chord Library
03:01:49.279 provider errors so the provider's API
03:01:51.899 has changed or does not work as expected
03:01:54.180 due to emerging edge cases and when we
03:01:56.399 talk about what's easy for us to solve
03:01:58.200 and what's hard well the first two are
03:02:00.180 very easy and the other two are harder
03:02:02.399 to solve so for language errors we can
03:02:04.800 use format validate or version to
03:02:08.540 resolve our language errors version
03:02:10.439 would just be say hey what version are
03:02:12.300 we using maybe we need to update it
03:02:14.100 right validate with detect if
03:02:15.479 something's wrong with
03:02:16.920 um the uh the the syntax and format
03:02:19.620 would fix formatting syntax but you know
03:02:22.319 that probably wouldn't fix that much
03:02:23.520 there for State errors the idea here is
03:02:26.760 we might want to use refresh apply
03:02:29.220 replace everything that we saw in the
03:02:31.200 drift section for core errors we might
03:02:34.560 want to go check out the log so TF
03:02:36.540 underscore log is basically just the way
03:02:39.420 of saying like hey these are where the
03:02:40.560 log files are or is logs turned on we
03:02:42.960 have a whole slide on that but really
03:02:45.240 like all you're going to do is use the
03:02:47.160 logs to find information and then report
03:02:49.740 a GitHub issue since all terraform is on
03:02:53.160 GitHub you just go there and then
03:02:55.560 somebody would try to resolve it and the
03:02:58.260 same thing with providers providers are
03:03:00.300 all hosted on GitHub and so you would
03:03:02.700 just use TF logs to try to find some
03:03:04.319 information there but we'll take a look
03:03:06.180 a greater look at TF log and how to you
03:03:10.380 know get that information for the harder
03:03:12.420 to solve cases okay
03:03:13.580 [Music]
03:03:17.279 okay so let's talk about how we would go
03:03:19.560 about debugging terraform via the log
03:03:21.600 file so terraform has detailed logs
03:03:23.580 which can be enabled by setting the TF
03:03:25.859 underscore log followed by the type
03:03:28.500 environment you want to run so the
03:03:30.899 variables that we have or the
03:03:33.000 environments we can specify is Trace
03:03:35.220 debug info warn error or Json Json will
03:03:39.720 output logs at the trace level or higher
03:03:42.060 and use parsable Json encoding as the
03:03:44.760 formatting okay so logging can be
03:03:47.279 enabled separately so you can do this
03:03:49.920 via TF log core or you can get it at the
03:03:54.240 TF log provider so if you just want core
03:03:56.220 stuff or if you just want provider stuff
03:03:57.920 you just set those environment variables
03:04:00.359 and as we saw in the previous thing that
03:04:02.520 there you know there was core errors and
03:04:04.380 provider variables so that could be a
03:04:05.819 good way to do that and so TF uh TF core
03:04:10.380 TF log core and TF log provider take the
03:04:12.660 same environment variables we see on the
03:04:14.160 right hand side there Trace debug info
03:04:16.200 Etc okay if you want to choose where you
03:04:19.080 want to log things you just can set the
03:04:21.180 TF log path I don't think I actually say
03:04:23.580 where the default path is I think it's
03:04:25.140 actually in the the project directory
03:04:27.060 but if you want to override that you can
03:04:28.859 I imagine it either takes an absolute
03:04:31.200 path or a relative path and here's an
03:04:33.899 example of a terraform log so this is
03:04:36.540 for everything and so there you can see
03:04:39.479 information I'm going to get my pen tool
03:04:41.100 out here for a moment but you can see we
03:04:43.140 have information about the provider this
03:04:45.300 is using
03:04:46.560 um there then there's some back-end
03:04:48.840 local stuff so you know there's some
03:04:50.340 information you're not expected to
03:04:52.319 understand this information generally
03:04:54.240 but you could go bring it to the
03:04:56.040 provider but you could probably solve
03:04:57.960 something you know if you were to read
03:04:59.640 the core code or the provider is okay
03:05:02.510 [Music]
03:05:06.720 okay so we looked at TF log which is the
03:05:09.300 terraform log but there's also a crash
03:05:11.100 log and so if terraform ever crashes and
03:05:13.979 basically this means it goes into panic
03:05:15.600 because it uses the go runtime it saves
03:05:17.340 a log file with the debug logs from the
03:05:19.620 session as well as the Panic message and
03:05:21.840 back Trace to the crash.log and so I
03:05:24.899 imagine this is golang information so I
03:05:28.140 don't use golang that often but you can
03:05:30.660 see we have dot gopanic.go so I think
03:05:33.600 that there's not much you can do with it
03:05:35.520 so this is where you would just create a
03:05:37.140 GitHub issue and pass it along to the
03:05:39.420 terraform team because they're going to
03:05:40.680 be able to make sense of it okay
03:05:42.330 [Music]
03:05:46.140 foreign
03:05:49.440 [Music]
03:05:54.060 so we're on to our module section uh so
03:05:57.180 let's first talk about how we would go
03:05:58.620 find a module I know we already saw this
03:06:00.600 earlier when we were looking at the
03:06:01.560 terraform registry but let's just cover
03:06:02.880 it again and talk about some of the uh
03:06:05.520 uh details of search okay so terraform
03:06:09.180 modules can be publicly found in the
03:06:11.100 terraform registry and so on the left
03:06:13.200 hand side when you're under the modules
03:06:15.060 within terraform registry you can filter
03:06:17.760 your providers okay but another thing
03:06:20.760 you can do is you can type in Search
03:06:23.220 terms and you can do partial Search
03:06:24.840 terms like Azure compute but what I
03:06:27.060 really want you to know is that only
03:06:28.800 verified modules will be displayed in
03:06:31.740 Search terms and so I assume that means
03:06:33.720 verified and also official ones and the
03:06:36.600 reason I'm giving this extra emphasis is
03:06:38.399 because it was an exam question so I
03:06:40.560 just want you to know that only verified
03:06:42.439 and official ones are going to show up
03:06:45.240 when you search okay
03:06:48.779 foreign
03:06:50.939 let's talk about using modules and
03:06:52.920 there's our public modules and private
03:06:55.080 modules so public modules are going to
03:06:57.060 be on the terraform registry and private
03:06:58.979 modules are going to be in terraform
03:07:00.600 cloud or I suppose terraform Enterprise
03:07:02.460 so terraform registry is integrated
03:07:04.800 directly into terraform so it makes it
03:07:06.960 really easy to start using them so all
03:07:09.060 you're going to do is use the module
03:07:11.220 block so I'm just going to highlight
03:07:13.740 that there then we have the name of our
03:07:15.960 module we're providing the source of our
03:07:18.000 module and then there's the version of
03:07:19.920 our module terraform init command will
03:07:22.200 download and cache any module referenced
03:07:24.660 by a configuration now looking at
03:07:27.420 private modules it looks very similar
03:07:30.840 um it's just that the name is different
03:07:31.979 so we're specifying the host name in
03:07:34.319 front here and a namespace as well so to
03:07:37.560 configure private module axis you need
03:07:39.840 to authenticate against terraform Cloud
03:07:41.819 via terraform login so that's something
03:07:44.880 there we definitely cover that a lot in
03:07:47.640 the Brax exam so just in case you know
03:07:50.040 you know all the education is there
03:07:51.600 alternate alternatively you can create a
03:07:54.180 user API token and manually configure
03:07:56.640 credentials into CLI to configure the
03:07:58.859 file so there you go
03:08:00.240 foreign
03:08:04.260 let's talk about how we would go about
03:08:05.939 publishing modules and this in
03:08:07.439 particular is for the terraform registry
03:08:09.359 so these are public modules so if we
03:08:12.120 want to publish modules it supports
03:08:14.100 versioning automatically generating
03:08:15.720 documentation allowing uh users to
03:08:18.779 browse the version histories showing
03:08:21.420 examples and read Maze and all of these
03:08:24.300 modules are actually going to be hosted
03:08:25.800 on GitHub so the idea is you're going to
03:08:28.680 put your module there first and once a
03:08:31.560 module is registered to push updates you
03:08:33.420 simply push new versions to properly
03:08:35.220 form get tags you have to name the your
03:08:39.300 your modules in a very particular way on
03:08:42.060 GitHub so the thing is it has to start
03:08:44.460 with terraform hyphen then the provider
03:08:46.859 so AWS and then the name so hyphen VPC
03:08:49.620 and the way you publish it on terraform
03:08:52.140 registry is you have to connect and
03:08:54.420 publish via your GitHub account so you
03:08:57.120 just hit sign in with GitHub and it's
03:08:59.040 just going to give you a drop down and
03:09:00.359 you're just going to choose the repo and
03:09:02.040 that's as simple as it is okay
03:09:04.319 foreign
03:09:08.160 all right let's talk about verified
03:09:09.600 modules so these are reviewed by
03:09:11.580 hashicorp and actively maintained by
03:09:13.319 official contributors to stay up to date
03:09:15.420 and compatible with both terraform and
03:09:17.399 their respective providers so here's an
03:09:19.380 example of a module from our friend
03:09:20.939 Anton down below and as you can see it
03:09:23.399 has a little badge that's how you know
03:09:24.960 that it's verified so verified modules
03:09:27.060 are expected to be actively maintained
03:09:28.920 by hashicorp Partners verified badges
03:09:31.620 aren't an indication of the flexibility
03:09:34.859 or feature support but just to kind of
03:09:37.439 go through some things here very simple
03:09:39.720 modules can be verified just because
03:09:41.700 they're great examples of modules
03:09:43.319 unverified modules could be extremely
03:09:45.420 high quality and actively maintained
03:09:47.100 unverified modules shouldn't be assumed
03:09:49.200 to be poor quality unverified means it
03:09:51.840 hasn't been created by a hashicorp
03:09:54.600 partner so you know that again it's not
03:09:56.880 indicative of quality but it just means
03:09:59.340 that it's gone through a bit of vetting
03:10:00.600 okay
03:10:01.520 [Music]
03:10:05.520 all right let's take a look here at the
03:10:07.200 standard module structure and this is a
03:10:08.880 file and directory recommended for
03:10:10.380 module development and this is the idea
03:10:12.180 if you were to go and publish your own
03:10:14.340 module this is what people would expect
03:10:15.899 to see so if you had root modules that's
03:10:17.700 what it'd be and you have nested module
03:10:19.620 I want to point out that when you are
03:10:21.240 running terraform you technically are
03:10:22.859 creating modules even if you aren't
03:10:25.260 intending them to publish them into the
03:10:26.880 terraform registry but you know when you
03:10:29.640 make a main.tf you've basically made
03:10:31.500 your own root module okay so the primary
03:10:33.899 entry point is the root module and these
03:10:36.120 are required files in the root directory
03:10:37.979 so your main.tf is the entry point file
03:10:40.560 for your module variables TF is the
03:10:42.899 variables that can be passed in
03:10:44.479 outputs.tf are outputted values readme
03:10:47.340 describes how the modules work license
03:10:49.740 the license under which the module is
03:10:51.600 available for NASA modules which are
03:10:53.819 optional but must be contained in the
03:10:55.740 modules directory a sub module that
03:10:58.020 contains a readme is considered usable
03:10:59.939 by external users a sub module that does
03:11:02.399 not contain a readme is considered inter
03:11:04.140 for only internal use and the idea is to
03:11:07.080 avoid using relative paths when sourcing
03:11:09.359 module blocks so hopefully that gives
03:11:11.100 you an idea okay
03:11:12.430 [Music]
03:11:20.279 foreign
03:11:23.550 [Music]
03:11:24.720 let's talk about core terraform
03:11:26.640 workflows and these have three steps
03:11:28.260 write plan and apply so write plan and
03:11:30.840 apply we saw this kind of in the
03:11:33.240 terraform life cycle and the idea here
03:11:37.439 is that you know it's just to try to
03:11:40.080 describe what it's going to be for your
03:11:42.000 team and requirements as you grow and
03:11:44.460 you're utilizing this workflow so if
03:11:46.500 you're talking about individual
03:11:47.760 practitioners so a single person a team
03:11:50.220 using OSS so they're not using they're
03:11:53.100 using open source software using
03:11:54.540 terraform but they're not using the
03:11:56.040 terraform Cloud platform and then what
03:11:57.720 it would be like if they're using the
03:11:59.040 terraform Cloud platform in terms of
03:12:01.560 this right plan apply you're going to
03:12:03.840 see these examples don't perfectly fit
03:12:05.700 here I am just presenting a summarized
03:12:08.819 versions of the documentation and the
03:12:11.819 reason why is because on the exam this
03:12:14.160 is one of the sub domains that you need
03:12:17.819 to know so I'm not saying that I think
03:12:20.399 these are perfectly presented but I
03:12:22.680 think that I have to cover them because
03:12:24.180 they are in the exam and I you do learn
03:12:26.640 something here so we will go through
03:12:28.200 them okay
03:12:29.020 [Music]
03:12:33.240 so let's take a look at a terraform or
03:12:36.540 team workflow for a single person an
03:12:38.760 individual practitioner looking at the
03:12:40.979 right step first so you're going to be
03:12:43.140 writing your terraform configuration in
03:12:44.819 your editor of choice on your computer
03:12:47.700 um but the thing is you'll be storing
03:12:49.140 your terraform code in something like
03:12:51.180 GitHub even if you are an individual
03:12:53.160 user you're going to be putting in git
03:12:54.300 or GitHub or some kind of Version
03:12:55.740 Control System you're going to be
03:12:57.840 repeatedly running terraform plan or
03:12:59.819 even possibly terraform validate to find
03:13:02.100 syntax errors and the great thing about
03:13:04.439 this is that you get this tight feedback
03:13:06.240 loop between editing the code and
03:13:07.740 running your test commands because it's
03:13:09.060 all on your local machine we're not
03:13:10.979 sending things off to build servers or
03:13:13.140 other services so it's very fast and
03:13:16.140 easy talking about the plan stage so
03:13:18.420 when the developer is confident with
03:13:20.100 their workflow in the right step that
03:13:22.260 commits their code to their local
03:13:24.359 repository this is the stage where it's
03:13:27.060 a local limit it's not a remote commit
03:13:28.859 they may be only using a single Branch
03:13:31.200 so just probably working in Maine or if
03:13:33.600 you're still using the old syntax Master
03:13:35.460 Branch once their commit is written
03:13:38.220 they'll proceed to apply that'll bring
03:13:40.319 us to the apply stage so they will run
03:13:42.240 terraform apply this is on your local
03:13:44.040 machine it's not part of any other
03:13:46.380 process you're just running terraform
03:13:47.819 apply and it'll be prompted to review
03:13:49.920 their plan after the review the final
03:13:52.200 review they will approve the changes and
03:13:54.300 await provisioning after a successful
03:13:56.700 provision they will push their local
03:13:58.380 commits to their remote repository so
03:14:01.080 this is where you will then finally
03:14:02.760 commit your code so there you go
03:14:05.720 [Music]
03:14:10.200 so we looked at what it would be like if
03:14:12.120 we had a single person working with
03:14:13.800 terraform let's talk about if it's a
03:14:15.300 team and they're not using terraform
03:14:16.439 Cloud they're just doing it uh the
03:14:18.300 old-fashioned way okay so each team
03:14:20.399 member writes code locally on their
03:14:22.200 machine in their editor of choice as per
03:14:24.000 usual a team member will store their
03:14:26.279 code in a branch in their code
03:14:28.319 repository whether it's a uh per feature
03:14:31.140 per user per whatever is up to you
03:14:34.340 branches help avoid conflicts while a
03:14:37.140 member is working on their code but
03:14:39.240 branches will allow an opportunity to
03:14:41.399 resolve conflicts during a merge into
03:14:43.319 main it's no different than working with
03:14:45.540 you know code because that's what it is
03:14:47.460 terraform plan can be used as a quick
03:14:50.340 feedback loop for small teams so we
03:14:52.080 still have that option but as your team
03:14:54.120 grows larger a concerned over sensitive
03:14:56.460 credentials becomes a concern and so
03:14:58.979 this is where you may need to introduce
03:15:00.479 a CI CD process so that it's it's going
03:15:04.680 to be in control of the credential so
03:15:06.479 the idea is that you don't run plan you
03:15:08.399 just push to your branch and it can run
03:15:10.920 it or it only happens on pull requests
03:15:12.960 that's up to you know your team and how
03:15:14.760 they decide to set it up when a branch
03:15:16.680 is ready to be incorporated on pull
03:15:18.479 requests an execution plan can be
03:15:20.580 generated I guess when we say execution
03:15:22.859 plan this could be a speculative plan
03:15:24.960 okay so it's not something we're going
03:15:26.279 to run it's just something we're going
03:15:27.240 to review and displayed within the pull
03:15:29.220 requests for review to apply the changes
03:15:31.439 the merges need to be approved and
03:15:33.660 merged which will kick off a code build
03:15:35.700 server that will run terraform apply
03:15:37.439 that's the apply stage there so this is
03:15:40.260 all good but what we need to kind of
03:15:42.660 highlight is all the work and labor that
03:15:44.939 goes into setting up your own team if
03:15:46.680 you're going to do it all from scratch
03:15:48.660 without terraform Cloud so the devops
03:15:50.460 team has to set up and maintain their
03:15:51.840 own CI CD pipeline they have to figure
03:15:53.819 out how to store the state files whether
03:15:55.859 they're going to be in a standard back
03:15:58.200 in a remote state or they're going to
03:16:00.180 encrypt it and put them into the code
03:16:02.819 repository which is not recommended they
03:16:05.220 are limited in their access controls so
03:16:07.200 they can't do granular actions to say
03:16:08.819 okay I only want to allow this person to
03:16:11.340 destroy and this person to apply it's
03:16:13.080 not like that with get repos they have
03:16:16.800 to figure out a way to safely store and
03:16:18.540 inject secrets into their build server's
03:16:20.279 runtime and that's not argue argue it's
03:16:23.700 not very hard depending on the solution
03:16:24.840 that you choose but it is a thing that
03:16:26.520 they have to figure out they might need
03:16:28.740 to manage multiple environments and this
03:16:30.600 can create additional overhead because
03:16:32.220 for each environment you'll have to
03:16:34.080 create another ciccd pipeline okay so
03:16:37.680 hopefully that gives you the idea of the
03:16:39.420 effort here and this is going to set us
03:16:41.819 up to say what terraform cloud is going
03:16:43.620 to solve okay
03:16:44.890 [Music]
03:16:49.200 let's take a look at what our team
03:16:50.939 workflow or our terraform workflow will
03:16:52.859 be if we were using terraform clouds so
03:16:55.200 18 we'll use terraform Cloud as a remote
03:16:57.000 back-end of course they were using uh
03:16:59.460 their favorite editor as per usual
03:17:01.800 working on their local machines to write
03:17:03.479 that code the input variables will be
03:17:05.340 stored on terraform Cloud instead of
03:17:07.080 their local machine terraform cloud
03:17:08.939 integrates with your version control
03:17:10.740 system such as git to quickly set up a
03:17:12.960 cicd pipeline a team member writes code
03:17:15.300 to a branch it commits per usual so that
03:17:17.279 doesn't change a pull request is created
03:17:20.399 by a team member in terraform Cloud will
03:17:22.080 generate the speculative or execution
03:17:24.000 plan however you want to call it for
03:17:25.680 review in your version control system
03:17:27.420 the member can also review and comment
03:17:30.000 on the plan in terraform Cloud after the
03:17:32.760 pull request is merged terraform cloud
03:17:34.740 in the terraform Cloud runtime sorry the
03:17:37.800 terraform Cloud runtime will perform a
03:17:39.720 terraform apply and a team member can
03:17:41.819 confirm and apply the changes within the
03:17:43.439 terraform Cloud UI okay so terraform
03:17:46.560 Cloud streamlines a lot of the CI CD
03:17:48.600 efforts storing it storing and securing
03:17:50.880 sensitive credentials and makes it
03:17:52.260 easier to go back and audit the history
03:17:54.000 of multiple runs so in terms of the exam
03:17:57.840 if and I didn't see any questions on
03:18:00.240 this but I know they exist they're just
03:18:02.160 going to be asking you
03:18:04.020 you know which like they might describe
03:18:06.240 something and say which kind of workflow
03:18:07.800 does this fit and so if you generally
03:18:09.359 know the difference between terraform
03:18:11.100 Cloud working with the team open source
03:18:13.740 software without terraform cloud and
03:18:15.000 individual workflow it's not too hard
03:18:16.620 you'll be okay all right
03:18:18.350 [Music]
03:18:22.140 foreign
03:18:25.440 [Music]
03:18:26.880 we're taking a look here at back ends
03:18:29.160 and each terraform configuration can
03:18:30.960 specify a back end which defines where
03:18:33.180 and how operations are performed and
03:18:35.700 where State snapshots are stored so
03:18:38.160 terraform divides their backends into
03:18:39.899 two types we have standard and enhanced
03:18:42.000 first looking at standard this is where
03:18:44.160 you can only store the state and it does
03:18:47.340 not perform terraform operations such as
03:18:49.500 terraform apply so to perform operations
03:18:52.319 you have to use a CLI on your local
03:18:54.779 machine and the reason why is that
03:18:57.120 standard back ends are basically
03:18:58.620 third-party backends so a standard back
03:19:00.840 end could be AWS S3 and so you know this
03:19:04.200 is a storage service it doesn't have the
03:19:06.000 capabilities of pragmatically triggering
03:19:08.220 things okay
03:19:09.479 uh when we have when we're talking about
03:19:11.220 enhanced back ends we can store both the
03:19:14.819 state and perform terraform operations
03:19:17.779 so enhanced backends are subdivided
03:19:20.340 further so we have local so files and
03:19:22.680 data are stored in a local machine
03:19:24.000 executing terraform commands and remote
03:19:26.399 so files and data are stored in the
03:19:28.740 cloud so terraform Cloud the reason why
03:19:31.080 they can perform terraform operations
03:19:32.819 and when you look at local and remote
03:19:34.920 local is your machine so of course it
03:19:37.680 can execute terraform and then remote is
03:19:39.359 terraform Cloud which has its own
03:19:41.399 runtime environment it's basically a
03:19:43.859 build server so it of course can do both
03:19:46.740 those operations and that's how you're
03:19:48.300 going to remember the difference between
03:19:49.439 those two okay
03:19:50.920 [Music]
03:19:55.439 all right so we were just talking about
03:19:57.240 standard and enhanced back ends and I
03:19:59.100 was saying that standard back ends are
03:20:01.020 basically third-party providers that is
03:20:03.300 something other than terraform Cloud so
03:20:05.520 let's take a look at what options we
03:20:07.080 have available to us starting with the
03:20:09.479 major cloud service providers so AWS has
03:20:12.180 simple storage S3 Azure has block
03:20:16.140 storage account notice it says Azure RM
03:20:18.960 because that's just the name of what
03:20:20.640 they call it I don't know what the RM
03:20:21.960 stands for resource manager I imagine
03:20:23.779 Google Cloud Storage is an option then
03:20:26.819 we have Alibaba we have openstack we
03:20:30.000 have 10 cent and then we have Manta
03:20:33.000 which is part of joynet's cloud storage
03:20:35.580 so I don't think a lot of people are
03:20:37.380 going to remember joinet joynet was very
03:20:39.120 popular provider like post or pre-2010
03:20:43.380 so I remember them 10 cent is a Asia
03:20:47.340 provider I think they were a texting
03:20:49.560 service they're very popular but they're
03:20:51.359 not the largest provider over in Asia
03:20:52.979 Alibaba is and of course we have the the
03:20:55.620 three major ones here and then openstack
03:20:58.319 is for uh private Cloud okay then on the
03:21:01.560 other side of it when we're looking at
03:21:02.760 more exotic or things that aren't Cloud
03:21:05.340 server providers we have
03:21:06.899 um artifactory we have hashicorp console
03:21:10.740 etcd postgres database kubernetes
03:21:13.439 secrets and you can also use the ACP
03:21:15.779 protocol
03:21:16.740 now notice I have these little locks
03:21:18.479 here that's indicating which have state
03:21:21.000 locking which do not if you don't know
03:21:22.500 what state locking is don't worry we'll
03:21:23.760 talk about it here in a moment
03:21:26.279 um would there be a question on the exam
03:21:27.840 saying oh which service you know doesn't
03:21:30.720 have state locking and the answer is no
03:21:32.880 they would never ask that it's too
03:21:34.500 minute but just notice that the only
03:21:37.080 thing that doesn't have state locking is
03:21:38.819 uh artifactory which I'm kind of
03:21:40.800 surprised because it's a universal
03:21:42.000 repository manager and there's the one
03:21:44.700 case like with HP protocol where it's
03:21:46.260 optional so it's not that you can't have
03:21:48.600 it it's just that it's not it doesn't
03:21:50.580 necessarily have to be there and in
03:21:52.260 particular some the the state is or the
03:21:55.380 Locking State locking is
03:21:57.359 buy another service so for AWS it's
03:21:59.460 dynamodb that is doing the state locking
03:22:01.500 and then with Alibaba uh alibaba's cloud
03:22:04.380 storage it's table store okay so uh you
03:22:07.800 know there's not much to know here but
03:22:09.479 uh you know it's just kind of
03:22:10.319 interesting if you want to have a
03:22:12.180 different kind of backend maybe you want
03:22:13.319 to use postgres because you're really
03:22:14.340 familiar with it you can actually store
03:22:15.540 it there okay so let's take a look at
03:22:17.399 what it would look like if we were to
03:22:18.899 use a standard back end so here's an
03:22:20.819 example for AWS since I think S3 is very
03:22:23.880 popular so if you were to set up your
03:22:26.460 back end so here I have a bucket here
03:22:29.340 and I've have to name the state file so
03:22:32.040 I call it State file and then I give it
03:22:33.540 the region and there it is so the backup
03:22:36.060 of a state file will reside on your
03:22:38.100 local machine so the backup's not going
03:22:39.540 to be an S3 configuring a standard back
03:22:42.180 end does not require terraform cloud
03:22:43.979 account or workspace because
03:22:47.340 you know it's it's totally separate from
03:22:49.200 it so that's something I wasn't sure
03:22:50.399 when I was first using it was okay can I
03:22:52.200 use a standard back end but I still have
03:22:53.399 to have a terraform account or workspace
03:22:54.720 and the answer is no all right
03:22:56.710 [Music]
03:23:01.080 all right so we're taking a look at
03:23:02.399 enhanced back end so we're going to
03:23:03.779 start with local and then move on to
03:23:05.100 remote so for the local back end we
03:23:07.140 store the state on the local file system
03:23:09.120 and it locks the state using the systems
03:23:11.819 API it also performs operations locally
03:23:14.399 and when we say local we just mean a
03:23:16.380 local machine we don't necessarily mean
03:23:17.760 it has to be our workstation a code
03:23:19.859 build server could also be considered a
03:23:22.500 local machine okay it just means
03:23:24.180 anything but terraform Cloud that is
03:23:25.800 running the terraform code so by default
03:23:28.800 you are using the backend State when you
03:23:30.720 have not specified any kind of back end
03:23:33.060 so normally you'd see a background
03:23:34.920 defined in here we don't so it's going
03:23:37.020 to just default to the local you can
03:23:39.600 specify the back end with an argument
03:23:41.220 local most people don't you just leave
03:23:42.779 it blank and you can change the path to
03:23:45.120 the local file
03:23:46.439 a working directory so I think that if
03:23:48.960 you were to specify you'd want to put
03:23:50.520 the path
03:23:51.660 in but generally again we keep that
03:23:53.520 blank you can set a back end to
03:23:56.580 reference another state files so you can
03:23:58.319 read it outputted values this is a way
03:24:00.359 of cross-referencing stacks so just
03:24:02.880 notice that we have this thing that says
03:24:04.200 terraform remote State we're going to
03:24:05.880 repeat this later on in the course
03:24:07.560 because this is a very important concept
03:24:10.140 and I feel that it gets overlooked in
03:24:11.640 the documentation but it has to do with
03:24:13.979 local backends so the idea is that you
03:24:16.500 could say hey I have this other file
03:24:18.899 that has a back end and I'm just going
03:24:20.819 to use data sources specify its backend
03:24:23.340 and then point to its actual terraform
03:24:25.140 State file okay
03:24:27.000 foreign
03:24:30.300 [Music]
03:24:31.620 we're taking a look here at remote back
03:24:33.660 ends for the enhanced back-end type and
03:24:35.580 a remote back end uses the terraform
03:24:37.140 platform which is either terraform cloud
03:24:39.239 or terraform Enterprise
03:24:40.700 by default I usually just say terraform
03:24:43.319 Cloud when I'm referring to the
03:24:44.640 terraform platform but just to
03:24:46.140 understand there is a distinction
03:24:47.160 between terraform cloud and terraform
03:24:48.600 enterprise Enterprise being the
03:24:50.100 on-premise
03:24:51.380 offering okay so with a remote back end
03:24:54.540 when terraform apply is performed via
03:24:56.279 the CLI the terraform Cloud run
03:24:57.899 environment is responsible for executing
03:24:59.939 the operation so that's what you get
03:25:01.920 when you get terraform cloud is you get
03:25:03.239 this run environment so it's basically
03:25:04.500 just a built-in code build server to run
03:25:08.100 terraform commands for you one thing I
03:25:10.380 really want you to know about remote
03:25:12.120 back-ends because this really tripped me
03:25:13.859 up uh when I was actually trying to make
03:25:16.500 the follow along which is the fact that
03:25:18.540 because the terraform Cloud run
03:25:20.399 environment is the one exiting the
03:25:22.080 command your provider credentials need
03:25:24.420 to be configured in the environment
03:25:25.920 variables in terraform Cloud so you know
03:25:28.140 if you had a project and you configured
03:25:30.660 it with um TF bars locally and then you
03:25:34.439 were to swap out your remote backend
03:25:36.359 it's not going to work the way you
03:25:38.460 expect it to because
03:25:40.200 um again the terraform Cloud run
03:25:41.760 environment is not going to take your
03:25:43.200 credentials and then move them to the
03:25:45.120 cloud okay you have to do that yourself
03:25:47.479 when using a remote backing you need to
03:25:49.979 set a terraform Cloud workspace
03:25:53.160 so you would go ahead and go to
03:25:56.040 terraform cloud and just go create one
03:25:57.660 you create one or multiple ones for a
03:25:59.640 single project if you use a single
03:26:01.560 workspace for a project you're just
03:26:03.120 going to use the workspaces uh name and
03:26:06.239 if you set multiple workspaces via
03:26:08.220 prefet you can use a prefix okay and the
03:26:10.620 way this prefix works is that you're
03:26:12.479 going to say like my app or something
03:26:13.979 and when you go to run terraform apply
03:26:16.319 what it's going to do is prompt you to
03:26:18.720 say which environment do you want to use
03:26:20.040 so and this is what you've created in
03:26:22.739 your terraform Cloud workspace you've
03:26:24.239 created one called Dev you've created
03:26:25.439 one called Product saying which
03:26:27.180 workspace do you want to deploy to I
03:26:30.060 want to know that you can only set
03:26:32.040 either name or prefix you can't set both
03:26:34.859 okay so just understand that
03:26:37.430 [Music]
03:26:41.640 all right so we're taking a look at the
03:26:43.620 cloud backend
03:26:45.600 um uh code block here and so this is
03:26:48.479 very similar to terraform backend remote
03:26:51.180 if we're specifying terraform as our
03:26:55.140 back end but now instead of having to do
03:26:57.840 backend remote we can just give it a
03:26:59.819 cloud block and the reason for this is
03:27:03.000 well I don't know you can still
03:27:11.279 foreign
03:27:57.899 all right let's take a look at the cloud
03:27:59.760 backend block so when using terraform
03:28:01.979 Cloud as a remote back-end State you
03:28:04.620 should instead use the cloud block to
03:28:06.600 configure its usage so uh previously in
03:28:09.720 previous uh terraform versions it would
03:28:11.460 look like this so you'd have terraform
03:28:13.140 back and remote and the way you know
03:28:15.120 it'd be using terraform cloud is that
03:28:16.620 the hostname would be set as app.t
03:28:18.660 terraform.io and so this has been
03:28:20.700 changed so now that all you have to do
03:28:22.319 is use this Cloud block and so you just
03:28:25.140 don't specify that hostname and for the
03:28:27.479 most part
03:28:28.500 um uh you know the configurations
03:28:30.540 between them are very similar so the
03:28:33.060 only thing that we're seeing different
03:28:33.899 is this prefix maybe that prefix is
03:28:35.700 still there we'd have to double check
03:28:37.140 the documentation on that but what's
03:28:38.939 important to understand is that there's
03:28:40.260 this Cloud block and it is the record
03:28:42.000 amended way to do it now I do want to
03:28:44.040 point out that I tested both and the
03:28:46.380 remote the remote version still works so
03:28:48.899 you can still do it this way if you're
03:28:50.520 doing it the old school way and this is
03:28:52.800 just an alternate way uh would they ever
03:28:55.140 make it so you could not use the remote
03:28:56.640 state in the future for uh terraform
03:28:58.859 Cloud you have to use the block I don't
03:29:00.840 know but I can tell you right now that
03:29:02.640 they do have that cloud block
03:29:04.500 so both are valid options and the latter
03:29:07.319 of course being the recommended uh use
03:29:09.779 one so yeah there you go
03:29:13.160 thank you
03:29:16.320 [Music]
03:29:17.640 so since we're talking about back ends
03:29:19.319 let's talk about back-end initialization
03:29:20.939 in particular the back end hyphen config
03:29:23.520 flag this is more of an exotic option
03:29:25.680 but I figured we should go over it
03:29:27.300 because it could appear on your exam so
03:29:29.760 the flag for the back end config flag
03:29:32.220 for terraform init can be used for
03:29:33.960 partial back-end configuration so in
03:29:36.239 situations where the back-end settings
03:29:37.859 are dynamic or sensitive so they cannot
03:29:41.040 be statically specified in your
03:29:43.620 configuration file this is what you
03:29:44.939 would do
03:29:46.020 so here would be your main.tf and notice
03:29:49.380 it says back in remote
03:29:51.180 and it has no details in it
03:29:53.580 so then what you do is you create a
03:29:55.080 separate file called backend.hcl and now
03:29:57.960 you're specifying the workspace the host
03:30:00.000 name the organization and then uh with
03:30:03.060 terraform and net you're going to then
03:30:04.380 say Okay use this file as the backend
03:30:08.220 information that we're going to inject
03:30:09.660 into our backend remote so there you go
03:30:12.740 [Music]
03:30:17.100 okay we're taking a look here at
03:30:18.600 terraform remote State and I give this a
03:30:20.640 lot more attention in the course because
03:30:21.840 I feel that it gets overlooked within
03:30:24.180 the terraform documentation it's such a
03:30:26.040 powerful feature and something that I'm
03:30:27.720 used to having in cloudformation which
03:30:29.220 is cross-referencing Stacks so I want to
03:30:30.840 make sure that you know it too so
03:30:32.580 terraform remote State data source
03:30:34.380 retrieves the root module output values
03:30:36.359 from another terraform configuration
03:30:38.760 file using the latest State Snapshot
03:30:41.279 from the remote back end so the idea is
03:30:43.200 that you can reference a state file from
03:30:45.359 somewhere else you can do it uh via a
03:30:48.060 remote backend and a local backend so
03:30:50.460 just take a look here we see data and
03:30:53.640 the data sources terraform remote State
03:30:55.500 and we're setting the back end as a
03:30:57.359 remote on the right hand side here it is
03:30:59.279 local and if it's a local back end we
03:31:01.680 give the path to the TF State file if
03:31:04.080 it's remote that means it's another
03:31:05.460 workspace and terraform Cloud so we set
03:31:07.800 the workspace that we want to access and
03:31:10.920 then when we want to access those
03:31:12.180 resources we're using data sources so we
03:31:14.279 do data Dot and it's terraform remote
03:31:16.140 State and then we specify it knows that
03:31:18.720 it's no difference whether it's remote
03:31:20.460 or local but you're going to be getting
03:31:21.899 datas from outputs okay so only the root
03:31:25.380 level output values from the remote
03:31:26.939 State snapshots are exposed resource
03:31:29.520 data and output values from nested
03:31:31.140 modules are not accessible to make
03:31:33.739 module outputs values accessible as a
03:31:37.140 root module output values you must
03:31:39.540 explicitly configure a pass-through in
03:31:41.640 the root module so here's an example of
03:31:44.880 us doing a pass-through so we have a
03:31:47.760 module called app and it has a source
03:31:49.500 and then we're just setting an output
03:31:51.000 notice that we are just grabbing the
03:31:52.620 value and passing it along
03:31:54.479 I want to tell you about the alternative
03:31:55.979 to terraform remote State because if you
03:31:58.380 can you should use these as opposed to
03:32:00.300 using terraform Road States so terraform
03:32:02.700 remote state only exposes output values
03:32:04.620 its users must have access to the entire
03:32:07.080 State snapshot which often includes some
03:32:09.300 sensitive information it's recommended
03:32:11.520 explicitly uh it it's recommended to
03:32:14.580 explicitly publishing data for external
03:32:16.319 consumption to a separate location
03:32:18.060 instead of accessing it via a remote
03:32:20.640 state so what would be Alternatives well
03:32:23.220 you've seen this because when we looked
03:32:25.020 at data sources we were technically
03:32:26.220 we're using Alternatives but the idea is
03:32:28.080 that you are going to say AWS S3 bucket
03:32:31.319 AWS rep 53 zones and these are kind of
03:32:34.080 already set up to work with AWS or
03:32:37.140 whichever provider okay so that's that
03:32:41.160 there
03:32:42.600 but uh yeah hopefully that's pretty
03:32:44.640 clear so the idea is that when you can
03:32:46.800 use these data sources because you know
03:32:49.680 they're actually working off of live
03:32:51.359 data right like it's hitting a resource
03:32:53.220 it's not just looking at a state file
03:32:54.600 that contains data okay
03:32:56.580 [Music]
03:33:01.200 so we had mentioned State locking just
03:33:03.720 briefly when we were looking at standard
03:33:05.460 back ends but let's go take a look in
03:33:07.200 detail what these are because they're
03:33:08.880 very important for your workflows so
03:33:10.800 terraform will lock your state for all
03:33:12.720 operations that could write State this
03:33:15.060 prevents others from acquiring the lock
03:33:16.859 and potentially corrupting your state so
03:33:19.200 State locking happens automatically on
03:33:21.300 all operations that could write State
03:33:22.979 you won't see any message that it's
03:33:25.080 happening if the state locking fails all
03:33:28.020 right so terraform does not output when
03:33:30.359 a lock is complete however if acquiring
03:33:33.420 the lock is taking longer than expected
03:33:35.520 terraform will output a status message
03:33:37.739 so neither on failure and neither when
03:33:40.739 it is complete just if it takes too long
03:33:42.899 so there's a transient issue something
03:33:44.640 with like a networking issue you can
03:33:46.920 disable lock so what you do is use the
03:33:49.620 hyphen lock flag but it's generally not
03:33:52.080 recommended you can force and unlock
03:33:54.060 there's cases where uh you know just
03:33:56.340 does not unlock or add so what you'll
03:33:59.399 have to do is use the force unlock
03:34:00.720 camera and if you unlock the state when
03:34:03.779 someone else is holding the lock it
03:34:05.220 could cause multiple writers Force
03:34:07.439 unlock should only be used to unlock
03:34:09.420 your own lock in the situation where
03:34:12.000 automatic unlocked failed to protect you
03:34:14.819 the force unlock command requires a
03:34:16.979 unique lock ID so terraform will output
03:34:19.380 this lock ID if unlocking fails so this
03:34:22.020 is what it would look like so we have
03:34:23.160 terraform Force unlock and then whatever
03:34:25.680 the ID is hyphen Force so yeah there's a
03:34:29.279 lot going on here but yeah that's what
03:34:31.260 it is
03:34:31.940 [Music]
03:34:36.359 all right so let's talk about protecting
03:34:38.160 sensitive data so terraform State file
03:34:40.319 can contain sensitive data so long-lived
03:34:42.600 database credentials and is possible
03:34:44.279 attack Vector for malicious actors and
03:34:47.160 so when you're dealing with the local
03:34:48.600 state when you're using local backend
03:34:51.000 the state is stored in plain text Json
03:34:53.100 files you need to be careful you do not
03:34:55.260 share the state file with anyone you
03:34:57.060 need to be careful you do not commit
03:34:58.560 this file to your git repository when
03:35:00.960 you're using a remote state with
03:35:01.920 terraform Cloud the idea here is the
03:35:04.439 save file is held in memory and is not
03:35:06.060 persisted to disk the state file is
03:35:07.979 encrypted at rest the state file is
03:35:10.020 encrypted in transit with terraform
03:35:11.760 Enterprise you have detailed audit
03:35:13.200 logging for tampering evidence to take
03:35:14.760 it one step further so you can just see
03:35:17.279 that there's a lot of work that has to
03:35:18.840 be done when you are using it locally
03:35:21.140 but with terraform Cloud this is kind of
03:35:23.700 the cell for terraform cloud is that
03:35:25.020 it's just going to do everything
03:35:26.220 possible to make that secure would it be
03:35:28.859 secure to use a remote say with a
03:35:30.600 third-party storage let's talk about
03:35:31.680 that so you can store state with a
03:35:33.779 various third-party back-ends but you
03:35:35.580 need to be careful to review your
03:35:36.960 backend's capabilities determine if you
03:35:38.819 meet your security and compliance
03:35:40.560 requirements some back-ends are not by
03:35:43.020 default as secure as they could be so
03:35:44.580 for example AWS S3 you could have you
03:35:47.399 have to ensure encryption and versioning
03:35:49.560 is turned on and you need to create a
03:35:51.420 custom Trail for data events so you can
03:35:53.220 get
03:35:54.239 tamper evidence logging if you turn on
03:35:56.340 data events for custom cloud trail
03:35:59.220 events but one thing that if it's
03:36:01.500 important to you is that you know if you
03:36:02.760 use S3 it's not held in memory you know
03:36:04.739 that'd be using a cloud HSM or KMS so
03:36:09.060 you know you have to understand there
03:36:10.560 are some trade-offs okay
03:36:12.570 [Music]
03:36:17.040 let's take a quick look here at
03:36:18.479 terraform ignore files and if you know
03:36:20.279 what git ignore files it's pretty much
03:36:21.720 the same thing so when executing a
03:36:23.760 remote plan or apply in a CLI driven run
03:36:25.920 an archive of your configuration
03:36:27.540 directory is uploaded to terraform cloud
03:36:29.399 and so you could Define paths to ignore
03:36:31.680 from upload via the dot terraform ignore
03:36:34.200 file at the root of your configuration
03:36:36.060 directory if this file is not present
03:36:38.100 the archive will exclude the following
03:36:39.840 by default so dot get dot terraform and
03:36:43.920 Dot terraforming Nora works just like a
03:36:45.660 DOT get ignore with the only difference
03:36:46.979 is that you cannot have multiple dot
03:36:49.020 terraform ignore files in subdirectories
03:36:50.760 only the file in the root directory will
03:36:53.279 be read so there you go and yes I know
03:36:56.040 there's a double the okay so don't worry
03:36:58.800 about that
03:36:59.530 [Music]
03:37:03.359 foreign
03:37:07.319 foreign
03:37:10.660 [Music]
03:37:19.680 let's talk about resources so resources
03:37:22.020 in configuration files represent
03:37:23.580 infrastructure objects such as virtual
03:37:25.319 machines databases virtual Network
03:37:26.880 components and storage and so it pretty
03:37:28.859 much looks like this a resource type is
03:37:30.600 determines the kind of infrastructure
03:37:32.640 object it is so here it says AWS
03:37:35.279 instance and this would represent an AC
03:37:37.380 AWS ec2 instance this is all defined
03:37:39.779 within the providers documentation so
03:37:42.359 you have to kind of look at what name
03:37:43.680 they use to figure out what it is and
03:37:45.960 even though you don't see provider
03:37:47.819 explicitly set here a resource does
03:37:49.979 belong to a provider and you can
03:37:52.200 explicitly set it and you would do this
03:37:53.819 when you'd want to set a resource
03:37:55.439 outside the default provider that you
03:37:57.120 have in your configuration file and so
03:38:00.120 one little thing that I hadn't mentioned
03:38:02.100 anywhere else and that's why I made this
03:38:03.359 slide was to mention about special
03:38:05.100 timeout nested blocks within resources
03:38:06.840 so some resource types provide a special
03:38:08.760 time on asset block argument that allows
03:38:10.620 you to customize how long certain
03:38:12.479 operations are allowed to take before
03:38:13.859 being considered to have failed okay so
03:38:16.560 there you go
03:38:17.520 foreign
03:38:20.840 [Music]
03:38:22.260 let's talk about complex types so a
03:38:24.540 complex type is a type that groups
03:38:26.040 multiple values into a single value and
03:38:28.200 complex types are represented by type
03:38:30.600 Constructors but several of them are
03:38:33.540 have shorthand keyword versions okay so
03:38:36.180 there are two categories of complex
03:38:37.800 types we have collection types for
03:38:39.479 grouping similar values so list map set
03:38:41.880 and structural types for grouping
03:38:43.560 potentially to similar values so Tuple
03:38:46.080 an object and it's now that we have an
03:38:48.300 overview let's go jump into collection
03:38:49.859 types and structural types
03:38:51.690 [Music]
03:38:56.040 a collection type allows multiple values
03:38:58.200 of one other type to be grouped together
03:38:59.880 as a single value and the type of value
03:39:02.160 within a collection is called its
03:39:03.840 element type the three kinds of
03:39:05.460 collection types are list map and set
03:39:07.680 and so looking at our first one here
03:39:10.140 what we're doing is we are setting
03:39:12.479 ourselves something that looks kind of
03:39:13.620 like an array and it's these list type
03:39:15.300 here and what we can do is use our index
03:39:17.880 so the indices 0 to reference the first
03:39:20.520 element which is Mars so that's going to
03:39:22.439 make our username Mars for a map it's
03:39:25.080 very similar to a ruby hash or
03:39:26.460 singleness to Json object and the idea
03:39:29.040 here is that it's very similar to the
03:39:31.439 first except now we're doing a key and
03:39:33.120 value and then we access it by based on
03:39:36.060 the key name so plan B is going to
03:39:38.700 return 50 USD okay
03:39:40.920 we have set it is similar to a list but
03:39:43.020 has no secondary index or preserved
03:39:45.359 ordering
03:39:46.620 all values must be of the same type and
03:39:49.140 will be cast to match the first element
03:39:51.359 okay so it's a great way to kind of have
03:39:55.080 um well I guess no secondary index but
03:39:56.819 yeah so you do two set and then it would
03:39:58.739 turn into this okay
03:40:00.450 [Music]
03:40:04.620 all right let's take a look here at
03:40:05.819 structural type so a structural type
03:40:07.200 allows multiple values of several
03:40:09.000 distinct types to be grouped together
03:40:10.319 with a single value structural types
03:40:12.660 require a schema as an argument to
03:40:14.460 specify which types are allowed for
03:40:15.960 which elements so this is what they're
03:40:18.000 talking about when they say this schema
03:40:19.439 so when you actually Define the variable
03:40:21.000 notice where it says object and you are
03:40:23.279 actually setting a is going to be a
03:40:25.140 string and B is going to be a string
03:40:27.180 there's this optional option which I
03:40:28.680 think is right now in beta but hopefully
03:40:30.779 by the time this course is out or it's
03:40:32.399 the future you have that option there
03:40:34.260 but just assume that they're all
03:40:35.399 required so that's what they're talking
03:40:36.479 about is that you are specifying exactly
03:40:38.700 what you expect the schema to be okay so
03:40:42.359 there are two kinds of structural types
03:40:44.520 we have objects and tuples and they're
03:40:46.140 going to look very familiar to maps and
03:40:48.239 lists because they're pretty much the
03:40:49.319 same but with explicit typing so object
03:40:51.239 is a map with more explicit keying so
03:40:53.399 this example we'd have name for string
03:40:55.080 age for number and so that's what it
03:40:57.239 would expect the data structure to be
03:40:58.739 for Tuple multiple return types with a
03:41:00.899 parameter so we can have string number
03:41:02.939 or Boolean so so this is where we'd have
03:41:06.319 a as a string 15 or true as a Boolean so
03:41:10.080 you know there you go
03:41:12.320 [Music]
03:41:16.500 hey this is Andrew Brown from exam Pro
03:41:18.300 and we're going to look at the
03:41:19.800 collection and structural type so I have
03:41:22.140 a new folder down below just in case we
03:41:25.020 need to Define some things so I'm going
03:41:26.939 to go here and just call this main.tf
03:41:31.380 and we are just going to configure this
03:41:33.660 for a local terraforms we'll just give
03:41:35.760 the brackets there and so the idea is
03:41:37.680 that we might have different kinds of
03:41:39.420 variables
03:41:40.859 and we had done this previously where we
03:41:43.080 created a list and a map but we can do
03:41:45.779 that again so we'll have like planet
03:41:48.899 right
03:41:50.760 so that's list and then we just default
03:41:53.220 that to a value Mars
03:41:56.340 Earth
03:41:58.739 Moon
03:42:00.300 and then we could also have you know
03:42:02.460 plans here and that would be our map
03:42:04.500 type
03:42:08.580 okay and so here we'll just set it
03:42:14.040 the curlies
03:42:17.939 plan A
03:42:25.200 Plan B
03:42:30.180 plan C
03:42:43.979 um
03:42:45.060 so we'll do terraform console and so
03:42:46.859 that should load these variables for us
03:42:49.620 to use
03:42:51.060 and so if I do var.plans
03:42:54.239 I get that and if I do VAR dot planets
03:42:58.920 uh didn't like what I did there input
03:43:01.380 variable has not been declared
03:43:03.600 I suppose just plan it there so I should
03:43:05.580 have named that planets up here
03:43:08.279 and so what we're going to do here is
03:43:10.380 just go ahead and exit
03:43:12.840 type clear
03:43:14.880 I'm just going to expand this a bit
03:43:16.260 bigger so we're taking over more of the
03:43:17.880 screen and let's take a look at
03:43:19.620 structural types so these require you to
03:43:21.359 actually Define
03:43:22.979 um
03:43:23.939 parameters so what I'm going to do is go
03:43:25.920 down below and we're going to do the
03:43:27.779 object
03:43:29.880 and object is very similar to the map so
03:43:32.460 let's go down here
03:43:34.739 plans object
03:43:38.700 and so here what we do is we'd say type
03:43:43.380 object
03:43:45.779 and we would just have to Define some
03:43:47.580 settings here
03:43:51.359 um
03:43:54.000 so we could say
03:43:59.520 a is a string
03:44:03.899 all right we'll see if that works
03:44:09.779 the default value is now compatible with
03:44:11.399 the variable type constraint attribute a
03:44:13.620 is required
03:44:15.359 so that's fine what we could do is just
03:44:18.180 Define this as like plan A
03:44:23.040 Plan B
03:44:25.080 plan C
03:44:31.200 and now if we just do VAR plans object
03:44:35.939 when you are using this you know you
03:44:38.160 might want to specify some different
03:44:39.600 kinds here so you could just say like
03:44:42.479 you say like plan here
03:44:45.899 as soon as they plan name
03:44:48.840 plan amount
03:44:52.020 maybe it's like number
03:44:55.319 and so then we'd say plan name
03:44:58.920 plan amount
03:45:01.500 basic
03:45:03.720 maybe this will be 10.
03:45:09.779 okay and we'll just uh
03:45:12.180 type exit here and go back into
03:45:13.800 terraform Cloud hopefully we don't get
03:45:15.300 an error here so the plan amount is
03:45:17.399 required so you know we can't have a
03:45:19.080 spelling mistake here
03:45:23.340 just do VAR plan here
03:45:28.859 um
03:45:31.080 well we named it correctly there and
03:45:32.880 when we went up here and specified it I
03:45:34.680 think we got it right plan object
03:45:38.819 so
03:45:41.399 tripler doesn't like here oh you know
03:45:43.380 what we're not in terraform Cloud okay
03:45:44.700 that's fair
03:45:47.040 and we're still spelling this wrong
03:45:52.260 oops
03:45:58.979 okay so there we go we get our basic
03:46:00.960 plan
03:46:02.100 um and then we could do a tuple here so
03:46:07.439 I don't know if I've ever defined a
03:46:08.760 tuple before so let's just try it here
03:46:10.380 and so we'll just say uh
03:46:13.859 groceries or value or random
03:46:22.739 type equals Tuple
03:46:32.460 I'm just looking up if there's any kind
03:46:34.020 of definition I can find here
03:46:44.279 I'm not really finding anything but I'm
03:46:45.840 just going to go Define this here
03:46:47.520 because I thought maybe it needed like a
03:46:48.840 schema or something but maybe it doesn't
03:46:50.160 so we'll just say
03:46:51.540 hello 22
03:46:54.960 false okay
03:46:57.840 terraform console
03:47:01.020 dribble Constructor requires one
03:47:02.460 argument specifying the element types as
03:47:04.500 a list
03:47:06.060 okay so if that's the case then what we
03:47:08.340 could do is say string
03:47:10.620 number
03:47:12.239 Boolean
03:47:18.479 the type Constructor requires one
03:47:20.520 argument specifying the number of
03:47:22.140 elements so clearly I'm doing this wrong
03:47:24.359 so just give me a second I'll be back in
03:47:25.920 a moment okay all right so I think the
03:47:27.359 problem here was just that I need to
03:47:28.800 make brackets here like this
03:47:31.739 we'll give that a go
03:47:34.680 boolean's not a valid option what if we
03:47:37.080 try Bool
03:47:41.220 okay we say VAR dot random
03:47:43.680 good and so I'll just go ahead and exit
03:47:45.660 that out I'm just going to see what
03:47:47.100 happens if I change the order here so
03:47:48.479 let's say I do instead of 22 here
03:47:51.060 we go here
03:47:54.239 okay so notice that you know we can have
03:47:56.580 all sorts of Kinds but they have to
03:47:57.840 match exactly the order that is there so
03:48:00.239 yeah that's pretty much it so there you
03:48:02.100 go
03:48:02.880 [Music]
03:48:07.380 the terraform language includes a number
03:48:09.540 of built-in functions that you can call
03:48:11.340 from within Expressions to transform
03:48:13.380 your combined values so we have numeric
03:48:15.540 string collection encoding file system
03:48:18.840 date and time hash encrypto ipnetwork
03:48:22.460 type conversions so we are going to go
03:48:25.260 through all of these we might not go
03:48:26.819 through every single function but we'll
03:48:28.620 go through every single major category
03:48:30.739 in terms of the exam the only thing
03:48:33.120 that's going to show up might be string
03:48:35.100 functions why they do this I don't know
03:48:37.140 it's not a very good exam question but
03:48:38.760 those might appear but I think that this
03:48:40.920 is one of the strongest features of
03:48:42.359 terraform over something like cloud
03:48:43.979 formation and I really want to just show
03:48:46.800 you the Gambit of them okay
03:48:48.720 foreign
03:48:52.000 [Music]
03:48:53.279 let's take a look here at numeric
03:48:54.899 functions starting with absolute so
03:48:56.340 Returns the absolute value of the given
03:48:57.779 number so 23 is 23 0 is 0 and if you get
03:49:00.720 a negative number it's going to flip to
03:49:02.100 the positive for 4. what it does is it
03:49:04.560 rounds down to the nearest whole number
03:49:06.239 so see where it says 4.9 becomes a 4.
03:49:08.700 you have logs so it Returns the
03:49:11.420 logarithmetic I can't say that word
03:49:13.760 logarithm logarithm of a given number in
03:49:16.680 a given base so log 50 comma 10 is going
03:49:19.920 to give you that 16 comma 2 is going to
03:49:22.319 give you 4 okay seal it it's where it
03:49:25.260 will always round up so see where it
03:49:27.120 says 5.1 and it goes all the way to 6.
03:49:29.340 we have Min so take one or more numbers
03:49:31.739 and return the smallest number from the
03:49:33.359 set and Max take one or more numbers and
03:49:36.060 return the greatest number of the set I
03:49:37.500 don't have examples because that's
03:49:38.460 pretty straightforward you know if
03:49:39.960 there's a two and a four it's going to
03:49:41.040 return the two in Min if it's a two and
03:49:42.600 a four it's going to return the four for
03:49:44.279 Max we have parse n so parse is the
03:49:47.580 given string as a representation of an
03:49:49.920 integer in the specified base and
03:49:51.779 Returns the resulting number so if we
03:49:54.660 have a hundred here in strings it's
03:49:56.520 going to and we say comma 10 we're going
03:49:59.220 to get 100 because that's the base
03:50:00.239 system it's base system 10 base system
03:50:02.939 16 we can see letters in there right so
03:50:05.399 it's able to translate that this is two
03:50:07.920 so that's basically binary so zeros and
03:50:10.500 ones so you get the idea there
03:50:12.840 uh pow so calculates an exponent by
03:50:16.680 raising its first argument to the power
03:50:19.439 of the second argument so that's just
03:50:21.420 the way of doing powers and then we have
03:50:22.979 Signum so determine the sign of a number
03:50:25.080 returning a number between negative one
03:50:27.420 and one to represent the sign so there
03:50:30.720 you go
03:50:31.970 [Music]
03:50:36.359 all right let's take a look here at
03:50:37.620 string functions the first being chop so
03:50:39.840 removes new line characters at the end
03:50:41.700 of a string so you know if there's a
03:50:44.100 hyphen n or sorry backslash n you don't
03:50:46.140 want to see that there that's the way
03:50:47.340 you get rid of it then you have formats
03:50:49.380 it produces a string by formatting a
03:50:51.000 number of other values according to the
03:50:52.800 specification so here there are
03:50:55.939 percentage Delights so this is
03:50:58.020 representing a a digit so it's taking
03:51:00.540 that number this says it's going to be
03:51:02.040 formatted as a string okay
03:51:04.520 format list so produce a list of strings
03:51:07.260 by formatting a number of other values
03:51:09.120 according to a specification string so
03:51:12.660 here we have an array and then we have
03:51:15.060 our specification so you can see it's
03:51:16.800 substituting the name there
03:51:19.979 um we'll look at indents so adds a given
03:51:22.020 number of spaces to the beginnings of
03:51:23.760 all but the first line in a given
03:51:25.739 multi-string so here we have a string
03:51:29.479 and what it's going to do is see where
03:51:32.460 we have the interpolation here and then
03:51:34.680 we have indent I know the the
03:51:36.300 highlighting is not great because it's a
03:51:37.620 single string but we have interpolation
03:51:39.300 we have parentheses two so give it a a
03:51:42.660 layer of two indentation and then it's
03:51:45.779 going to break that up and give it
03:51:47.460 indentation so we have join so produce a
03:51:50.220 string by concatenating together all
03:51:52.140 elements of a given list of strings with
03:51:53.880 a given deliminator so use delimiters is
03:51:57.359 double click or sorry it's a comma and
03:51:59.819 so it's going to glue that together to
03:52:01.439 make this okay
03:52:02.939 if there's only a single one there just
03:52:04.859 won't be any comma in there we can lower
03:52:07.680 all the text it's pretty straightforward
03:52:09.180 we have regular Expressions so that is
03:52:12.180 an extremely powerful feature so here we
03:52:14.279 have the regex I don't know what the
03:52:15.779 regex format is uh maybe it's Pearl I'm
03:52:18.899 not sure there's like a bunch of
03:52:21.060 different types of regex Standards so
03:52:23.220 you know do you have to figure that out
03:52:24.720 so you know how to use it and then
03:52:26.640 there's a regex all so applies to a
03:52:28.380 regular expression to a string and
03:52:29.580 returns a list of notches where this
03:52:31.260 just is returning uh one okay
03:52:33.899 We have replaced so search is a given
03:52:35.760 string for another given substring and
03:52:37.620 replaces each occurrence within a given
03:52:40.859 replacement string this is just like the
03:52:42.660 JavaScript replace we have split this is
03:52:45.300 the opposite of join so if we want to
03:52:47.220 split on the comma we specify comma here
03:52:49.260 we have Str rev so string reverse so
03:52:52.920 reverse is a string so hello becomes Ole
03:52:56.279 we have sub ol
03:52:59.720 sure I don't know
03:53:02.160 um so substring so extracts a substring
03:53:04.739 from a given string by offset and and
03:53:07.140 length so we have a substring and we're
03:53:09.600 saying we want one to four so we only
03:53:11.819 want one two three four here okay
03:53:14.880 because it starts at zero we have title
03:53:17.399 so make a title okay so capitalize the H
03:53:19.260 and the w we have trim removes the
03:53:22.319 specified character from the start and
03:53:24.239 end of the string so we don't want these
03:53:25.979 and we tell it to remove those
03:53:27.840 there's a lot of string functions uh so
03:53:29.939 we have trim prefix so it removes the
03:53:32.279 specified prefix from the start of the
03:53:34.140 given string if the string does not
03:53:35.760 start with the prefix the string is is
03:53:38.160 returned and unchanged so here we say we
03:53:40.859 want to get rid of hello in the front so
03:53:42.540 we do that suffix is the opposite so we
03:53:45.120 want to get a rid of world out of the
03:53:46.920 suffix so we do that we have trim space
03:53:49.439 so removes all types of white space from
03:53:51.479 both the start and end of the line so it
03:53:53.340 gets rid of the new lines and the spaces
03:53:55.800 upper is going to put everything to
03:53:57.420 Upper and there you go on the exam they
03:53:59.819 probably will ask you uh like what
03:54:02.040 string function does or which one does
03:54:04.260 not do something so this is the only
03:54:06.239 part of the built-in functions you have
03:54:07.680 to know for the exam I don't think it's
03:54:09.239 a very good exam question but it does
03:54:11.040 appear there so you need to know it okay
03:54:13.200 foreign
03:54:16.440 [Music]
03:54:18.260 functions and these are the most
03:54:20.460 powerful built-in functions and there's
03:54:22.319 a lot of them and I made sure to give
03:54:24.420 you an example for each one because I
03:54:25.920 really do want you to know these because
03:54:27.300 this is the power of terraform the First
03:54:29.760 on our list here is altru's returns true
03:54:31.979 if all elements in a given collection
03:54:33.600 are true are true or it also returns
03:54:36.720 true if the collection is empty so it's
03:54:38.699 either true true right or we have true
03:54:41.100 false so because there's a false it's
03:54:42.960 not going to be true so any true is very
03:54:45.720 similar but there only has to be one
03:54:47.699 that is true so if this is true and
03:54:50.520 there's a false that's going to be true
03:54:51.840 if it's blank it's going to be false
03:54:54.239 okay
03:54:55.319 we have chunkless splits a string list
03:54:58.260 into fixed size chunks returning a list
03:55:00.660 of lists so here we're telling it to
03:55:04.020 chunk it every two so grab every two and
03:55:06.060 make them into their own little array or
03:55:07.920 list I suppose we have coalesce takes
03:55:10.319 any number of arguments Returns the
03:55:11.819 first one that isn't null or empty
03:55:13.560 string if you're used to postgres you
03:55:15.180 use this all the time but the idea is
03:55:17.279 it's going to grab the a in this case
03:55:19.800 it'll grab the B because that's blank in
03:55:21.479 this case we'll grab the one because
03:55:22.380 that's the first value we have coalesce
03:55:24.600 list takes any number of list arguments
03:55:26.460 and Returns the first one that isn't
03:55:28.199 empty so very similar it's just using
03:55:30.180 lists or if we want to call them array
03:55:31.800 so the first one is available so it
03:55:33.239 takes that one we have compact so it
03:55:36.120 takes a list of strings and returns a a
03:55:38.160 new list with an empty string elements
03:55:40.800 removed so it's just going to get rid of
03:55:43.500 that space there and we'll get ABC
03:55:46.199 we have concat so it takes two or more
03:55:48.540 lists and combines them into a single
03:55:50.699 list so that's very convenient we have
03:55:52.920 contain so determines whether a given
03:55:55.260 list or set contains a given single
03:55:57.960 value as one of its elements so does it
03:56:00.960 have an A yes it does does it have a d
03:56:03.300 no it does not we have distinct so takes
03:56:06.120 a list and returns a new list with any
03:56:09.359 duplicate elements removed so we just
03:56:12.899 want to make sure we only have one of
03:56:14.399 each so do we have any duplicates here
03:56:16.020 we have two a's and two B's so we're
03:56:19.979 going to end up with just a single list
03:56:22.140 so only exactly one of each letter
03:56:25.020 we have elements retrieves a single
03:56:27.180 element from a list so get me the
03:56:29.460 element at uh at three here so
03:56:33.300 um wait retrieves a single element from
03:56:35.699 a list
03:56:37.620 okay well that's what it does you give
03:56:39.420 it a three and it gives you an a I don't
03:56:41.580 know why it's not clicking for me but I
03:56:43.500 I'm not following through here index
03:56:45.960 finds the element index for a given
03:56:48.359 value in a list so we say where is B and
03:56:51.359 the index of B is is one because it'd be
03:56:53.699 zero and this would be one still really
03:56:55.500 confused about this one
03:56:57.140 flatten takes a list and replaces any
03:57:00.120 elements that are are lists with a
03:57:03.000 flattened sequence of list content so
03:57:04.800 basically it says give me a bunch of
03:57:06.120 eraser let's turn into one flat list
03:57:10.020 uh Keys take a map and return a list
03:57:13.199 containing the keys from the map so we
03:57:15.660 just want the keys a c and d
03:57:18.660 we want length this is pretty
03:57:20.040 straightforward so what's the length of
03:57:22.020 this zero this is two this is one
03:57:24.479 because it's a one uh mapper one thing
03:57:27.899 key value in there and if it's a string
03:57:30.359 it's going to count the characters so
03:57:31.620 there's five characters
03:57:33.060 we have lookup so retrieves the value of
03:57:35.160 a single element from a map
03:57:37.500 given its key if the given key does not
03:57:40.500 exist the given default value is
03:57:42.239 returned instead
03:57:44.040 so we say look up a and what we get is a
03:57:49.859 y right look up C and it could not find
03:57:53.760 C so by default give us what instead
03:57:57.000 key a match Keys construct a new list by
03:57:59.460 taking a subset of elements from one
03:58:01.560 list whose indexes match the
03:58:03.300 corresponding indexes of values in
03:58:05.520 another list
03:58:06.899 that sounds complicated let's read that
03:58:08.460 one more time so constructs a new list
03:58:10.640 by taking a subset of elements from one
03:58:14.760 list who indexes match the corresponding
03:58:17.040 index of values in another list that is
03:58:18.840 confusing so we have one less than
03:58:21.239 another one so we have this one here
03:58:25.020 and we have us West Us East USD so we
03:58:27.540 say okay we have uses so the elements
03:58:30.660 here is two and three so give us two and
03:58:32.640 three so that's what it does
03:58:34.560 that was a that was a tricky I can't
03:58:36.300 think of what you use that for but
03:58:37.560 that's a interesting function merge
03:58:39.840 takes an arbitrary number of maps or
03:58:42.120 objects and returns a single map or
03:58:45.180 object that contains a merged set of
03:58:46.800 elements from all arguments
03:58:48.960 so it just merges them together so it's
03:58:50.939 just like concat
03:58:52.859 or I suppose like flatten uh one takes a
03:58:55.859 list set or Tuple values from with
03:58:58.199 either zero or one element if the
03:59:00.600 collection is empty one returns null
03:59:02.279 otherwise one Returns the first element
03:59:04.020 if there are two or more elements then
03:59:06.420 one will uh one will return an error so
03:59:10.260 it returns null on an empty List It
03:59:12.180 Returns the first one and then here it
03:59:13.859 says invalid function so it's just
03:59:15.060 saying is there one right is it one or
03:59:17.699 zero ranges generates a list of numbers
03:59:20.580 using a start value a limit value and a
03:59:23.760 step value so we say three and we get 0
03:59:26.520 1 and 2.
03:59:28.199 during its a list of numbers using a
03:59:30.960 start value limit value and a step value
03:59:32.880 okay
03:59:34.500 uh reverse so takes a sequence and
03:59:37.199 produces
03:59:38.460 res oh not reverse Reserve sorry Reserve
03:59:42.300 takes a sequence and produces a number
03:59:44.720 induced sequence of the same length with
03:59:47.460 all the same elements as the given
03:59:49.260 sequence but in reverse order oh it is
03:59:52.140 reverse r e reverse I guess I spelled it
03:59:54.899 wrong here sorry reverse one two three
03:59:57.359 three two one just notice this is a
03:59:59.220 spelling mistake okay
04:00:00.779 uh set intersection so function takes
04:00:03.540 multiple sets and produces a single set
04:00:05.840 containing only the elements that all of
04:00:08.520 the given sets have in common in other
04:00:10.560 words it computes the intersection of
04:00:12.479 the sets well it's tiring so from what I
04:00:15.779 can tell it's like they all have B so
04:00:17.520 give us B right
04:00:19.500 set product functions find all the
04:00:21.779 possible combinations of elements from
04:00:23.760 all of the given sets by Computing the
04:00:26.100 cardistarian product we're really
04:00:28.020 getting into math here so we got app one
04:00:31.260 and app2
04:00:32.880 and so we got uh development develop
04:00:35.580 okay so this continues on so it's going
04:00:37.319 to say give me app one with development
04:00:38.760 give me uh app two with development then
04:00:41.340 Apple Mustang and then app2 with staging
04:00:43.739 and etc etc because that's why I put the
04:00:46.020 three dots there set subtract function
04:00:48.420 returns a new set containing the
04:00:50.699 elements from the a from the first set
04:00:52.920 that are not present in the second set
04:00:54.840 in other words it computes the relative
04:00:57.540 complement of the first set in the
04:01:00.180 second set
04:01:01.500 uh it lost me there but it says set
04:01:03.899 subtract so here I see a B and C A and C
04:01:07.020 minus it you get B okay
04:01:09.840 set Union function takes multiple sets
04:01:12.060 and produces a single set containing the
04:01:13.920 elements from all the given sets in
04:01:16.080 other words it computes the union of the
04:01:18.120 sets so it says set Union so we have
04:01:21.540 a b b c and d and in the results we get
04:01:25.439 d b c a so I guess
04:01:29.880 um single set containing the elements
04:01:31.199 from all the given so yeah yeah I guess
04:01:33.660 it's just we get unique ones across the
04:01:35.520 sets uh we have slice and notice like
04:01:38.160 we're going through all these things
04:01:39.000 it's like you probably won't use these
04:01:40.439 more exotic ones so it's not a big deal
04:01:42.060 if we don't nail them here but it's
04:01:43.620 important that we go through these so
04:01:45.120 that you know you just know all the
04:01:46.380 options are here so slice extract some
04:01:48.840 constructive consecutive elements from
04:01:51.540 within a list so here we are saying one
04:01:54.300 and three so we have B and C that's
04:01:56.460 where they start index one
04:01:59.640 um and then extract some consecutive
04:02:02.460 elements from within a list one comma
04:02:05.580 three
04:02:06.479 okay
04:02:08.520 sort takes a list of strings and returns
04:02:11.100 a new list with those strings sorted
04:02:13.640 lexicographically so we have e d a and x
04:02:17.279 and so now they're alphabetical so a d e
04:02:20.160 and X
04:02:21.899 well I think this is the last one uh
04:02:24.060 some takes a list of set numbers and
04:02:25.979 Returns the sum of those values that's
04:02:27.479 pretty straightforward add them all up
04:02:28.800 transpose take a map of list of strings
04:02:31.439 and swap the key and values to produce a
04:02:33.840 new map a list of strings so kind of
04:02:36.540 like inverts it values takes a map and
04:02:39.479 returns a list containing the values of
04:02:41.220 the map so we saw this earlier we got
04:02:43.080 the keys this is where we just want to
04:02:44.160 get the values zip map so construct a
04:02:46.920 map from a list of keys and a
04:02:48.660 corresponding list of values so we have
04:02:51.120 a b one two and this turns it into a
04:02:53.580 equal one b equals two I think I saw
04:02:55.800 this on the exam so that one you might
04:02:57.779 want to remember but yeah that's
04:02:58.979 collection functions as you can imagine
04:03:00.600 they're extremely powerful but they can
04:03:02.279 also be really confusing so maybe just
04:03:04.020 use them a little bit when you need to
04:03:05.819 okay
04:03:06.640 [Music]
04:03:10.979 we're taking a look here at encoding and
04:03:12.840 decoding functions so functions that
04:03:14.760 will encode and decode for various
04:03:16.560 formats so imagine we need to encode
04:03:19.500 into base64 so we do hello world or
04:03:22.620 imagine we give that encoded string and
04:03:25.260 we want to decode it back to hello world
04:03:27.020 that's what we can do so there's a lot
04:03:29.640 of different encoding decoding functions
04:03:31.080 most of them are the same they're just
04:03:32.520 kind of variants so we're not going to
04:03:33.840 go through every single one but I'll
04:03:35.520 list them out so you know what they are
04:03:36.540 so we have base64 encode Json encode
04:03:39.120 text and code base64 yaml encode base64
04:03:42.359 gzip URL encode base64 decode CSV decode
04:03:47.040 Json decode text decode base64 yaml
04:03:51.180 decode and just notice that you know
04:03:53.580 these aren't one to one so there is one
04:03:55.020 for this we have one for here uh we have
04:03:59.040 one for yaml
04:04:00.720 uh this is unique this is unique this is
04:04:04.380 unique okay just so you can tell for
04:04:06.960 your own code I think this one's a very
04:04:08.880 common one that you'll use but the idea
04:04:10.439 is that let's say you have hello world
04:04:11.699 you want to replace that string with a
04:04:13.680 uh whatever friendly for a URL right so
04:04:15.960 it just encodes it okay it's very useful
04:04:18.300 when you're making URL links so there
04:04:20.880 you go
04:04:21.670 [Music]
04:04:25.920 we're taking a look here at file system
04:04:27.359 functions so this has everything to do
04:04:28.859 with the file system so the first is
04:04:30.359 absolute path so the idea is you give it
04:04:32.460 something that's relative and it's going
04:04:34.020 to give you something absolute directory
04:04:36.720 name so this is a string containing a
04:04:38.880 file system path and removes the last
04:04:40.680 portion from it so we don't need the
04:04:42.960 file name so we just remove that off of
04:04:44.880 there we have path expand so takes a
04:04:47.819 fossils and path that might begin with a
04:04:49.800 tilde and expands it into its absolute
04:04:53.279 path so this would be like for home okay
04:04:57.359 um base name so it takes a string
04:04:59.040 containing a file system path and it's
04:05:00.899 basically the opposite of directory name
04:05:02.279 we just want the file here okay
04:05:04.620 onto the next page here this file will
04:05:08.520 read the contents of the file pretty
04:05:10.080 straightforward we can check if a file
04:05:12.779 exists so we just do file exists here we
04:05:15.899 have file set so it enumerates a set of
04:05:17.880 regular file names given a path and
04:05:20.040 pattern file base64 so it reads the
04:05:23.340 contents of a file at a given path and
04:05:25.260 Returns the basics before encoding that
04:05:27.540 might be good for images template file
04:05:29.880 so reads the file at a given path and
04:05:32.220 returns its content as a template using
04:05:34.920 a supplied set of template variables so
04:05:37.920 that's really useful if you want to do
04:05:39.300 some kind of templating
04:05:40.739 uh and just notice it's a two-step
04:05:42.479 process so this is the template file the
04:05:44.939 actual file itself and then we load it
04:05:46.500 here it's called a DOT TPL so there you
04:05:49.439 go
04:05:50.260 [Music]
04:05:54.479 we're taking a look at date and time
04:05:55.800 functions the first is format date so
04:05:58.319 the idea is that we provide a format
04:06:01.680 that we want and then we give it a
04:06:03.420 timestamp that is in the RFC 3339 format
04:06:06.540 and we get a variety of different
04:06:08.819 um formats out there we can add time so
04:06:11.819 again it's going to be that RFC 3339
04:06:13.920 format and we say add 10 minutes add one
04:06:16.140 hour then we have timestamp so you it
04:06:19.199 returns a UTC timestamp string in the
04:06:21.239 RFC 3239 format so you just say
04:06:23.340 timestamp it's I guess it would get
04:06:24.779 right now and then you get it in that
04:06:26.520 format okay
04:06:27.730 [Music]
04:06:31.680 let's take a look at hash and crypto
04:06:33.479 functions so generates hashes and
04:06:35.399 cryptographic strings so the most
04:06:37.319 popular one out there would probably be
04:06:38.640 B so here we just say hello world
04:06:40.380 and we're going to get this thing here
04:06:42.380 understand that a hash cannot be
04:06:45.000 reversed so once it is turned uh into uh
04:06:48.540 you know this format the only way you're
04:06:50.040 going to be able to confirm the contents
04:06:51.660 of it is to Hash something that is
04:06:54.180 similar and then compare it against it
04:06:55.920 okay so we have base64 Shaw 256 we have
04:07:00.180 512 we got B Crypt we have file Bay 64
04:07:03.120 Shaw 256 file based 64 Shaw 512 file md5
04:07:07.560 file Shaha one file Shaw 56 file Shaw
04:07:11.699 512 md5 RSA decrypt sha-1 Shaw to V6
04:07:17.279 Shaw 512 uuid uid V5 so I only showed
04:07:21.960 the one because you know it gets kind of
04:07:24.420 boring to go through all these and
04:07:25.859 really it's just going to be based on
04:07:27.000 your use case what you're going to be
04:07:28.620 using on a day-to-day basis is probably
04:07:30.239 bcrypt md5 and you uids so there you go
04:07:34.090 [Music]
04:07:38.220 let's take a look at IP network
04:07:39.720 functions these are the coolest
04:07:41.100 functions I think that are built into
04:07:42.479 terraform so we have cider host so what
04:07:45.060 we can do is give ourselves a
04:07:47.819 a address and then we can give it a
04:07:50.520 subnet Mass size and we'll get back an
04:07:52.260 IP address and so you can see we have
04:07:55.020 this both in the ipv4 and the IPv6 we
04:07:58.500 have cider net mask so here we are doing
04:08:02.100 cidernet math so we just say forward
04:08:05.160 slash 12 and it's going to translate it
04:08:06.660 into the full ipv4 then we have cider
04:08:10.140 subnet so this is just where we say Okay
04:08:12.840 I want a subnet of a particular size so
04:08:15.779 we say 172 1600 comma 4 2 and look it's
04:08:20.580 going to give us 18 0 back doesn't make
04:08:23.279 sense that's okay I mean networking is
04:08:25.140 really hard but I just want you to know
04:08:26.640 that these functions are here for you
04:08:28.920 okay cider subnet calculates a sequence
04:08:31.199 of consecutive IP addresses within a
04:08:32.939 particular cider prefix so 4484 and then
04:08:36.300 you get those sizes there okay
04:08:39.200 [Music]
04:08:43.380 all right we're on to type conversion
04:08:45.000 function so the first we're looking at
04:08:46.380 is can so can evaluates the given
04:08:48.540 expression and returns a billion value
04:08:49.979 indicating whether the expression
04:08:51.359 produced a result without any error so
04:08:53.640 can we use this right so we say
04:08:56.000 local.food.bar and so you know if if
04:08:58.739 this Foo wasn't defined then it would
04:09:00.660 say false but apparently we've made it
04:09:02.640 all the way to borrow okay
04:09:04.560 we have defaults a specialized function
04:09:06.660 intended for use with input variables
04:09:08.819 whose type constraints are object types
04:09:10.739 or collection of object types that
04:09:12.420 include optional attributes and I don't
04:09:15.660 show that one here because it's not that
04:09:16.859 exciting but non-sensitive takes a
04:09:18.720 sensitive value and returns a copy of
04:09:20.819 that value with the sensitive markings
04:09:22.920 removed therefore exposing the sensitive
04:09:24.840 values so if we have an output here and
04:09:27.060 we want to make it non-sensitive that's
04:09:29.460 what we could do then sensitive as you
04:09:31.979 imagine is just the opposite okay
04:09:35.840 we have two Bool so converts its
04:09:38.939 arguments to a Boolean value so if we
04:09:40.560 have a string that's true we can turn it
04:09:42.000 into a real Boolean value we have to map
04:09:44.520 converts an argument to a map value to
04:09:46.439 set converts it to a set to list
04:09:48.899 converts it to a list to number converts
04:09:51.840 it to a number string to string and then
04:09:54.899 we last we have is try so evaluates all
04:09:56.939 of its arguments expressions in turn and
04:09:58.680 Returns the result of the first one that
04:10:01.080 does not produce any errors the thing
04:10:02.699 that's the hardest to figure out is set
04:10:05.040 I cannot find really good examples or
04:10:07.739 documentation on the use case of set
04:10:09.239 there are some cases where you need to
04:10:10.560 use sets which is an actual type but
04:10:12.779 even talking to DA's and
04:10:14.939 technical writers they weren't even sure
04:10:16.620 themselves so this is not something
04:10:18.960 you're going to come across very often
04:10:20.279 but
04:10:21.060 there's like one case where I saw it so
04:10:23.100 I'll probably point that out when we do
04:10:24.420 hit it okay
04:10:25.340 [Music]
04:10:29.699 hey this is Andrew Brown from exam Pro
04:10:31.380 and we are going to go take a look at um
04:10:34.560 built-in functions as soon as my
04:10:36.479 terminal decides to be responsive I
04:10:38.220 don't know why as soon as I start
04:10:39.060 recording it decides to lock up so we'll
04:10:41.460 just give it a moment there there we go
04:10:42.960 and so I have a new folder there I
04:10:44.819 figured we could just find some
04:10:45.840 variables so that we don't have to uh
04:10:48.260 you know constantly write stuff in so
04:10:51.420 we'll just say main.tf
04:10:53.640 we're going to go terraform here
04:10:57.979 and so might be fun to you know kind of
04:11:01.319 some kind of variable here and so I have
04:11:03.540 off screen here all the functions so
04:11:05.640 we're just going to kind of pick some at
04:11:06.899 random here to play around with so we
04:11:08.699 get some experience okay
04:11:10.380 so just going through strings
04:11:14.520 I think what we can do is Define like
04:11:16.140 our strings so we just say Str here
04:11:18.720 and we'll just say type equals string
04:11:22.199 and we'll just say default here able to
04:11:24.420 say hello
04:11:25.800 world
04:11:27.660 forward slash n
04:11:30.000 something like that
04:11:31.920 okay
04:11:33.960 and then we'll do terraform console here
04:11:39.960 I gotta remember to do it this way
04:11:45.180 so we do var.str
04:11:47.460 okay and so that accesses our string
04:11:49.260 there
04:11:50.520 maybe we might want to take out the new
04:11:51.840 line for now
04:11:59.640 so I'm just going to kind of pull this
04:12:01.140 up over here
04:12:02.880 look at some kind of things we can do
04:12:11.580 okay maybe collapse that get that out of
04:12:14.160 the way all right so there's a lot of
04:12:16.439 string functions and on the exam they
04:12:18.000 might actually ask you some which is in
04:12:20.340 my opinion I don't I don't really like
04:12:21.660 that but that's what they do
04:12:23.160 and so you know we might want to look at
04:12:25.140 something like split or something so
04:12:27.779 here we could do
04:12:30.600 hello world
04:12:33.420 okay
04:12:36.779 start that up again
04:12:38.880 so we'll do split
04:12:41.160 comma
04:12:42.840 VAR Str okay and that would split that
04:12:45.840 into a list
04:12:47.699 we might want to do something
04:12:50.939 like upper so I think we did that
04:12:53.640 earlier where we did upper
04:12:59.100 okay
04:13:00.720 you might want to do trim remove specify
04:13:03.660 characters from the start and end of the
04:13:05.100 string so maybe we have this here
04:13:12.779 and so we'll say trim
04:13:16.260 VAR Str
04:13:19.560 and whoops
04:13:21.359 it's not what I wanted to do
04:13:24.840 trim far Str
04:13:28.080 UCT like that okay
04:13:31.739 and there's again there's not a lot
04:13:33.960 that's exciting here maybe we'll try a
04:13:35.699 replace so we can do replace
04:13:40.020 and we'll we want to replace we won't
04:13:42.239 provide our string
04:13:43.920 and then the substring that we're
04:13:45.479 looking for so world
04:13:47.460 replace that with bar soon which is Mars
04:13:50.760 there we go
04:13:54.779 so nothing super exciting over there
04:13:57.540 what's more interesting are some things
04:13:59.220 like these hash encryptos
04:14:01.500 so something we might want to generate
04:14:02.760 out is a uuid I think that we might be
04:14:05.279 able to do this here so let's just see
04:14:06.600 what happens if we try to call it like
04:14:08.880 that
04:14:10.800 clear
04:14:12.300 to our form cloud
04:14:15.540 oops terraform console that's what I
04:14:17.640 meant to type
04:14:20.399 and so functions can't be called in here
04:14:22.260 which is totally fine
04:14:24.239 so go back and just set that like that
04:14:28.380 I just wanted to show you that
04:14:30.359 so if we did uuid we would get that
04:14:33.660 if we used bcrypt
04:14:37.319 so I might say bcrypt
04:14:42.180 hello world
04:14:49.260 okay
04:14:51.540 might be something interesting the IP
04:14:53.699 network here
04:14:56.340 so we might want to generate out a cider
04:14:58.260 subnet
04:14:59.819 right
04:15:02.040 the typing conversions is something that
04:15:04.020 you might come across a bit so we
04:15:05.939 already saw that when we converted a set
04:15:07.439 to a list and things like that
04:15:09.359 so maybe we might want to convert
04:15:11.340 something to a Boolean so we might say
04:15:13.439 two Bool
04:15:15.779 true
04:15:18.180 okay
04:15:21.180 these are pretty complicated the
04:15:22.920 collections
04:15:24.180 but we might have something that we want
04:15:25.800 to do here so coalesce might be
04:15:27.359 something that's interesting where we
04:15:28.800 have an array so or a list I suppose
04:15:33.120 so we might say like items
04:15:39.060 and make that a list
04:15:44.040 null null empty
04:15:47.520 last okay
04:15:53.460 bar items
04:15:55.680 so we might say coal
04:15:58.859 Plus
04:16:01.020 okay
04:16:03.540 and that didn't look like it pulled
04:16:05.580 anything out of there to reform coalesce
04:16:07.979 operation with this list of strings use
04:16:09.720 this symbol so we could use that
04:16:12.120 um
04:16:13.439 to do that so that just kind of expands
04:16:15.479 the arguments and so that what happened
04:16:18.060 here is null didn't exist Alden exists
04:16:19.920 this didn't exists so it pulled out last
04:16:21.479 okay
04:16:24.540 maybe we might want to just use keys
04:16:27.720 maybe we might just want to use Keys
04:16:29.340 here
04:16:46.080 okay so it might sound like hello
04:16:52.620 world
04:16:55.199 goodbye
04:16:58.500 Moon and remember we can do uh hash
04:17:01.260 Rocket Arrow equals or colon it's just
04:17:03.960 up to your preference I just wrote that
04:17:06.120 in for whatever reason I'm used to using
04:17:07.620 Ruby and that's what we use as hash
04:17:08.880 Rockets that's the name of the symbol
04:17:10.500 the equals Arrow
04:17:13.439 um okay it didn't like that so I guess
04:17:15.540 we do have to do it this way that's
04:17:16.920 totally fine I'm not upset by that I
04:17:18.720 thought it supported all three
04:17:21.420 maybe it's like minus equals or
04:17:23.100 something I don't know but what we'll do
04:17:25.560 say is save our stuff
04:17:28.199 and then what we can do here is do keys
04:17:31.439 okay
04:17:34.340 and it didn't look like it grabbed oh
04:17:37.319 yeah I grabbed the keys that's fine okay
04:17:38.520 and then we might say values
04:17:42.120 all right
04:17:45.180 um
04:17:46.979 you know maybe we might want to try
04:17:48.180 reverse that one's pretty clear
04:17:56.580 one two three
04:18:01.680 okay so nothing super complicated I
04:18:04.319 wonder if absolute would work in here
04:18:05.939 like the file system so we have absolute
04:18:07.560 path
04:18:08.819 I don't know if I don't know if this
04:18:10.080 would produce anything here oh it does
04:18:11.939 okay so we could ABS path
04:18:14.699 say path dot root
04:18:16.620 there you go
04:18:18.779 okay so that pretty much gives you a
04:18:20.580 general idea of built-in functions so
04:18:22.920 there you go
04:18:23.630 [Music]
04:18:27.899 all right let's take a look here at
04:18:29.340 terraform Cloud again but in Greater
04:18:31.260 detail so terraform cloud is an
04:18:32.819 application that helps teams use
04:18:34.199 terraform together and so there is the
04:18:36.779 UI there and terraform cloud is
04:18:38.220 available as a hosted service on
04:18:39.899 terraform terraform.io it's actually at
04:18:42.300 the app.t terraform.io once you're
04:18:44.160 logged in and it has a lot of different
04:18:46.620 features so it can manage State files uh
04:18:49.199 have a history of your previous runs a
04:18:51.060 history of your previous States easy and
04:18:53.100 secure variable injection tagging run
04:18:56.220 trigger so chaining workspaces together
04:18:57.899 specify any version terraform per
04:19:00.060 workspace Global State sharing
04:19:01.920 commenting on runs notifications via
04:19:04.199 webhooks email and slack organization
04:19:06.359 and workspace level permissions policy
04:19:09.060 is code via Sentinel policy sets MFA
04:19:12.000 single sign-on cost estimation
04:19:15.000 Integrations with service now Splunk
04:19:17.899 kubernetes and custom run tasks and that
04:19:21.000 is not the limit to what it does but
04:19:22.859 this is what I could fit on the slide
04:19:24.420 okay
04:19:25.300 [Music]
04:19:29.520 let's take a quick look here at the
04:19:31.560 terminology or anatomy of terraform
04:19:34.380 clouds so we have an organization and
04:19:36.540 with an organization we have our
04:19:38.160 workspaces and a workspace represents a
04:19:41.040 unique environment or stack then you
04:19:43.080 have your teams these are composed of
04:19:44.580 multiple members and a team can be
04:19:46.560 assigned to multiple workspaces then you
04:19:49.080 have runs a run represents a single run
04:19:51.180 of the terraform-run environment that is
04:19:53.399 operating on an execution plan runs can
04:19:55.739 be triggered by like you your the UI
04:19:58.739 itself or maybe like a git repo it could
04:20:00.960 be API driven or CLI driven so there you
04:20:03.420 go
04:20:04.859 foreign
04:20:06.980 [Music]
04:20:08.340 so there are three types of cloud run
04:20:10.140 workflows so when you create a workspace
04:20:11.939 you have to choose a workflow and you
04:20:13.620 have either Version Control workflow we
04:20:16.620 have CLI driven workflow or API driven
04:20:19.020 workflow okay so just going over them in
04:20:22.319 Greater detail for the first one which
04:20:24.120 is that version controlled workflow
04:20:26.359 terraform cloud is integrated with a
04:20:28.380 specific branch in your VCS so githubs
04:20:31.680 via web hooks whenever pull requests are
04:20:33.840 submitted for branch speculative plans
04:20:35.880 are generated whatever a merge occurs to
04:20:38.279 that Branch then a run is triggered on
04:20:40.140 terraform Cloud then you have API driven
04:20:42.420 so workspaces are not directly
04:20:43.859 associated with the Version Control
04:20:45.660 System repository and runs are not
04:20:49.020 driven by web hooks on your VCS provider
04:20:52.080 a third-party tool or system will
04:20:54.120 trigger runs via uploading a
04:20:56.279 configuration file via the terraform
04:20:58.819 Cloud API so this configuration file is
04:21:02.580 a bash script that is packaged in an
04:21:04.500 archive and you're pushing it as a
04:21:06.540 configuration version so you're
04:21:07.680 basically creating configuration
04:21:09.060 versions every time you do that then
04:21:11.160 there's CLI driven and this is the way
04:21:12.720 we're going to be using mostly in the
04:21:14.279 course so runs are triggered by the user
04:21:17.160 running terraform CLI commands so you'll
04:21:20.040 run terraform apply and or plan locally
04:21:23.760 on your machine it's going to just work
04:21:25.140 as per usual okay
04:21:26.750 [Music]
04:21:31.020 let's take a look at organization level
04:21:33.180 permissions which manage certain
04:21:34.859 resources or settings across an
04:21:36.840 organization so the first things that
04:21:39.239 you can set would be something like
04:21:40.560 manage policy so create edit delete the
04:21:42.779 organization Central policies manage
04:21:44.819 policy override so override soft
04:21:46.439 mandatory policy checks manage
04:21:48.420 workspaces so create administer all
04:21:50.520 workspaces within an organization manage
04:21:52.979 VCS settings so set of VCS providers and
04:21:55.920 SSH Keys available within the
04:21:57.600 organization and for an organization we
04:22:00.120 have this concept of organization owners
04:22:01.800 so every organization has at least one
04:22:04.439 organization owner and you can have
04:22:05.880 multiple this is a special role that has
04:22:07.920 every available permission and some
04:22:09.359 actions only available to owners so this
04:22:12.720 could be publishing private modules
04:22:14.399 invite users to organizations manage
04:22:16.439 team memberships view all secret teams
04:22:18.960 manage organization permissions manage
04:22:21.479 all organization settings manage
04:22:23.460 organization Billings delete
04:22:25.199 organizations and manage agents so just
04:22:27.960 understand that there are these special
04:22:29.279 ones just for this organizational owner
04:22:32.100 and then these are these other ones here
04:22:33.840 that you can set for other types of
04:22:35.640 organizational level permissions okay
04:22:37.790 [Music]
04:22:41.939 let's take a look here at workspace
04:22:43.560 level permissions that allows you to
04:22:45.180 manage resources and settings for a
04:22:47.100 specific resource and we have granular
04:22:49.020 ones and then we have pre-made
04:22:50.399 permissions so let's go through the
04:22:51.660 granular permissions first so these
04:22:53.640 granular permissions you can apply to a
04:22:55.979 user via a custom workspace permissions
04:22:58.319 and so we have read runs queue plans
04:23:00.840 apply runs lock and unlock workspaces
04:23:03.180 download signal locks read variables
04:23:05.340 read and write read State outputs read
04:23:08.399 State versions read and write State
04:23:09.960 versions and so the idea is that what
04:23:12.960 you can do is just go and cherry pick
04:23:14.580 out what you want to assemble your
04:23:17.520 permissions for your user now if you
04:23:19.319 want something a little bit easier to do
04:23:22.260 you can use fixed permission sets and
04:23:24.660 these are pre-made permissions for quick
04:23:26.160 assignment and they're based on the read
04:23:27.660 plan and write so we have read runs read
04:23:31.020 variables read State versions for plans
04:23:33.000 we have q plans read variables read
04:23:35.160 State versions We have write so apply
04:23:37.439 runs lock and unlock workspaces download
04:23:39.899 setting unlocks read write variable read
04:23:42.899 write State versions and then there are
04:23:45.479 workspace admins and this is kind of
04:23:47.279 like the organizational owner so a
04:23:49.199 workspace admin is a special role that
04:23:51.540 grants all level of permissions in some
04:23:53.580 workspace admin only permissions those
04:23:55.859 admin only permissions would be read and
04:23:57.660 write workspace settings set or remove
04:24:00.600 workspace permissions of any team and
04:24:02.399 delete workspaces so there you go
04:24:04.340 [Music]
04:24:08.399 let's take a look here at API tokens so
04:24:10.680 terraform Cloud supports three types of
04:24:12.479 API tokens users teams and organization
04:24:14.640 tokens so for organization API tokens
04:24:17.160 they have permissions across the entire
04:24:18.720 organization each organization can have
04:24:20.819 one ballot API token at a time only
04:24:23.040 organization owners can generate or
04:24:24.720 revoke an organization token
04:24:26.340 organization API tokens are designed for
04:24:28.560 creating and configuring workspaces and
04:24:30.120 teams they're not recommended as
04:24:31.979 all-purpose interfaces to terraform
04:24:33.479 Cloud so basically you just use them
04:24:35.460 when you are setting up your
04:24:36.720 organization for the first time and you
04:24:38.760 want to do it pragmatically okay then
04:24:40.680 you have Team API tokens so this allows
04:24:43.020 access to workspaces that the team has
04:24:44.939 access to without being tied to any
04:24:46.680 specific user each team can have one
04:24:49.020 valid API token at a time any member of
04:24:51.600 a team could generate or revoke that
04:24:53.340 team's token when a token is regenerated
04:24:55.859 the previous token is immediately
04:24:58.439 becomes invalid designed for performing
04:25:00.600 API operations on the workspaces same
04:25:03.359 access level to the workspace the team
04:25:05.520 has to access to I would imagine this is
04:25:07.800 when you're sending out your own custom
04:25:09.120 CI CD pipelines or something like that
04:25:11.040 I'm not really sure exactly the use case
04:25:13.620 for team API tokens we have user API
04:25:16.199 tokens the most flexible token type
04:25:18.359 because they inherit permissions from
04:25:19.859 the user they are associate could be for
04:25:22.439 a real user or a machine user when you
04:25:24.779 do terraform login this is what you're
04:25:26.640 getting a a um a user API token okay
04:25:31.319 foreign
04:25:34.640 [Music]
04:25:35.939 so I just wanted to quickly show you
04:25:37.739 this axis levels chart that helps you
04:25:40.080 understand uh what kind of permissions
04:25:42.060 you were giving at the access level and
04:25:44.220 notice there's implicit and then
04:25:45.659 required or explicit permissions I'm
04:25:47.580 assuming that this means that you need
04:25:49.140 to assign those permissions to the user
04:25:50.819 first before they'd have it so just
04:25:52.500 because you have a user token doesn't
04:25:53.819 mean you get all of these orange
04:25:55.760 diamonds it's just the ones that you've
04:25:57.779 assigned to that user or team where I
04:26:00.180 believe that the organization you're
04:26:01.979 going to run into a chance where you're
04:26:03.479 going to have all these permissions by
04:26:05.580 default whether you want them or not so
04:26:07.620 just understand uh that you have to
04:26:10.620 double check this before you use your
04:26:12.060 tokens and that this chart exists okay
04:26:14.660 [Music]
04:26:19.020 all right so we covered private registry
04:26:20.880 earlier in the course when we were
04:26:22.260 looking at the terraform registry the
04:26:23.760 public one but let's cover it again with
04:26:25.260 a little bit different information so
04:26:26.819 terraform Cloud allows you to publish
04:26:28.439 private modules for your organization
04:26:29.880 within terraform Cloud private registry
04:26:32.100 and tour from Cloud's private module
04:26:34.319 registry helps you share terraform
04:26:35.819 modules across your organization include
04:26:38.220 support for module versioning a
04:26:39.779 searchable filterable list of available
04:26:41.399 modules a configuration designer which I
04:26:44.580 didn't find this thing but it sounds
04:26:45.899 really cool all users in your
04:26:47.939 organization can view your private
04:26:50.220 module registry authentic for
04:26:52.380 authentication you can either use a user
04:26:54.479 token or a team token so I guess this
04:26:56.399 would be the case where you might want
04:26:57.540 to use a team token for authentication
04:26:59.040 but the type of token you choose May
04:27:00.960 Grant different permissions as we saw
04:27:02.819 with the access levels just the slide
04:27:05.220 prior using terraform login will obtain
04:27:07.380 a user token just a reminder and to use
04:27:10.260 a team token you'll need to manually set
04:27:12.120 it in your terraform configuration CLI
04:27:14.460 file okay
04:27:15.750 [Music]
04:27:20.220 so there's a feature within terraform
04:27:21.720 Cloud that can do cost estimation and it
04:27:24.540 is a feature that will give you a
04:27:25.920 monthly cost of resources displayed
04:27:27.479 alongside your runs this feature is only
04:27:29.939 available starting at the teams and
04:27:31.500 governance plan and above but the idea
04:27:33.779 is that it will tell you for specific
04:27:35.939 resources and give you a summary so
04:27:37.680 notice here that we have some pricing
04:27:39.720 I'm going to get my pen tool out but we
04:27:41.580 have the overall cost and then it's
04:27:43.199 broken down per resource and so you can
04:27:45.540 see we have an hourly monthly and
04:27:47.100 monthly Delta
04:27:49.080 I don't know what the monthly Delta is
04:27:50.819 but um you know it gives you kind of
04:27:52.620 idea of cost you can use sentinel
04:27:54.659 policies to assert the expectation that
04:27:56.279 the resources are under a particular
04:27:57.899 cost so that's just kind of a bonus
04:27:59.699 there where you're like okay I want to
04:28:01.080 assure my spend is this the only
04:28:02.699 downside at least at the time right now
04:28:04.859 for cost estimation is the amount of
04:28:07.319 support it has so we have AWS Azure and
04:28:09.180 gcp so these are the resources that it
04:28:11.880 will support and so you have to look
04:28:13.020 through here and say okay you know is
04:28:15.600 there any resources I'm using outside of
04:28:17.220 this that I really care about
04:28:19.140 um and that so I think that if you're
04:28:20.819 using like core services so like ec2
04:28:23.040 instances load balancers things like
04:28:26.340 that that should help you out so like we
04:28:28.319 see AWS instance the load balancer the
04:28:30.540 volume some cloudwatch logs ALB for
04:28:34.739 Google it's just disk instance and
04:28:36.300 database so yeah it's just really
04:28:38.220 dependent on you know what's here so you
04:28:40.859 know it may meet your needs or you might
04:28:42.960 say okay this is not enough okay
04:28:44.990 [Music]
04:28:49.380 here's just a few options that I think
04:28:51.540 are worth noting within the terraform
04:28:53.220 Cloud workflows we have a whole section
04:28:55.560 of workflows but I decided to put it
04:28:57.060 over here just because let's talk about
04:28:58.920 it one thing you can do within terraform
04:29:00.420 cloud is set whatever version you want
04:29:02.760 so you can go as far back as you want uh
04:29:04.920 and this is great if you need to mix and
04:29:06.899 match different workspaces because you
04:29:09.120 have different stacks and they were
04:29:10.199 built on different terraform versions
04:29:11.460 and you're just not ready to upgrade
04:29:13.020 them yet you can choose to share State
04:29:15.359 globally across your organization for a
04:29:17.939 particular workspace this could be
04:29:19.020 really useful if you need to reference
04:29:20.640 things wherever you can choose to Auto
04:29:22.979 approve run so if you don't want to
04:29:24.720 always do that manual approve you can do
04:29:27.120 that this is great if you are looking
04:29:28.439 for that kind of agile kind of workflow
04:29:31.199 where if something is merged then it
04:29:33.899 should be rolled out okay
04:29:35.460 please
04:29:39.300 let's talk about if we had to migrate
04:29:41.340 our local state and we're using just the
04:29:43.140 default one two terraform Cloud how
04:29:44.760 would we do it so to migrate terraform
04:29:46.319 projects it only uses the default
04:29:47.760 workspace here from cloud it's pretty
04:29:49.500 easy you're going to create a workspace
04:29:50.760 and terraform Cloud you're going to
04:29:52.140 replace your terraform configuration
04:29:53.399 with the remote backend so if you have
04:29:55.620 nothing it's using local and you just
04:29:57.180 put in your remote State and then once
04:29:59.760 you have that in there you do a
04:30:01.500 terraform and knit and it's going to say
04:30:03.000 hey do you want to copy the existing
04:30:04.260 state you're going to type yes and once
04:30:05.939 you've done that I believe you have to
04:30:07.260 delete your old State file if you are
04:30:09.899 migrating multiple
04:30:12.239 um
04:30:12.859 multiple environments or you're moving
04:30:15.540 from a standard remote back end it's a
04:30:17.460 little bit more complicated they
04:30:18.659 definitely have guides in the docs but
04:30:20.159 this is the pretty much standard one
04:30:22.140 that you're going to come across when
04:30:23.279 you're working very early and we'll
04:30:24.720 definitely see this as we are using
04:30:27.319 terraform in our follow alongs okay
04:30:30.659 foreign
04:30:33.779 I want to talk about what kind of
04:30:35.279 Integrations we have for terraform for
04:30:37.199 Version Control Systems so we have
04:30:39.359 GitHub GitHub auth GitHub Enterprise get
04:30:41.939 lab gitlab EEG and CE I assume that's
04:30:44.939 Enterprise Edition and Community Edition
04:30:46.500 bucket Cloud bitbucket Server and data
04:30:49.080 center Azure devops service Azure devops
04:30:52.080 server so it's very simple you're just
04:30:53.699 going to choose from the one of the four
04:30:55.319 right and then you're gonna just drop
04:30:57.120 down and choose what variant it is there
04:30:58.979 and connect your repo every single
04:31:02.180 provider has different configuration
04:31:04.080 settings so you might have to meet those
04:31:05.699 depending on what they are you can get
04:31:07.920 from private repos you might have to add
04:31:09.659 your SSH key or something like that okay
04:31:12.280 [Music]
04:31:16.920 let's talk about terraform Cloud run
04:31:18.600 environment so when terraform Cloud
04:31:20.399 executes your terraform plan it runs
04:31:22.500 them in its own run environment so what
04:31:25.080 is a run environment a run environment
04:31:26.520 is a virtual machine or container
04:31:27.779 intended for the execution of code for a
04:31:29.819 specific runtime environment a run
04:31:31.439 environment is essentially a code build
04:31:32.880 server so the terraform Cloud run
04:31:34.680 environment is a single-use Linux
04:31:36.180 machine running on the x86 or x64
04:31:39.120 architecture and the details of its
04:31:41.040 internal simple petition is not known it
04:31:43.380 is possible to install software on it
04:31:45.659 but the only issue is that we don't know
04:31:47.040 what it is is a Debian is it Ubuntu you
04:31:48.899 just can't tell terraform Cloud will
04:31:50.880 inject the following environment
04:31:52.020 variables automatically on each runtime
04:31:53.760 so we have TFC run ID this is a unique
04:31:56.819 identifier for the current run the
04:31:59.340 workspace name the workspace slug so
04:32:02.399 this is the organization followed by the
04:32:04.199 workspace just going to get my pen tool
04:32:06.239 to just kind of point out over here on
04:32:07.859 the right hand side we have the
04:32:09.960 configuration version and git Branch so
04:32:11.880 you know if it is going to be on Main
04:32:13.979 it's going to tell us that if it's going
04:32:15.779 to be a particular version we'll know
04:32:16.800 that as well we can get the shaw of the
04:32:19.080 current commit there's that version and
04:32:21.600 if you want to access these variables
04:32:23.040 you just Define variable and the name
04:32:24.779 and then you can access it throughout
04:32:26.939 the code okay
04:32:28.250 [Music]
04:32:32.340 let's take a look here at terraform
04:32:33.840 Cloud agents this is a paid feature of
04:32:35.760 the business plan to allow terraform
04:32:37.260 Cloud to communicate with isolated
04:32:38.880 private or on-premise infrastructure
04:32:40.620 it's kind of like an in-between uh
04:32:42.720 between a terraform cloud and terraform
04:32:44.340 Enterprise where you want to use
04:32:45.479 terraform Cloud but you have uh
04:32:47.520 on-premise infrastructure but you're not
04:32:48.960 ready to move to terraform Enterprise so
04:32:51.359 this is useful for on-premise
04:32:52.620 infrastructure types such as vsphere
04:32:54.500 nutanix and openstack the agent
04:32:57.659 architecture is pole based so there are
04:32:59.640 no inbound connectivities required any
04:33:01.979 agent you provision will pull terraform
04:33:03.659 Cloud for work and Carry Out execution
04:33:05.400 of that work locally agents currently
04:33:07.680 only support the x86 architecture or the
04:33:10.160 x64-bit Linux operating system okay so
04:33:13.740 you can also run the agent within Docker
04:33:16.980 using the official terraform agent
04:33:18.958 Docker container if you just prefer that
04:33:20.520 over a VM agent supports terraform
04:33:22.680 version 0.12 and above the system
04:33:26.219 requires
04:33:27.438 request the system requires I'm going to
04:33:30.660 change that in the slide later on but
04:33:32.938 the system requires at least four
04:33:35.039 gigabytes of free to space for temporary
04:33:37.859 temporary local copies and two gigabytes
04:33:40.320 of memory needs access to make outbound
04:33:43.020 requests so you need to have open port
04:33:45.840 443 for app terraform i o registry
04:33:49.320 terraform i o releases hashicorp.com and
04:33:53.039 um
04:33:54.500 archivist.terra for my IO so there you
04:33:56.699 go
04:33:56.910 [Music]
04:34:01.379 this is Andrew Brown from exam Pro and
04:34:02.879 we are on to our terraform Cloud uh
04:34:04.680 follow alongs now we already did
04:34:05.820 terraform Cloud uh Version Control
04:34:07.618 System earlier than I thought we were
04:34:09.061 going to do so I'm going to remove from
04:34:10.080 the list and what we'll do is focus on
04:34:11.879 permissions and maybe the API tokens and
04:34:14.699 things like that so what I want you to
04:34:16.080 do and I've got some old tabs open here
04:34:17.879 but I'm going to make my way over to uh
04:34:20.699 terraform.io
04:34:22.500 and I'm going to go log into terraform
04:34:24.240 Cloud here
04:34:25.438 and I don't think I've ever done this
04:34:27.180 but I can upgrade to the trial count
04:34:29.099 because the thing is is that when we are
04:34:30.840 in our account here and we're trying to
04:34:32.641 look at permissions and we're not using
04:34:35.039 Force unlocking anymore I might just
04:34:37.020 keep that around for a little bit but if
04:34:38.820 we were to go to our user settings here
04:34:41.458 we go to organizations
04:34:45.180 um that might not be a very good example
04:34:47.938 like I said I wanted like the
04:34:49.141 organization settings here
04:34:52.320 which would be
04:34:55.379 maybe here yep up here and so you know
04:34:58.199 when we go to our teams and our users
04:35:00.299 our users everyone's being added as an
04:35:02.219 owner we don't have like granular
04:35:03.480 permissions and that's because we'd have
04:35:05.520 to upgrade and so I figured this would
04:35:08.099 be a good opportunity for me to just
04:35:09.299 kind of upgrade to show you those uh
04:35:11.219 more detailed uh role-based Access
04:35:12.778 Control permissions just so you know
04:35:15.000 where they are so I'm gonna go the
04:35:16.680 upgrade now and notice that we're on the
04:35:18.480 free plan and also take note because
04:35:20.660 later on the course I talk about pricing
04:35:22.980 or we've already already acrossed it but
04:35:25.080 notice that we have a team plan and a
04:35:26.820 team and governance plan this one's at
04:35:28.259 twenty dollars and this one's at seventy
04:35:30.000 dollars so you know this is not
04:35:32.160 something that's reflected at least not
04:35:33.719 right now on the terraform website and
04:35:36.660 so it just looks like there's a team in
04:35:37.919 governance plans for twenty dollars in
04:35:39.240 this middle one's missing the key
04:35:41.340 difference here is this one has Sentinel
04:35:42.660 policies code but you can see on the
04:35:44.278 free plan we are able to do
04:35:46.259 team-based stuff
04:35:48.000 let's go switch over to the trial plan
04:35:49.799 I'm going to see if I can do this
04:35:51.240 without entering a credit card in so
04:35:53.340 here it says you're currently on trial
04:35:54.840 planned I didn't have to enter anything
04:35:56.278 in that's really great and so that means
04:35:58.500 now I have all these Team Management
04:35:59.699 options so if I go over to team
04:36:01.500 management
04:36:02.660 I can actually go ahead and create some
04:36:04.799 teams
04:36:06.180 uh so I'll just say like Developers
04:36:10.500 okay
04:36:12.299 and so now I have all these options so
04:36:14.278 we can say this person if someone's in
04:36:16.500 this team they're allowed to manage
04:36:17.400 policies they're able to do that
04:36:19.799 a visible team can be seen by every
04:36:22.500 member or you can keep them secret we
04:36:24.419 can generate team API tokens which I
04:36:27.900 guess we could just like cover this as
04:36:28.980 we do it but notice we can go here and
04:36:31.080 that generates out that token that we
04:36:32.641 can use I'm going to go ahead and delete
04:36:33.840 that token
04:36:36.660 um so nothing super exciting there you
04:36:38.759 know it's not like that complicated
04:36:40.618 if we want to set things on the
04:36:43.259 workplace now if we go back to workplace
04:36:46.080 or workspaces here
04:36:47.938 and now we have Team access
04:36:50.340 and notice I can go to add team uh
04:36:52.799 permissions here
04:36:54.419 and we can say select this team for
04:36:56.160 their permissions
04:36:57.419 and so these are these uh pre-built ones
04:36:59.879 in
04:37:00.719 um
04:37:01.799 so we have read plan rights so these are
04:37:04.199 those three predefined ones that we
04:37:06.299 talked about previously and then we have
04:37:07.980 down here like assign permissions for
04:37:09.660 the admin of a workspace
04:37:11.759 we are able to set customized
04:37:13.438 permissions so if we toggle this
04:37:16.259 um we should be able to do it I mean
04:37:17.820 this looks like it's the same thing no I
04:37:19.980 guess it's more granular so here I guess
04:37:21.539 we have our granular permissions that we
04:37:23.580 can set so for runs we can do read plan
04:37:25.320 or reply
04:37:26.759 Locker unlock a workspace
04:37:30.061 send a locks things like that
04:37:33.118 it's not super complicated
04:37:35.458 if we want drain out API tokens for
04:37:38.820 uh well there's the organizational one
04:37:41.160 there's the teams one and then there's
04:37:42.958 the user one so
04:37:44.879 if we go to the organization
04:37:49.799 we can see that we can generate out one
04:37:51.419 here so I can say create an API token so
04:37:53.340 there it is let's go ahead and delete
04:37:54.599 that
04:37:55.799 and if we go back to our teams
04:38:01.680 we did this earlier but we can generate
04:38:03.719 one here
04:38:06.061 and then if you want to generate one for
04:38:07.618 your users probably under user settings
04:38:09.958 yeah so we generate tokens there as well
04:38:12.299 okay
04:38:15.778 so I mean again there's not a lot to
04:38:18.240 talk about here but um yeah so I guess
04:38:20.759 that really covers permissions and API
04:38:22.199 tokens okay okay so that finished
04:38:24.240 deploying there and so we can see our
04:38:26.099 resources have been created but one
04:38:27.660 thing that we didn't set was the prefix
04:38:30.359 I'm actually interested to see that that
04:38:32.641 worked properly but what I could do is
04:38:35.039 say prefix
04:38:38.458 and then do an underscore here and I
04:38:40.379 don't know how that would affect it
04:38:47.278 and this actually happened over in this
04:38:49.680 repository here I'm actually using a
04:38:51.480 hyphen so I'm going to just change that
04:38:52.859 to that
04:39:03.599 might have to do a terraform edit there
04:39:05.160 migrate the state
04:39:13.618 so that was a complete mistake on my
04:39:15.359 part but I guess my thought was that I
04:39:17.160 thought I had to have
04:39:19.740 um this is still on Main and I guess
04:39:21.000 we'd never really set up a production
04:39:22.020 Branch but yeah so now when we have the
04:39:24.180 prefix in it's actually going to prompt
04:39:25.561 us for the other one so the currently
04:39:26.879 selected workspaces are default does not
04:39:29.278 exist and so Dev is showing up and
04:39:31.199 notice that we can't deploy to main so I
04:39:33.778 think the thing is is that if we wanted
04:39:35.219 a production one we would just create
04:39:36.660 that workspace and then it would reflect
04:39:38.458 here so the way you make uh multiple
04:39:41.520 workspaces here would actually have to
04:39:43.260 make them all so we'd have to make a VCS
04:39:44.940 terraform prod and I'm very certain that
04:39:47.160 it would just show up here and then you
04:39:48.420 would select the number that you'd want
04:39:50.480 though what's interesting is the fact
04:39:52.560 that we are in the dev branch and we
04:39:54.060 have to say oh I want to deploy the dev
04:39:56.520 one so that's kind of a little bit of a
04:39:59.040 caveat there but I guess there's not
04:40:00.718 really any way around it but I mean this
04:40:02.100 pretty much
04:40:03.060 you know explores what we need for
04:40:05.878 multiple workspaces with terraform cloud
04:40:07.798 and we did the remote ones and we're all
04:40:10.560 good so there we go I guess the last
04:40:12.298 thing here we should probably do is just
04:40:13.860 clean up so if we go to terraform Dev
04:40:15.660 here we're going to go down to
04:40:18.120 destruction and we'll run a destroy plan
04:40:22.080 here
04:40:25.320 okay
04:40:28.080 and once this is all done you know you
04:40:29.878 can go ahead and just delete these
04:40:32.580 repositories
04:40:34.740 and notice this one is it has a private
04:40:36.958 lock on it so oh because it's actually
04:40:38.520 running right now so it's being locked
04:40:40.320 so yep there we go so that's it
04:40:42.970 [Music]
04:40:47.458 all right now let's take a look at the
04:40:48.958 terraform registry the private registry
04:40:50.700 so just go over here and click on
04:40:52.080 registry at the top and we can bring in
04:40:54.180 public
04:40:55.200 um
04:40:56.040 public things here so I can just go here
04:40:57.718 and type this in and we can hit add
04:41:00.780 and so now
04:41:02.878 um we just hit add to terraform cloud
04:41:05.820 add to my organization and that's public
04:41:08.280 facing but we could also add private
04:41:10.200 facing modules
04:41:11.820 so if we go back to our registry here
04:41:14.760 just going to go ahead and uh
04:41:19.260 down to publish here
04:41:21.120 and we go to GitHub
04:41:23.218 and I guess custom
04:41:25.920 and so then I suppose we just have to
04:41:27.480 enter all the stuff in here so as an
04:41:29.100 optional display name for your V Version
04:41:31.920 Control provider
04:41:33.958 client IDs client secrets
04:41:38.520 so it seems like there's a lot of work
04:41:40.200 to do we'd have to set up the SSH key
04:41:41.820 pair but I mean that's generally the
04:41:43.920 details that you need to know for that
04:41:45.180 okay
04:41:46.320 just seems like a lot of work for us to
04:41:48.180 set that up
04:41:49.218 you know and the course is going to be
04:41:51.120 like hey can you add a private module
04:41:52.560 and be like yes okay
04:41:54.240 so we'll go ahead and just remove this
04:41:56.340 so you can add both public and private
04:41:58.200 modules
04:42:00.000 um you know so there you go
04:42:01.580 [Music]
04:42:05.878 I have mentioned terraform Enterprise so
04:42:07.980 many times in this course but we've
04:42:09.718 never really talked about in detail and
04:42:11.160 now is our opportunity to do so so
04:42:13.440 terraform Enterprise is the self-hosted
04:42:15.660 distribution of terraform platform and I
04:42:17.878 just want to point out sometimes I call
04:42:19.980 the terraform platform terraform Cloud
04:42:21.600 just because that's the more prominent
04:42:23.280 uh version of it but terraform cloud is
04:42:25.740 a separate product from terraform
04:42:28.138 Enterprise it's just one is uh assassin
04:42:31.680 the other one is self-hosted so
04:42:33.600 terraform Enterprise offers a private
04:42:35.520 instance of the terraform platform
04:42:36.840 application with the benefits such as no
04:42:38.940 resource limits with additional
04:42:40.620 enterprise-grade architectural features
04:42:42.180 such as audit logging so you do you'd
04:42:44.340 have tamper evidence saml single sign-on
04:42:46.798 and I'm sure there's a lot more other
04:42:48.780 options there so let's just kind of look
04:42:50.580 at the architecture really quickly on
04:42:52.080 how this works so the first thing is you
04:42:53.520 have the terraform platform which is
04:42:55.080 going to be installed on a machine and
04:42:57.298 in particular this is installed on Linux
04:42:59.458 and it's specifically installed on
04:43:02.520 Debian okay so I believe that is the
04:43:04.620 Debian logo as far as as I remember if
04:43:06.900 it's not we'll find it on the next slide
04:43:08.160 if I'm wrong okay you're going to have
04:43:10.378 to have some kind of storage and there's
04:43:12.120 a few different options probably the
04:43:14.400 most common is going to be on something
04:43:16.680 like S3 but you can store it on the
04:43:19.080 storage or on the disk itself you have
04:43:22.080 to have a postgres database so that's
04:43:24.360 part of the infrastructure because that
04:43:26.100 is what the platform uses and you'll
04:43:29.340 also have to have your own TLS
04:43:31.080 certificate to access the machine
04:43:34.138 but there are also cases where you know
04:43:36.180 these are going through air gapped
04:43:37.200 environments but the idea is that you
04:43:38.400 have SSL or TLS it's like end-to-end
04:43:41.638 encryption it goes all the way to the
04:43:42.900 machine that's where it terminates okay
04:43:44.540 you'll also need your terraform license
04:43:46.740 so you'll have to plug that in once you
04:43:48.718 start up the terraform platform say hey
04:43:50.638 tell us the code so you can unlock this
04:43:53.458 um this software for you to use on this
04:43:55.798 dedicated machine okay
04:43:58.500 foreign
04:44:00.580 [Music]
04:44:02.218 so the requirements for terraform
04:44:03.958 Enterprises is going to highly vary
04:44:05.458 based on your operational mode that you
04:44:07.260 choose to run it in and that is really
04:44:08.638 dependent on how data should be stored
04:44:10.920 and when we're looking at the uh the
04:44:13.378 architectural diagram that was uh the
04:44:15.780 operational mode of external Services
04:44:17.458 there's three types of operational nodes
04:44:19.378 the first being external Services that's
04:44:21.360 when you use postgres and then use cloud
04:44:24.900 storage so in that example we're using
04:44:26.458 S3 but you can use gcp Azure blob
04:44:28.798 storage or Mino object storage but the
04:44:31.560 idea is that postgres and the cloud
04:44:33.240 storage are external they're not part of
04:44:34.798 that Linux server okay then you have a
04:44:37.440 mounted disk so this would just be
04:44:39.360 having a a persisted disk attached to
04:44:42.840 the VM so you know in the best case it's
04:44:46.020 called EBS so this stores data in a
04:44:48.360 separate directory on the host intended
04:44:50.280 for external disk so that would be both
04:44:52.020 the postgres database and the storage
04:44:53.940 volume itself you know postgres is still
04:44:56.280 a requirement and no matter what mode
04:44:58.260 you use then you have demo so stores all
04:45:00.900 data on the instance data can be backed
04:45:03.000 up with snapshots not recommended for
04:45:04.440 production use so this is where you have
04:45:07.020 ethereal data so you know the data you
04:45:09.660 know can vanish if you restart the
04:45:11.160 machine unless you make physical
04:45:12.420 snapshots
04:45:14.160 another component is credentials ensure
04:45:16.440 you have credentials to use Enterprise
04:45:18.138 and have a secure connection so the
04:45:21.240 first is we need the terraform
04:45:22.260 Enterprise license so you obtain that
04:45:23.878 from hashicorp and the other part is
04:45:25.740 having a TLS certificate and private key
04:45:27.480 so you need to prove uh you're the uh
04:45:30.180 you own uh your own TLS certificate okay
04:45:34.260 then we have the Linux instance so
04:45:35.878 terraform Enterprises designed to run on
04:45:38.280 Linux and it supports more than one
04:45:40.680 version so you know I said it was only
04:45:42.298 Debian but I guess there's a bunch I
04:45:44.040 just forgot so we have Debian Ubuntu Red
04:45:46.798 Hat Centos Amazon Linux there's a
04:45:50.340 variety for those Oracle Linux so yeah I
04:45:54.120 guess I just a big fan of Debian so
04:45:55.620 that's I guess that was my my thinking
04:45:57.420 there for Hardware requirements we have
04:45:59.520 at least 10 gigabytes of disk space on
04:46:01.740 the root volume at least 40 gigabytes of
04:46:04.138 disk space for the docker data directory
04:46:06.240 so that would be the VAR lib Docker at
04:46:09.780 least eight gigabytes of the system
04:46:11.218 memory and at least four CPU cores so
04:46:15.840 there you go
04:46:17.100 foreign
04:46:21.480 let's talk about error gapped
04:46:23.160 environments so what is an air gap an
04:46:24.900 air gap or disconnected network is a
04:46:26.878 network security measure employed on one
04:46:29.218 or more computers to ensure that a
04:46:30.718 secure computer network is physically
04:46:32.340 isolated from unsecure networks so the
04:46:34.440 public internet so it's no internet no
04:46:37.680 outside connectivity Industries in the
04:46:39.780 public sector so government military or
04:46:41.638 large Enterprises finance and energy
04:46:43.080 often employ air gap networks and so I
04:46:45.840 want you to know that hashicorp
04:46:47.400 terraform Enterprise supports an
04:46:48.718 installation type of air gap
04:46:50.040 environments okay so to install or
04:46:52.798 update terraform Enterprise you will
04:46:54.298 supply an air gap bundle which is an
04:46:56.458 archive of a terraform Enterprise
04:46:57.600 release version so that's how you would
04:47:00.120 um you know provided okay
04:47:01.850 [Music]
04:47:06.060 so let's take a look at terraform Cloud
04:47:07.740 features and pricing so I just want to
04:47:10.740 quickly go through it here so we have
04:47:12.900 three models we have the open source
04:47:14.700 software so OSS we have the cloud
04:47:17.040 offerings and the self-hosted offerings
04:47:18.840 I know these tiers we have free teams
04:47:21.718 and governance technically it's teams
04:47:24.540 and then teams and governance so they're
04:47:27.420 two separate plans but this is the way
04:47:29.040 they display it in their marketing
04:47:30.840 content but it really is a separate two
04:47:32.458 separate tiers in there you have
04:47:34.138 business and then Enterprise which is
04:47:35.878 considered self-hosted so in terms of
04:47:37.740 feature set
04:47:38.940 across the board you have IAC
04:47:41.718 workspaces variables runs resource
04:47:45.298 graphs providers modules the public
04:47:47.218 module registry which is terraform
04:47:48.900 registry workspace is a bit odd because
04:47:51.180 there are terraform Cloud workspaces
04:47:53.520 right
04:47:54.540 and then you have local workspaces so
04:47:57.360 technically those should be broken up
04:47:58.680 into two separate things or named
04:48:01.560 differently but that's just how it is
04:48:03.060 with terraform so you know just asterisk
04:48:05.400 on that workspaces there for the free
04:48:07.798 tier you get remote state or sorry for
04:48:10.200 everything outside of the open source
04:48:12.000 you get remote State vs VSC connection
04:48:14.458 so that's Version Control State
04:48:16.740 connection so connecting to GitHub or or
04:48:19.798 git lab or whatever workspace management
04:48:21.780 secure variable storage remote runs
04:48:24.000 private module registry once we get into
04:48:27.360 Cloud we get Team Management Sentinel
04:48:29.520 policy as code management cost
04:48:30.900 estimation the reason why I have that in
04:48:32.760 Red is because on the exam it could ask
04:48:34.798 you when is Sentinel policy available is
04:48:37.320 it available at what level and the thing
04:48:39.840 is it goes from teams and governments
04:48:42.180 all the way to the Enterprise level now
04:48:44.820 technically there is again one called
04:48:47.458 teams and there's teams and governance
04:48:49.200 so it's part of teams and governance not
04:48:50.638 part of teams okay
04:48:53.400 uh once we get into business this is
04:48:55.080 where we start to get single sign-on and
04:48:56.878 audit logging so you know if you need it
04:48:59.100 in the cloud or if you need it
04:49:00.620 self-hosted both options are available
04:49:03.680 in the business we have the you can have
04:49:06.600 the self-hosted agents for configuration
04:49:09.180 designer servicenow integration you have
04:49:11.040 it for those uh as well in terms of how
04:49:15.060 many runs you can have this is very
04:49:17.218 important because this is how many this
04:49:19.080 is going to put a bottleneck in terms of
04:49:20.820 your infrastructure rights on the free
04:49:22.260 Terry you can have one current run of a
04:49:25.260 workspace and teams you could have two
04:49:28.020 and then at the business level and
04:49:29.878 Beyond its unlimited current runs for uh
04:49:33.600 how you would actually interact with um
04:49:36.360 terraform you know this is going to be
04:49:37.980 through the local CLI for the open
04:49:39.540 source software for these it's Cloud
04:49:42.120 meaning that
04:49:43.798 um it's Cloud that is triggering the
04:49:46.378 execution commands and then self-hosted
04:49:48.600 it's not in the cloud it's on that
04:49:49.860 private machine okay
04:49:51.840 uh then we have support So for support
04:49:54.958 it's all community so that's just going
04:49:57.540 reaching out to DA's maybe there's a
04:49:59.638 slack Channel I believe that they have a
04:50:02.040 form so they have like a form where you
04:50:04.798 can ask questions and then they have
04:50:06.120 these layers like bronze silver and gold
04:50:08.360 I could not determine what these are
04:50:11.700 like what is offered in them and the odd
04:50:14.700 thing is is that you know there's a
04:50:16.080 silver and gold but it's offered both at
04:50:17.580 business and Enterprise so I don't know
04:50:19.440 if like you can upgrade to from silver
04:50:21.060 to gold so it's optional or you always
04:50:23.160 get silver and gold could not get
04:50:25.138 clarification I tried asking the sales
04:50:26.760 team no one would tell me so I think you
04:50:28.980 have to really be deep in that sales
04:50:30.780 funnel to find out in terms of pricing
04:50:33.480 it's zero to up to five users so the
04:50:36.600 thing is and this is really confusing
04:50:38.820 about terraform cloud and they really
04:50:40.620 shouldn't have called it teams up here
04:50:42.000 but you can start using terraform Cloud
04:50:44.940 for free up to five users as a team okay
04:50:48.660 so just negate the fact that it's not
04:50:50.458 called teams what they're saying is that
04:50:52.620 teams is really about getting a
04:50:56.638 base workspace Remote Manager which is
04:50:58.980 actually our RBA like
04:51:01.160 our ABC controls
04:51:03.718 uh role-based access controls so that's
04:51:06.120 the whole point of using teams so if you
04:51:08.340 need that and that's when you're at five
04:51:09.660 that's going to use it but you can use
04:51:11.400 it in the free tier as a team and you it
04:51:13.798 absolutely should once you get to the
04:51:16.440 teams plan it's going to be twenty
04:51:17.878 dollars a month and then if you need
04:51:19.560 teams and governance it's actually like
04:51:21.360 seven dollars a month so again it's kind
04:51:23.700 of like a bit misleading how they've
04:51:25.440 labeled this out but if you go and open
04:51:27.120 up teams Cloud you can see what the
04:51:29.700 actual packages are
04:51:31.260 for uh business that self-hosted your
04:51:34.500 contact and sales so I have no idea what
04:51:36.060 the cost is there so there you go
04:51:38.160 [Music]
04:51:42.298 all right we're taking a look here at
04:51:43.680 workspaces so workspaces allow you to
04:51:45.900 manage multiple environments or
04:51:47.280 alternate State files such as
04:51:48.780 development reproduction and there are
04:51:50.760 two variants of the workspace we have
04:51:52.320 CLI workspaces a way of managing
04:51:54.840 alternate State files locally or via
04:51:56.638 remote back-ends and then we have
04:51:58.260 terraform Cloud workspaces that act like
04:52:01.138 completely separate working directories
04:52:02.940 I'm going to tell you these two are
04:52:04.798 confusing because they don't exactly
04:52:06.480 work the same way but they have the same
04:52:08.280 name and originally workspaces were
04:52:10.560 called environments and so you know when
04:52:12.180 you're using terraform Cloud it makes a
04:52:13.620 lot of sense to call them environments
04:52:14.940 and the CLI workspace it's just a little
04:52:17.160 bit different so you know I'm not sure
04:52:19.020 if I'm going to do a great job
04:52:20.040 explaining the difference of these
04:52:21.298 things you really have to go through the
04:52:22.620 motion of it to really get the hang of
04:52:24.718 it but I'll do the best I can here okay
04:52:26.700 so think of workspaces as being similar
04:52:29.040 to having different branches in a git
04:52:30.600 repo workspaces are technically the
04:52:32.638 equivalent to renaming your state file
04:52:35.160 okay so in terraform 0.9 they used to be
04:52:38.280 workspaces used to be called
04:52:39.600 environments but people got confused
04:52:41.400 which I have no video why but you know
04:52:44.340 that's what it is now so by default you
04:52:47.040 already have a single workspace in your
04:52:48.840 local backend called default and the
04:52:51.298 default workspace can never be deleted
04:52:53.458 so even if you don't think you're using
04:52:55.020 workspaces you absolutely are even the
04:52:57.180 first time you use terraform at least in
04:52:59.160 the CLI workspace okay
04:53:01.320 [Music]
04:53:05.280 let's get a little bit into the
04:53:07.020 internals this isn't really that much
04:53:08.638 detail but depending if you are on a
04:53:11.820 local or remote back end changes how the
04:53:13.740 state file is stored so if you're on a
04:53:15.360 local state or a remote State it's going
04:53:17.280 to be different so uh terraform stores
04:53:19.500 the the workspace States in a folder
04:53:21.600 called
04:53:23.420 terraform.tfstate.d on the road State
04:53:25.920 the workspace file are stored directly
04:53:28.080 in the configured backend in practice
04:53:31.138 individuals or very small teams will
04:53:33.000 have been have known to commit these
04:53:35.160 files to the repos but using a remote
04:53:37.620 backend instead is recommended when
04:53:39.840 there are multiple collaborators so I
04:53:41.638 guess there's not really much to say
04:53:42.600 here but just understand that when you
04:53:45.120 have a local state file it's going to be
04:53:46.620 in that terraform TF State D and then
04:53:48.900 when it's remote State you don't have to
04:53:50.100 worry about it okay
04:53:51.520 [Music]
04:53:55.620 let's talk about interpolation with
04:53:58.200 current workspaces so you can reference
04:54:00.180 the current workspace name via the
04:54:02.480 terraform.workspace named value so we
04:54:05.580 saw that in the lineup way earlier in
04:54:07.378 the course so the idea here is that if
04:54:09.780 you wanted to
04:54:11.340 um see if the default like let's say you
04:54:14.040 want to say am I in the default
04:54:15.420 workspace then return five as opposed to
04:54:17.340 one because maybe you're very
04:54:20.040 comfortable spinning up more in the
04:54:21.780 default than whether it was something
04:54:23.520 else and just another example maybe you
04:54:26.580 want to use it to apply the name of the
04:54:29.218 workspace as a tag so here that would
04:54:31.440 actually give this virtual machine in
04:54:33.180 AWS the name web hyphen whatever it is
04:54:35.520 production or development so there you
04:54:37.260 go
04:54:39.360 foreign
04:54:42.540 let's talk about multiple workspaces so
04:54:45.060 a terraform configuration has a back end
04:54:47.100 that defines how operations are executed
04:54:49.200 and where persistent data is stored so
04:54:51.480 like the terraform state so multiple
04:54:53.580 workspaces are currently supported by
04:54:55.560 the following backends Azure RM console
04:54:59.240 cos GCS so that's Google Cloud Storage
04:55:02.580 kubernetes local Manta postgres remote
04:55:06.360 S3 they're not going to ask you this on
04:55:08.638 the exam which ones are supported but
04:55:10.020 you know for your own purposes if you
04:55:12.180 want to use multiple workspaces with a a
04:55:15.120 standard back end you probably want to
04:55:16.860 know which ones certain back ends
04:55:18.840 support multiple name workspaces
04:55:20.520 allowing multiple states to be
04:55:21.958 associated with a single configuration
04:55:24.200 that the configuration still has only
04:55:27.060 one back end but multiple distinct
04:55:29.218 instances of the configuration to be
04:55:30.718 deployed without configuring a new back
04:55:32.700 end or changing authentication
04:55:34.080 credentials why would you want to use
04:55:35.940 multiple workspaces for something like a
04:55:38.040 standard
04:55:39.420 um
04:55:40.020 a standard back end well the idea here
04:55:43.320 is that you know if let's say you're
04:55:44.638 using terraform cloud and you've reached
04:55:47.040 your limit of five users and it just
04:55:49.138 gets too expensive to go to the sex user
04:55:51.840 where you have to pay for all of them uh
04:55:54.000 you know then the thing is is that you
04:55:55.860 know this is an option for you it's just
04:55:57.420 kind of like another option out there
04:55:58.680 until you are ready to pay for terraform
04:56:00.420 Cloud at the next tier up so that's the
04:56:02.940 reason why I'm mentioning it here for
04:56:04.320 you okay
04:56:05.250 [Music]
04:56:09.420 all right let's quickly walk through the
04:56:11.100 terraform Cloud workspace and the
04:56:12.600 easiest ways to just show you a
04:56:13.740 screenshots so you create a workspace on
04:56:16.080 terraform Cloud so first you'll create
04:56:17.400 an organization mine's called exam Pro
04:56:19.080 and within that you'll create multiple
04:56:21.718 workspaces from there you'll click into
04:56:23.458 your workspace and you'll see uh like
04:56:26.280 previous run States variable settings
04:56:27.840 we'll click into runs from runs what
04:56:30.540 we'll get is a list of what happened
04:56:32.520 previously we can click into one of
04:56:34.378 those and we can see our plan and our
04:56:37.560 apply we can leave a comment on each run
04:56:40.320 that has happened if we if we just want
04:56:42.600 to expand the plan and apply here for
04:56:44.940 plan we will see all the details of what
04:56:47.340 it would change and then apply is it
04:56:49.920 actually setting up that infrastructure
04:56:51.718 and whether it was successful or not
04:56:53.840 notice you can also download Sentinel
04:56:56.100 unlock files we'll come and talk about
04:56:57.540 that later when we get to our Central
04:56:59.400 section we can also see a history of
04:57:01.980 previously held States so these are
04:57:04.200 snapshots of that infrastructure
04:57:07.020 and so you can click into there and
04:57:08.520 exactly see what it looks like this is
04:57:10.500 useful if you want to go and download it
04:57:12.680 if you were to need it so here's a diff
04:57:16.200 of what changed since the last state
04:57:17.940 okay and of course you can download that
04:57:20.100 stuff so you know hopefully that gives
04:57:21.360 you an idea of what you can do with
04:57:22.620 terraform cloud workspaces
04:57:24.958 foreign
04:57:28.260 [Music]
04:57:29.820 let's talk about terraform Cloud run
04:57:31.920 triggers so terraform Cloud provides a
04:57:34.378 way to connect your workspaces to one or
04:57:36.298 more workspaces via run triggers within
04:57:38.760 your organization known as source
04:57:41.040 workspaces so run triggers allows runs
04:57:44.340 to queue automatically in your workspace
04:57:47.100 on successful apply of runs in any of
04:57:50.040 your source workspaces and you can
04:57:51.660 connect each workspace to up to 20
04:57:54.298 source workspaces so run triggers are
04:57:56.820 designed for workspaces that rely on
04:57:58.500 information or infrastructure produced
04:58:00.000 by other workspaces if a terraform
04:58:02.218 configuration uses data sources to read
04:58:04.920 values that might be changed by another
04:58:06.540 workspace run triggers lets you
04:58:08.458 explicitly specify the external
04:58:10.080 dependencies so the idea is just allow
04:58:12.480 you to say okay I have one workspace I
04:58:15.120 I've triggered that I wanted now to do
04:58:17.160 that so this is really great if you have
04:58:18.780 a bunch of uh of environments or or
04:58:22.980 Stacks that are reliant on each other
04:58:24.480 and you want it to kind of have a chain
04:58:26.700 reaction the reason I'm mentioning run
04:58:28.980 triggers is a I think it's a cool
04:58:30.780 feature and B Because triggers is
04:58:33.958 something that is also uh something else
04:58:36.298 when we're looking at provisioners and I
04:58:38.638 just wanted to just clarify that there's
04:58:40.020 run triggers from terraform cloud and
04:58:42.060 then there's triggers that are for
04:58:44.520 um well I said provisioners I really
04:58:46.560 mean null resources they have triggers
04:58:48.360 in that okay so it's not going to show
04:58:50.520 up an example it's just a good to know
04:58:52.080 feature I just want to make sure there's
04:58:53.458 no confusion with the other triggers
04:58:55.840 [Music]
04:58:59.940 let's take a look at some of the
04:59:01.440 terraform workspace CLI commands that we
04:59:03.298 have available to us the first starting
04:59:04.740 with terraform workspace list so list
04:59:06.480 all the existing workspaces and the
04:59:08.638 current workspace is indicated by an
04:59:10.620 asterisk so that is our current
04:59:12.060 workspace there terraform workspace show
04:59:14.340 show the current workspace so right now
04:59:16.138 we're working in development terraform
04:59:18.000 workspace select switch to a Target
04:59:20.040 workspace so here we could say select
04:59:22.560 default and now we're in the default
04:59:24.180 terraform workspace new so create and
04:59:26.458 switch to a new workspace and then we
04:59:28.798 have terraform workspace delete so
04:59:30.360 delete a Target workspace now
04:59:32.760 understand that this is affecting your
04:59:35.760 local ones for the CLI commands Okay but
04:59:39.540 um yeah so this would actually show up
04:59:41.520 in the exam they might ask you like you
04:59:43.680 know which is Select and what does list
04:59:46.378 do and things like that so make sure you
04:59:48.240 know these commands Okay
04:59:49.550 [Music]
04:59:54.000 all right so I just wanted to contrast
04:59:55.980 against the local or CLI driven
04:59:58.740 workflows via the terraform Cloud
05:00:00.180 workflows because there's this great uh
05:00:02.458 table chart that's from the
05:00:04.160 documentation that I want to show you so
05:00:06.120 to our firm cloud workspaces and local
05:00:08.340 working directories serve the same
05:00:09.780 purposes but they store their data
05:00:12.420 differently so just looking here we'll
05:00:15.120 go down to components here so for
05:00:16.620 terraform configuration it's going to be
05:00:18.120 on disk for local for terraform cloud in
05:00:20.520 linked Version Control repositories or
05:00:22.920 periodically uploaded via the API or CLI
05:00:26.180 we have variable values so this is where
05:00:29.100 we use tfrs and when we're in terraform
05:00:31.260 Cloud it's in the actual workspace the
05:00:33.120 terraform Cloud workspace and so that
05:00:35.160 means that we are setting environment
05:00:36.480 variables to propagate that into our
05:00:38.940 code or inject those variables into our
05:00:40.798 code on execution for State it's on disk
05:00:43.560 or in a remote back end and in the
05:00:46.378 workspace for terraform Cloud it's
05:00:48.120 actually in the workspace credentials
05:00:50.218 and secrets are in Shell environments or
05:00:51.958 our internet prompts and workspace
05:00:53.458 they're stored ascent the variables
05:00:54.780 these are environment variables again so
05:00:56.940 there you go
05:00:57.970 [Music]
05:01:02.040 hey this is Andrew Brown from exam Pro
05:01:03.780 and we are on to our terraform Cloud uh
05:01:05.760 follow alongs now we already did
05:01:06.900 terraform Cloud uh Version Control
05:01:08.760 System earlier than I thought we were
05:01:10.200 going to do so I'm going to remove from
05:01:11.160 the list and what we'll do is focus on
05:01:13.020 permissions and maybe the API tokens and
05:01:15.780 things like that so what I want you to
05:01:17.040 do and I've got some old tabs open here
05:01:18.900 I'm going to make my way over to uh
05:01:21.780 terraform.io
05:01:23.520 and I'm going to go log into terraform
05:01:25.200 Cloud here
05:01:26.458 and I don't think I've ever done this
05:01:28.200 but I can upgrade to the trial account
05:01:30.180 because the thing is is that when we are
05:01:31.920 in our account here and we're trying to
05:01:33.718 look at permissions and we're not using
05:01:36.120 Force unlocking anymore I might just
05:01:38.160 keep that around for a little bit but if
05:01:39.900 we were to go to our user settings here
05:01:42.480 we go to organizations
05:01:46.320 um that might not be a very good example
05:01:49.020 I guess I wanted like the organization
05:01:50.580 settings here
05:01:53.340 which would be
05:01:56.400 maybe here yep up here and so you know
05:01:59.218 when we go to our teams and our users
05:02:01.320 our users everyone's being added as an
05:02:03.240 owner we don't have like granular
05:02:04.500 permissions and that's because we'd have
05:02:06.540 to upgrade and so I figured this would
05:02:09.120 be a good opportunity for me to just
05:02:10.378 kind of upgrade to show you those uh
05:02:12.240 more detailed uh role-based Access
05:02:13.798 Control permissions just so you know
05:02:16.020 where they are so I'm gonna go the
05:02:17.700 upgrade now and notice that we're on the
05:02:19.500 free plan and also take note because
05:02:21.620 later on the course I talk about pricing
05:02:24.000 or we've already already acrossed it but
05:02:26.100 notice that we have a team plan and a
05:02:27.840 team and governance plan this one's at
05:02:29.280 20 and this one's at seventy dollars so
05:02:32.458 you know this is not something that's
05:02:33.540 reflected at least not right now on the
05:02:35.878 terraform website and so it just looks
05:02:38.340 like there's a team in governance plans
05:02:39.480 for twenty dollars in this middle one's
05:02:40.980 missing the key difference here is this
05:02:43.020 one has Sentinel policies code but you
05:02:44.820 can see on the free plan we are able to
05:02:46.320 do
05:02:47.280 team-based stuff
05:02:48.958 let's go switch over to the trial plan
05:02:50.820 I'm going to see if I can do this
05:02:52.260 without entering a credit card in so
05:02:54.360 here it says you're currently on trial
05:02:55.860 planned I didn't have to enter anything
05:02:57.298 in that's really great and so that means
05:02:59.520 now I have all these Team Management
05:03:00.718 options so if I go over to team
05:03:02.520 management
05:03:04.378 um I can actually go ahead and create
05:03:05.520 some teams
05:03:07.260 uh so I'll just say like Developers
05:03:11.580 okay
05:03:13.378 and so now I have all these options so
05:03:15.360 we can say this person if someone's in
05:03:17.580 this team they're allowed to manage
05:03:18.540 policies they're able to do that
05:03:20.878 a visible team can be seen by every
05:03:23.580 member or you can keep them secret we
05:03:25.500 can generate team API tokens which I
05:03:28.980 guess we could just like cover this as
05:03:30.060 we do it but notice we can go here and
05:03:32.160 that generates out that token that we
05:03:33.718 can use I'm going to go ahead and delete
05:03:34.920 that token
05:03:37.680 um so nothing super exciting there you
05:03:39.780 know it's not like that complicated
05:03:41.700 if we want to set things on the
05:03:44.340 workplace now if we go back to workplace
05:03:47.160 or workspaces here
05:03:49.020 and now we have Team access
05:03:51.420 and notice I can go to add team
05:03:53.298 permissions here
05:03:55.440 and we can say select this team for
05:03:57.180 their permissions and so these are these
05:03:59.760 uh pre-built ones in
05:04:01.740 um
05:04:02.878 so we have read plan rights so these are
05:04:05.280 those three predefined ones that we
05:04:07.378 talked about previously and then we have
05:04:09.000 down here like assign permissions for
05:04:10.740 the admin of a workspace
05:04:12.780 we are able to set customized
05:04:14.458 permissions so if we toggle this
05:04:17.280 um we should be able to do it I mean
05:04:18.840 this looks like it's the same thing no I
05:04:21.060 guess it's more granular so here I guess
05:04:22.560 we have our granular permissions that we
05:04:24.600 can set so for runs we can do read plan
05:04:26.340 or reply
05:04:27.840 Locker unlock a workspace
05:04:31.138 send a locks things like that
05:04:34.260 it's not super complicated
05:04:36.540 if you want to drain out API tokens for
05:04:39.840 uh well there's the organizational one
05:04:42.180 there's the teams one and then there's
05:04:43.980 the user one so
05:04:45.900 if we go to the organization
05:04:50.878 we can see that we can generate out one
05:04:52.440 here so I can say create an API token so
05:04:54.360 there it is just go ahead and delete
05:04:55.680 that
05:04:56.820 and if we go back to our teams
05:05:02.760 we did this earlier but we can generate
05:05:04.798 one here
05:05:07.138 and then if you want to generate one for
05:05:08.700 your user it's probably under user
05:05:09.958 settings
05:05:11.040 yeah so we generate tokens there as well
05:05:13.320 okay
05:05:16.798 so I mean again there's not a lot to
05:05:19.260 talk about here but um yeah so I guess
05:05:21.840 that really covers permissions and API
05:05:23.280 tokens okay okay so that finished
05:05:25.320 deploying there and so we can see our
05:05:27.120 resources have been created but one
05:05:28.680 thing that we didn't set was the prefix
05:05:31.440 I'm actually interested to see that that
05:05:33.718 worked properly but what I could do is
05:05:36.120 say prefix
05:05:39.540 and then do an underscore here and I
05:05:41.458 don't know how that would affect it
05:05:48.360 and this actually happened over in this
05:05:50.760 repository here I'm actually using a
05:05:52.560 hyphen so I'm going to just change that
05:05:53.940 to that
05:06:04.620 might have to do a terraform edit there
05:06:06.180 migrate the state
05:06:14.638 so that was a complete mistake on my
05:06:16.378 part but I guess my thought was that I
05:06:18.180 thought I had to have
05:06:20.820 um this is still on Main and I guess
05:06:22.080 we'd never really set up a production
05:06:23.160 Branch but yeah so now when we have the
05:06:25.260 prefix in it's actually going to prompt
05:06:26.638 us for the other one so the currently
05:06:27.900 selected workspaces are default does not
05:06:30.360 exist and so Dev is showing up and
05:06:32.340 notice that we can't deploy to main so I
05:06:34.920 think the thing is is that if we wanted
05:06:36.298 a production one we would just create
05:06:37.740 that workspace and then it would reflect
05:06:39.540 here so the way you make uh multiple
05:06:42.600 workspaces here would actually have to
05:06:44.340 make them all so we'd have to make a VCS
05:06:46.020 terraform prod and I'm very certain that
05:06:48.298 it would just show up here and then you
05:06:49.500 would select the number that you'd want
05:06:51.560 though what's interesting is the fact
05:06:53.638 that we are in the dev branch and we
05:06:55.138 have to say oh I want to deploy the dev
05:06:57.600 one so that's kind of a little bit of a
05:07:00.180 caveat there but I guess there's not
05:07:01.860 really any way around it but I mean
05:07:03.060 that's pretty much you know explores
05:07:05.280 what we need for multiple workspaces
05:07:08.100 with terraform cloud and we did the
05:07:09.540 remote ones and we're all good so there
05:07:12.060 we go I guess the last thing here we
05:07:13.920 should probably do is just clean up so
05:07:15.480 if we go to terraform Dev here uh we're
05:07:18.000 going to go down to destruction and
05:07:21.240 we'll run a destroy plan here
05:07:26.400 okay
05:07:29.160 and once this is all done you know you
05:07:31.020 can go ahead and just delete these
05:07:33.718 repositories
05:07:35.760 and notice this one is it has a private
05:07:37.980 lock on it so oh because it's actually
05:07:39.540 running right now so it's being locked
05:07:41.340 so yep there we go so that's it
05:07:43.920 [Music]
05:07:48.420 hey this is Andrew Brown from exam Pro
05:07:50.340 and we are taking a look at Sentinel
05:07:51.900 which is an embedded policies code
05:07:53.580 framework integrated within the
05:07:54.958 terraform platform so what is policies
05:07:57.660 code when you write code to automate
05:08:00.120 regulatory or governance policies and
05:08:03.180 features of Sentinels include uh it that
05:08:05.340 it's embedded so enable policy
05:08:07.620 enforcement in the data path to actively
05:08:09.958 reject violating Behavior instead of
05:08:12.298 passively detecting so it's very active
05:08:15.420 or proactive fine-grained condition
05:08:17.700 based policies so make policy decisions
05:08:20.280 based on the condition of other values
05:08:22.440 multiple enforcement levels so advisory
05:08:24.660 soft and hard mandatory levels allow
05:08:26.580 policy writers to warn on or inject
05:08:29.820 reject Behavior we have external
05:08:31.980 information so Source external
05:08:33.718 information to make holistic policy
05:08:35.580 decisions we have multi-cloud compatible
05:08:38.218 compatible so ensure infrastructure
05:08:40.378 changes are within business and
05:08:42.298 Regulatory policy across multiple
05:08:44.040 providers and Sentinel is a paid service
05:08:46.320 part of the team and governance upgrade
05:08:47.878 package so Syrian team in governance
05:08:50.160 it's available for that
05:08:51.798 business and Enterprise okay
05:08:54.660 [Music]
05:08:58.740 let us expand a bit on the concept of
05:09:00.900 policies code and relating to Sentinel
05:09:03.060 so Sentinel is built around the idea and
05:09:04.740 provides all the benefits of policy of
05:09:06.840 code let's talk about the benefits we
05:09:08.520 get with this so sandboxing the ability
05:09:10.260 to create guardrails to avoid dangerous
05:09:12.000 actions or remove the need of manual
05:09:14.100 verification codification the policies
05:09:16.378 are well documented exactly represent
05:09:17.940 what is enforced Version Control easy to
05:09:20.340 modify or iterate on policies with a
05:09:22.440 chain of history of changes over time
05:09:24.900 testing so syntax and behavior can
05:09:27.480 easily be validated with Sentinel
05:09:28.980 ensuring policies are configured as
05:09:30.540 expected automation so policies existing
05:09:33.120 as code allows you to allows you to
05:09:35.760 direct integrate policies in various
05:09:37.680 systems to Auto remediate and notify
05:09:40.320 we're talking about senatal and policies
05:09:42.360 code we have language so all Sentinel
05:09:45.200 policies are written using the sender
05:09:47.520 language this is designed to be
05:09:49.020 non-programmer and programmer friendly
05:09:50.760 and embeddable and safe for development
05:09:52.920 Central provides a CLI for development
05:09:54.718 and testing and for testing Central
05:09:56.700 provides a test framework designed
05:09:58.138 specifically for for automation so
05:10:00.420 hopefully that gives you an idea of the
05:10:02.100 benefits of policy code and in
05:10:03.420 particular with Sentinel
05:10:04.700 [Music]
05:10:08.878 all right let's take a look at the
05:10:10.920 Sentinel language and also just a broad
05:10:13.560 uh range of of use cases that we could
05:10:16.138 use these for so you can start thinking
05:10:17.700 about how to start applying Sentinel the
05:10:19.798 great thing is that there are a bunch of
05:10:21.420 example policies provided by hashicorp
05:10:23.520 so you can easily
05:10:25.440 um you know start using them right away
05:10:26.638 but let's go through the big list to
05:10:28.020 kind of give you an idea where you would
05:10:29.878 use policies code so for AWS maybe you'd
05:10:32.340 want to restrict the owners of the AWS
05:10:34.138 Ami to a data of the data source maybe
05:10:36.718 you want to enforce mandatory tags on
05:10:38.520 taggable AWS resources restrict
05:10:40.440 availability zones used by ec2 instances
05:10:42.620 disallow a
05:10:45.620 0.0.0.04.0 basically anywhere address
05:10:48.000 out to the internet restrict instance
05:10:50.340 types of ec2 so maybe you only want
05:10:52.260 people using T2 micros require S3
05:10:54.420 buckets to be private encrypted by KMS
05:10:56.218 since that is a big
05:10:57.900 um a big problem for people on AWS where
05:11:00.900 their buckets get leaked require vpcs to
05:11:04.200 have DNS host names enabled we're
05:11:06.000 looking at gcp enforced mandatory labels
05:11:07.860 on VMS disallow allow anywhere cider and
05:11:11.458 force limits on gke clusters because
05:11:13.378 those can get really expensive restrict
05:11:15.000 machine types of VMS just like AWS for
05:11:17.700 VMware required storage DRS on datastore
05:11:21.120 clusters restrict size and type of
05:11:22.920 virtual disks restrict CPU count memory
05:11:25.378 of VMS restrict size of VM disks record
05:11:28.260 NFS 4.1 and cure Burrows I never can say
05:11:32.520 that properly on NAS data stores for
05:11:34.560 Azure enforced mandatory tags of VMS
05:11:36.958 restrict Publishers of VMS restrict VM
05:11:39.360 images restrict the size of azure VMS
05:11:41.580 enforce limits on AKs clusters restricts
05:11:44.760 cider blocks of security groups for
05:11:46.680 cloud agnostic allowed only say we can
05:11:50.520 only use these allowed providers say or
05:11:53.340 explicitly say what providers are not
05:11:55.740 allowed limit proposed monthly costs
05:11:58.320 prevent providers in non-root modules
05:12:00.298 require all modules have version
05:12:02.160 constraints require all resources be
05:12:04.560 created in modules and private module
05:12:06.958 registry use most recent versions of
05:12:09.780 modules in a private module registry
05:12:11.218 that's more so like about the tooling
05:12:13.080 around modules
05:12:14.400 now let's take a look at an example and
05:12:16.860 this is one for restricting uh available
05:12:19.440 zones on ec2 instances so like what data
05:12:21.780 centers you're allowed to use and so we
05:12:24.060 first import our language functions
05:12:25.620 that's going to allow us to use
05:12:27.240 particular uh feature functions in this
05:12:29.700 we're going to specify our azs we're
05:12:32.218 going to get all the virtual machines
05:12:34.320 we're going to filter that and restrict
05:12:36.660 the AZ for those VMS we're going to
05:12:39.000 Define that rule to make it enforceable
05:12:40.620 so there you go
05:12:43.520 thank you
05:12:45.490 [Music]
05:12:46.980 all right let's take a look here with
05:12:48.360 Sentinel with terraform so Central can
05:12:50.100 be integrated with terraform via
05:12:51.060 terraform Cloud as part of your IEC
05:12:52.680 provision Pipeline and where it's going
05:12:54.480 to sit is between plan and apply okay
05:12:59.040 so the way you do it is you're going to
05:13:00.480 have to create a policy set and apply
05:13:02.520 these to the terraform workspace so it's
05:13:04.620 not that complicated to get it hooked up
05:13:06.798 so yeah that's all there is to it okay
05:13:09.700 [Music]
05:13:13.920 hey this is Andrew Brown from exam Pro
05:13:15.718 and we're going to learn a bit about
05:13:17.280 Sentinel with terraform I'm not going to
05:13:19.260 say I'm amazing at it but we are going
05:13:20.580 to stumble our way through and see what
05:13:21.840 we can accomplish we know we can
05:13:23.400 download Sentinel box and there's also
05:13:25.260 the ability to set policy sets and I do
05:13:27.420 know that there are a bunch of pre-made
05:13:29.760 Sentinel policies so we go send no
05:13:32.400 policies here terraform
05:13:35.820 uh and we go examples uh there we are
05:13:39.298 probably here
05:13:40.920 there are a bunch of ones that we can go
05:13:42.600 in here so I'm thinking that there's
05:13:43.920 something that we can do here
05:13:46.080 um but we'll have to figure our way
05:13:47.280 through here because I actually haven't
05:13:48.240 ran any um policies myself so we have
05:13:51.298 these two environments I'm not using Dev
05:13:53.160 anymore I'm done with this I'm going to
05:13:54.480 go ahead and destroy that and we're
05:13:56.280 going to go down to terraform destroy
05:13:58.680 I'm pretty sure I don't have any running
05:14:00.120 infrastructure actually I'm going to
05:14:01.440 double check by going to the overview
05:14:02.760 everything has been destroyed and so
05:14:05.280 I'll go back over here and we're going
05:14:06.660 to destroy this I'm going to type in VCS
05:14:09.320 terraform Dev
05:14:14.940 great if we go into this workplace or
05:14:17.580 workspace nothing is provisioned right
05:14:19.798 now so I want to get everything running
05:14:22.860 again because last time we ran a destroy
05:14:26.400 so I think that if we want to get this
05:14:28.620 working it should be pretty easy I'm
05:14:30.060 going to go back to
05:14:31.560 our
05:14:32.900 workflows file here
05:14:35.280 and we're just going to revert some
05:14:36.480 changes so I'm going to go back and
05:14:38.280 change this to name
05:14:42.180 and I'm just going to go whoops we're
05:14:44.340 going to go into our 120 directory here
05:14:46.920 and we're going to check out Main and
05:14:48.780 that actually might just revert those
05:14:49.860 changes there I don't think anything
05:14:50.878 really changed much other than this part
05:14:52.620 here
05:14:54.900 and so what I'm going to do is just go
05:14:57.360 Um
05:14:58.560 make a minor change it doesn't matter
05:15:00.420 what it is maybe a space
05:15:03.420 get add all whoops
05:15:06.660 git commit hyphen m
05:15:09.480 changes
05:15:11.638 get push
05:15:14.878 I'll have to do a good pull here
05:15:18.780 get push
05:15:21.660 sorry get push
05:15:24.060 and so what I want to see here is a
05:15:26.040 trigger for the Run
05:15:30.298 there we go and I'll see you here in a
05:15:31.920 bit when it's provisioned okay all right
05:15:33.480 so after a short little weight there it
05:15:34.798 looks like our branches Ran So I think
05:15:37.378 our resources are provisioned it's cool
05:15:40.440 we actually have cost estimation I
05:15:42.120 didn't have to do anything to turn that
05:15:43.620 on we already have it notice that it's
05:15:45.180 giving us an hourly of Zero 12 cents the
05:15:48.540 monthly is going to be eight dollars in
05:15:50.280 you know 35 cents there if there was
05:15:52.920 more resources there we would obviously
05:15:54.240 get that I assume that it would show up
05:15:55.920 here in the top right corner so
05:15:59.400 we're not really interested in the
05:16:00.840 provision infrastructure but more so
05:16:02.580 looking at these Sentinel locks so I'm
05:16:05.040 going to go ahead and download them
05:16:06.180 there and that's going to download as a
05:16:09.480 um a zip
05:16:10.798 or an archive of some sorts and so what
05:16:13.860 I can do here
05:16:15.540 is just unzip it so I'm just going to
05:16:17.400 make a new folder
05:16:19.860 here and we'll just call these um
05:16:23.100 Sentinel marks
05:16:27.840 okay I'm just going to open up the zip
05:16:29.400 and so here's all the stuff in here so
05:16:31.138 we have a variety of different files I
05:16:33.060 think some of them might be redundant
05:16:34.798 I'm not sure what we have to do with
05:16:36.420 them but I'm just going to go ahead and
05:16:37.500 grab these and drag them into the folder
05:16:39.718 here
05:16:41.218 okay and actually what I'm going to do
05:16:43.138 is
05:16:45.060 um I'm going to just make a new section
05:16:47.520 in my folder here whoops
05:16:51.360 just give me a second here
05:16:54.840 we'll just open up the Explorer to
05:16:56.400 anything
05:16:57.718 yeah we have a folder right here
05:17:04.980 because what I want to do is just drop
05:17:06.420 those files in so we can just see them
05:17:07.798 in vs code the contents of them
05:17:15.120 there we go
05:17:16.860 and so now I'm just going to go down to
05:17:18.360 here
05:17:19.320 and we'll take a look so we have
05:17:20.760 Sentinel HCL
05:17:24.360 all right and so that's just defining a
05:17:26.280 bunch of mocks
05:17:28.280 we have this Central File here
05:17:35.340 so I was hoping when we open this it
05:17:36.900 would be able to figure out what to do
05:17:38.218 with this and I have no idea so you know
05:17:39.958 what what I'm going to do is I'm just
05:17:41.700 going to do a little bit of reading and
05:17:42.900 I'm going to come back to you after I
05:17:44.280 finish reading this okay all right so
05:17:46.020 spending a little bit of time uh
05:17:48.000 watching some stuff so I was just going
05:17:49.378 through the Deep dive of Sentinel here
05:17:51.000 uh and just going through the
05:17:52.680 documentation and as far as I understand
05:17:54.240 it looks like that you write policies
05:17:56.878 and then you can also write tests for
05:17:58.560 your policies to assert that your
05:17:59.878 policies are doing what you expect them
05:18:01.740 to do and I guess those uh Sentinel
05:18:04.138 locks are written in a form of HCL but
05:18:07.260 it is a little bit confusing because you
05:18:08.580 get this folder with a bunch of stuff in
05:18:10.080 it and it can be either written as Json
05:18:12.240 or like this htl like format but as far
05:18:16.320 as I can tell it's just saying what it's
05:18:18.660 done is it's generated out these the
05:18:20.580 current state of exactly what your
05:18:22.440 infrastructure is and I think that it's
05:18:24.060 going to check to see is it exactly what
05:18:26.940 you expect it to be so I don't know if
05:18:29.340 MOX is that very useful and might be a
05:18:31.620 little bit too much for this particular
05:18:33.420 course so I'm just going to say okay
05:18:35.580 let's just kind of ignore locks because
05:18:38.940 they're just a little bit too too
05:18:40.740 difficult and out of scope here let's
05:18:42.958 follow focus on trying to get a policy
05:18:45.060 implemented so I'm going to go back over
05:18:47.160 here and what I'm going to do is I know
05:18:49.740 that if I go to settings
05:18:53.940 I mean I've seen it before I just can't
05:18:55.740 remember if it's under a workspace
05:18:57.840 no it's I think it's at the organization
05:18:59.458 level so we're gonna go to the settings
05:19:00.480 here
05:19:01.500 and there we have our policies so we
05:19:04.260 here we can create new policies so
05:19:05.638 managing individual policy terraforms
05:19:07.138 deprecated policy sets now supports VCS
05:19:09.840 integration with direct API uploads this
05:19:12.240 provides a streamlined policy management
05:19:13.560 experience policies which includes okay
05:19:15.120 so this is the old way of doing it and
05:19:17.040 so we'll go here and create a new policy
05:19:18.600 set so connect a new policy set
05:19:22.020 um okay so I guess what we have to do oh
05:19:25.920 boy this is a lot different than I
05:19:27.060 thought it was going to be so I thought
05:19:28.378 it was just like we're going to go here
05:19:29.520 and create it and then dump our code in
05:19:31.020 which apparently that's what it is but
05:19:32.878 it seems like we need to associate with
05:19:34.440 the policy set so just give me a moment
05:19:36.420 because I do want to show you the the
05:19:37.798 most up-to-date way to do this I'll be
05:19:39.718 back in a second all right all right so
05:19:41.458 doing a little bit of reading here it
05:19:42.718 looks like what we have to do is create
05:19:44.160 ourselves a sendile.hcl file and this is
05:19:46.620 going to say what policies we want to
05:19:48.180 enforce so I assume this is basically
05:19:49.860 the policy set as a file and here we
05:19:52.260 specify the policies that we care about
05:19:55.560 um I actually just want to go back to
05:19:57.240 the files we were looking at earlier
05:19:58.680 because we saw this HCL file so I guess
05:20:01.260 this would technically be a policy set
05:20:03.540 is that what we call that here but
05:20:05.580 notice it says mock so these aren't
05:20:07.080 policies per se these are just grouping
05:20:09.200 mocks but in any case I think we'll have
05:20:13.080 to create this file so what I'm going to
05:20:14.520 try to do
05:20:15.840 and I don't know this is going to work
05:20:17.520 but we'll just stumble our way through
05:20:18.900 here because it's the best way to learn
05:20:19.980 is we're going to create ourselves our
05:20:22.138 own Sentinel file here so we're going to
05:20:23.940 say
05:20:24.600 um
05:20:25.200 Sentinel dot HCL
05:20:28.980 and we're going to Define ourselves a
05:20:30.718 policy
05:20:31.798 this is going to be the one that we're
05:20:33.120 going to use but I'm just going to grab
05:20:34.200 it here notice there are different
05:20:35.760 enforcement levels so
05:20:37.620 um I don't really care we put in I just
05:20:39.180 want to see that we can successfully get
05:20:40.500 anything working here and I'm going to
05:20:42.958 go back to the examples
05:20:45.660 if we can go find that there so
05:20:48.298 Sentinel
05:20:49.980 policy examples and let's just go take
05:20:51.958 one of those and see what we can do with
05:20:53.340 it okay
05:20:56.160 so if we scroll on down
05:20:58.440 um
05:20:59.760 this allows zero zero zero cider Block
05:21:01.980 in the security group that seems like
05:21:03.360 something that would be pretty relevant
05:21:04.620 restrict instance type of ec2 instance
05:21:06.840 that could be something as well that we
05:21:08.280 could do
05:21:09.180 so you know I just have to decide what
05:21:12.060 it is we want to do here restrict owners
05:21:13.560 so there's a few that are good here
05:21:14.878 let's take this take a look at this one
05:21:16.500 because I feel like this might be very
05:21:17.700 simple
05:21:18.660 so yeah this is perfect okay so what
05:21:20.940 we'll do is we'll take uh this policy
05:21:22.980 here so I wonder if I could just go
05:21:24.958 download this file here it's probably
05:21:26.760 like a download button
05:21:29.218 well I can't find it so we'll just or
05:21:31.320 maybe it's up here
05:21:32.458 no okay we'll just create this by hand
05:21:35.040 here so I'm going to go copy and it
05:21:38.100 looks like we can just drop it in here
05:21:39.600 so I'm just going to new
05:21:41.400 file here
05:21:42.900 and put that there and we will just go
05:21:45.718 to Raw
05:21:50.400 and we will go ahead and drop that on in
05:21:52.500 there
05:21:54.360 so I wish I had like sandal highlighting
05:21:56.458 I don't know if there is such one for vs
05:21:58.440 code if there is it'd be really nice so
05:22:00.360 we would type in Sentinel
05:22:05.760 um uh yes we do
05:22:08.820 this one has more downloads so we'll go
05:22:11.100 with that one
05:22:13.200 no rating as of yet looks like it works
05:22:15.900 so let's go give them a five star
05:22:19.500 I think that's only fair because uh no
05:22:21.420 one's done that yet
05:22:28.080 might be a bit too hard to uh I've never
05:22:30.180 written a review before but we'll go
05:22:31.378 here and say works as expected
05:22:34.740 thank you for this uh
05:22:37.560 extension
05:22:41.940 okay so what I'm going to do is go back
05:22:44.638 over to here and so here we have some
05:22:46.920 kinds now we're running a T2 micro I
05:22:49.620 believe so this policy should cause it
05:22:52.860 to fail and that's exactly what we want
05:22:54.360 but I'm just going to go look up and
05:22:56.040 down to see if it's all correct looks
05:22:57.600 good to me so I think we'll have to
05:22:59.100 change over here is the name so I'm just
05:23:00.900 going to clear this out and we'll say
05:23:03.480 restrict
05:23:05.040 ec2 instance
05:23:07.200 type
05:23:08.580 we'll save that hard mandatory sounds
05:23:10.620 really good to me
05:23:13.080 um probably have to spell it right for
05:23:14.580 it to work r-e-s yeah strict okay great
05:23:17.580 and so what I'll do is just copy this up
05:23:20.100 here
05:23:27.900 okay and so we have our signal HCL file
05:23:31.080 and it's referencing a local file now
05:23:32.580 the question is you know can we use the
05:23:35.340 same repository I assume we would be
05:23:37.200 able to uh for our policy set but it
05:23:39.600 almost seems like it might encourage you
05:23:40.860 to have your policies separate from your
05:23:42.420 repository that you're testing and that
05:23:44.100 might be really good because let's say
05:23:45.298 you have multiple workspaces or
05:23:47.340 environments and they all require the
05:23:49.200 same policy set you wouldn't want to
05:23:50.458 have them in your code base like that
05:23:51.840 but for the purposes of this we're just
05:23:54.360 going to keep it simple I'm going to go
05:23:56.218 ahead and open up terminal here and
05:23:59.340 we're going to commit these uh these
05:24:00.958 changes to our Repository
05:24:03.000 and this will end up triggering a deploy
05:24:04.980 even though we don't necessarily want
05:24:06.958 that to happen but there's no way around
05:24:09.240 that so get well I suppose we could just
05:24:12.240 cancel it out but or not have the auto
05:24:13.920 apply but I don't feel like changing
05:24:15.298 that so we'll do get status here we'll
05:24:17.280 go get add all git commit hyphen M uh
05:24:21.780 simple policy here
05:24:26.520 get push
05:24:28.860 okay
05:24:30.360 and so that's being pushed to our
05:24:32.400 repository that's going to trigger a
05:24:34.260 deploy and we don't care I I assume that
05:24:36.540 it won't pick up the policy because we
05:24:37.860 have to kick the policy set
05:24:39.680 so
05:24:41.458 um apparently use the API to upload your
05:24:42.958 policy set which is kind of cool I
05:24:44.580 suppose we could have done that but um
05:24:47.458 well too late we probably should use VCS
05:24:50.280 anyway you know what I mean so we'll go
05:24:52.440 to GitHub here and we will find our
05:24:54.360 terraform repository which is here
05:24:57.180 um you know policy
05:25:00.480 well we should probably name this right
05:25:02.040 so we policy to enforce uh instance type
05:25:09.480 I don't know if we need a description I
05:25:10.980 guess we'll find it in a second here I
05:25:12.600 guess we could have also put the policy
05:25:14.400 in a um a subdirectory there that might
05:25:17.458 have been okay to do
05:25:19.138 it's going to default to the main branch
05:25:20.638 which is fine policies enforced On All
05:25:22.680 workspaces or policies and force on
05:25:24.360 selected workspaces and we only have one
05:25:26.638 but that's what we'll do down here so
05:25:28.200 we'll say update
05:25:30.000 the name is invalid
05:25:31.798 oh uh it has to be like
05:25:34.740 a proper name so restrict
05:25:39.060 ec2
05:25:40.920 now again this is a policy set so you
05:25:42.600 could just say like
05:25:43.798 um
05:25:44.458 you know basic server policy
05:25:47.638 set that'd probably be better and then
05:25:49.560 you probably want to list to say what it
05:25:51.060 does it restricts
05:25:52.980 um ec2 instances instance type
05:25:56.100 okay and we'll go down here and create
05:25:58.260 that policy set
05:26:00.320 and that looks like we're in good shape
05:26:02.940 so we applied it um now will it actually
05:26:06.060 happen on this run because it's already
05:26:07.980 running I believe we're going to this
05:26:09.420 workplace
05:26:10.560 workspace I like to say workplace it's
05:26:12.718 workspace and uh we go over here this is
05:26:15.480 already planned and finished so what I
05:26:16.920 want to do is just trigger another uh
05:26:20.040 um deploy here so there's nothing
05:26:21.780 changed
05:26:24.360 so
05:26:25.798 I'm not sure what we do here
05:26:28.138 um I guess what we could do and actually
05:26:29.400 this is something that I'm I don't know
05:26:30.718 but like how would you trigger a replace
05:26:33.420 on here because if we were doing let's
05:26:36.540 go to plan and see what happens I wonder
05:26:38.100 if we could do that in the plan here
05:26:40.378 reasons for trigger
05:26:42.718 do refresh only plan because one thing I
05:26:45.360 was thinking about is like imagine I
05:26:46.680 wanted to replace an element you can do
05:26:48.120 that hyphen replace but I don't know how
05:26:49.560 you do that through VCS but anyway what
05:26:52.378 I'm going to do is just go change
05:26:53.878 anything in our code
05:26:56.400 um so it could just be a space it
05:26:57.660 doesn't really matter
05:26:59.580 get add plus git commit
05:27:03.240 trigger uh change
05:27:06.900 and we just want to observe
05:27:09.360 the um
05:27:13.138 the policy working okay
05:27:18.780 so I'm just going to open this up here
05:27:20.218 I'm not sure if it's going to show up in
05:27:22.320 the plan section or the apply section so
05:27:24.120 we'll just wait here to watch see the
05:27:25.740 plan generate out
05:27:43.320 and so the plan finished
05:27:45.780 um we don't see any Sentinel uh Central
05:27:47.940 being applied there
05:27:49.920 apply will not run
05:27:52.500 let's expand that there this looks fine
05:27:58.560 I guess technically we didn't change
05:28:00.000 anything so that probably is not very
05:28:01.740 helpful so what I'm going to do is go
05:28:05.100 and change a variable because maybe
05:28:06.900 that's that's what's going to help here
05:28:08.400 so we have a micro here which is fine
05:28:10.680 we're just going to change this over to
05:28:11.940 Nano
05:28:15.958 that makes sense why I didn't do it so
05:28:18.298 we'll go back over to runs and I'm going
05:28:19.920 to trigger I'm going to start a plan so
05:28:22.020 uh changed ec2 instance type
05:28:28.500 we'll say Start Plan
05:28:52.080 okay so we have one change which is fine
05:28:57.240 we just okay so that part pass is going
05:28:59.940 to go to cost estimation
05:29:03.360 that passed it's going to apply it
05:29:05.040 because remember we have um Auto approve
05:29:07.860 on the server so it's not even going to
05:29:09.360 ask us to confirm it and so I want to
05:29:11.580 see if that policy is in place
05:29:27.120 well it's running I'm just going to go
05:29:28.500 review our policy here
05:29:31.500 just to make sure it's not like the
05:29:32.878 opposite saying like you cannot have
05:29:34.138 these so include now a loud easy to do
05:29:36.660 instance type so it's small medium or
05:29:38.040 large so it really should quit out on
05:29:39.660 this one here
05:29:45.840 but it seems like it's working like it's
05:29:48.000 not uh it's not picking up the policy
05:29:49.500 but I'll see you hear it back in a bit
05:29:50.820 okay all right so I didn't see the
05:29:53.160 policy trigger there so I'm going to go
05:29:54.540 back to policy sets and notice here it
05:29:56.040 says zero workspaces which is unusual
05:29:57.780 because I definitely selected one but
05:29:59.340 maybe I didn't click through or hit uh
05:30:01.080 add so I'm going to go down here and
05:30:03.120 click this one again and maybe I didn't
05:30:05.580 hit this button here
05:30:07.500 okay and now I'll probably have to hit
05:30:09.180 update um policy set before we do I just
05:30:11.280 want to read about this these parameters
05:30:12.480 are past the central runtime on
05:30:13.620 performing policy checks so I guess I'd
05:30:15.660 be like a way where you'd have a generic
05:30:17.400 policy and then you could kind of put
05:30:18.600 parameters in so that's kind of cool so
05:30:20.820 I'm going to go back here and double
05:30:22.138 check to make sure that we have a
05:30:23.400 workspace set and so what we'll do is
05:30:25.920 just change the variable again
05:30:29.160 um so we will go to our variables here
05:30:32.638 and I'm going to go change this back to
05:30:34.440 a micro and so I think this time we are
05:30:37.020 going to have better success okay so
05:30:39.120 we'll hit save we'll go back up to runs
05:30:42.240 we'll go and start a new plan uh change
05:30:45.900 instance type
05:30:47.520 again here
05:30:51.718 and we will save that plan and so that
05:30:54.240 plan is now running I will see you back
05:30:56.100 here in a bit uh when we see that
05:30:57.958 Sentinel policy I don't know when it
05:30:59.520 triggers so I'll see you back here in a
05:31:00.600 bit all right welcome back so after our
05:31:02.218 cross estimation it did a policy check
05:31:03.780 and you can see that it failed um and
05:31:05.520 here the error says import TF plans
05:31:07.920 function is not available so I'm not
05:31:10.138 sure why that's happening so I think
05:31:12.180 that um I mean our set failed but not
05:31:14.638 for the reason we wanted to so I'm going
05:31:15.840 to go investigate this I'll be back in a
05:31:17.160 moment okay all right so uh what I've
05:31:19.320 done here is I've gone and looked up uh
05:31:21.958 like how to create a policy set and
05:31:23.520 hashicorp learn has this example project
05:31:25.860 here and if we go into its GitHub
05:31:29.100 project and I go here you're going to
05:31:31.560 notice that it it's like this apparently
05:31:33.540 does basically the same thing restrict
05:31:34.680 AWS instance type and apparently tag as
05:31:37.200 well but it doesn't have the TF
05:31:39.980 functions the TF plan functions here so
05:31:44.638 um maybe we don't need that function in
05:31:46.740 there and maybe the uh the example is
05:31:48.360 just out of date at this time so import
05:31:50.040 common functions
05:31:51.600 for Sentinel
05:31:53.340 okay but this one doesn't have it it
05:31:55.260 does it does have it for mocks right
05:31:58.200 um
05:31:59.298 so maybe we just need to kind of like
05:32:02.638 walk through this really quickly and see
05:32:04.260 how we can fix this so the policy uses
05:32:06.298 the Sentinel TF2 plan import to require
05:32:08.240 that all ec2 instances have instance
05:32:11.040 types planned under the loud list
05:32:13.878 but I don't see that import there
05:32:17.400 okay and it is in here
05:32:19.740 so I guess what we'll do is just grab
05:32:21.420 this one
05:32:23.820 okay and I'm going to go ahead and just
05:32:25.860 delete this one out here
05:32:27.840 um
05:32:28.440 again this isn't working I don't know if
05:32:30.120 this would work with that one so I'm
05:32:32.218 going to take it out
05:32:33.600 this is pretty clear what this does so
05:32:35.700 we'll just have that allowed types it's
05:32:37.920 interesting like here it's underscore
05:32:39.240 and then here it's like a title case
05:32:41.218 there's some inconsistencies there so
05:32:43.740 they have a lot of types as well
05:32:46.440 um
05:32:47.760 and I'm just seeing if there's like find
05:32:49.620 resources in here
05:32:54.600 so allow types rule to enforce the name
05:32:57.600 tag
05:32:58.860 so I don't care about that
05:33:00.958 rule to restrict the instance type so
05:33:03.000 I'm going to go ahead and grab this one
05:33:04.260 here and let's just take a look at the
05:33:05.940 differences here
05:33:10.020 okay so instant type allowed rule all
05:33:12.718 ec2 instances as
05:33:14.820 that instance
05:33:16.620 change after instance type a lot type so
05:33:19.080 this is way way different
05:33:21.900 um
05:33:23.340 so I mean I fully don't understand this
05:33:25.500 but I do know that this one
05:33:28.320 it will probably work so I'm going to go
05:33:31.080 down here
05:33:32.638 we have count violations I'm not really
05:33:34.740 worried about that
05:33:39.060 and
05:33:40.798 the rule is different
05:33:43.740 like if I was really serious about this
05:33:45.298 I'm sure I could you know figure out the
05:33:47.458 logic here but again this is just for
05:33:48.840 the purposes of us learning so we don't
05:33:50.820 have to go too crazy here now this says
05:33:52.200 instance type allowed and mandatory
05:33:53.878 instance tags we're not dealing with
05:33:55.320 tags here so I'm just going to say this
05:34:04.200 okay and so I think this will produce
05:34:06.360 what we want
05:34:07.920 so allows those types
05:34:11.820 I don't know if it had this in here
05:34:17.400 get all instant types from the module
05:34:20.400 I think we didn't put this in here so
05:34:22.200 this might be kind of the equivalent
05:34:26.458 ec2 instances filter TF plan resource
05:34:30.840 changes
05:34:33.120 okay
05:34:37.080 contains a create or an update
05:34:41.458 okay
05:34:44.290 [Music]
05:34:44.940 um
05:34:45.660 I mean this isn't bad we technically
05:34:47.458 have a name set so you know what I'm
05:34:49.440 just going to grab this whole thing
05:34:50.458 because then we're just going to have a
05:34:52.378 much easier time we don't have to worry
05:34:53.638 about it but it was nice to walk through
05:34:54.840 that file very quickly because the name
05:34:57.120 tag is set in our project a because we
05:34:59.700 can see we can see that's the server
05:35:01.560 name so what we'll do is we'll just go
05:35:04.378 ahead and add this to our repository
05:35:06.718 here and the great thing is that since
05:35:09.240 it's the vs code or it's in the same
05:35:10.920 Version Control System I would think
05:35:12.240 that it would update in time so what
05:35:14.520 we'll do is just do get add all git
05:35:17.340 commit hyphen m
05:35:19.860 fix the policy
05:35:22.620 git push
05:35:27.780 okay and we'll go back over here
05:35:34.500 and we will see
05:35:37.138 if the policy check happens and when it
05:35:39.780 does happen it's actually
05:35:41.638 airing out because we're not using the
05:35:43.620 right instance size right that's what we
05:35:45.420 want to see
05:35:48.540 a little bit of trial error it's not a
05:35:50.040 big deal I also read like over here that
05:35:52.378 the Sentinel file for HCL only contains
05:35:55.260 module and policies but then we saw a
05:35:56.940 sentinel file or htl file that clearly
05:35:58.798 had mocks in it so
05:36:01.440 I mean maybe maybe it just only used
05:36:03.180 locally maybe it's not intended for um
05:36:05.040 production
05:36:07.620 um so we'll go down here TF plan so it
05:36:10.980 didn't pick it up okay so what I'm going
05:36:12.900 to do is go back to my policy set and
05:36:14.700 maybe it's just like the order of how
05:36:16.200 this happened
05:36:17.458 so see this says it was updated uh last
05:36:19.798 five minutes ago
05:36:21.958 updated it a minute ago so this could
05:36:23.580 just be like a race case where
05:36:25.740 um you know this ran before the other
05:36:28.680 one so I'm going to try to execute this
05:36:30.240 again start a new plan uh trigger plan
05:36:37.740 and we'll see if that works now because
05:36:39.480 again this said
05:36:41.160 literally updated a minute ago so maybe
05:36:42.660 it didn't pick it up
05:36:50.940 so you can see why it would also be good
05:36:52.680 to have your policy set in a separate
05:36:54.240 repo because if you're deploying this
05:36:55.740 you don't want to keep triggering your
05:36:57.900 deploys
05:36:59.040 so I think probably that's what you know
05:37:01.080 we should have done I mean it's a lot
05:37:02.280 extra work but you know this way you
05:37:03.900 kind of understand why
05:37:06.540 SO waiting on that plan run I really
05:37:08.218 don't care about cost estimation I mean
05:37:09.900 you could make a policy to check based
05:37:11.760 on that I I'm assuming we just turned
05:37:13.500 that off if we wanted to
05:37:16.020 and we'll go over to cost estimation
05:37:18.360 here yeah we can just disable it
05:37:21.420 but the thing here is that it set our
05:37:23.218 policy passed
05:37:25.798 so we'll go here so the result means
05:37:28.260 that all Central policies passed
05:37:30.780 so restrict the instance type so
05:37:33.240 description
05:37:34.740 main rule that requires other rules to
05:37:36.660 be true
05:37:39.120 ruleton Force name tag is on all
05:37:41.100 instances that's true rule to restrict
05:37:42.660 the instance type
05:37:43.920 so maybe we don't understand uh maybe
05:37:46.798 this works in the opposite way oh the t2
05:37:48.718 micros here okay so
05:37:51.780 I just want to see it fail so what we'll
05:37:53.878 do is go back up to our variables here
05:37:56.580 and we'll go to our instance type
05:38:00.000 and we'll just change this to Nano
05:38:03.240 and we'll save that
05:38:05.100 we'll go back over here to our runs
05:38:10.080 oh this is still running the old one
05:38:11.820 here that's fine we can just queue up
05:38:13.620 another one here so we can just say
05:38:14.820 start a new plan
05:38:16.458 uh new instance type
05:38:23.160 okay and if we go back over to here
05:38:27.360 the last one wouldn't have done anything
05:38:28.980 because the infrastructure would have
05:38:30.360 been the same so
05:38:36.180 the previous one we just did here right
05:38:38.458 it would just been like oh no it's still
05:38:40.138 trying to apply it so I guess there is a
05:38:41.520 change
05:38:42.718 maybe we changed the instance type last
05:38:44.580 time I don't know
05:38:46.080 so anyway I'll see you back here when
05:38:48.000 this is completely done okay
05:38:49.620 all right great so we got an error if we
05:38:51.180 go into our instance type here
05:38:53.100 right and we look at it we can see that
05:38:55.320 it failed because uh it wasn't the right
05:38:57.900 uh type so
05:39:00.600 um I mean that's pretty interesting so
05:39:02.218 the other thing I would say that we
05:39:03.900 could do is also kind of check out mocks
05:39:06.120 now because I kind of feel like I have a
05:39:07.500 better grasp on it now that we have a
05:39:08.878 test running so just thinking straight
05:39:10.980 about it a mock really is a
05:39:12.660 representation of the state of
05:39:14.100 infrastructure at the time of so if we
05:39:16.320 go back to our runs and we go to a
05:39:17.820 successful run like the trigger plan
05:39:19.320 here and this one was successful we
05:39:21.240 could go to the plans here and then
05:39:22.440 download these mock files so we do have
05:39:25.260 the ones from prior and I think those
05:39:26.878 are totally fine and valid to use so
05:39:29.340 what if what we do is go back to our
05:39:31.798 project over here and we have
05:39:35.218 um
05:39:36.298 the mock files over here but really
05:39:38.820 where they need to be is within the
05:39:40.378 workflow directory because looking at
05:39:42.060 the documentation here
05:39:43.560 what it's saying is that you get all
05:39:45.540 these things and this basically
05:39:46.500 represents the state of those mock files
05:39:48.240 and then you need to make a test folder
05:39:50.160 and then a test data folder and then
05:39:52.378 there's gonna be something based on the
05:39:53.400 name of the uh the mock file so what
05:39:55.920 we'll do is we'll go
05:39:58.040 up to this folder here and we'll say new
05:40:00.480 folder test and then we'll make another
05:40:03.480 new folder here test data
05:40:07.620 those folders are files
05:40:10.138 I think those are files so I'll delete
05:40:12.718 that it's just out of habit to click the
05:40:15.360 um
05:40:16.560 the file there so we'll say new folder
05:40:18.180 so we'll say test
05:40:20.280 and then we'll say another new folder
05:40:21.840 there
05:40:22.920 test data
05:40:24.900 okay and so we have our sendle file here
05:40:28.860 so we need to have I think a similarly
05:40:31.620 named one here so if we go back over
05:40:33.000 here
05:40:35.400 um this is Foo whatever so I think we
05:40:37.440 need to have a folder in here because
05:40:39.298 it's all based on convention and I just
05:40:40.980 it's pretty not that hard to figure I
05:40:42.600 don't have to read the docs to know that
05:40:43.740 we'll just put that in here take out the
05:40:45.600 word Sentinel
05:40:47.040 and then I would assume that we need a
05:40:48.718 file in here what's it called like this
05:40:50.580 pass and fail so I'm going to just do a
05:40:52.138 pass
05:40:53.760 file new
05:40:55.440 pass.hcl
05:40:58.500 okay and then we have our test data so
05:41:00.840 that was what we had down below here so
05:41:03.900 I need to go grab that information
05:41:07.260 I'm just looking for a folder where
05:41:10.500 I might already have open here if I
05:41:12.600 don't that's fine we'll just go ahead
05:41:13.920 down below and just right click
05:41:16.560 and reveal and explore
05:41:20.218 we'll go over here
05:41:22.200 and I need to move all these over so I
05:41:24.958 just copy them over and we're going to
05:41:26.458 go over to our terraform work
05:41:30.480 flow here and I'm going to go here and
05:41:33.600 paste that data in
05:41:35.458 I don't know if these contain any kind
05:41:37.260 of sensitive data because if they're
05:41:38.340 based on the TF State file these might
05:41:40.260 be something you don't want to share
05:41:41.878 that might be a security vulnerability I
05:41:43.620 don't know but I definitely won't have
05:41:45.180 these available when I put this
05:41:46.500 repository up for free so we have those
05:41:49.980 files in the right place
05:41:53.160 and we have all this stuff here so I I
05:41:56.458 think that um like you notice it's not
05:41:59.160 there so I'm assuming that we need to
05:42:00.718 open up this file and copy into our main
05:42:02.400 HCL file so we'll go down below here and
05:42:05.458 then I think it's just a matter of
05:42:06.780 copying all this stuff right
05:42:09.540 we'll say cut
05:42:12.240 and then we will go to
05:42:16.920 um back up to here I suppose
05:42:20.340 into our
05:42:22.680 file it's getting a little bit confusing
05:42:24.120 with all this stuff eh
05:42:27.000 okay so that's in the right place our
05:42:29.400 test data is there good here we are okay
05:42:31.680 so what I'm going to do is just go down
05:42:33.480 here and paste that in
05:42:37.080 okay and so
05:42:39.000 we didn't write any kind of pass
05:42:42.980 data test
05:42:45.180 so that's something we will need here
05:42:46.680 I'm not sure what we'll get so we'll
05:42:48.120 just scroll down here
05:42:50.040 so you can find the contents of a
05:42:51.660 pass.hcl
05:42:58.440 it's not showing anything here so just
05:43:00.360 give me a moment I'm going to see what
05:43:01.440 we have to do for this this test okay
05:43:03.060 all right so a little bit of Googling it
05:43:04.920 looks like uh this one's on the same
05:43:06.480 tracker so since we probably copied the
05:43:08.340 mock data from this one or somewhere
05:43:10.378 through here we could probably just go
05:43:11.580 grab this so
05:43:13.500 um this is pretty much what our pass
05:43:15.420 file will look like
05:43:16.920 so we'll go ahead and grab this here I
05:43:20.160 don't know if we really need a fail to
05:43:22.020 write a failing test I don't really care
05:43:23.280 about that I just want to see anything
05:43:25.020 pass here
05:43:26.280 we'll paste that in here we do have to
05:43:27.900 be sure that we are accessing our data
05:43:30.000 correctly so if we're in test it's going
05:43:32.340 to go up one directory to the
05:43:35.100 terraform directory
05:43:37.620 but wouldn't it have to then CD into
05:43:41.458 uh test so I don't think that Source
05:43:44.100 path is correct
05:43:47.218 just going to double check that here
05:43:49.980 they do have an example repositories
05:43:51.660 let's take a look here what we have
05:43:55.138 um
05:43:56.340 yeah it's kind of odd so I think
05:43:59.878 that
05:44:01.680 if this is relevant it needs to go to
05:44:04.320 test data
05:44:06.180 because how else will it get there okay
05:44:09.718 so we'll do that so test rules main
05:44:11.760 equals true
05:44:14.760 um
05:44:15.600 okay so that's a pretty simple test
05:44:18.120 and so I think the way we run tests is
05:44:19.798 there's like a sentinel test
05:44:21.900 thing here
05:44:23.218 I don't know if we have Sentinel
05:44:24.540 installed I don't think so
05:44:27.958 so there's no Sentinel command
05:44:31.320 so I guess that's something we're gonna
05:44:32.760 have to install Sentinel
05:44:33.780 [Music]
05:44:34.378 um
05:44:35.160 CLI terraform
05:44:38.520 okay
05:44:39.660 over here
05:44:42.360 uh we're on technically Linux even
05:44:45.058 though we're on Windows we're on Linux
05:44:46.860 so here it's just saying uh download it
05:44:49.200 and then put it in the correct path
05:44:52.620 so install so we'll get the appropriate
05:44:54.600 package here
05:44:57.120 and we are technically on Linux
05:45:01.638 and I guess we are 64-bit
05:45:08.340 it's going to download here
05:45:11.040 scroll up oh it is already downloading
05:45:12.600 okay great and so I'm just going to go
05:45:14.520 to my downloads
05:45:17.878 and I'm going to open it up here
05:45:19.798 so there it is and so I need to um
05:45:23.340 get it into the user local bin here so
05:45:26.040 I'm just going to first get it in
05:45:28.440 anywhere so
05:45:30.180 because I'm just working here I'm just
05:45:31.798 going to go open this up so reveal in
05:45:33.958 the Explorer
05:45:36.000 okay
05:45:37.798 and this is not where I want it to be
05:45:40.020 I'm just dropping it here for the time
05:45:41.218 being
05:45:47.820 technically we could run it from there I
05:45:49.558 don't think it'd be that big of a deal
05:45:51.600 so I'm just going to go back to my vs
05:45:53.400 code here
05:45:55.260 and I'm going to just type signal
05:45:58.020 Sentinel
05:45:59.580 is there right
05:46:01.860 yep it's there
05:46:03.298 I'm not sure if it's executable but um
05:46:06.840 I'm just going to type in Sentinel here
05:46:08.298 Sentinel test
05:46:11.820 okay so it doesn't think it's command so
05:46:13.558 maybe I have to do like chamod U plus X
05:46:16.260 that makes it executable on Linux
05:46:20.040 so note command not found
05:46:22.320 well heck I'm right there maybe I have
05:46:24.298 to put a period forward slash like that
05:46:25.860 okay there we go so I mean of course you
05:46:28.798 don't want to leave it in here you and
05:46:30.660 this would also end up in a repository
05:46:31.980 so this will go to like your user local
05:46:33.420 bin probably so
05:46:35.280 I'm going to say like move sendle to
05:46:38.638 user local bin
05:46:41.580 and so now I should just be able to type
05:46:43.440 Sentinel it should get picked up
05:46:45.240 it does great so here I can do test
05:46:48.780 and down below it says open test no such
05:46:52.138 file or directory so it can't find the
05:46:54.840 mock data notice that it's going into
05:46:57.000 the test test data so that is no good
05:46:58.920 for us we did say to go up a directory
05:47:01.740 so maybe if I go up back one more like
05:47:03.958 this
05:47:07.500 would that work
05:47:09.480 no let's go put back in what they
05:47:11.638 actually had there which I have a hard
05:47:13.138 time believing that would be correct
05:47:16.638 so open mock okay so that's definitely
05:47:19.920 not right okay and so
05:47:24.780 personally I just want this to work so
05:47:26.400 I'm just going to cheat
05:47:28.860 this is absolutely what you should not
05:47:30.480 do but you know like I don't be fiddle
05:47:32.458 around with paths all day here
05:47:34.500 and so I'm just going to give it an
05:47:35.940 absolute path and see if that fixes our
05:47:37.680 problem
05:47:39.360 okay and so just say test data
05:47:42.780 here
05:47:48.360 um
05:47:51.660 so that should absolutely work I'm just
05:47:53.940 going to expand this here
05:47:55.500 this is mock TF plan
05:47:59.580 oh but it says pass in the name okay so
05:48:01.740 the problem isn't that it's the fact
05:48:03.000 that the mock data isn't named it's
05:48:04.620 because the thing is you could download
05:48:05.700 two different mocks right so you could
05:48:07.920 have a state that is successful and
05:48:09.360 failed and you'd probably want to rename
05:48:10.860 them to say passed or failed so we don't
05:48:12.958 necessarily have that so I think my
05:48:14.458 original thing was correct where we had
05:48:16.860 this test data
05:48:19.080 and so here we just have to make sure we
05:48:20.580 match the name so mock TF
05:48:22.980 uh V2 is fine here
05:48:25.500 okay again I don't understand the
05:48:27.718 difference between all these files I
05:48:29.100 definitely saw the documentation to
05:48:30.240 explain them all so you know that might
05:48:32.160 be something we want to read through
05:48:33.058 here
05:48:34.500 um so this is looking a little bit
05:48:35.700 better so mock TF plan hyphen version 2
05:48:37.860 Sentinel
05:48:40.020 so that
05:48:41.340 is correct
05:48:43.500 but the director it doesn't like the
05:48:45.540 direct it's going in that test again so
05:48:48.000 again I can just go back up one more
05:48:49.798 layer here
05:48:51.900 okay
05:48:54.240 there we go and it's passing so
05:48:57.120 um yeah so that's all it takes to
05:48:59.280 um do that again I think if we were to
05:49:01.080 commit this to our code I don't think
05:49:02.458 that these run so we can go like so we
05:49:05.040 can just go add it and see what happens
05:49:06.240 so we'll say get add
05:49:08.940 git commit hyphen M validation
05:49:15.600 and again I don't know if this mock data
05:49:18.180 should be allowed to be committed into
05:49:19.440 the Repository
05:49:21.360 because we have a TF State file here
05:49:22.860 right
05:49:31.920 okay I don't know but I'm going to just
05:49:33.360 do a push here to see what happens
05:49:36.298 but again I I really think that we're
05:49:38.458 probably not supposed to have it in
05:49:39.900 there
05:49:41.280 um so what we'll do
05:49:43.920 is go back to our terraform i o
05:49:52.020 sign in
05:49:56.218 and we'll just see what happens here I
05:49:57.958 mean we don't expect the uh this to pass
05:49:59.940 because it's still using the wrong
05:50:01.200 instance type but I was just curious to
05:50:03.540 see if the mock would appear in any way
05:50:04.920 here I don't think it does I think
05:50:06.298 that's just something that you have to
05:50:07.558 do uh beforehand and I think what you'd
05:50:09.900 have is you'd have a pull request and
05:50:11.280 the pull request could be used to run
05:50:13.080 those unit tests because that's
05:50:14.760 basically what it is okay so yeah that's
05:50:16.920 exactly what I thought would happen but
05:50:18.600 down below here it says the mock block
05:50:20.820 is not supported so
05:50:24.420 I wonder what you would do so if you
05:50:26.520 can't have mocks in the file
05:50:29.218 what would you do locally because you
05:50:31.920 need to I guess the thing is is that the
05:50:34.378 mock file the sentinel.hcl file would
05:50:36.840 not be in this fold so you might have
05:50:39.000 the central HCL file in your main
05:50:41.218 repository for mocking right and if you
05:50:44.878 committed it wouldn't run it because the
05:50:46.200 policy set would actually be in another
05:50:47.458 repository so I think that's how it's
05:50:49.260 supposed to work so
05:50:50.638 yeah I think really we want to have
05:50:52.740 policy sets in their own repository like
05:50:55.080 completely away from there because we're
05:50:56.520 seeing we're running into a lot of
05:50:57.600 problems but we pretty much accomplished
05:50:59.280 what we wanted to do with Sentinel more
05:51:00.900 than I thought we were going to do so
05:51:02.760 that's pretty great so there you go
05:51:04.860 um in terms of this we probably want to
05:51:06.780 tear this down uh we do need to do
05:51:08.700 something with vaults and stuff like
05:51:10.740 that but I think that what we'll do is
05:51:12.420 just tear this down and you know if we
05:51:14.280 need to bring it back up we'll do that
05:51:16.260 so I'm going to go to destruction here
05:51:18.240 Ed
05:51:22.080 we're gonna go ahead and just destroy
05:51:23.458 the plan here
05:51:28.260 okay
05:51:30.660 and we're all now in good shape
05:51:33.780 and so um yeah I'll see you in the next
05:51:36.240 part okay
05:51:37.260 but we're all done here for for Sentinel
05:51:39.298 all right uh actually I guess we're not
05:51:41.040 gone here just yet because it looks like
05:51:42.660 our destroy run failed uh because we
05:51:44.580 didn't pass here so
05:51:47.040 um that is a bit of a problem so we'll
05:51:49.020 have to go to the variables
05:51:51.298 I guess it's a good Edge case to know
05:51:52.680 about but um we'll go back and change
05:51:54.180 this to a micro even though it's going
05:51:56.160 to just tear it down anyway you know
05:51:58.378 so we'll go and type in micro save
05:52:00.480 variable and we'll go back to our runs
05:52:04.440 we'll start a new plan we're sorry we'll
05:52:07.080 go to settings here
05:52:08.700 destruction
05:52:10.680 cue the plan
05:52:13.378 I'm just curious the community plan
05:52:15.058 we'll redirect a new up output here
05:52:18.120 okay cool um so I'm just going to type
05:52:20.280 in VCS terraform again here
05:52:28.860 okay and so
05:52:30.600 this should work
05:52:33.660 and I will come back and just confirm
05:52:35.878 this with you okay so I'll be back in a
05:52:37.260 second all right so the real reason we
05:52:39.058 can't uh get rid of this is because we
05:52:40.620 have those darn mocks in there so
05:52:44.340 um
05:52:45.120 what I'm going to do is go over to our
05:52:46.620 signal file here
05:52:48.240 um up to I mean we don't use this one so
05:52:50.340 I'm gonna go ahead and delete that it's
05:52:51.600 not even something that's going to
05:52:52.860 happen and
05:52:55.558 we need to update our
05:53:00.780 HCL file here
05:53:02.638 okay
05:53:04.020 and I'm assuming that this supports uh
05:53:08.160 this okay
05:53:10.500 because this is not how we should be
05:53:12.298 doing this
05:53:13.320 um and here we go get add git commit
05:53:17.340 hyphen m
05:53:22.378 INE or change
05:53:25.500 okay and this is going to trigger a run
05:53:28.138 here
05:53:30.480 but I really wanted to destroy
05:53:36.958 so we'll just give it a moment there to
05:53:38.638 start so we can kill it
05:53:42.480 um
05:53:46.378 did I not push
05:53:50.100 oh maybe I didn't push
05:53:54.840 and we'll go back here
05:53:56.940 there's that run I'm going to go in here
05:53:59.878 I want to stop it uh cancel run
05:54:04.320 okay and so now what I'll do is go over
05:54:07.020 to the here
05:54:09.420 destroy this
05:54:13.138 we'll run that okay we'll destroy that
05:54:18.660 and I will again see if this is working
05:54:21.958 and I'll see you back here in a moment
05:54:23.040 okay all right so I just wanted to
05:54:24.180 confirm there that everything is uh
05:54:26.160 destroyed so we're all in good shape
05:54:27.660 okay so uh yeah so we're actually done
05:54:30.480 Sentinel now for real okay bye
05:54:32.770 [Music]
05:54:37.558 all right let's take a look here at
05:54:38.760 hashicor Packer so it's a developer tool
05:54:41.340 to provision a build image that will be
05:54:43.080 stored in a repository using a build
05:54:45.420 image before you deploy provides you
05:54:47.520 with the following immutable
05:54:48.840 infrastructure your VMS and your Fleet
05:54:51.000 are all one-to-one in configuration
05:54:53.218 faster deploys for multiple servers
05:54:55.620 after each build earlier detection and
05:54:58.500 intervention of package changes or
05:55:00.180 deprecationable technology so let's take
05:55:02.458 a look at what that workflow would look
05:55:03.840 like so you'd have your code you commit
05:55:05.638 it to your CI CD Pipeline and within
05:55:07.980 that pipeline it would start up a build
05:55:09.360 server running uh Packer and that would
05:55:12.600 trigger a build image so you'd use a
05:55:14.940 something to provision it with so you
05:55:16.378 could use ansible or a variety of
05:55:17.878 different provisioners within Packer and
05:55:20.580 then Packer would then store it
05:55:22.020 somewhere so maybe this would be Amazon
05:55:23.638 machine image because you're deploying
05:55:25.200 to AWS
05:55:26.520 and then what you do is reference that
05:55:28.860 image in your terraform code and when
05:55:31.320 you provision it would get deployed to
05:55:33.000 your
05:55:33.900 CSP so this would be AWS in this case so
05:55:37.020 packet configurations is a machine uh
05:55:40.200 Packer configuration configures the
05:55:42.180 machine via oops
05:55:59.218 hey it's Andrew Brown from exam Pro and
05:56:01.138 we are taking a look at hashicorp
05:56:02.638 Packers so Packer is a developer tool to
05:56:04.378 provision a build image that will be
05:56:05.940 stored in a repository so using a build
05:56:08.400 image before you deploy it's going to
05:56:10.320 give you the following benefits
05:56:11.280 immutable infrastructure your VMS and
05:56:13.320 your Fleet are all one-to-one
05:56:14.520 configuration faster deploys for
05:56:16.798 multiple servers after each build
05:56:18.240 earlier detection intervention of
05:56:20.340 package changes or deprecation volt
05:56:22.440 technology let's take a look at what
05:56:24.000 that workflow would look like so first
05:56:25.680 we'd have GitHub or or your git so
05:56:28.440 wherever you commit your changes and
05:56:30.718 from there that would trigger a CI CD
05:56:32.820 Pipeline with within that cicd pipeline
05:56:35.458 it would trigger a virtual machine so or
05:56:38.280 a build server that's a running Packer
05:56:40.320 and so that would trigger the build
05:56:41.820 image process from there Packer would
05:56:44.520 use some kind of provisioner like
05:56:45.780 ansible to provision the image and then
05:56:48.000 when it was done and and it was all good
05:56:50.100 it would store it summer like in Amazon
05:56:52.020 machine image once it is stored wherever
05:56:55.138 you want it to go then in terraform you
05:56:57.900 would just reference it using like a
05:56:58.980 data source and then from there you
05:57:00.900 could provision your resource okay so
05:57:03.780 Packer configures a machine via a packer
05:57:06.900 template and yes I know the E is missing
05:57:10.558 um so sorry about that but Packer
05:57:12.058 templates use the hashicorp
05:57:13.620 configuration language HCL which we saw
05:57:15.900 if you remember way earlier in the
05:57:18.298 course and that's what we're going to
05:57:19.920 review next is what that Packer template
05:57:21.540 file looks like okay
05:57:22.840 [Music]
05:57:27.780 all right so Packer configures a machine
05:57:30.240 or container via a packer template file
05:57:33.298 and Packer template uses the hashic
05:57:35.100 configuration language HCL so that's why
05:57:37.200 it looks very familiar to terraform and
05:57:39.298 a variety of other languages we've been
05:57:40.798 looking at in this course and so what
05:57:43.260 this file is doing is provisioning a
05:57:45.298 virtual machine on AWS so here you can
05:57:47.400 see that it's a TT micro and the US West
05:57:49.620 2 region that it's probably going to be
05:57:51.780 installing Apache since it's named httpd
05:57:54.020 and the way it's going to be created is
05:57:56.638 via an EBS volumes let's talk about kind
05:57:59.280 of the components that we're looking at
05:58:00.480 here so when you have a packer template
05:58:02.458 file you have to specify a source and
05:58:04.378 this says where and what kind of image
05:58:06.420 we are trying to build so the source is
05:58:08.458 Amazon EBS so it's looking for an Ami
05:58:11.820 image or it's being backed by that EBS
05:58:13.680 volume there okay in this case it's an
05:58:16.500 EBS back to Ami the image will be stored
05:58:18.958 directly in AWS under the ec2 images and
05:58:21.840 so we have the build step so the build
05:58:23.400 allows us to provide configuration
05:58:25.440 scripts Packers supports a wide range
05:58:27.780 your provisioners so we have shaft
05:58:29.760 puppet ansible power Powershell bash
05:58:32.040 salt whatever you want basically has it
05:58:34.980 and the post provisioners runs after the
05:58:37.320 image is built so they can be used to
05:58:39.120 upload artifacts or re-package them all
05:58:42.120 right and the place where this is going
05:58:44.040 to be stored is going to be on Amis okay
05:58:46.798 so there you go
05:58:48.880 [Music]
05:58:53.340 let's look at how we actually integrate
05:58:55.200 terraform and Packer together in terms
05:58:57.180 of a CI CD workflow we kind of saw this
05:58:59.280 in uh that overall graphic in the first
05:59:01.860 uh Packer slide let's just kind of look
05:59:04.260 at the code okay so to integrate Packer
05:59:06.360 there are two steps they're going to
05:59:07.378 build the image so Packer is not a
05:59:09.120 service but a development tool so you
05:59:10.980 need to manually run Packer or automate
05:59:12.540 the building of images with a build
05:59:14.400 server running Packer then the second
05:59:16.798 part of that is referencing the image so
05:59:19.020 once an image is built you can reference
05:59:21.180 reference the image as a data source so
05:59:24.240 if it's stored in Abus Ami we're going
05:59:26.040 to just Source it from there and the way
05:59:29.100 we select it is what we can do is say
05:59:31.440 okay get us the most recent one and use
05:59:34.620 this regular expression and the owner
05:59:36.840 has to be us and and those kind of
05:59:39.540 parameters to decide how to choose that
05:59:41.400 image so that's all there is to it
05:59:43.440 you're just using data sources to
05:59:44.940 reference them after they've already
05:59:46.260 been built okay
05:59:47.590 [Music]
05:59:51.660 hey this is Andrew Brown from exam Pro
05:59:53.458 and we are taking a look at using Packer
05:59:56.100 with terraform and mostly it's just
05:59:58.260 about just using Packer uh and so what I
06:00:01.558 want to accomplish here is to generate
06:00:03.298 on an image and store that onto Amazon
06:00:05.458 machine images and then load that into a
06:00:07.920 terraform file or like reference it as a
06:00:09.840 data source so I've never done this
06:00:11.700 before but it should be fun and we'll
06:00:13.500 figure this out so what we're first
06:00:15.058 going to need to do is download Packer
06:00:17.040 so notice in the top right corner we
06:00:19.200 make your way to Packer however you want
06:00:20.940 to and we'll go ahead and download and
06:00:23.580 this one is for Windows it's a binary
06:00:25.740 but we are going to be using Linux we've
06:00:28.200 done this so many times these three two
06:00:29.940 commands so I'm not going to do that
06:00:31.260 again here but if you have yet to do so
06:00:33.058 you can go and run that and so I'm going
06:00:35.340 to go ahead and install Packer and once
06:00:37.980 Packer is installed I will come back
06:00:40.080 here and we will get to it okay all
06:00:42.120 right so after a short little weight
06:00:43.138 there Packer is installed and so what I
06:00:45.360 want to do is go into my Packer folder
06:00:47.878 here and I'm just going to run Packer
06:00:49.980 and see what we get
06:00:53.520 and so we have Packer build console fix
06:00:56.458 format a knit so install missing plugins
06:00:59.040 uh it looks kind of similar to terraform
06:01:01.740 build images from a template that sounds
06:01:05.280 kind of interesting so I think the first
06:01:06.900 thing we're going to need to do is
06:01:07.920 Define ourselves a template file so I
06:01:11.458 remember I researched one and and put
06:01:14.040 one in my uh slides here so let's make
06:01:16.260 our way over there and see if we can
06:01:18.420 kind of just like use our notes here as
06:01:20.100 a reference so going down to this Packer
06:01:22.020 file let's go ahead and just write one
06:01:24.000 here uh I don't say what the name of the
06:01:27.180 Packer file is that would probably help
06:01:29.400 but I believe that they're just named as
06:01:31.020 dot HCL files so what I'm going to do
06:01:34.200 is go into this here and make a new file
06:01:38.100 and we're going to say
06:01:39.660 um
06:01:40.860 uh I guess apache.htl since we are
06:01:43.740 already very familiar with how to
06:01:44.760 install Apache that seems like the
06:01:45.958 easiest way to do it and again this is
06:01:48.120 going to be very similar looking to
06:01:50.700 terraform because it's
06:01:52.320 you know all based on HCL so we'll do a
06:01:54.900 type
06:01:57.058 string
06:01:58.860 and we are going to need some kind of
06:02:00.780 default Ami so we can go grab the one
06:02:04.020 we've been using all along here
06:02:07.138 um I think we specified it
06:02:09.958 we can just go back to count Count's
06:02:11.820 always a good one to go to
06:02:14.340 um so I just want to go and grab
06:02:18.298 where is it
06:02:20.280 um count count count where are you you
06:02:21.840 see anybody see it
06:02:29.760 I'm blanking today so I'm just going to
06:02:31.620 grab it from AWS
06:02:33.840 it's not a big deal
06:02:36.840 I'm just pulling up AWS here we're going
06:02:38.580 to make our way over to ec2
06:02:41.638 and we're going to go ahead and launch
06:02:43.920 ourselves a new server actually I could
06:02:45.958 probably grab it from the old one no
06:02:47.218 I'll launch a new one just in case you
06:02:48.840 don't see anything there that might not
06:02:49.860 be fair I'm going to go ahead and grab
06:02:51.780 that Ami ID
06:02:53.878 and I'll just move that off screen here
06:02:55.558 for a moment and we're going to place in
06:02:57.180 that am ID because I assume we want one
06:02:58.860 to override then we're going to say
06:03:00.540 locals uh app name I think the example I
06:03:04.980 wrote here is is Apache because that is
06:03:06.900 what Apache is is httpd not sure how
06:03:09.298 they came up with that name but uh
06:03:10.740 that's how they call it so we need to
06:03:13.200 provide ourselves a source so we're
06:03:15.840 going to do Amazon EBS
06:03:18.840 httpdd
06:03:22.200 notice that like the source is not
06:03:24.000 called Data it's just called Source if
06:03:25.680 we go over to the documentation here
06:03:28.378 just what I want to show you here Docs
06:03:33.660 if it ever loads
06:03:35.580 come on docs you can do it
06:03:40.740 so down below here or on the left hand
06:03:42.958 side we have sources so I believe if we
06:03:44.638 were to go over to here and go over to
06:03:47.040 Amazon Ami
06:03:49.200 someone says Amazon MI
06:03:52.500 overview
06:03:56.280 uh
06:03:58.620 builders
06:04:01.620 ec2
06:04:03.958 EBS
06:04:12.600 I'm just trying to find the same kind of
06:04:14.580 information that it has there a
06:04:16.980 it's not really doing what I want but
06:04:18.600 anyway I know that this code is correct
06:04:20.040 even though we can't seem to find this
06:04:22.020 out probably just go type in Packer EBS
06:04:25.440 Amazon EBS I really like to always refer
06:04:28.200 to the documentation when I can here so
06:04:30.420 it does say it's a builder
06:04:33.540 Amazon abs
06:04:36.180 source
06:04:41.400 down below here we go
06:04:43.980 all right so yeah
06:04:45.958 um I don't understand this uh this
06:04:47.580 Builder flag as of yet but uh we'll work
06:04:50.340 our way through here and figure it out
06:04:51.480 okay so I'm gonna go back and pull up my
06:04:54.840 vs code here
06:04:56.780 and we're gonna put curlies here
06:04:59.638 and so we need our Mi name here
06:05:02.878 so my server
06:05:05.040 uh dollar sign local
06:05:08.520 app name
06:05:10.320 instance type
06:05:12.958 T2 micro
06:05:15.980 region this is going to be us East one
06:05:19.760 Source Ami this is going to be the
06:05:23.458 variable we set up above amiid
06:05:26.638 then we are going to do SSH username
06:05:28.798 that's going to be ec2 user that's the
06:05:31.440 default that AWS always has
06:05:34.440 uc2 user
06:05:36.540 we can do some tags here not really
06:05:38.458 necessary but it's good to probably give
06:05:40.378 it a name right so we'll just say name
06:05:43.940 Apache server
06:05:48.240 and actually we could probably just do
06:05:50.280 local.app name
06:05:52.020 maybe instead
06:05:54.420 and then we have our build step here so
06:05:56.878 we're going to specify our sources and
06:05:59.520 we're going to do
06:06:03.798 source.amazon ebs.htpd
06:06:08.400 and we're going to do provisioner
06:06:11.520 Pro
06:06:13.680 visioner
06:06:16.260 shell
06:06:19.200 and then we want to provide a script
06:06:22.260 I think we can we can actually do it in
06:06:24.120 line if we didn't want to do a script
06:06:25.620 there but we know our script works so
06:06:27.600 maybe we should just stick to that so
06:06:29.040 I'm just going to call this
06:06:31.100 userdata.sh because we already have that
06:06:33.180 somewhere
06:06:34.340 before so we'll do Post process we don't
06:06:37.378 need a post processor so we just want to
06:06:39.420 run that script
06:06:40.680 um
06:06:41.400 I believe we have that in our terraform
06:06:43.138 workflow
06:06:45.120 we go over there to our workflow
06:06:47.820 wherever it is
06:06:50.878 might also be under modules if we go
06:06:52.798 into our module here
06:06:54.840 didn't we create one there called user
06:06:56.638 data
06:06:59.218 oh that's a yaml file
06:07:02.218 uh okay
06:07:04.440 um I mean that's not a big deal we could
06:07:07.440 probably just
06:07:09.600 okay so we're not going to do it that
06:07:11.400 way all right um
06:07:13.260 if we're not going to do it this way we
06:07:14.878 probably can provide inline things we
06:07:16.860 don't probably have to do script equals
06:07:18.180 so what I'm going to do is go back to
06:07:21.420 the terraform documentation here or
06:07:24.058 Packer documentation I should say
06:07:26.520 and what I want to do is look at
06:07:27.900 provisioners
06:07:29.340 we're going to go look at Shell
06:07:31.620 so it has this inline step and I assume
06:07:33.540 that this is going to run in a
06:07:34.980 sequential order so inline array of
06:07:36.660 strings
06:07:38.218 okay so what we will do here is we will
06:07:41.638 type in inline
06:07:48.540 and I've done this like a thousand times
06:07:50.280 but I'm just going to go Google it
06:07:52.620 Apache install AWS tutorial
06:07:56.580 there's probably like one on the AWS
06:07:58.200 website for it
06:08:02.160 for like user data
06:08:07.980 and this is pretty much has some of it
06:08:10.200 here I was just kind of looking for
06:08:11.820 these commands like the Yum install and
06:08:15.000 the pseudosystem start
06:08:17.100 so we're going to go ahead and grab that
06:08:21.558 and then we're going to go
06:08:28.378 and grab the next few lines here
06:08:36.000 because we want to start and enable
06:08:38.160 what's the three things that we need to
06:08:39.420 do
06:08:42.958 not complicated at all
06:08:46.740 and so what I'm going to do is type in
06:08:49.020 Packer build and see what happens now I
06:08:52.080 didn't specify Ava's credentials or
06:08:53.580 anything like that I assume it would
06:08:54.718 pick up the defaults
06:08:56.458 and we're going to go to the top here so
06:08:58.138 it looks like we have to provide the
06:08:59.160 template name so maybe we'll do Apache
06:09:02.160 HCL here
06:09:07.440 and it says
06:09:09.900 error parsing Json invalid character V
06:09:12.660 for the beginning of the value
06:09:15.000 oh so it has to be
06:09:17.600 pkr.hcl okay
06:09:22.138 I'm really liking the user experience of
06:09:24.180 the developer experience for these clis
06:09:25.500 they're really good at telling us what's
06:09:26.700 wrong with them
06:09:27.980 PKR HCL if there's like a default file I
06:09:31.920 don't know what it should be called
06:09:33.600 uh so we got a bunch of Errors which is
06:09:35.280 fine unsupported argument locals an
06:09:38.280 argument locals is not expected here did
06:09:39.718 you mean to define a Local's Block it's
06:09:41.400 because I put an equals in front of it
06:09:43.920 supposed to just be this
06:09:46.200 not that we were really using locals for
06:09:47.940 much here
06:09:54.958 and looks like it is provisioning found
06:09:57.000 in Ami it's going to use that as the The
06:09:58.680 Source One creating a temporary key pair
06:10:01.400 authorizing to Port 22
06:10:04.700 uh name Packer Builder so I don't know
06:10:08.458 if this uses I don't think it does but I
06:10:11.458 don't know if it uses Amazon uh but
06:10:14.280 because there's like ec2 Builder image
06:10:15.958 there might be a way to use it with um
06:10:18.240 Packer directly but I'm not sure how to
06:10:20.280 do that
06:10:21.120 it's going to go through here I'm just
06:10:22.620 going to see to make sure it's not
06:10:23.580 running a pipeline here is it image
06:10:26.638 Pipelines
06:10:28.200 no okay that's good but what I will do
06:10:30.600 is go over to my ec2 here
06:10:34.558 and what I want to go do okay so Packer
06:10:37.920 Builders is running as a virtual machine
06:10:39.360 so it's actually
06:10:40.920 um uh going to spin up a VM and then
06:10:43.620 bake the Ami that way which seems a lot
06:10:47.218 better
06:10:49.080 um we'll go over to our Mis and see when
06:10:50.638 that happens there
06:10:55.558 um let's just unlock another those that
06:10:57.480 red stuff doesn't look good
06:10:59.280 seems like it didn't really matter
06:11:02.760 so the thing like AWS has an entire
06:11:05.580 pipeline for ec2 image Builder but it
06:11:07.740 does cost money to run where I kind of
06:11:09.540 feel like if all Packer is doing is
06:11:12.058 spinning up a virtual machine
06:11:13.138 temporarily to make that image that's
06:11:14.580 going to be a lot more cost effective
06:11:16.558 I mean we could go look up what the cost
06:11:18.718 is to use ec2 image Builder while we're
06:11:20.820 watching this
06:11:24.058 Builder can't seem to type today
06:11:28.138 uh it's pricing I just want to know the
06:11:30.480 pricing
06:11:37.500 happy free
06:11:40.378 oh is it there's a no cost I could have
06:11:42.420 swore there was a cost for this
06:11:44.280 no cost image Builders offered at no
06:11:46.500 cost other than the cost of the
06:11:47.760 underlying AWS resource I think the
06:11:49.798 thing is that it's that when you use
06:11:53.160 um ec2 image Builder you have to use of
06:11:55.440 a particular size
06:11:58.860 you know if you don't really use AWS
06:12:00.480 anymore in Azure gcp I can understand
06:12:02.040 why this is not much of an interest but
06:12:03.540 I'm pretty sure
06:12:06.000 if I go here
06:12:12.058 that the size that you get for the image
06:12:16.378 what size of
06:12:18.360 each image does ec2 image Builder use
06:12:21.058 because I remember it was like really
06:12:22.620 really large un like unreasonably large
06:12:25.260 and that was the cost involved in it
06:12:27.600 can't find it today it's not a big deal
06:12:30.718 but waiting for the Ami to become ready
06:12:32.820 so if we go over to our Amis here and
06:12:35.580 give us a refresh we can see that it is
06:12:37.740 spinning so it is provisioning that Ami
06:12:40.920 while that is going on what we can do is
06:12:42.780 just start setting up the next part of
06:12:44.638 this so
06:12:46.798 um Within
06:12:48.360 our Packer here we can say new file and
06:12:50.878 I'm going to say main.tf I'm going to go
06:12:53.700 as per usual and grab some default codes
06:12:56.400 from our account example which is for
06:12:58.558 right here
06:13:00.600 okay copy that we're going to go all the
06:13:03.120 way down to the ground here and
06:13:06.120 going to go into the main TF here paste
06:13:08.218 that on in
06:13:09.480 and we probably want to keep the public
06:13:11.400 IP around we actually don't really care
06:13:13.138 but I'm putting it in any way I'm going
06:13:14.580 to take out the tags oh I want to leave
06:13:16.138 the name in so I'll just say like server
06:13:17.520 packer
06:13:19.200 okay server Apache packer
06:13:24.320 and
06:13:26.218 uh this is the thing that we want to
06:13:28.020 replace out this all looks fine so this
06:13:30.600 is what we need to figure out is our Ami
06:13:32.160 here it's probably going to come in as a
06:13:33.360 data source it has to come in as a data
06:13:35.458 source and I'm pretty sure that's what I
06:13:37.020 wrote
06:13:38.280 in our documentation here so yeah AWS
06:13:41.160 Ami example things like that so
06:13:43.980 what we're going to do
06:13:45.360 is Type in AWS
06:13:46.980 am I
06:13:49.200 Packer image
06:13:51.840 and we'll just Define that data source
06:13:53.820 so AWS Ami
06:13:57.180 Packer image
06:13:59.700 and we have executable users executable
06:14:03.660 users equals self
06:14:06.360 I'm not saying I know what all these
06:14:07.740 options do but like you just go to the
06:14:09.480 documentation you grab them you got
06:14:10.620 something that works true name regex
06:14:14.940 okay and so we would do something like
06:14:17.160 start with the little carrot character
06:14:19.940 and what did we name this this starts
06:14:23.218 with uh my server hyphen
06:14:26.280 probably would have helped if we named
06:14:27.958 it with like something like
06:14:29.760 packer in the name but I think that's
06:14:32.218 fine
06:14:34.440 um
06:14:36.540 we might as well might might as well go
06:14:38.520 the full name here
06:14:40.620 and say httpd because that's technically
06:14:42.540 what it's going to be
06:14:45.420 we might want to match for more values
06:14:49.020 here so
06:14:50.878 I'm not sure I guess like we do that
06:14:55.740 because sometimes it's like three digits
06:14:57.120 or whatever but I don't know what Packer
06:14:58.620 is going to do if we keep pushing
06:14:59.700 additional ones I'm not really familiar
06:15:01.558 with with that so we'll just say owner's
06:15:04.138 equals self
06:15:06.958 and so now that should be all set up to
06:15:09.360 go as that is
06:15:11.340 running it finished so that's all good
06:15:13.260 we're going to say terraform init
06:15:17.458 and here it says block definition must
06:15:20.100 have a block content Eliminator
06:15:24.420 so we have a small problem here
06:15:28.920 it looks correct to me
06:15:32.760 uh this is not right okay
06:15:38.820 we'll see if we can knit this
06:15:44.160 now whether our build image works
06:15:45.840 properly I don't know
06:15:49.500 it'd be really good to write like some
06:15:51.360 tests for it I imagine that there is
06:15:53.700 some kind of way to do that
06:15:56.520 um
06:15:57.420 I guess it'd be like the post-processor
06:15:59.218 scripts maybe you'd want to do that
06:16:00.718 where you'd want to use that as a means
06:16:03.120 for
06:16:04.500 testing
06:16:06.058 I'm not really sure obviously different
06:16:08.100 provisioners might have that kind of
06:16:10.620 stuff built in so you know it might be
06:16:12.958 just part of the provisioning tool you
06:16:14.458 can use
06:16:16.260 so it initialized here we're going to do
06:16:18.600 a terraform plan
06:16:21.780 because I'm hoping that it might
06:16:23.040 complain about the data AWS Ami here if
06:16:25.378 it does not exist properly and it did so
06:16:27.180 your Curry return no results please
06:16:28.798 change your search criteria and try
06:16:30.240 again
06:16:31.378 so however I wrote this is probably not
06:16:34.558 correct so I will just take this out
06:16:36.840 here
06:16:38.940 try this
06:16:47.160 data a to the same at Packer no results
06:16:51.240 so what I'll do is go over to
06:16:54.240 bc2 here and actually that's the only
06:16:55.980 name that's here for the Ami so I guess
06:16:59.100 I could just go here and grab the name
06:17:03.298 but maybe that's not the problem oh no
06:17:06.058 that might be fine so we'll just do this
06:17:13.920 name reg X
06:17:17.160 okay
06:17:18.540 so let's go look up data AWS Ami
06:17:26.458 ex couple users most recent name regex
06:17:29.160 owners
06:17:31.320 maybe we can just do like a filter here
06:17:34.340 a regex to apply to an analyst returned
06:17:37.558 by AWS this allows for more advanced
06:17:39.298 filtering not supported by the AWS API
06:17:41.280 this filtering is done locally on the
06:17:43.440 AWS what returns
06:17:45.558 so I suppose that is good but like I
06:17:48.958 just need it to work
06:17:51.840 so I'm going to try the filter instead
06:17:55.320 and I'm actually going to put literally
06:17:57.058 the name in my server httpd
06:18:00.660 I'm going to take out the regex assuming
06:18:02.400 that is the problem
06:18:09.058 owners itself executable users itself
06:18:12.660 um please change the criteria
06:18:16.200 I don't know what executable users users
06:18:18.298 actually does let's maybe look up what
06:18:19.680 that is limit search to users with
06:18:21.540 explicit launch permissions on the image
06:18:24.600 is that required no so let's just take
06:18:27.180 that out
06:18:30.900 if more than one there isn't so let's
06:18:33.120 just take that out for the time being
06:18:36.120 who's the owner of this
06:18:37.920 we're the owner right we have to be
06:18:40.980 honors this IP address that must be us
06:18:43.200 or sorry not IP but like our account
06:18:45.240 number
06:18:47.280 so I mean that should be fine
06:19:00.740 incorrect attribute value type
06:19:03.780 oh okay so that was fine so we'll do dot
06:19:05.940 ID
06:19:10.558 but you know if you're doing this like
06:19:12.360 if you wanted a continuous pipeline
06:19:13.740 you'd probably want to get the most
06:19:14.940 recent and have a better regex
06:19:18.958 um and so I'll do a terraform apply Auto
06:19:20.940 approve and see if this works
06:19:46.020 one thing I kind of Wonder is like with
06:19:47.760 Packer how would you do like a
06:19:49.200 versioning
06:19:56.218 because that's what I'm not certain
06:19:57.958 about so like I'm just kind of like
06:19:59.280 looking through here and seeing what
06:20:00.780 they would do for that I would imagine
06:20:03.420 that uh you're probably supposed to like
06:20:05.218 increment it and have it part of the
06:20:06.660 name
06:20:07.860 nothing's really speaking to me there
06:20:09.660 but you know like
06:20:11.218 the idea is that you want to have things
06:20:12.780 like
06:20:13.860 zero zero zero zero one zero two zero
06:20:16.980 three
06:20:18.180 but I imagine like there's some
06:20:19.620 pragmatic way maybe there's like a
06:20:20.940 built-in function or something that we
06:20:22.260 can do to do that or what you do is you
06:20:24.958 just have a variable probably that's
06:20:26.700 actually what you probably do is you'd
06:20:28.920 have like variable
06:20:30.600 like version
06:20:32.700 right
06:20:33.900 string
06:20:37.260 and then you probably set it and it
06:20:38.940 would come through that way
06:20:42.058 like you you'd set it over here it says
06:20:44.820 our server has finished provisioning
06:20:46.138 let's go C and take see if that actually
06:20:48.360 worked we'll go up to ec2 instances here
06:20:52.378 that is running
06:20:54.480 copy that
06:20:57.298 paste that in
06:21:03.540 um the security group doesn't have any
06:21:05.100 open ports right
06:21:10.920 so it probably did work it's just we
06:21:13.138 didn't create a security group with us
06:21:14.580 so there are no open ports for us to
06:21:16.320 check I'm not worried about this I don't
06:21:18.480 care if it actually did work or not
06:21:20.160 because we more or less followed all the
06:21:22.260 steps there but I believe the reason
06:21:23.760 it's not working like there is just
06:21:25.378 because we don't have a security group
06:21:26.280 but I just don't want to fiddle with
06:21:28.740 that and put it into a state so that it
06:21:30.718 does not match so anyway we're all done
06:21:33.120 here so I'm going to do a terraform
06:21:35.298 apply Auto approve
06:21:38.580 destroy
06:21:43.200 so there we go we accomplished that with
06:21:45.298 Packer that pretty much wraps up all the
06:21:47.638 main follow-ons for the course so
06:21:50.340 hopefully that was a lot of fun
06:21:52.860 um yeah we'll just continue on here
06:21:54.670 [Music]
06:21:59.100 all right so let's talk about
06:22:00.240 terraforming console because you're
06:22:01.920 going to hear console mentioned
06:22:03.058 throughout the documentation and you
06:22:05.100 might think it's critical to the exam
06:22:06.600 but it's not so I just want to make sure
06:22:08.100 we understand its relation to terraform
06:22:10.080 so console is a service networking
06:22:12.120 platform which provides service
06:22:13.320 Discovery so central registry for
06:22:15.480 services in the network it allows for
06:22:17.340 direct communication so no single point
06:22:18.958 of failure via load balancers it has a
06:22:21.000 service mesh so managing Network traffic
06:22:22.558 between Services a communication layer
06:22:24.840 on top of your container application so
06:22:26.340 think middleware it has application
06:22:28.440 configuration capabilities so console is
06:22:31.080 useful when you have a micro service or
06:22:33.718 a service oriented architecture with
06:22:35.340 hundreds of thousands of services so
06:22:37.680 these are containerized apps or
06:22:39.298 workloads and so the way console
06:22:42.420 integrates with terraform is in the
06:22:43.920 following ways it is a remote back end
06:22:45.718 because console has a key value store
06:22:48.058 and this is where you could store the
06:22:51.180 state of your terraform files then also
06:22:54.058 there's a console provider because you
06:22:56.160 can use terraform to set up some things
06:22:58.680 in console for you but there's not much
06:23:01.080 else outside of that okay
06:23:03.730 [Music]
06:23:08.820 all right we're taking a look here at
06:23:10.200 hashicor Vault so vault is a tool for
06:23:12.840 securing accessing secrets from multiple
06:23:15.480 secret data stores vault is deployed to
06:23:17.580 a server where a vault admin can
06:23:19.798 directly manage secrets and we have
06:23:21.540 operators also known as developers can
06:23:23.218 access Secrets via an API Vault provides
06:23:26.280 a unified interface to any secret such
06:23:28.558 as AWS Secrets console key values Google
06:23:30.958 Cloud KMS Azure service principles it
06:23:34.020 provides tights access control so just
06:23:37.500 in time which is reducing surface
06:23:39.660 attacks based on a range of time and
06:23:42.298 just enough privilege so reducing
06:23:43.740 surface attack by providing at least
06:23:45.420 permissive permissions we can also
06:23:48.058 record a detailed audit log so we have
06:23:50.638 tamper evidence so this is kind of the
06:23:52.680 idea of our little hash Decor fault
06:23:55.378 stack so you have your secrets engines
06:23:57.180 these are third-party services or sorry
06:23:59.400 cloud services that actually store the
06:24:01.200 secrets you have your Vault cluster
06:24:02.940 which act as the adapter to your
06:24:04.558 resources and the resources which are
06:24:06.480 going to access them so again vault is
06:24:08.820 deploy to Virtual machines in a cluster
06:24:10.920 and vaults can be backed up via snapshot
06:24:13.378 so if you do provision them and you're
06:24:15.180 worried about the state of those vaults
06:24:17.218 you can definitely save those for later
06:24:19.020 okay
06:24:20.300 [Music]
06:24:24.600 let's take a look here at terraform and
06:24:26.760 Vault how they would work together so
06:24:28.260 when a developer is working with
06:24:29.340 terraform and they need to deploy a
06:24:30.900 provider like AWS they will need AWS
06:24:33.420 credentials so AWS credentials are
06:24:35.040 long-lived meaning a user generates a
06:24:37.138 key in secret and they are usable until
06:24:39.000 they are deleted so the Abus credentials
06:24:41.040 reside on the developers local machine
06:24:42.660 and so the machine is at risk of being
06:24:45.058 compromised by malicious actors looking
06:24:47.340 to steal this credentials so if we could
06:24:49.500 provide credentials just in time expires
06:24:52.980 or credentials after a short amount of
06:24:54.480 time so short-lived we could reduce the
06:24:56.820 attack surface area of the local machine
06:24:59.100 and so this is where Vault comes in
06:25:00.780 because Vault can be used to inject
06:25:02.218 short-lived Secrets at the time of
06:25:04.620 terraform apply so imagine you are you
06:25:08.820 are the developer and you run your
06:25:11.100 terraform apply at that point in time
06:25:13.138 it's going to inject the secrets the way
06:25:15.298 we do that is via data sources data
06:25:17.878 source is always the way we get data
06:25:19.260 into our terraform configuration file
06:25:21.360 but let's look at that in Greater detail
06:25:22.980 in the next slide here okay
06:25:25.920 foreign
06:25:27.670 [Music]
06:25:29.040 let's take a look at how this Vault
06:25:30.780 injection via data source works so a
06:25:32.580 vault server is provisioned a vault
06:25:34.798 engine is configured like AWS Secrets
06:25:36.718 engine The Vault will create a machine
06:25:38.760 user for AWS fault will generate a
06:25:41.280 short-lived AWS credential for that
06:25:43.798 machine user thought we'll manage and
06:25:45.840 apply database policy and then within
06:25:47.520 our terraform we can provide a data
06:25:49.500 source to the Vault so that's what we're
06:25:51.360 doing we're saying Vault Ibis access
06:25:53.040 credentials and we are getting the
06:25:55.260 output from our terraform remote State
06:25:56.878 admin outputs backend and then from
06:26:00.120 there we can reference them into AWS
06:26:02.160 okay so when terraform applies run it
06:26:04.980 will pull short-lived credentials to be
06:26:06.660 used used for the scope of the duration
06:26:08.638 of the current run every time you run
06:26:10.558 apply you will get a new short lived
06:26:13.080 credentials which is the whole point of
06:26:14.940 the short-lived idea okay
06:26:17.610 [Music]
06:26:21.840 hey this is Andrew Brown from exam Pro
06:26:23.638 and we are taking a look at Vault
06:26:26.040 um and so the idea here is that we want
06:26:28.080 to be able to inject secrets from vault
06:26:30.480 in a secure manner for our local
06:26:32.820 developer environments I really kind of
06:26:34.740 wish I included this screenshot or this
06:26:36.900 graphic within my slides I just found it
06:26:39.298 as as of now because it does really
06:26:41.160 represent all the types of secret
06:26:42.298 engines and capabilities of Vault one
06:26:44.280 thing in particular I wasn't aware of is
06:26:45.840 that it has its own key value store so
06:26:48.958 that's what we're going to be using
06:26:50.100 we're going to keep it really simple
06:26:51.240 here
06:26:52.620 um but the first thing we're going to
06:26:53.878 have to do is go ahead and install Vault
06:26:55.798 so just down below I have a link here
06:26:57.780 that I found and we'll go down below and
06:27:01.620 it's not shouldn't be too hard to
06:27:03.420 install so
06:27:05.000 uh we are on Linux today I mean I'm on a
06:27:08.040 Windows machine but I'm using Linux
06:27:10.500 um as the windows subsystem there and so
06:27:13.798 this is where we're going to start and
06:27:15.180 grab our stuff so making my way over to
06:27:17.458 vs code whoops
06:27:19.620 um and
06:27:21.360 I'm just trying to think should we use
06:27:22.740 this for a new project probably so I'm
06:27:24.958 going to just CD out here
06:27:28.138 and I'm going to make my way into
06:27:30.860 uh vault which apparently I don't have a
06:27:33.180 folder for so I'm going to just go here
06:27:36.900 and we're going to
06:27:39.680 uh if I reveal and explore
06:27:46.558 and we'll make a new one
06:27:50.218 200 volts
06:27:53.100 okay and so
06:27:57.180 we'll start first install something then
06:27:59.100 we'll set up a project all right so
06:28:01.680 um
06:28:02.458 let's go through the installation
06:28:03.780 process here okay so we'll go do a curl
06:28:07.558 which is our first step
06:28:10.920 and that's just going to grab the gpg I
06:28:12.840 think we already have it because we did
06:28:14.100 it for probably the the CLI 4
06:28:17.718 terraform there but we'll just do it
06:28:19.558 again there it doesn't hurt I'll add the
06:28:21.180 repository again I think we already did
06:28:22.500 this when we installed the CLI in the
06:28:24.000 beginning of this course
06:28:27.000 but we'll let it go again there I
06:28:28.980 remember this takes a little bit of time
06:28:30.058 so we'll just wait here for a bit
06:28:36.298 all right so now we need to run the last
06:28:38.340 command which is actually going to go
06:28:39.780 ahead and install Vault here for us
06:28:41.580 we'll just go ahead and grab that line
06:28:43.860 and I'm going to go ahead and paste that
06:28:45.900 on in
06:28:47.700 I'm not sure if I grabbed that properly
06:28:49.200 we'll try that one more time
06:28:51.600 it uh I got my consoles on response so
06:28:54.298 there we go okay
06:28:55.740 just happens when I um I stop and start
06:28:57.900 recording it just for some reason times
06:28:59.400 out like that so I'll go ahead and hit
06:29:01.080 enter there and that will go ahead and
06:29:02.760 install our vaults and then after that
06:29:05.340 we're going to have to start getting it
06:29:06.480 running
06:29:07.260 um there is again a tutorial to inject
06:29:09.360 secrets I'm not going to stick one to
06:29:10.920 one with it because it does come with a
06:29:13.320 repository but I find that it is a
06:29:15.360 little bit more work than we want to do
06:29:16.920 here we just want to kind of get a basic
06:29:18.900 example working and I just want to make
06:29:21.000 our lives a little bit easier so I'm
06:29:22.378 just going to modify it as we go here
06:29:25.680 but uh yeah we'll just wait for that to
06:29:27.540 install I'll see you back here in a
06:29:28.920 moment okay all right so after a short
06:29:30.840 little weight here I believe that vault
06:29:33.298 is installed let's find out if it works
06:29:34.920 so we'll type in Vault
06:29:36.840 once I get the responsiveness back from
06:29:39.240 my console here just giving it a moment
06:29:41.760 great nope nope there we go Vault and so
06:29:45.298 vault is there and so what we can do is
06:29:47.100 start it up in a developer mode and I
06:29:50.100 remember from here they actually had
06:29:51.298 some pretty good instructions on the
06:29:52.980 starting of that so
06:29:56.100 um like the way they do this project and
06:29:57.900 I have the repo here is that they
06:30:00.600 um they provision Vault with a bunch of
06:30:03.840 different things so I think they're
06:30:04.920 using like S3 here and that would
06:30:06.958 probably be a really common use case for
06:30:09.480 this but I really want to simplify and I
06:30:11.580 don't want to have to provision that
06:30:13.080 terraform and cross-reference the stuff
06:30:15.360 so we're just going to simplify that so
06:30:18.058 I'm just looking for the command to
06:30:19.680 start fault because I saw a good one
06:30:21.900 here that was like vaults
06:30:25.378 um ah here it is right there so Vault
06:30:27.420 server hyphen dab that starts in the
06:30:28.980 developer mode Dev root token ID there's
06:30:31.620 something about like ceiling or
06:30:32.940 unsealing stuff I don't know what that
06:30:34.080 means but I assume that's a way of
06:30:35.160 securing the Vault but we're going to go
06:30:36.660 ahead ahead and just type that in so
06:30:38.400 we're going to go Vault server hyphen
06:30:41.760 Dev hyphen Dev root token ID and
06:30:44.700 obviously you wouldn't want to do this
06:30:45.600 for your production they call there's
06:30:46.920 education I'm just going to stick with
06:30:48.180 that to make our lives a bit easier and
06:30:49.980 so what that's going to do is start up a
06:30:51.540 vault server it is running on this port
06:30:54.000 here so I suppose we should export that
06:30:57.780 or or keep this because we'll probably
06:30:59.638 have to reference it somehow notice we
06:31:01.980 have this like unsealed key so the
06:31:03.420 unsealed key and root token are
06:31:04.620 displayed Below in case you want to seal
06:31:06.240 or re-authenticate
06:31:08.520 um developments should not be used in
06:31:09.660 production so what I'm going to do
06:31:11.878 is I'm just going to create a
06:31:14.820 uh uh a readme file in our vault here so
06:31:20.160 we'll just say new file read me because
06:31:22.138 I just want to dump this stuff of course
06:31:23.760 you know you should not share these with
06:31:25.558 anybody but I just don't want to forget
06:31:27.298 these while we're working through this
06:31:29.638 so I'm going to go ahead and copy that
06:31:32.400 and we will go ahead and save that
06:31:35.000 and
06:31:36.600 so
06:31:38.878 what I want to do now oops
06:31:41.218 did we lose our terminal
06:31:44.100 did I close it
06:31:46.500 okay I must have closed it so which one
06:31:49.138 were we working in second third one
06:31:51.420 which is it
06:31:53.180 fourth okay it's the third one so
06:31:56.040 don't be like me close out your old one
06:31:57.900 so I'm just gonna close out these old
06:31:58.980 ones so I'm less confused
06:32:02.458 there we go and so it says that it
06:32:04.680 started on this address here so I'm
06:32:06.900 gonna go copy that address
06:32:08.878 and we're going to open this up you can
06:32:10.980 do everything via the CLI
06:32:14.340 uh I just want to
06:32:17.340 copy that there
06:32:19.020 but they have a nice UI which is nice
06:32:20.878 and so this is where we're going to put
06:32:21.958 that token education and drop that down
06:32:24.540 so there are some other options where
06:32:26.160 there's a lot of options for
06:32:27.360 authenticating but token is obviously
06:32:29.280 the easiest probably not the most secure
06:32:30.900 because the way we wrote it and notice
06:32:32.940 that we have a couple things
06:32:33.958 pre-installed so we have cubbyhole which
06:32:36.298 is a per token private secret storage
06:32:38.580 and then we have key value secret
06:32:40.920 storage again I don't know much about
06:32:42.600 these because this isn't a um
06:32:45.180 this isn't a course on vault it's just
06:32:47.520 kind of us showing a basic integration
06:32:49.558 and more focus on the terraform side but
06:32:51.298 here is where we can create our secrets
06:32:52.798 we can of course use the CLI to do that
06:32:55.740 and I think they showed in the getting
06:32:57.600 started here
06:32:59.400 and we don't have to do it this way I'd
06:33:02.040 rather do it through your eye but you do
06:33:03.360 like vault key key V put and then you
06:33:06.480 put the name of your secret so here's
06:33:08.218 secret forward slash hello and then the
06:33:10.200 key and the value that's where the store
06:33:11.820 I assume that this would go to the well
06:33:13.740 this would specify we're using here so
06:33:16.020 what we'll do is we'll go over here
06:33:18.180 and we'll create ourselves a new secret
06:33:19.620 because we're going to want to store
06:33:20.520 something here so we want the path for
06:33:22.020 the secret
06:33:23.040 this is pretty common with um if you've
06:33:25.138 ever used parameter store you have a
06:33:27.600 path
06:33:28.440 I don't know if it starts with a forward
06:33:29.760 slash
06:33:30.840 may not end in a forward slash probably
06:33:32.400 can begin with it so I'm going to say
06:33:33.420 AWS key because we'll do the key in the
06:33:36.600 secret right so here
06:33:39.240 oh okay cool cool so we can do forward
06:33:41.280 slash AWS and then down below I would
06:33:44.160 just add another one
06:33:45.660 maybe I got to add each one at a time so
06:33:47.520 we'll say key
06:33:49.378 and I'll actually go grab our proper
06:33:51.660 ones
06:33:53.760 um oh I should have stopped that I'm
06:33:55.440 going to
06:33:56.760 start that up again
06:33:58.260 okay and we'll add a plus there because
06:34:00.900 everything lives in memory when you're
06:34:02.340 in the dev one so you really don't want
06:34:04.020 to shut that down or you'll have to redo
06:34:05.340 all this from scratch so what I'm going
06:34:07.260 to do is just go back
06:34:09.780 here and drag this down a little bit
06:34:12.000 more
06:34:14.040 okay and I'm just gonna go see if I have
06:34:16.200 to re-log in because I might have messed
06:34:17.520 this all up
06:34:19.440 yes I do so we'll type in education so
06:34:21.718 we really don't want to stop running
06:34:22.798 that server during the duration of this
06:34:25.260 follow along okay and so we'll go back
06:34:28.440 into secret here create a secret
06:34:31.680 forward slash AWS
06:34:33.980 uh what do you want is it Json no I
06:34:36.480 don't think it matters
06:34:37.920 if we can add two keys that's all that
06:34:39.420 matters to me and so what I'm going to
06:34:41.520 do
06:34:42.360 is cat out
06:34:45.120 credentials of course this is not the
06:34:46.798 secure way of doing it so you know again
06:34:48.240 don't show people these things and so I
06:34:50.940 want this and I probably should match
06:34:52.080 the name
06:34:53.458 I'm gonna like type in the whole darn
06:34:54.840 thing
06:34:56.580 and we'll grab this
06:34:59.580 oops
06:35:01.080 I want to see that value is correct good
06:35:03.000 we're going to add another one here this
06:35:04.860 is going to be our axis Secrets or axis
06:35:08.100 secret access key I really don't like
06:35:09.840 how those have been named and we'll go
06:35:11.760 ahead and grab on this
06:35:17.280 and
06:35:18.900 um I mean we don't really need to really
06:35:20.760 store the region here but why not
06:35:22.320 because we're doing all the rest to here
06:35:23.820 we might as well just throw them all in
06:35:25.200 here
06:35:27.298 for fun
06:35:30.180 and uh here it says maximum number of
06:35:32.940 versions I don't need anything beyond
06:35:35.218 one because we're not going to be
06:35:36.958 updating these
06:35:38.400 um require check and set so rights will
06:35:40.860 only be allowed if the keys current
06:35:42.540 version matches the version specified in
06:35:44.580 the cas parameter not sure what that
06:35:46.680 means maybe just like you're passing
06:35:47.940 something along when you are doing
06:35:49.260 something but uh I think this is all
06:35:51.540 good
06:35:52.440 you know what I'm just going to leave
06:35:53.638 that back to 10 just in case I've made a
06:35:55.320 mistake and we have to go debug that I'm
06:35:56.638 going to go hit save and so there are
06:35:58.860 secrets
06:36:00.718 um and so what we want to do is be able
06:36:03.000 to access them and so maybe this is our
06:36:05.700 opportunity to learn the CLI here a bit
06:36:07.558 so I have it pulled up on the left hand
06:36:09.480 side and so what I'm going to do is type
06:36:10.798 in vault key V get and we'll do AWS I
06:36:15.120 don't know if we can start with the
06:36:15.780 forward slash there I'm going to hit
06:36:17.218 enter
06:36:19.160 and
06:36:20.878 um the server gave an HTTP response to
06:36:22.680 an https client
06:36:24.600 so I'm not sure
06:36:28.020 why that's a problem because
06:36:30.900 like I mean I understand that it started
06:36:32.638 up in HT http
06:36:34.980 but I mean I'm in development so you
06:36:37.620 know what else am I going to really do
06:36:38.878 here
06:36:39.780 let's see if I can just scroll up here
06:36:41.218 and if there's anything else
06:36:44.638 um
06:36:45.540 hmm
06:36:48.540 and I could have swore that it installed
06:36:50.280 a private key as we were doing this
06:36:51.660 because I remember seeing that there
06:36:54.840 was like a private key
06:37:00.240 I could have swore there was one
06:37:01.500 something but private key
06:37:03.298 so I'm not sure what the problem is here
06:37:05.040 I'll be back in a moment and I will
06:37:07.020 resolve it okay
06:37:08.878 so the suggestion I'm getting is that we
06:37:11.638 need to
06:37:12.780 um export a couple of environment
06:37:14.940 variables
06:37:16.080 so see here where it writes this so we
06:37:18.000 say you need to set the following so
06:37:20.280 maybe we will go through and set those
06:37:22.740 so I'll go grab that there but here's
06:37:25.320 the thing is like how do I run that
06:37:29.638 because these are I think these are like
06:37:32.878 not the same so I mean I can't run it
06:37:34.980 over here can I
06:37:36.540 I don't think so
06:37:38.940 uh well I guess if we're doing key Vault
06:37:41.040 value there maybe we can
06:37:45.360 um still no good what if we export The
06:37:48.260 Vault token
06:37:51.058 I think we said it was education here
06:37:55.500 um
06:37:59.520 let's do Vault status
06:38:04.378 so yeah I'm not sure how we're going to
06:38:05.700 do it that way I mean it's not a really
06:38:07.440 big deal because I don't think that we
06:38:09.298 have to access it that way but notice
06:38:10.740 here like as I was reading here you know
06:38:15.360 they're just saying down below oh we had
06:38:17.400 to set this and that so I'm not really
06:38:20.100 sure
06:38:23.040 what I would do here so the output is
06:38:25.320 like this
06:38:26.700 run these commands and it should do it
06:38:28.378 again the error message can be similar
06:38:30.298 to different problems so that or maybe
06:38:32.458 I'm just specifying the key incorrectly
06:38:33.958 and that's why it doesn't like it so
06:38:36.250 [Music]
06:38:37.680 um
06:38:38.340 let's just type in Vault and see what we
06:38:39.840 have here so Vault QV
06:38:42.058 maybe if we do like a list can we get a
06:38:43.740 list
06:38:45.600 list the secrets
06:38:49.500 um AWS
06:38:51.298 AWS
06:38:53.760 clear
06:38:57.958 I'm not sure what parameter it wants
06:38:59.580 there
06:39:01.798 uh let's go look it up so let's say like
06:39:04.740 tariff or was it vault key V list option
06:39:11.520 seems to want another parameter here
06:39:13.860 I'm going to scroll on down so Secret
06:39:17.580 forward slash my app
06:39:22.260 um folders are suffixed with the forward
06:39:24.180 slash the input must be a folder list of
06:39:26.820 a file will not return
06:39:29.878 um do I have to put Secret in front of
06:39:31.980 it
06:39:33.360 Secret
06:39:38.040 AWS
06:39:40.680 no so I don't know what the issue is
06:39:42.958 there I just would have been nice to use
06:39:44.820 it via the CLI but the thing is is that
06:39:46.860 again we don't need to use it that way
06:39:48.420 we just need to
06:39:50.700 um you know set it and and get it but I
06:39:53.160 thought it would be fun to kind of see a
06:39:54.718 lie there so now that we have those set
06:39:57.780 the way we're going to extract out these
06:40:00.000 values is by using a data source and so
06:40:03.840 what I want to do is just create a new
06:40:06.000 local project and I think we'd like to
06:40:08.218 always pull from our account repo here
06:40:09.718 so I'm going to go all the way up to
06:40:10.860 here and I'm going to go grab the main
06:40:12.980 and I'm just going to copy the contents
06:40:15.420 there we're going to go all the way down
06:40:17.218 to the ground and we're going to make a
06:40:20.280 new
06:40:21.600 main TF file here
06:40:24.000 we're gonna go paste that on in
06:40:27.180 and uh we just want my server
06:40:31.138 we don't need an output it's fine
06:40:33.840 this is all fine this is all fine but uh
06:40:36.718 the one thing is we don't want to use
06:40:38.040 our particular provider there so what
06:40:39.540 I'm going to do
06:40:41.520 um is I'm going to just open up our
06:40:47.520 credentials file there
06:40:51.840 and I'm just going to change this to
06:40:53.218 something else like other so that it
06:40:55.200 doesn't load that profile there
06:40:57.600 okay I just
06:40:59.520 take these out of here
06:41:02.820 um I think we can leave that alone
06:41:05.580 and I think that's everything so what I
06:41:08.820 want to do now we don't need that count
06:41:10.138 we'll get rid of that count
06:41:12.958 we'll go check out the documentation or
06:41:15.660 the code base here
06:41:17.940 because it gives us a bit of an idea how
06:41:19.620 we need to implement this
06:41:21.298 we'll go over the operator
06:41:23.400 we'll go over to the main
06:41:26.280 and so they're setting some variables
06:41:27.780 here like name region path things like
06:41:29.638 that but again we want to grab it from
06:41:31.080 The Source there actually
06:41:33.200 cross-referencing it like this other
06:41:35.160 they provision the admin and grabbing it
06:41:36.840 that way I don't want to do it that way
06:41:38.160 I wanted to use just the data source
06:41:39.958 like this
06:41:41.218 so
06:41:43.920 I'm not sure how that's going to work so
06:41:46.020 let's go look that up
06:41:54.600 okay so here it says read it was
06:41:56.458 credentials from an AWS secret back end
06:41:59.100 and I'm not trying to do that I'm just
06:42:01.080 trying to read them from the key vaults
06:42:03.660 okay so we probably want faults
06:42:09.298 generic secret would this be from Key
06:42:11.940 vault
06:42:15.298 this resource is primarily intended to
06:42:17.340 be used with the generic secret back end
06:42:18.840 but it is also compatible with any Vault
06:42:20.700 endpoint that is provided
06:42:23.700 but is that the key value one that's not
06:42:26.940 clear to me
06:42:30.240 um so I think it is
06:42:33.058 so let's see if we can figure that out
06:42:34.860 here so I'm just going to move that off
06:42:36.000 screen here
06:42:37.500 and we're going to add ourselves the
06:42:39.420 data source so I guess we're really not
06:42:40.980 following the other tutorial at all
06:42:42.180 because it we literally have to use a
06:42:43.980 different
06:42:44.700 um
06:42:45.718 key value there a
06:42:47.940 so we'll say secrets and this is going
06:42:50.340 to be like AWS
06:42:52.920 credentials Maybe
06:42:55.440 there's creds they don't have to worry
06:42:57.180 about spelling mistakes and we need to
06:42:59.280 specify a path notice it always starts
06:43:01.260 with like secret I don't know if we
06:43:02.878 always have to start it with secret so I
06:43:05.580 will just say AWS here
06:43:08.058 and there might be some additional
06:43:10.260 options I'm just scrolling through to
06:43:11.458 hear that so you have paths so this is
06:43:14.340 the fully the full logical path from
06:43:16.440 which to request the data to read data
06:43:18.240 from generic secret back in Mountain
06:43:19.680 Vault by default this should be prefix
06:43:21.360 with secret forward slash so we do have
06:43:22.980 to do that reading from other back ends
06:43:25.260 as data sources possible consult each
06:43:27.180 back-end documentation to see which
06:43:28.680 endpoint supports the get version
06:43:31.080 version of the secret to read we only
06:43:33.420 have a single version so we don't have
06:43:35.400 to specify that so technically that
06:43:38.218 should be correct
06:43:40.138 so what we will want to do now in our
06:43:42.058 provider is specify all those options
06:43:44.458 so again I'm just going back to the
06:43:46.440 source code this is off screen but we
06:43:48.958 need to set the region the access key
06:43:52.860 and the secret key here
06:43:56.458 and so this is going to be data and it's
06:43:59.458 going to be
06:44:01.200 Vault generic Secret
06:44:04.820 and I guess it would be AWS
06:44:09.360 and then we're accessing those things
06:44:10.920 like region
06:44:13.020 and so I'm going to go ahead and just
06:44:14.458 copy that really quickly
06:44:20.820 and we will go over back to our vault
06:44:23.340 here because the names are over here
06:44:25.860 so go grab that paste that in there
06:44:29.400 we'll go grab that paste that in there
06:44:33.540 and I'm just going to double check to
06:44:35.700 make sure if I've made any mistakes
06:44:39.000 this one it's showing it from the admin
06:44:41.160 so it goes admin outputs but we're not
06:44:42.660 outputting from anything we're just
06:44:43.920 grabbing it from uh the Vault there so
06:44:46.860 maybe what we need to do is just kind of
06:44:48.360 review
06:44:49.500 how this generic fault works
06:44:52.500 so this does Data Vault generic and then
06:44:55.558 it does data and then Square braces
06:45:00.320 so I wonder if we always have to do data
06:45:03.360 so for example The Vault there is a a
06:45:05.760 key named auth token the value is a
06:45:07.500 token that we need to keep Secret
06:45:09.958 but yeah I don't understand is this a
06:45:11.580 Json object or just a way of referencing
06:45:13.138 it because it doesn't specify that so
06:45:15.480 we'll just give it a try
06:45:17.700 nothing hurts with trying right so we'll
06:45:19.378 say data
06:45:21.058 and this might again might not be the
06:45:22.620 right way I don't know if it's single or
06:45:24.058 doubles there it's doubles
06:45:27.058 so I just wonder if that was like the
06:45:28.378 one case where it's doubles
06:45:34.200 okay and we will do this
06:45:38.160 and so I think that that should
06:45:40.680 maybe work
06:45:42.240 don't know
06:45:43.440 what I'm wondering is if I if I live
06:45:45.298 with a forward slash would it have
06:45:46.558 considered that and or is it now double
06:45:49.020 but I don't think so because look here
06:45:50.940 it looks like it's stripped it out
06:45:52.020 because it just says AWS here so we got
06:45:53.580 a secret since just AWS
06:45:55.620 almost looks like there's a space in the
06:45:57.180 front of it eh
06:45:58.740 but it's not there so maybe there's not
06:46:00.660 this is kind of like a little glitch so
06:46:04.620 um
06:46:05.700 we need to go and CD into this directory
06:46:08.160 here
06:46:09.660 and we just need to do a terraforming
06:46:11.760 knit
06:46:13.740 that's kind of interesting because like
06:46:15.120 we haven't set up the provider
06:46:17.100 I guess it's not going to happen until
06:46:18.180 we actually use the provider so maybe
06:46:19.378 it's not an issue just yet
06:46:23.700 I'm curious to see if it pulls any kind
06:46:25.200 of modules in for the vault generic
06:46:26.580 Secret
06:46:29.160 so we'll just give it a moment there to
06:46:30.600 initialize
06:46:38.580 okay so after there we can see that it
06:46:40.378 did actually add vault in so it must be
06:46:42.420 ready to take it from there
06:46:45.600 um I'm going to do a terraform plan here
06:46:48.298 and you know I'm going to just change
06:46:49.500 this to like my server with vaults
06:46:53.100 now remember it's not going to be able
06:46:54.360 to pull from the um
06:46:58.138 from our local credentials because we're
06:46:59.638 not setting a profile and we overroad
06:47:01.138 the default just in case
06:47:02.760 so here it's saying a resource a data
06:47:04.920 resource Vault generic secret AWS has
06:47:07.020 not been declared in the root module
06:47:09.478 um it hasn't I mean it looks like I did
06:47:12.718 no maybe I typed it wrong so we'll go
06:47:16.978 here I don't think it matters but I'll
06:47:20.400 just put it above
06:47:21.840 okay and I'm just going to double check
06:47:24.360 to make sure nope it matches oh because
06:47:26.520 it's eight of his creds that's fair
06:47:47.160 um you didn't use the option o that's
06:47:48.540 fine so my question will be will this
06:47:50.820 correctly provision because we will not
06:47:52.860 know until we uh use this right here I
06:47:56.700 suppose if we try to use a data source
06:47:59.040 for AWS that would probably also
06:48:01.080 indicate whether it's working or not so
06:48:02.820 maybe we should try doing that
06:48:04.558 we do like data AWS VPC
06:48:08.878 and then we just do like ID equals here
06:48:12.020 because that would have to use the
06:48:13.920 credentials right
06:48:15.958 and so we'll just go well that's
06:48:18.478 actually it's not specifying any of the
06:48:20.580 the VPC here so maybe maybe we won't do
06:48:23.218 that because it's just too much work
06:48:25.860 um so what I'll do here
06:48:28.440 is I'm going to do a terraform apply
06:48:31.558 Auto approve
06:48:33.660 and Let's cross our fingers and hope
06:48:35.700 this works
06:48:43.558 and while that is running what I'm going
06:48:45.478 to do is just pull up my AWS environment
06:48:47.218 here
06:48:56.280 and apparently I'm not logged in so
06:48:58.080 that'll give me a bit of time here to
06:48:59.638 kind of catch up here while this is
06:49:00.900 provisioning there
06:49:19.920 and so it looks like it actually
06:49:21.600 provisioned the server and if that's the
06:49:22.978 case that means that our secrets are
06:49:24.360 being pulled correctly right so if we go
06:49:26.638 over to ec2 here
06:49:32.940 and we go and check out this instance it
06:49:35.940 is running so it worked
06:49:38.520 um if we just want to do a sanity check
06:49:40.020 to make sure it absolutely is working we
06:49:41.638 can just introduce a bug into this
06:49:43.620 so maybe we go here and we just say
06:49:48.360 uh um I guess we'd have to make a new
06:49:50.700 version create a new version and what
06:49:52.558 I'm going to do is purposely introduce
06:49:53.700 some mistakes so we're just going to put
06:49:54.840 like an at sign here on the end we're
06:49:56.340 going to save that and I'm going to make
06:49:59.160 a minor change like Nano
06:50:01.860 and so what I'm expecting is for this to
06:50:04.080 fail let's see if it fails on the plan I
06:50:05.940 don't think it will
06:50:10.978 give it a fail in the apply and it does
06:50:13.260 okay so the plan would tell us whether
06:50:14.820 it didn't work or not so that clearly uh
06:50:17.638 clearly means it absolutely is pulling
06:50:19.378 from it especially when we're doing the
06:50:20.638 plan
06:50:21.600 so
06:50:24.000 um I want to go back to
06:50:26.700 our file there I just kind of lost the
06:50:28.740 folder I'm just looking for it the I got
06:50:31.080 too many um too many Chrome windows open
06:50:33.420 here
06:50:35.040 there it is okay so we'll go back here
06:50:37.320 and we'll
06:50:39.120 I wonder if we can just revert back to
06:50:40.680 the previous version
06:50:44.280 um see I don't know if I would delete
06:50:45.718 there I don't want to I don't want to
06:50:47.280 jinx it so I'm just going to go here
06:50:50.160 and take out that at sign we're going to
06:50:52.500 go ahead and save that and so that
06:50:53.700 should be updated we're going to do
06:50:54.780 terraform plan
06:51:04.200 great and so what I want to do is just
06:51:06.000 tear this down so we'll say terraform
06:51:08.340 apply Auto approve and Destroy okay and
06:51:13.440 while that is destroying I'm pretty
06:51:14.940 pretty confident that's going to work
06:51:16.378 I'm going to stop my Vault server oh
06:51:18.420 wait
06:51:19.920 is that going to still work did I get
06:51:21.298 the credentials in time
06:51:22.920 oh no I I made a big boo-boo okay so
06:51:27.900 um
06:51:28.798 I I Killed My Vault server before I was
06:51:31.378 supposed to
06:51:34.378 that's really embarrassing
06:51:36.360 um anyway that's not a big deal because
06:51:37.860 I kind of wanted to stop the server
06:51:39.360 anyway
06:51:40.920 but I want to go back into our it was
06:51:42.958 credentials there and turn that back to
06:51:45.540 defaults
06:51:46.978 and I wanted to go back up here and just
06:51:48.780 flip that back so that we can get rid of
06:51:50.280 the server right so I don't want to kind
06:51:52.978 of lose these for the tutorial so I'm
06:51:54.718 just going to go here and just comment
06:51:56.160 those out for a second
06:51:58.680 profile defaults
06:52:02.458 oops
06:52:04.860 region
06:52:06.478 Us East one
06:52:09.478 and
06:52:10.978 um we'll do that again that's
06:52:12.660 embarrassing
06:52:19.558 okay and I'm just going to preemptively
06:52:21.120 I'm not going to save this file but I'm
06:52:22.558 just going to do this for now
06:52:26.400 um it's still trying to connect
06:52:28.920 oh boy
06:52:32.700 so
06:52:35.878 just put these back in here
06:52:39.718 because it's set to the Vault can I do a
06:52:41.760 terraform refresh probably not
06:52:46.020 no probably not what if I do a
06:52:48.180 terraforming net because I did change
06:52:49.798 like I was using Vault so maybe I just
06:52:51.478 have to do that to fix that problem
06:52:54.680 and let's try destroy again
06:53:03.120 that was a big boo-boo on my part eh
06:53:06.660 nope okay so let's go back over here
06:53:11.580 and start it up again and I'm pretty
06:53:14.340 sure there's like a way to back up your
06:53:16.200 vaults like there's probably some kind
06:53:17.400 of like snapshot or something
06:53:19.020 um again I'm not that uh deep into it so
06:53:21.478 I cannot tell you if that's the case
06:53:24.478 um so I guess we'll just go back here
06:53:26.458 and remake our secrets
06:53:30.360 because it shouldn't have persisted
06:53:31.740 right
06:53:33.180 if it did I'd be so happy
06:53:35.820 nope okay
06:53:38.240 AWS we'll leave 10 in there and then
06:53:41.040 we'll just have to copy all this stuff
06:53:42.600 over again because of my
06:53:44.520 bonehead mistake there so we have region
06:53:48.360 which is Us East one
06:53:52.740 U.S east one here
06:53:56.458 and uh
06:54:03.660 go over here
06:54:09.540 well at least you know what to do if
06:54:11.100 that happens to you okay
06:54:13.860 I don't need the uh equal sign there
06:54:18.540 go ahead and add this one
06:54:36.298 okay and what we're going to do is go
06:54:38.160 ahead and save that
06:54:41.340 and we'll just quit out of that we'll do
06:54:43.138 a terraform plan
06:54:47.040 since we know that that will pick it up
06:54:48.540 right
06:54:54.798 and uh we'll do terraform apply Auto
06:54:57.660 approve destroy
06:55:00.420 Okay so
06:55:02.160 again this only applies to development
06:55:03.780 but uh yeah don't kill your Vault server
06:55:06.120 before you're done destroying okay
06:55:08.218 so I'll see you back here in a moment
06:55:10.920 all right so that infrastructure is
06:55:12.780 destroyed we can go back to here and
06:55:14.458 then we can stop our server and for your
06:55:16.378 benefit I'm just going to bring back
06:55:18.000 these in here
06:55:19.500 so you don't have to worry about that
06:55:21.058 and uh yeah we uh we accomplished Vault
06:55:24.058 for injections now you might say well
06:55:25.798 how would you do this with terraform
06:55:27.420 Cloud well the thing is is that
06:55:28.860 terraform Cloud already uses
06:55:30.840 uh Vault Under the Hood when you store
06:55:32.700 your environment variables there and the
06:55:34.320 idea is that uh I suppose you don't need
06:55:36.780 to pull them in from all those sources
06:55:38.280 but I think that was one of my my
06:55:40.138 questions I had when I was talking to
06:55:41.520 one of the DA's which was like okay it's
06:55:43.740 great that terraform cloud has
06:55:46.260 um uh you know uses behind the scenes
06:55:48.360 but what if I want that to live
06:55:49.620 somewhere else but maybe that's not
06:55:51.900 really necessary
06:55:53.400 um because I don't know but yeah that's
06:55:55.680 it so we're all done with vaults
06:56:00.958 hey this is Andrew Brown from exam Pro
06:56:02.820 and we are taking a look at Atlantis
06:56:04.320 which is an open source developer tool
06:56:05.878 to automate terraform pull requests
06:56:07.500 which you can find at run atlantis.io so
06:56:09.900 the idea is once this is installed on
06:56:11.580 your GitHub and you merge a pull request
06:56:13.978 then it's going to go ahead and do a
06:56:16.620 terraform apply so this would be a way
06:56:18.298 for you to do
06:56:20.160 um get Ops or to automate your uh your
06:56:23.820 infrastructure as code and the
06:56:25.920 interesting thing is that hashicorp
06:56:27.600 actually maintains this project they
06:56:29.760 didn't originally build it was built by
06:56:31.260 two people from another company and it
06:56:33.780 wasn't that they did not want to use
06:56:35.100 terraform Cloud which can do this but at
06:56:38.520 the time I think they had a hard time at
06:56:40.080 the company getting procurement because
06:56:41.458 it was a very large company and so they
06:56:44.100 had to build something so they built out
06:56:45.780 this thing
06:56:46.820 and anyway these two people end up
06:56:49.138 getting hired by hashicorp and hashicorp
06:56:50.940 maintains this project which is really
06:56:52.558 nice because it is an alternative for
06:56:54.600 terraform Cloud
06:56:56.280 um but uh yeah that's all
06:56:59.100 foreign
06:57:01.260 [Music]
06:57:02.458 let's take a look at cdk for terraform
06:57:04.798 and so to understand this we need to
06:57:06.718 First understand what is cdk so AWS
06:57:09.058 Cloud development kit is an imperative
06:57:11.040 infrastructure as code tool with sdks
06:57:13.680 for your favorite language so the idea
06:57:15.780 is that you can use something like
06:57:16.920 typescript python Java c-sharp go and
06:57:20.100 Ruby Ruby's definitely there that's the
06:57:22.020 language I like to use AWS cdk is
06:57:24.420 intended only for AWS Cloud resources
06:57:26.540 because cdk generates a cloud formation
06:57:29.340 so CFN templates this is known as
06:57:31.558 synthesizing and uses that for IAC but
06:57:34.740 cdk for terraform is a standalone
06:57:36.600 project by hashicorp that allows you to
06:57:38.218 use cdk but instead of CFN templates it
06:57:40.680 generates out it's going to generate
06:57:41.878 terraform templates and so basically
06:57:43.920 anything terraform can do you can do it
06:57:45.958 through cdk and that allows you to do
06:57:48.540 interesting things like use cdk to
06:57:51.360 provision Azure resources so that is
06:57:53.940 very interesting uh and a great
06:57:56.400 development that I think that they're
06:57:57.478 doing
06:57:58.110 [Music]
06:58:02.520 hey this is Andrew Brown from exam Pro
06:58:04.558 and we are taking a look at grunt work
06:58:06.120 which is a software company that builds
06:58:07.680 devops tools that extends or leverages
06:58:09.420 terraform the reason we're talking about
06:58:11.100 them is that they produce a couple of
06:58:13.500 very popular open source tools that work
06:58:15.420 with terraform and you're going to see
06:58:16.798 their name because
06:58:18.360 um uh you know the co-founders there are
06:58:19.920 very active in the community uh Jim has
06:58:22.260 wrote in a really good book on terraform
06:58:24.298 so you know it's no surprise that uh
06:58:26.580 they are present but it's worth giving
06:58:28.138 them a mention so you know who they are
06:58:29.458 uh the first thing I want to mention is
06:58:31.138 the infrastructure is the code Library
06:58:32.458 so these are a bunch of reusable battle
06:58:34.558 tested production ready infrastructure
06:58:36.058 code for AWS gcp Azure
06:58:38.700 um and so they have some free ones there
06:58:40.620 and some paid ones there then there's
06:58:42.540 teragram so a thin wrapper that provides
06:58:44.580 extra tools for keeping your
06:58:45.718 configurations dry we have terror tests
06:58:48.180 a testing framework for infrastructure
06:58:49.620 provisioned with terraform we have grunt
06:58:52.080 work Landing zones for AWS this is a
06:58:54.478 multi-count security on AWS we have
06:58:56.400 grunt work pipelines and then there's
06:58:58.260 the grunt work reference architecture
06:59:00.298 and so where we're going to focus our
06:59:02.218 attention in here is just on Terra Grunt
06:59:04.378 and Terra tasks because those are things
06:59:06.840 I think are essential to know if you are
06:59:09.240 using terraform because you know you'll
06:59:10.920 run into those use cases where you might
06:59:12.180 want to use them okay
06:59:13.530 [Music]
06:59:18.360 all right let's take a look here at
06:59:19.740 teragram so this is a thin wrapper for
06:59:21.780 terraform that provides extra tools for
06:59:23.760 keeping your configuration dry working
06:59:25.620 with multiple terraform modules managing
06:59:27.900 remote State and this is accessible to
06:59:30.058 tariff Terra
06:59:31.638 grunt.gruntwork.io so the idea here is
06:59:34.620 the concept of don't repeat yourself so
06:59:36.360 it's a programming methodology to
06:59:38.040 abstract repeated code into functions
06:59:40.138 and modules or libraries and often in
06:59:42.180 isolate files to reduce code complexity
06:59:44.040 efforts and errors so the way that works
06:59:46.260 is that you'll see these HCL files which
06:59:48.360 are the Terra grunt code and they're
06:59:50.760 actually named Terra grant.hcl and
06:59:52.740 that's what's going to be used to
06:59:54.378 abstract away or dry up your terraform
06:59:58.260 files so here is an example of Terror
07:00:01.080 run now Terra Grant does a lot of
07:00:02.580 different things and you're going to
07:00:05.360 find its use when you actually use
07:00:07.320 terraform and practice and you run into
07:00:08.820 these limitations in terraform and you
07:00:11.700 go and I wish there was a way around it
07:00:13.020 integrine like almost always solves that
07:00:15.420 and so one example is being able to
07:00:17.940 generate rate Dynamic providers and I
07:00:20.940 don't mean like Dynamic values here in
07:00:22.920 the sense that there's that Dynamic
07:00:24.600 value feature of terraform but I just
07:00:27.058 mean the fact that at the time of this
07:00:29.100 it's very hard to inject or to write out
07:00:33.120 providers so they have this generate
07:00:35.218 function that allows you to get around
07:00:36.840 that
07:00:37.860 another really interesting thing is that
07:00:39.600 Terra grunt supports better granular
07:00:41.940 literary for modules by reducing lots of
07:00:44.700 boilerplate uh the way they do this is
07:00:47.100 is that you are referencing your
07:00:48.540 terraform files uh via the source here
07:00:50.638 okay so you're not including your
07:00:52.860 modules within your code you're just
07:00:54.478 referencing them and then you pass along
07:00:56.218 their inputs and this is going to be
07:00:58.378 very important when we look at wanting
07:01:00.840 to write unit tests for your
07:01:01.860 infrastructure because when you learn
07:01:03.958 about how you test IAC you have to
07:01:06.420 really break things down into smaller
07:01:07.978 parts and if you have a lot of friction
07:01:09.478 there it's going to make your team not
07:01:11.520 want to adopt that or it's going to make
07:01:13.860 that process really slow but again this
07:01:16.320 is more like at scale or when you hit
07:01:17.760 these kind of requirements okay
07:01:19.920 oh
07:01:23.210 [Music]
07:01:24.660 all right let's take a look here at
07:01:26.100 testing and terraform and so what we
07:01:27.600 have here on the left hand side is our
07:01:29.100 usual
07:01:30.240 um pyramid that tells us the layers of
07:01:32.340 testing and so I kind of want to walk
07:01:34.320 through the layers there and talk about
07:01:36.000 a bit of the tools that are available to
07:01:38.040 the terraform community and you know the
07:01:40.440 reason why we want to move up the
07:01:41.700 pyramid here to get uh better tests and
07:01:44.040 then we'll take a look at Terra test so
07:01:45.360 at the bottom we have static analysis
07:01:47.100 and this is where you test your code
07:01:48.600 without deploying and you've been doing
07:01:49.978 it all along when you do terraform
07:01:51.420 validate terraform plan or you're using
07:01:53.400 Sentinel you're doing static analysis
07:01:56.340 and that just means that we're testing
07:01:58.978 you know like the composition or the the
07:02:01.620 shape of our code or like its outputs to
07:02:04.500 what it says it should be doing okay but
07:02:06.958 you can't catch all your problems there
07:02:08.280 and that's where you move on to unit
07:02:09.360 testing and unit testing uh you know
07:02:11.760 traditionally means like in programming
07:02:13.620 to test like a particular function its
07:02:15.958 inputs and its outputs it's a little bit
07:02:18.180 harder for infrastructure because
07:02:20.580 um you know you have to have it
07:02:22.200 connected to other things so it the
07:02:24.360 definite sessions a little bit warped
07:02:25.798 but the idea here and specifically with
07:02:27.478 terraform is you're just testing a
07:02:28.680 single module and that really says like
07:02:31.080 okay well you need to really Pare down
07:02:33.540 that module to be of the small scope and
07:02:36.420 that's where you end up dividing your
07:02:37.740 modules into very small units of work
07:02:40.260 and so for tooling here we got Terra
07:02:42.420 Test Kitchen uh terraform and inspec
07:02:46.020 um and so uh yeah that's where that
07:02:48.420 motivation came with um you know Terra
07:02:50.400 Grande the last thing saying okay let's
07:02:51.420 split them up into smaller stuff uh we
07:02:53.638 have integration testing this is pretty
07:02:55.260 much just using multiple
07:02:57.540 um uh modules together you know so you
07:03:01.260 say okay well I know that this Lambda
07:03:03.360 function is working but do I know it
07:03:04.680 works in conjunction with this sqsq or
07:03:06.900 something like that then you have
07:03:08.520 end-to-end testing and this is where
07:03:09.958 you're testing basically like business
07:03:11.160 use cases so it's not just saying okay
07:03:13.500 from a technical perspective but from a
07:03:15.360 business use case do or the customer use
07:03:17.878 case do we meet the requirements here uh
07:03:20.280 and this uh is very hard because what
07:03:22.500 you have to actually do is set up a
07:03:23.820 persistent test Network environment but
07:03:25.620 once you have one you're going to be
07:03:27.298 really good shape one example of a test
07:03:30.840 environment and it is paid but
07:03:32.520 groundwork has their own called the
07:03:33.780 grunt work reference architecture uh but
07:03:36.780 you know if you had to do it without
07:03:38.218 that you'd have to just roll your own
07:03:39.540 kind of environment
07:03:40.920 so you know if you do want a good
07:03:43.138 breakdown of all these different kinds
07:03:44.580 uh you know Jim from grunt work has a
07:03:46.798 complete talk on automated testing for
07:03:48.420 infrastructure as a code I strongly
07:03:50.100 recommend it because it really gives you
07:03:51.840 a better scope than what I can cover
07:03:53.340 here
07:03:54.660 um but let's just go take a quick look
07:03:55.798 at Terra test so Terra test allows you
07:03:57.420 to perform unit tests and integration
07:03:58.860 tests on your infrastructure it tests
07:04:01.020 your infrastructure by temporarily
07:04:02.458 deploying it validating the results then
07:04:04.740 tearing down the test environment and so
07:04:06.840 here's an example of what a a test
07:04:09.958 function would look like in Terror test
07:04:11.580 it is written in golang I know golang
07:04:13.920 can be very hard to use but you don't
07:04:15.540 need to know much about it if you you
07:04:17.580 pretty much copy and paste it and just
07:04:19.138 kind of tweak the values to get the
07:04:20.878 result you want so you know hopefully
07:04:22.500 that helps to tell you how you would
07:04:24.298 test in terraform and you know that
07:04:25.798 about Terra test okay
