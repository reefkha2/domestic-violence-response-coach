# Domestic Violence Response Coach System

## Deployment Options

### Option 1: Clone and Deploy
1. Clone this repository
   ```bash
   git clone https://github.com/reefkha2/domestic-violence-response-coach.git
   cd domestic-violence-response-coach
   ```

2. Deploy using AWS CLI:
   ```bash
   aws cloudformation deploy \
     --template-file domestic_inclusive_violance_demo.yaml \
     --stack-name domestic-violence-response-system \
     --capabilities CAPABILITY_NAMED_IAM
   ```

### Option 2: Request Access
For organizations interested in deploying this solution, please contact us to receive secure access to the deployment template.

## Solution Overview

This solution provides a comprehensive system for assisting specialists at Saudi women's protection centers during live sessions with domestic violence victims. The system leverages Amazon Bedrock's Claude 3.5 Sonnet v2 model to create an AI coach that guides specialists through victim interactions using established protocols.

### Problem Statement

Domestic violence response specialists face several challenges:
- Need for real-time guidance during sensitive conversations
- Ensuring adherence to established protocols (DASH Risk Model and Saudi national protocol)
- Maintaining cultural sensitivity and appropriate language
- Accurately assessing risk levels and recommending appropriate actions
- Documenting case details and summaries efficiently

### Solution Components

This CloudFormation template deploys a complete solution including:

1. **Bedrock Agent**: An AI domestic violence response coach that provides real-time guidance to specialists
2. **API Gateway**: HTTP endpoints for frontend integration
3. **Lambda Functions**: Backend processing for user profiles, case details, and agent interactions
4. **DynamoDB Tables**: Storage for user profiles and case summaries

## Architecture Diagram

![Architecture Diagram](architecture_diagram.png)

*Note: Place your architecture diagram image file in the same directory as this README and name it "architecture_diagram.png"*

## Deployment Instructions

### Prerequisites

- AWS CLI installed and configured
- Appropriate permissions to create CloudFormation stacks, Lambda functions, IAM roles, and Bedrock agents
- Amazon Bedrock access with Claude 3.5 Sonnet v2 model enabled in your region

### Deployment Steps

1. **Using AWS CLI**:

```bash
aws cloudformation create-stack \
  --stack-name domestic-violence-response-system \
  --template-body file://domestic_inclusive_violance_demo.yaml \
  --capabilities CAPABILITY_NAMED_IAM
```

2. **Using AWS Console**:

   a. Open the AWS CloudFormation console
   b. Click "Create stack" and select "With new resources (standard)"
   c. Upload the `domestic_inclusive_violance_demo.yaml` file
   d. Follow the prompts to configure stack parameters
   e. Acknowledge IAM resource creation by checking the capability box
   f. Click "Create stack"

3. **Monitor Deployment**:
   
   The deployment will take approximately 5-10 minutes to complete. You can monitor the progress in the CloudFormation console.

## Using the System

### API Endpoints

After successful deployment, the CloudFormation stack will output the API Gateway endpoint URL. This URL serves as the base for all API calls from your frontend application.

### Available Routes

| Method | Endpoint | Description | Request Body/Parameters | Response |
|--------|----------|-------------|------------------------|----------|
| POST | /invokeAgent | Invokes the Bedrock agent | `{"input": "user message", "sessionId": "optional-session-id"}` | `{"response": "agent response", "sessionId": "session-id"}` |
| POST | /StoreNewUser | Creates a new user profile | `{"name": "User Name", "phoneNumber": "1234567890", "email": "optional@email.com"}` | `{"message": "User profile created successfully", "caseId": "generated-case-id"}` |
| GET | /checkUser | Checks if a user exists by phone number | Query param: `phoneNumber=1234567890` | `{"exists": true/false, "user": {user-details}}` |
| GET | /getUserCaseDetails | Gets case details for a user | Query param: `caseId=case-id-value` | `{"profile": {user-profile}, "summaries": [{summary-entries}]}` |
| POST | /saveSummary | Saves a case summary | `{"caseId": "case-id", "summary": "session summary text"}` | `{"message": "Summary saved successfully", "caseId": "case-id", "timestamp": "timestamp"}` |

### Frontend Integration

To integrate with a frontend application:

1. Use the API Gateway endpoint URL from the CloudFormation outputs
2. Make HTTP requests to the appropriate routes as described above
3. Handle responses according to your application's needs

Example JavaScript code for invoking the agent:

```javascript
async function invokeAgent(userInput, sessionId = '') {
  const apiUrl = 'https://your-api-gateway-url.execute-api.region.amazonaws.com/prod/invokeAgent';
  
  const response = await fetch(apiUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      input: userInput,
      sessionId: sessionId
    })
  });
  
  return await response.json();
}
```

### Agent Capabilities

The Bedrock agent is configured to:

1. Respond in natural Saudi dialect Arabic (Najdi)
2. Guide specialists through the Saudi national protocol for domestic violence response
3. Apply the DASH (2009) Risk Model for risk assessment
4. Provide specialized guidance for elderly victims (WHO Elder Abuse Indicators) and persons with disabilities (Stay Safe)
5. Generate session summaries and risk reports when requested

## Resource Cleanup

To delete all resources created by this template:

1. **Using AWS CLI**:

```bash
aws cloudformation delete-stack --stack-name domestic-violence-response-system
```

2. **Using AWS Console**:

   a. Open the AWS CloudFormation console
   b. Select the stack you created
   c. Click "Delete" from the Actions menu
   d. Confirm deletion

The template has been configured with appropriate deletion policies to ensure all resources are properly cleaned up when the stack is deleted.

## Security Considerations

- The template creates IAM roles with least privilege permissions
- API Gateway endpoints can be further secured with authentication mechanisms
- Consider implementing additional security measures for production deployments
- Review and adjust IAM permissions based on your specific requirements

## Support and Contributions

For questions, issues, or contributions, please contact the project maintainers.

## License

This solution is provided as a reusable asset and can be freely modified and distributed according to your organization's requirements.
