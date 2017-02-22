from bottle import route, run, template, static_file, request
import random
import json
import pymysql



connection = pymysql.connect(host='sql11.freesqldatabase.com',
                             port=3306,
                             user='sql11157866',
                             password='Unmt97v6Wd',
                             db='sql11157866',
                             charset='utf8',
                             cursorclass=pymysql.cursors.DictCursor)



@route("/", method="GET")
def index():
    return template("adventure.html")



@route("/start", method="POST")
def start():
    username = request.POST.get("user").lower()
    current_adv_id = request.POST.get("adventure_id")


    with connection.cursor() as cursor:
        sql = "SELECT username FROM users WHERE username = '{}'".format(username)
        cursor.execute(sql)
        result = cursor.fetchall()


        if not result:
            add_user(username)
            new_game = "SELECT question FROM questions_table WHERE question_id = 1"
            cursor.execute(new_game)
            result_new_game = cursor.fetchone()


            answers = "SELECT answers, outcome FROM answers_table WHERE question_id = 1"
            cursor.execute(answers)
            result_answers = cursor.fetchall()


            image = "SELECT image FROM questions_table WHERE question_id = 1"
            cursor.execute(image)
            game_image = cursor.fetchone()


            next_steps_results = []
            for ans in result_answers:
                next_steps_results.append({"option_text":ans['answers'],"id": ans['outcome']})


            return json.dumps({"user": username,
                               "adventure": current_adv_id,
                               "text": result_new_game["question"],
                               "image": game_image["image"],
                               "options": next_steps_results
                               })



        else:
            existing_game = "SELECT question FROM questions_table WHERE question_id = (SELECT question_id FROM users WHERE username = '{}')".format(username)
            cursor.execute(existing_game)
            result_existing_game = cursor.fetchone()


            answers = "SELECT answers, outcome FROM answers_table WHERE question_id = (SELECT question_id FROM users WHERE username = '{}')".format(username)
            cursor.execute(answers)
            result_answers = cursor.fetchall()


            image = "SELECT image FROM questions_table WHERE question_id = (SELECT question_id FROM users WHERE username = '{}')".format(username)
            cursor.execute(image)
            game_image = cursor.fetchone()


            next_steps_results = []
            for ans in result_answers:
                next_steps_results.append({"option_text": ans['answers'], "id": ans["outcome"]})


            return json.dumps({"user": username,
                               "adventure": current_adv_id,
                               "text": result_existing_game["question"],
                               "image": game_image["image"],
                               "options": next_steps_results
                               })



def add_user(data):
    with connection.cursor() as cursor:
        sql = "INSERT INTO users(username) VALUES ('{}')".format(data)
        cursor.execute(sql)
        connection.commit()



@route("/story", method="POST")
def story():
    username = request.POST.get("user")
    current_adv_id = request.POST.get("adventure")
    next_story_id = request.POST.get("next") #this is what the user chose - use it! #this is Adventures.currentStep


    try:
        with connection.cursor() as cursor:

            next_question = "SELECT question FROM questions_table WHERE question_id = '{}'".format(next_story_id)
            cursor.execute(next_question)
            result_next = cursor.fetchone()


            answers = "SELECT answers, outcome FROM answers_table WHERE question_id = '{}'".format(next_story_id)
            cursor.execute(answers)
            result_answers = cursor.fetchall()


            image = "SELECT image FROM questions_table WHERE question_id = '{}'".format(next_story_id)
            cursor.execute(image)
            game_image = cursor.fetchone()


            next_steps_results = []
            for ans in result_answers:
                next_steps_results.append({"option_text": ans['answers'], "id": ans["outcome"]})


            save_user_progress()


            #todo add the next step based on db
            return json.dumps({"user": username,
                                "adventure": current_adv_id,
                                "text": result_next["question"],
                                "image": game_image["image"],
                                "options": next_steps_results
                                })

    except:
        return json.dumps({'error': 'something is wrong with the database'})



def save_user_progress():
    username = request.POST.get("user")
    next_story_id=request.POST.get('next')
    with connection.cursor() as cursor:

        #update table set column
        try:
            update = 'UPDATE users SET question_id= "{0}" where username = "{1}" '.format(next_story_id,username)
            cursor.execute(update)
            connection.commit()
        except:
            return json.dumps({'error':'You done messed up, saving user progress'})



@route('/js/<filename:re:.*\.js$>', method='GET')
def javascript(filename):
    return static_file(filename, root='js')



@route('/css/<filename:re:.*\.css>', method='GET')
def stylesheets(filename):
    return static_file(filename, root='css')



@route('/images/<filename:re:.*\.(jpg|png|gif|ico)>', method='GET')
def images(filename):
    return static_file(filename, root='images')



def main():
    # run(host='localhost', port=9004)
    run(host='0.0.0.0', port=argv[1])



if __name__ == '__main__':
    main()

