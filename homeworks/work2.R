#Q1. (20%) Two six-sided dice are thrown sequentially, and the face values that come up are recorded.
# (a) List the sample space.
for(i in 1:6)
{
	for(j in 1:6)
	{
		print(paste0("{", i,",",j,"}"))
	}
}

# (b) List the elements that make up the following events: 
# (1) A=the sum of the two values is at least 5
print("A=the sum of the two values is at least 5:")
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i+j>=5){
			print(paste0("{", i,",",j,"}"))
		}
	}
}


# (2) B=the value of the first die is higher than the value of the second,

print("B=the value of the first die is higher than the value of the second,")
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i>j){
			print(paste0("{", i,",",j,"}"))
		}
	}
}

# (3) C=the first value is 4.
print("C=the first value is 4.")
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i==4){
			print(paste0("{", i,",",j,"}"))
		}
	}
}

# (1)\\(A \cap C\\)
print("A and C")
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i==4&&i+j>=5){
			print(paste0("{", i,",",j,"}"))
		}
	}
}
# (2)\\(B \cup C\\)
print("B or C")
for(i in 1:6)
{
	for(j in 1:6)
	{
		b=i>j
		c=i==4
		if(b||c){
			print(paste0("{", i,",",j,"}"))
		}
	}
}

# (3)\\(A \cap (B \cup C) \\)
print("A and (B or C)")
for(i in 1:6)
{
	for(j in 1:6)
	{
		a=i+j>=5
		b_or_c=(i>j)||(i==4)
		if(a && b_or_c){
			print(paste0("{", i,",",j,"}"))
		}
	}
}

#(d)Based on the classical approach,derive \\(P(A \cap C), P(B \cup C),and P(A \cap (B \cup C)) \\). 
#"P(A and C)= "
p1=0
for(i in 1:6)
{
	for(j in 1:6)
	{
		if(i==4&&i+j>=5){
			p1=p1+1
		}
	}
}
print(paste0("P(A and C)= ",p1,"/36"))

#P(B or C)
p2=0
for(i in 1:6)
{
	for(j in 1:6)
	{
		b=i>j
		c=i==4
		if(b||c){
			p2=p2+1
		}
	}
}
print(paste0("P(B or C)= ",p2,"/36"))

#P("A and (B or C)")
p3=0
for(i in 1:6)
{
	for(j in 1:6)
	{
		a=i+j>=5
		b_or_c=(i>j)||(i==4)
		if(a && b_or_c){
			p3=p3+1
		}
	}
}
print(paste0("P(A and (B or C))= ",p3,"/36"))

#(e) Use the `sample` function to simulate the throwing of two dice 1,000 times.Compute \\(P(A \cap C), P(B \cup C),and \,P(A \cap (B \cup C)) \\) from the 1,000 runs (i.e., the relative frequency approach). How different are the results from (d) (show me the R code in the .R file)?
n=1000
d1=sample(6,n,replace=T)

d2=sample(6,n,replace=T)

result=cbind(d1,d2)

#"P(A and C)= "
p1.sample=length(result[(d1==4&d1+d2>=5),1])
p1.sample=p1.sample/n
print(paste0("sample P(A and C)= ",p1.sample))
print(paste0("different between classical approach and sample:",(p1/36)-p1.sample))
#P(B or C)
p2.sample=length(result[(d1>d2|d1==4),1])
p2.sample=p2.sample/n
print(paste0("sample P(B or C)= ",p2.sample))
print(paste0("different between classical approach and sample:",(p2/36)-p2.sample))
#P("A and (B or C)")
p3.sample=length(result[d1+d2>=5&(d1>d2|d1==4),1])
p3.sample=p3.sample/n
print(paste0("sample P(A and (B or C))= ",p3.sample))
print(paste0("different between classical approach and sample:",(p3/36)-p3.sample))

#Q2. (20%) Use the choose function in R to answer (c), (d), and (e) 
#(c) How many different meals can be made from four kinds of meat, six vegetables, and three starches if a meal consists of one selection from each group?
choose(4,1)*choose(6,1)*choose(3,1)

