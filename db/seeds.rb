# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Post.all.each{|post| PostTag.create({post_id: Post.all.sample.id, tag_id: Tag.all.sample.id})}
Post.create({title: 'test post css', body:"<i>In an attempt to hold myself accountable I have decided to attempt 10 projects in 10 weeks. For my second project I wanted to make a twitter bot.</i> 
<br>
<h3>The Prompt</h3>
<br>
<p>Deciding what to make my twitter bot do was probably the toughest challenge. Did I want to make a political statement? Did I want to make something interactive? </p>
<p>Ultimately I decided it was best to keep it simple. I would make a twitter bot that tweets once a day: 'It is <day of the week>, the <date> and I've been social distancing for <i>X</i> days.' <br>
Besides, I can always add functionality in the future.</p>
<br>
<h3>The Process</h3>
<br>
<p>Making a twitter bot really consists of just <strong>5 Steps</strong>
<ol>
<li>Make a twitter dev account</li>
<li>Create a twitter app</li>
<li>Set up your dev environment</li>
<li>Code</li>
<li>Deploy</li>
</ol>
and that's it! Easy peasy!</p>

<h3>Step 1: Make a twitter dev account</h3>
<br>
<p> If you don't already have a twitter account, you'll need to sign up for one. Then <a href='https://developer.twitter.com/en/apply-for-access' target='blank'>apply for a dev account</a>. The twitter documentation is pretty self explanatory, but just make sure to save your access_tokens somewhere safe.</p>
<br>
<h3>Step 2: Make a twitter app</h3>
<br>
<p>The twitter docs do a better job of walking you through this than I could, so I'll just say this. Make sure you're generating the appropriate access token permissions. If you're going to have a bot that writes it's own tweets you'll need to have Read and Write permissions. They can be changed in your keys and tokens tab of your app.</p>
<img src='https://lh3.googleusercontent.com/r0y5Z56xQ6G2tTeIMY28sVb6ZvVYbVBA_lQs0nkVNObS9tQzKoloPJFJmXVtkvNbRLzt_0wh-g0CKP20HfeXGYVduA2SKNhfQJg8JLS1MwryWHBk83Jl0whGLMlZAM29tOyMktptCZoUJyP_p2cSJylnSu0ESDgAEwVEjJUESjMmgbuCWE0mEQcFVn8fEaNHqlkEsuOdO8mI7nM7cmy8PJJfWQtILClakxh0jhvve2z1TbQ3utJF6Tpo64bLL47EVt7ZPkGC5nawjQ_D-BLJXuGOBTp3YQKYdh9PwFHwPS3x78LcaG5QeCJn2USvPmt8KSlc8tmk2A72IqOzVznqeFW6cshWxgYQxpTxdSDXqxduHVaj7VsP6TuNMtzNLk5JLnDGY3WPuprhJ_EWIvjIkx4fa4FQmOhmK7SkI7vEpThr8EkjE3oYCh2bOid3T26s3AmdT6LVySeZD3d4IXaN1sHqYDrLdyV8-S591d2R8V3Z4YivMNdqzr-9TxV5wnj475fW7DGe3c3JnNmTLXaR-xr7ie7c4e5jPxC2P1drHpSvbek-yKZ1htnFZAlG0BnJsQtFXCKo22LVOgWSWM1xF7ayFZeCtGfAS0CU9tx2081Nfpcxnwz2S8amO2YKYY7HhlMjVDrYojLBca3WLwn8KNMy3dQllb263Lgqau805xQlQtR01mwjOWNKnJSJBQ=w597-h125-no?authuser=0'>
<br>
<h3>Step 3: Setting up your environment</h3>
<br>
<p>This part is pretty simple. I wrote my bot in Node.js, so make sure you've got Node.js and npm installed on your machine.</p>
<code>node -v
npm -v</code>
<p>First we'll need a directory to house our project. <code>mkdir your-bot-name</code></p>
<p>Then run <code>git init</code> so we can start tracking changes to our project.</p>
<p>Next we'll run <code>npm init</code> so we can start tracking our dependencies.</p>
<p> Finally we'll install a module called <a href='https://www.npmjs.com/package/twit' target='blank'>twit</a>. We'll use twit to handle our connection to the twitter api. Run <code>npm install --save twit</code></p>
<br>
<h3>Step 4: Code</h3>
<br>
<p>Now that we've got our environment set up we can get to the good stuff! First we'll make a file called <strong><i>config.js</i></strong> which will hold our of our access variables. <code>module.exports = {
    consumer_key:process.env.CONSUMER_KEY,
    consumer_secret:process.env.CONSUMER_SECRET,
    access_token:process.env.ACCESS_TOKEN,
    access_token_secret:process.env.ACCESS_TOKEN_SECRET
    }</code>
Next, we'll make a file called <strong><i>bot.js</i></strong> which will handle all of our bot logic</p>
<pre class='prettyprint'><code class='language-js'>// require config.js to get access tokens and secrets
const configure = require('./config')
// require twit
const Twit = require('twit');
// create a twit instance to handle communication with Twitter api
const T = new Twit(configure)
// dateRef stores day of week and month information to quickly convert date objects
const dateRef = {
}
// ordinalSuffixOf adds the appropriate suffix to a date i.e 19th, 22nd, 3rd
function ordinalSuffixOf(i) {
  }
// build our post
function buildPost(){
    const today = new Date()
    const theBeginning = new Date('03/15/2020')
    return `Today is ${dateRef.dayOfWeek[today.getDay()]}, the ${ordinalSuffixOf(today.getDate())} of ${dateRef.month[today.getMonth()]} and I've been social distancing for ${dayDifference(today, theBeginning)} days. #WearAMask `
}


// send our post to twitter
function createPost(){
    T.post('statuses/update', { status: buildPost() }, function(err, data, response){
        // if there is an error log it
        if(err){
            console.log(err)
        }
    })
}

// this function will create our first post, and then call createPost every 24 hours
function tweetTimer(){
    createPost()
    setInterval(createPost, 86400000)
}

tweetTimer()</code></pre>
<p> If you want to test out your bot before deploying, just run <code>$ node bot.js</code> and then go to your twitter page to see if it worked!</p>
<br>
"})
