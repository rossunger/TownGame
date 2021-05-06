extends Node
#class_name UtilityAI
"""
UTILITY AI is all about making decisions. 
An ACTOR has Actions they can take, which have:	
	- Considerations, which have:
		- Conditions, that affect the actions score
			- A score answer the question "how useful will it be to do this?" with 1 being imperative, and 0 being terrible. 

The Decide function compares all actions, and returns the highest scoring one. 

e.g. Actions:
	- go to house 
		- considerations:
			- isHungry
			- isTired
	- go to person
		considerations:
			- isLonely
				- if yes, score++
			- HasSomethingToSay
				- if yes, score++
			- likesPerson
				- if yes, score++
				- if no, score--
	- wait
		considerations:
			- needToBeSomewhere
				- if yes, score--


TO DO: implement "best-man-for-the-job" model aka ActorContextList, a variation on 
https://mcguirev10.com/2019/01/03/ai-decision-making-with-utility-scores-part-1.html

#TO DO: figure out if arrays are passed by pointer or actual value
func decide(actions = []):
	var winner = actions[0]
	for action in actions:
		action.consider()
		if action.score > winner.score:
			winner = action
	return winner #which you will then emit_signal()

class Action:
	var description = ""
	var score = 0 #set by the consider function
	var weight = 1 #weight is set by the designer... 10 = urgent, 1 = casual
	var signalToEmit = "" #the signal to emit if this action is to be done.
	var considerations = []	
	func consider():				
		for consideration in considerations:
			consideration.evaluate()
			
class Consideration:
	var description = ""	
	var score = 0 #set by the evaluate functio
	var weight = 1 #weight is set by the designer... 10 = urgent, 1 = casual	
	var curve = curve.new()
	var conditions =  []
	func evaluate():
		for condition in conditions:
			condition.check()

class Condition:	
	var isBool = true
	var curve  # the curve that we are checking it against, of type Curve
	var score = 0	
	var operator = "+"
	var data : Array # [data to be compared, data to be compared to]
	func check():				
		var expression = Expression.new()
		#expression.parse(data[0] + comparator + data[1], params) # e.g. "(x - y) 
		var value = expression.execute([data[0],data[1]])
		if isBool:
			return value
		score = curve.Interpolate( value )			
		return score
		pass





Skillset, DecisionMaker, Intelligence ... assign intelligence to character

Consideration.conditions[0] = Condition.new()
Consideration.conditions[0].isBool = false
Consideration.conditions[0].curve = Curve.new()
Consideration.conditions[0].data[0] = Distance(Player.location,Player.target.location)
Consideration.conditions[0].data[1] = 100
Consideration.conditions[0].comparator = ">"

A	Run away from target	
C		isTargetHostile? (bool)			0 or 1
X			Target.feelingsTowardsMe > 0
C		isTargetStrongerThanMe?			0 or 1
X			return Target.strength-my.strength > 0
C		amICloseToTarget?				0 or 1
X			return Distance(target, me) < 100
C		howMuchStrongerThanMeIsTarget?	returns a range from 0 = no biggie, to 1 = RUNNNNN
X			return (Target.strength-my.strength) * curve     
C		howCloseIsTarget?				returns a range from 0 = too far to care, to 1 = right next to me
X			return Distance(target, me) * curve     
	


"""
