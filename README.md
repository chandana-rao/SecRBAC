This project presents SecRBAC, a data-centric access control solution for self-protected data that can run in untrusted CSPs and provides extended Role-Based Access Control expressiveness. The proposed authorization solution provides a rule-based approach following the RBAC scheme, where roles are used to ease the management of access to the resources. This approach can help to control and manage security and to deal with the complexity of managing access control in Cloud computing. Role and resource hierarchies are supported by the authorization model, providing more expressiveness to the rules by enabling the definition of simple but powerful rules that apply to several users and resources thanks to privilege propagation through roles and hierarchies. Policy rule specifications are based on Semantic Web technologies that enable enriched rule definitions and advanced policy management features like conflict detection.  

A data-centric approach is used for data self-protection, where novel cryptograhpic techniques such as Proxy Re-EncryptionEncryption (PRE), IdentityBased Encryption (IBE) and Identity-Based Proxy ReEncryption (IBPRE) are used. They allow to re-encrypt data from one key to another without getting access and to use identities in cryptographic operations.  
These techniques are used to protect both the data and the authorization model. Each piece of data is ciphered with its own encryption key linked to the authorization model and rules are cryptographically protected to preserve data against the service provider access or misbehaviour when evaluating the rules. It also combines a user-centric approach for authorization rules, where the data owner can define a unified access control policy for his data. The solution enables a rule based approach for authorization in Cloud systems where rules are under control of the data owner and access control computation is delegated to the CSP, but making it unable to grant access to unauthorized parties. 

![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/Home.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/Home1.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/reg&login.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/NewData.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/ManageData.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/PrevilegedData.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/Encrypted.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/Encrypted2.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/Decrypt.PNG)
![alt text](https://github.com/chandana-rao/SecRBAC/blob/master/Snapshots/DecryptedData.PNG)
