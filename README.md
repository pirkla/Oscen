# Oscen
Oscen is an iOS app that allows admins to deploy simple surveys via managed app configurations. 

App Store: coming one day maybe

# Requirements
This app must be deployed via an MDM since it requires a managed app configuration.

# Installation
### Option 1 (coming soon)
- Reserve licenses via Apple School Manager or Apple Business Manager
- Deploy the app to devices
- Deploy the managed app configuration to the devices
### Option 2 (requires Apple Developer Enterprise Program)
- Archive app via XCode and choose distribute > enterprise and create an enterprise build 
- Upload the app to MDM and deploy to devices
- Deploy the managed app configuration to the devices

# Configuration
The managed app configuration id is com.pirklator.Oscen

The configuration format:
```
Key: title
Format: String
Key: webhook
Format: url
Key: variables
Format: Dictionary of String, String
Key: questions
Format: Array of Dictionaries
  Key: questionId
  Format: String
  Key: questionText
  Format: String
  Key: questionType
  Format: Enum, enter either textInput or dropdown
  Key: questionAnswers
  Format: Array of strings - note the array can be empty if using textInput
```
I know it's complicated, a page to generate these will be coming shortly.

A sample managed app configuration:
```
<plist>
<dict>
    <key>questions</key>
    <array>
        <dict>
            <key>questionAnswers</key>
            <array/>
            <key>questionId</key>
            <string>anystringhere</string>
            <key>questionText</key>
            <string>Question text here</string>
            <key>questionType</key>
            <string>textInput</string>
        </dict>
        <dict>
            <key>questionAnswers</key>
            <array>
                <string>one</string>
                <string>two</string>
                <string>three</string>
            </array>
            <key>questionId</key>
            <string>2</string>
            <key>questionText</key>
            <string>Pick One</string>
            <key>questionType</key>
            <string>dropdown</string>
        </dict>
        <dict>
            <key>questionAnswers</key>
            <array>
                <string>blue</string>
                <string>cat</string>
                <string>green</string>
            </array>
            <key>questionId</key>
            <string>4</string>
            <key>questionText</key>
            <string>Choose a color</string>
            <key>questionType</key>
            <string>dropdown</string>
        </dict>
    </array>
    <key>title</key>
    <string>SurveyTitleHere</string>
    <key>variables</key>
    <dict>
        <key>variablenamehere</key>
        <string>variabletosendhere</string>
        <key>variable2</key>
        <string>%udid% %username% to fill values from Jamf School</string>
        <key>variable3</key>
        <string>something else</string>
    </dict>
    <key>webhook</key>
    <string>https://server.to.post.to.here</string>
</dict>
</plist>
```

# Development
To start development clone the repo and in Targets > Oscen > Team > Choose a team. No developer program enrollment is required for this, it only allows the app to build locally.

All code is compatible with catalyst, but the menu items don't work and I didn't bother to figure out why. If that was fixed this could be built for macOS.

Note mocks are used when running debug builds, so questions will automatically fill and behavior is not identical to production.
