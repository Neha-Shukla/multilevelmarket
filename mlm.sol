pragma solidity >=0.4.22 <0.7.0;

// constructor() payable => working properly
// enter(address _refererId) => (1)reference amount paid successfully to _refererId
//                              (2)can enter only by paying 0.1 ether
//                              (3)pools missing levels incomplete
// getEthBalance() => working properly 
// withdrawMoneyTo() => working properly

contract MLM{
    
    //variables
    uint public constant minInvest=0.1 ether;
    uint public numInvestors=0;

    //no of vacant spaces at
    //particular level is 3**depth ie. when depth
    // 0 investors=1
    // 1 investors=3
    // 2 investors=9
    // 3 investors=27
    // 4 investors=81
    uint public depth=0; 
    uint public currUserId;
    //storing all investors who have invested 0.1 ether
    address[] public investors;
    
    //remove
    uint public investorsLength=0;
    
    uint i=1;
    
    //users Info struct
    struct User{
        uint id;
        address inviter;
        address self;
        uint level;
        uint pool;
        uint balance;
        uint references;
        uint paymentReceived;
    }
    
    //mappings
    mapping(address=>User) public users;
    
    //modifier to check minInvest
    modifier costs(uint price) {
      if (msg.value >= price) {
         _;
      }
   }
   
    //constructor
    constructor() public payable{
        require(msg.value>=0.1 ether,"insufficient balance");
        investors.length=4;
        
        //remove
        investorsLength=investors.length;
        
        investors[0]=msg.sender;
        
        //unnecessary
        currUserId = users[investors[0]].id;
        
        numInvestors = 1;
        depth=1;
        User memory user=User({
            id:i,
            inviter:msg.sender,
            self:msg.sender,
            level:1,
            pool:1,
            balance:0,
            references:0,
            paymentReceived:0
        });
        users[msg.sender]=user;
    }
    
    //Enter system Through referal
    function enter(address _inviterId) public payable{
        require(msg.value>=0.1 ether,"insufficient balance");
        numInvestors += 1;
        investors[numInvestors-1]=msg.sender;
        User memory user=User({
            id:i+1,
            inviter:_inviterId,
            self:msg.sender,
            level:1,
            pool:1,
            balance:0,
            references:users[msg.sender].references,
            paymentReceived:0
        });
        users[msg.sender]=user;
        i++;
        
         //remove
        investorsLength=investors.length;
        
        if(numInvestors == investors.length)
        {
            uint end = numInvestors-(3**depth);
            uint start = end - (3**(depth-1));
            uint localLevel = users[_inviterId].level;
            depth+=1;
            
            // pay all persons at above level
            for(uint j=start;j<end;j++)
            {
                if(localLevel==1)
                {
                    User memory userChanges=User({
                    id:users[investors[j]].id,
                    inviter:users[investors[j]].inviter,
                    self:users[investors[j]].self,
                    level:users[investors[j]].level+1,
                    pool:1,
                    balance:users[investors[j]].balance+60000000000000000,
                    references:users[investors[j]].references,
                    paymentReceived:users[_inviterId].paymentReceived
                    });
                    users[investors[j]]=userChanges;
                    
                    //unnecessary
                    currUserId+=1;
                }
                
                if(localLevel==2)
                {
                    User memory userChanges=User({
                    id:users[investors[j]].id,
                    inviter:users[investors[j]].inviter,
                    self:users[investors[j]].self,
                    level:users[investors[j]].level+1,
                    pool:1,
                    balance:users[investors[j]].balance+135000000000000000,
                    references:users[investors[j]].references,
                    paymentReceived:users[_inviterId].paymentReceived
                    });
                    users[investors[j]]=userChanges;
                    
                    //unnecessary
                    currUserId+=1;
                }
                
                else if(localLevel==3)
                {
                    User memory userChanges=User({
                    id:users[investors[j]].id,
                    inviter:users[investors[j]].inviter,
                    self:users[investors[j]].self,
                    level:users[investors[j]].level+1,
                    pool:1,
                    balance:users[investors[j]].balance+405000000000000000,
                    references:users[investors[j]].references,
                    paymentReceived:users[_inviterId].paymentReceived
                    });
                    users[investors[j]]=userChanges;
                    
                    //unnecessary
                    currUserId+=1;
                }
                
                else if(localLevel==4)
                {
                    User memory userChanges=User({
                    id:users[investors[j]].id,
                    inviter:users[investors[j]].inviter,
                    self:users[investors[j]].self,
                    level:users[investors[j]].level+1,
                    pool:1,
                    balance:users[investors[j]].balance+1215000000000000000,
                    references:users[investors[j]].references,
                    paymentReceived:users[_inviterId].paymentReceived
                    });
                    users[investors[j]]=userChanges;
                    
                    //unnecessary
                    currUserId+=1;
                }
            }
            
            
        }
            
            // giving 0.02 ether for referal to inviter
            User memory receiver=User({
                id:users[_inviterId].id,
                inviter:_inviterId,
                self:_inviterId,
                level:users[_inviterId].level,
                pool:1,
                balance:users[_inviterId].balance+20000000000000000,
                references:users[_inviterId].references+1,
                paymentReceived:users[_inviterId].paymentReceived
                });
            users[_inviterId]=receiver;
    }
    
    // get balance stored in smart contract
    function getEthBalance() public view returns(uint) {
        return address(this).balance;
        }
    
    //withdraw money from you balance and transfer to wallet
    function withdrawMoneyTo() public {
        
        //check if the person refered atleast 3 persons to claim money
        require(users[msg.sender].references>=3,"refer more people to claim your price");
        
        uint amount = users[msg.sender].balance;
        User memory user=User({
            id:users[msg.sender].id,
            inviter:users[msg.sender].inviter,
            self:users[msg.sender].self,
            level:users[msg.sender].level,
            pool:users[msg.sender].pool,
            balance:0,
            references:users[msg.sender].references,
            paymentReceived:users[msg.sender].paymentReceived+amount
            });
        users[msg.sender]=user;
        msg.sender.transfer(amount);
    }
    
}