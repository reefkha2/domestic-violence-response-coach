# Domestic Violence Response Coach System

## Solution Overview

The Domestic Violence Response Coach is an innovative AI-powered system designed to assist specialists at women's protection centers during live sessions with domestic violence victims. This first-of-its-kind solution leverages Amazon Bedrock's Claude 3.5 Sonnet v2 model to provide real-time guidance to specialists, ensuring they follow established protocols while maintaining cultural sensitivity.

### Key Benefits

- **Real-time Guidance**: Provides specialists with immediate suggestions during critical conversations
- **Protocol Adherence**: Ensures compliance with the DASH Risk Model and Saudi national protocol
- **Cultural Sensitivity**: Responds in natural Saudi dialect Arabic (Najdi) with culturally appropriate language
- **Risk Assessment**: Accurately evaluates risk levels and recommends appropriate actions
- **Specialized Support**: Includes dedicated protocols for elderly victims and persons with disabilities
- **Efficient Documentation**: Generates comprehensive session summaries and risk reports

### Solving a Critical Problem

Domestic violence response specialists face significant challenges when conducting victim interviews:
- Maintaining protocol compliance while being empathetic
- Navigating culturally sensitive conversations
- Making accurate risk assessments under pressure
- Documenting cases thoroughly while focusing on the victim

This solution is the first to combine advanced AI capabilities with established domestic violence response protocols in a culturally sensitive manner, specifically designed for Saudi women's protection centers.

## Architecture

![Architecture Diagram](architecture_diagram.png)



The system consists of:

1. **Bedrock Agent**: AI coach using Claude 3.5 Sonnet v2 model
2. **API Gateway**: Secure HTTP endpoints for frontend integration
3. **Lambda Functions**: Backend processing for case management
4. **DynamoDB Tables**: Secure storage for user profiles and case summaries

## Deployment Instructions

### Prerequisites

- AWS CLI installed and configured
- Appropriate permissions to create CloudFormation stacks, Lambda functions, IAM roles, and Bedrock agents
- Amazon Bedrock access with Claude 3.5 Sonnet v2 model enabled in your region

### Deployment Steps

1. Clone this repository:
   ```bash
   git clone https://github.com/reefkha2/domestic-violence-response-coach.git
   cd domestic-violence-response-coach
   ```

2. Deploy using AWS CLI:
   ```bash
   aws cloudformation deploy \
     --template-file simplified_template.yaml \
     --stack-name domestic-violence-response-system \
     --capabilities CAPABILITY_NAMED_IAM
   ```

3. Monitor the deployment in the AWS CloudFormation console. Deployment typically takes 5-10 minutes to complete.

## Using the System

### API Endpoints

After successful deployment, the CloudFormation stack outputs the API Gateway endpoint URL. This serves as the base URL for all API calls.

### Available API Routes

| Method | Endpoint | Description | Request Body/Parameters | Response |
|--------|----------|-------------|------------------------|----------|
| POST | /invokeAgent | Invokes the Bedrock agent | `{"input": "user message", "sessionId": "optional-session-id"}` | `{"response": "agent response", "sessionId": "session-id"}` |
| GET | /getUserCaseDetails | Gets case details for a user | Query param: `caseId=case-id-value` | `{"profile": {user-profile}, "summaries": [{summary-entries}]}` |
| POST | /saveSummary | Saves a case summary | `{"caseId": "case-id", "summary": "session summary text"}` | `{"message": "Summary saved successfully", "caseId": "case-id", "timestamp": "timestamp"}` |

### Integration Example

```javascript
// Example: Invoking the agent from a frontend application
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

## Resource Cleanup

To delete all resources created by this template:

```bash
aws cloudformation delete-stack --stack-name domestic-violence-response-system
```

The template has been configured with appropriate deletion policies to ensure all resources are properly cleaned up when the stack is deleted.

## License

This solution is provided under the MIT License and can be freely modified and distributed according to your organization's requirements.