#(d) A committee consists of five Chicanos, two Asians, three African Americans, and two Caucasians. 
#A subcommittee of five is chosen at random. What is the probability that all the ethnic groups are represented on the subcommittee?
total=5+2+3+2
choose(5,1)*choose(2,1)*choose(3,1)*choose(2,1)*choose(total-4,1)/choose(total,5)

#(e) A drawer of socks contains seven black socks, eight blue socks, and nine green socks.
# Two socks are chosen in the dark.
# What is the probability that they match?
socks.total=7+8+9
(choose(7,2)+choose(8,2)+choose(9,2))/choose(socks.total,2)
# What is the probability that a black pair is chosen?
(choose(7,2))/choose(socks.total,2)

#Q3. (10%) Simulating Blackjack (classical versus relative)
#(a) In the poker game Blackjack, let each of the 4 aces denote 11 points
# and each of the 16 cards > 10 (i.e., 10, J, Q, K) denote 10 points.
#Suppose someone picks 2 cards randomly out of a deck of cards (52 cards total), what is the probability of getting 21 points (i.e., Blackjack)?
# Use the choose function to obtain the answer.
choose(4,1)*choose(16,1)/choose(52,2)

#(b) Now, let the numbers 1-52 represent a deck of cards. Assign the numbers 1-4 to the four aces and the numbers 37-52 
#to the 16 cards > 10.Use the sample function and the for loop to simulate the random draw of 2 cards 50,000 times 
#(hint: with or without replacement?). 
#Create a variable success that represents the number of times you hit 21 points (i.e., Blackjack).
# Divide success by 50,000 to obtain the relative probability. 
#Is the relative probability close to the classical one from part (a)?

bj.sim=function(times)
{
	success=0
	for(i in 1:times){
		result=sample(52,2)	
		has.ace= any(result<=4)
		has.ten=any(result<=52&result>=37)
		if(has.ace&has.ten){
			success=success+1
		}
	}
	return (success)
}
success=bj.sim(50000)
bj.classical=choose(4,1)*choose(16,1)/choose(52,2)
print(paste0("the difference between simulate 50000times and classical is ",bj.classical-success/50000))
#What will happen to the relative probability if you only simulate the game for 50 times?
success=bj.sim(50)
bj.classical=choose(4,1)*choose(16,1)/choose(52,2)
print(paste0("the difference between simulate 50times and classical is ",bj.classical-success/50))

###Q5. (15%) A bank has five desks 1, 2,...,5. The percentages of customers visiting each desk are 20%, 30%, 10%, 15%, and 25%.
# Among customers for each desk, the percentages that customers would stay longer than 30 minutes are 40%, 60%, 20%, 80%, and 90%.
####(b) What is the overall probability of customers staying longer than 30 minutes?
customer_visit.p=c(0.2,0.3,0.1,0.15,0.25)
longer30.p=c(0.4,0.6,0.2,0.8,0.9)
customer_visit.p*longer30.p
longer30.overall=sum(customer_visit.p*longer30.p)
####(c) If a newly entering customer stays longer than 30 minutes, what are the posterior probabilities that she/he visits desks 1, 2,...,5? (i.e., find P(D1|E), P(D2|E),..., P(D5|E) and make sure that they sum to 1)
customer_visit.p*longer30.p/longer30.overall

#Q6. (15%) Assume that grades are posted according to the last 4 digits of one's ID. Use R to
#(a) Find that the actual probability that at least two students in a class of 100 share the same ID.
1-prod(c(9901:10000)/10000)
#(b) Simulate the last 4 digits for 100 students 5,000 times. How many times do you find at least two students have the same ID? 
#Divide the number by 5,000, what is the fraction?
uniq.sim=function(times){
	success=0
	
	for( i in 1:times)
	{
		ids=sample(0:9999,100,replace=T)
		if(length(unique(ids))<100){
			success=success+1
		}
	}
	return (success)
}
#(c) What is the smallest class enrollment (i.e., number of students) for 
#which the probability that at least two students have the same ID numbers is at least 0.5?

twosame.p=function(number){
	start=10000-number+1
	1-prod(c(start:10000)/10000)
}

find.number=function(p){
	n=0
	for(number in 1:10000)
	{	
		start=10000-number+1
		p2=1-prod(c(start:10000)/10000)
		if(p2>=p){
			n=number
			break;
		}
	}
	return (n)
}
find.number(0.5)