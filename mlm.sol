pragma solidity >=0.4.22 <0.7.0;

contract Market{
  
     address public ownerWallet;
    uint internal global;
    
        //pool1
        uint pool1level1activeUserID   ;
        uint pool1level2activeUserID   ;
        uint pool1level3activeUserID   ;
        uint pool1level4activeUserID   ;
        
    struct Variables {
        uint currUserID          ;
        //pool1
        uint pool1currUserID     ;
        
        //pool2
        uint pool2currUserID     ;
        uint pool3currUserID     ;
        uint pool4currUserID     ;
        uint pool5currUserID     ;
        uint pool6currUserID     ;
        
        //pool3
        uint pool7currUserID     ;
        uint pool8currUserID     ;
        uint pool9currUserID     ;
        uint pool10currUserID    ;
        uint pool11currUserID    ;
        
    }
    struct Variables2 {
       
        //pool2
        uint pool2activeUserID   ;
        uint pool3activeUserID   ;
        uint pool4activeUserID   ;
        uint pool5activeUserID   ;
        uint pool6activeUserID   ;
        
        //pool3
        uint pool7activeUserID   ;
        uint pool8activeUserID   ;
        uint pool9activeUserID   ;
        uint pool10activeUserID  ;
        uint pool11activeUserID  ;
       
    }
    Variables internal vars;
    Variables2 internal vars2;
    
    //pool1 user struct
    struct pool1userStruct{
     uint id;
     uint level;
     uint amountlevel1;
     uint amountlevel2;
     uint amountlevel3;
     uint amountlevel4;
     }
    // All entered users
    //balance store amount from downline
    struct UserStruct {
        bool isExist;
        uint id;
        uint referrerID;
        uint referredUsers;
        uint balance;
        uint referalAmount;
        uint pool2ReferredUsers;
        uint pool3ReferredUsers;
        
    }
    
    // All users who have buyed any pool
    struct PoolUserStruct {
        bool isExist;
        uint id;
        uint payment_received; 
    }
    
    //pool1 users
    mapping(uint=>pool1userStruct) public pool1Users;
    
    mapping (address => UserStruct) public users;
    mapping (uint => address) public userList;
    
    mapping (address => PoolUserStruct) public pool1users;
    mapping (uint => address) public pool1userList;
    
    mapping (address => PoolUserStruct) public pool2users;
    mapping (uint => address) public pool2userList;
    
    mapping (address => PoolUserStruct) public pool3users;
    mapping (uint => address) public pool3userList;
    
    mapping (address => PoolUserStruct) public pool4users;
    mapping (uint => address) public pool4userList;
    
    mapping (address => PoolUserStruct) public pool5users;
    mapping (uint => address) public pool5userList;
    
    mapping (address => PoolUserStruct) public pool6users;
    mapping (uint => address) public pool6userList;
    
    mapping (address => PoolUserStruct) public pool7users;
    mapping (uint => address) public pool7userList;
    
    mapping (address => PoolUserStruct) public pool8users;
    mapping (uint => address) public pool8userList;
    
    mapping (address => PoolUserStruct) public pool9users;
    mapping (uint => address) public pool9userList;
    
    mapping (address => PoolUserStruct) public pool10users;
    mapping (uint => address) public pool10userList;
    
    mapping (address => PoolUserStruct) public pool11users;
    mapping (uint => address) public pool11userList;
    

    uint ENTRY_FEES             =   0.1     ether;
    //pool1 price
    uint pool1_price            =   0.10    ether;
    //pool2 price
    uint pool2_price            =   0.50    ether;
    uint pool3_price            =   0.75    ether;
    uint pool4_price            =   1.25    ether;
    uint pool5_price            =   2.00    ether;
    uint pool6_price            =   3.50    ether;
    //pool3 price
    uint pool7_price            =   6.00    ether;
    uint pool8_price            =   10.00   ether;
    uint pool9_price            =   15.00   ether;
    uint pool10_price           =   20.00   ether;
    uint pool11_price           =   30.00   ether;
    
   
    event initialEntryEvent(address indexed _user, address indexed _referrer, uint _time);
    event referalAmountSentEvent(uint _poolNumber,address indexed _user, address indexed _referer,uint amount, uint _time);
    event buyPoolEvent(address indexed _user,uint _poolNumber,uint _referalAmount, uint _time);
    event userAssignedEvent(address indexed _user,uint _poolNumber,uint time);
    
    uint public totalEarned = 0;
     
    constructor() public {
        ownerWallet = msg.sender;
        global=0;
        
        
        //add owner to userlist
        UserStruct memory userStruct;
        vars.currUserID++;
        userStruct = UserStruct({
            isExist: true,
            id: vars.currUserID,
            referrerID: 0,
            referredUsers:0,
            balance:0,
            referalAmount:0,
            pool2ReferredUsers:0,
            pool3ReferredUsers:0
            
        });
        users[ownerWallet] = userStruct;
        userList[vars.currUserID] = ownerWallet;
        
        //add user to pool1 user
        pool1userStruct memory pool1=pool1userStruct({
            id:users[ownerWallet].id,
            level:1,
            amountlevel1:0,
            amountlevel2:0,
            amountlevel3:0,
            amountlevel4:0
        });
        pool1Users[users[ownerWallet].id]=pool1;
        pool1level1activeUserID=1;
        pool1level2activeUserID=1;
        pool1level3activeUserID=1;
        pool1level4activeUserID=1;
        //add owner to pool1
        PoolUserStruct memory pooluserStruct;
        vars.pool1currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool1currUserID,
            payment_received:0
        });
        
        pool1users[msg.sender] = pooluserStruct;
        pool1userList[vars.pool1currUserID]=msg.sender;
        
        //add owner to pool2
        vars.pool2currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool2currUserID,
            payment_received:0
        });
        vars2.pool2activeUserID=vars.pool2currUserID;
        pool2users[msg.sender] = pooluserStruct;
        pool2userList[vars.pool2currUserID]=msg.sender;
        
       //add owner to pool3
        vars.pool3currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool3currUserID,
            payment_received:0
        });
        vars2.pool3activeUserID=vars.pool3currUserID;
        pool3users[msg.sender] = pooluserStruct;
        pool3userList[vars.pool3currUserID]=msg.sender;
        
       //add owner to pool4
        vars.pool4currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool4currUserID,
            payment_received:0
        });
        vars2.pool4activeUserID=vars.pool4currUserID;
        pool4users[msg.sender] = pooluserStruct;
        pool4userList[vars.pool4currUserID]=msg.sender;
        
        //add owner to pool5
        vars.pool5currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool5currUserID,
            payment_received:0
        });
        vars2.pool5activeUserID=vars.pool5currUserID;
        pool5users[msg.sender] = pooluserStruct;
        pool5userList[vars.pool5currUserID]=msg.sender;
        
        //add owner to pool6
        vars.pool6currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool6currUserID,
            payment_received:0
        });
        vars2.pool6activeUserID=vars.pool6currUserID;
        pool6users[msg.sender] = pooluserStruct;
        pool6userList[vars.pool6currUserID]=msg.sender;
        
       //add owner to pool7
        vars.pool7currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool7currUserID,
            payment_received:0
        });
        vars2.pool7activeUserID=vars.pool7currUserID;
        pool7users[msg.sender] = pooluserStruct;
        pool7userList[vars.pool7currUserID]=msg.sender;
        
       //add owner to pool8
        vars.pool8currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool8currUserID,
            payment_received:0
        });
        vars2.pool8activeUserID=vars.pool8currUserID;
        pool8users[msg.sender] = pooluserStruct;
        pool8userList[vars.pool8currUserID]=msg.sender;
        
       //add owner to pool9
        vars.pool9currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool9currUserID,
            payment_received:0
        });
        vars2.pool9activeUserID=vars.pool9currUserID;
        pool9users[msg.sender] = pooluserStruct;
        pool9userList[vars.pool9currUserID]=msg.sender;
        
       //add owner to pool10
        vars.pool10currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool10currUserID,
            payment_received:0
        });
        vars2.pool10activeUserID=vars.pool10currUserID;
        pool10users[msg.sender] = pooluserStruct;
        pool10userList[vars.pool10currUserID]=msg.sender;
        
        //add owner to pool11
        vars.pool11currUserID++;
        pooluserStruct = PoolUserStruct({
            isExist:true,
            id:vars.pool11currUserID,
            payment_received:0
        });
        vars2.pool11activeUserID=vars.pool11currUserID;
        pool11users[msg.sender] = pooluserStruct;
        pool11userList[vars.pool11currUserID]=msg.sender;
    }
    
    //enter the system by paying minimum 0.1 ether and level 1 is buyed automatically
    function enterSystem(uint _referrerID) public payable{
        require(msg.value>=ENTRY_FEES,"You have to minimum 0.1 ether for entry");
        require(_referrerID > 0 && _referrerID <= vars.currUserID, 'Incorrect referral ID');
        require(!users[msg.sender].isExist, "User Exists");
        UserStruct memory userStruct;
        vars.currUserID++;
        userStruct = UserStruct({
            isExist: true,
            id: vars.currUserID,
            referrerID: _referrerID,
            referredUsers:0,
            balance:0,
            referalAmount:0,
            pool2ReferredUsers:0,
            pool3ReferredUsers:0
        });
        users[msg.sender] = userStruct;
        userList[vars.currUserID]=msg.sender;
        users[userList[users[msg.sender].referrerID]].referredUsers=users[userList[users[msg.sender].referrerID]].referredUsers+1;
        buyPool1(msg.sender);
        emit initialEntryEvent(msg.sender, userList[_referrerID], now);
    }
    
    // pay user for referal initially
     function payReferral(uint _poolNumber,address _user) internal {
        address referer;
        referer = userList[users[_user].referrerID];
        bool sent = false;
        uint pool_price=getPoolPrice(_poolNumber);
        uint amount = (pool_price * 20) / 100;
        users[userList[users[msg.sender].referrerID]].referalAmount=users[userList[users[msg.sender].referrerID]].referalAmount+amount;
        sent = address(uint160(referer)).send(amount);
        if(sent)
        {
            emit referalAmountSentEvent(_poolNumber,_user,referer,amount,now);
        }
     }
    
   //buy pool11currUserID
    function buyPool1(address _user) internal{
        //add user to pool1 user
        require(users[msg.sender].isExist, "User Not Registered");
        
        bool isinpool = isInPool(1,msg.sender);
        require(!isinpool, "Already in AutoPool");
        
        
        bool isPriceValid = checkPrice(1,msg.value);
        require(isPriceValid,"Price of Pool is Wrong");
        
        PoolUserStruct memory userStruct;
        //address poolCurrentuser=getPoolCurrentUser(poolNumber);
        increasePoolCurrentUserID(1);
        
        userStruct = PoolUserStruct({
            isExist:true,
            id:getPoolCurrentUserID(1),
            payment_received:0
        });
        assignPoolUser(1,msg.sender,userStruct.id,userStruct);
       
        //direct referal 20%
        address referer;
        referer = userList[users[msg.sender].referrerID];
        payReferral(1,referer);      
        
        pool1userStruct memory pool1=pool1userStruct({
            id:users[_user].id,
            level:1,
            amountlevel1:pool1Users[users[_user].id].amountlevel1,
            amountlevel2:pool1Users[users[_user].id].amountlevel2,
            amountlevel3:pool1Users[users[_user].id].amountlevel3,
            amountlevel4:pool1Users[users[_user].id].amountlevel4
        });
         pool1Users[users[_user].id]=pool1;
        if(vars.pool1currUserID>=pool1level1activeUserID*3+1)
        {
            pool1Users[pool1level1activeUserID].level+=1;
            pool1Users[pool1level1activeUserID].amountlevel1+=3*0.02 ether;
            pool1level1activeUserID++;
        }
       if(vars.pool1currUserID>=pool1level2activeUserID*9+4){
            pool1Users[pool1level2activeUserID].level+=1;
            pool1Users[pool1level2activeUserID].amountlevel2+=9*0.015 ether;
            pool1level2activeUserID++;
       }
       if(vars.pool1currUserID>=pool1level3activeUserID*27+13){
            pool1Users[pool1level3activeUserID].level+=1;
            pool1Users[pool1level3activeUserID].amountlevel3+=27*0.15 ether;
            pool1level3activeUserID++;
       }
       if(vars.pool1currUserID>=pool1level3activeUserID*27+13){
            pool1Users[pool1level4activeUserID].level+=1;
            pool1Users[pool1level4activeUserID].amountlevel4+=81*0.015 ether;
            pool1level4activeUserID++;
       }
    }
    
    
    //buyPool
    function buyPool(uint poolNumber) public payable{
        require(users[msg.sender].isExist, "User Not Registered");
        
        bool isinpool = isInPool(poolNumber,msg.sender);
        require(!isinpool, "Already in AutoPool");
        
        require(poolNumber>=2,"Pool number <2");
        require(poolNumber<=11,"Pool number >11");
        
        bool isPriceValid = checkPrice(poolNumber,msg.value);
        require(isPriceValid,"Price of Pool is Wrong");
        
        PoolUserStruct memory userStruct;
        //address poolCurrentuser=getPoolCurrentUser(poolNumber);
        increasePoolCurrentUserID(poolNumber);
        
        userStruct = PoolUserStruct({
            isExist:true,
            id:getPoolCurrentUserID(poolNumber),
            payment_received:0
        });
        assignPoolUser(poolNumber,msg.sender,userStruct.id,userStruct);
       
        //direct referal 20%
        address referer;
        referer = userList[users[msg.sender].referrerID];
        payReferral(poolNumber,referer);        

        //global //maintanance //investment
        uint pool_price=getPoolPrice(1);
        uint amount = (pool_price*20)/100;
        uint g1 = (pool_price * 7) / 100;
        global+=g1;
        
        //send maintanance to owner
        withdrawMoneyOwner((pool_price * 3)/100);
        
        uint activeUserId = getPoolActiveUserId(poolNumber);
        uint curruserID = getPoolCurrentUserID(poolNumber);
        if(curruserID>=activeUserId*3+1){
            users[getPoolActiveUser(poolNumber)].balance+=amount;
            increasePoolActiveUserID(poolNumber);
        }
        emit buyPoolEvent(msg.sender,poolNumber,pool_price,now);
    }

    // check if the user is in given pool
    function isInPool(uint _poolNumber,address _PoolMember) internal view returns (bool){
        if (_poolNumber == 1)
            return pool1users[_PoolMember].isExist;
        else if (_poolNumber == 2)
            return pool2users[_PoolMember].isExist;
        else if (_poolNumber == 3)
            return pool3users[_PoolMember].isExist;
        else if (_poolNumber == 4)
            return pool4users[_PoolMember].isExist;
        else if (_poolNumber == 5)
            return pool5users[_PoolMember].isExist;
        else if (_poolNumber == 6)
            return pool6users[_PoolMember].isExist;
        else if (_poolNumber == 7)
            return pool7users[_PoolMember].isExist;
        else if (_poolNumber == 8)
            return pool8users[_PoolMember].isExist;
        else if (_poolNumber == 9)
            return pool9users[_PoolMember].isExist;
        else if (_poolNumber == 10)
            return pool10users[_PoolMember].isExist;
        else if (_poolNumber == 11)
            return pool11users[_PoolMember].isExist;
        
        return true;
    }
    
    //check if the there is enough amount to buy given pool
    function checkPrice(uint _poolNumber,uint256 Amount) internal view returns (bool){
        bool ret = false;
        
        if ((_poolNumber == 1)&&(Amount ==pool1_price))
            ret = true;
        else if ((_poolNumber == 2)&&(Amount ==pool2_price))
            ret = true;
        else if ((_poolNumber == 3)&&(Amount ==pool3_price))
            ret = true;
        else if ((_poolNumber == 4)&&(Amount ==pool4_price))
            ret = true;
        else if ((_poolNumber == 5)&&(Amount ==pool5_price))
            ret = true;
        else if ((_poolNumber == 6)&&(Amount ==pool6_price))
            ret = true;
        else if ((_poolNumber == 7)&&(Amount ==pool7_price))
            ret = true;
        else if ((_poolNumber == 8)&&(Amount ==pool8_price))
            ret = true;
        else if ((_poolNumber == 9)&&(Amount ==pool9_price))
            ret = true;
        else if ((_poolNumber == 10)&&(Amount ==pool10_price))
            ret = true;
        else if ((_poolNumber == 11)&&(Amount ==pool11_price))
            ret = true;
        
        return ret;
    }
    
    //check who is active user id for given pool number
    function getPoolActiveUserId(uint _poolNumber) internal view returns (uint){
        if (_poolNumber == 2)
            return vars2.pool2activeUserID;
        else if (_poolNumber == 3)
            return vars2.pool3activeUserID;
        else if (_poolNumber == 4)
            return vars2.pool4activeUserID;
        else if (_poolNumber == 5)
            return vars2.pool5activeUserID;
        else if (_poolNumber == 6)
            return vars2.pool6activeUserID;
        else if (_poolNumber == 7)
            return vars2.pool7activeUserID;
        else if (_poolNumber == 8)
            return vars2.pool8activeUserID;
        else if (_poolNumber == 9)
            return vars2.pool9activeUserID;
        else if (_poolNumber == 10)
            return vars2.pool10activeUserID;
        else if (_poolNumber == 11)
            return vars2.pool11activeUserID;
       
        return 0;
    }
    
    //check who is active user address for given pool number
    function getPoolActiveUser(uint _poolNumber) internal view returns (address){
        if (_poolNumber == 2)
            return pool2userList[vars2.pool2activeUserID];
        else if (_poolNumber == 3)
            return pool3userList[vars2.pool3activeUserID];
        else if (_poolNumber == 4)
            return pool4userList[vars2.pool4activeUserID];
        else if (_poolNumber == 5)
            return pool5userList[vars2.pool5activeUserID];
        else if (_poolNumber == 6)
            return pool6userList[vars2.pool6activeUserID];
        else if (_poolNumber == 7)
            return pool7userList[vars2.pool7activeUserID];
        else if (_poolNumber == 8)
            return pool8userList[vars2.pool8activeUserID];
        else if (_poolNumber == 9)
            return pool9userList[vars2.pool9activeUserID];
        else if (_poolNumber == 10)
            return pool10userList[vars2.pool10activeUserID];
        else if (_poolNumber == 11)
            return pool11userList[vars2.pool11activeUserID];
       
        return address(0);
    }
    
    //increase current user id for given pool used when user is added
    function increasePoolCurrentUserID(uint _poolNumber) internal {
       if (_poolNumber == 1)
            vars.pool1currUserID++;
        else if (_poolNumber == 2)
            vars.pool2currUserID++;
        else if (_poolNumber == 3)
            vars.pool3currUserID++;
        else if (_poolNumber == 4)
            vars.pool4currUserID++;
        else if (_poolNumber == 5)
            vars.pool5currUserID++;
        else if (_poolNumber == 6)
            vars.pool6currUserID++;
        else if (_poolNumber == 7)
            vars.pool7currUserID++;
        else if (_poolNumber == 8)
            vars.pool8currUserID++;
        else if (_poolNumber == 9)
            vars.pool9currUserID++;
        else if (_poolNumber == 10)
            vars.pool10currUserID++;
        else if (_poolNumber == 11)
            vars.pool11currUserID++;
    }
    
    // get id of current user of given pool number
    function getPoolCurrentUserID(uint _poolNumber) internal view returns (uint){
        if (_poolNumber == 1)
            return vars.pool1currUserID;
        else if (_poolNumber == 2)
            return vars.pool2currUserID;
        else if (_poolNumber == 3)
            return vars.pool3currUserID;
        else if (_poolNumber == 4)
            return vars.pool4currUserID;
        else if (_poolNumber == 5)
            return vars.pool5currUserID;
        else if (_poolNumber == 6)
            return vars.pool6currUserID;
        else if (_poolNumber == 7)
            return vars.pool7currUserID;
        else if (_poolNumber == 8)
            return vars.pool8currUserID;
        else if (_poolNumber == 9)
            return vars.pool9currUserID;
        else if (_poolNumber == 10)
            return vars.pool10currUserID;
        else if (_poolNumber == 11)
            return vars.pool11currUserID;
        return 0;
    }
    
    //assign new user to given pool
  function assignPoolUser(uint _poolNumber,address newPoolMember,uint poolCurrentUserID,PoolUserStruct memory userStruct) internal {
        if (_poolNumber == 1){
            pool1users[newPoolMember] = userStruct;
            pool1userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 2){
            pool2users[newPoolMember] = userStruct;
            pool2userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 3){
            pool3users[newPoolMember] = userStruct;
            pool3userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 4){
            pool4users[newPoolMember] = userStruct;
            pool4userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 5){
            pool5users[newPoolMember] = userStruct;
            pool5userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 6){
            pool6users[newPoolMember] = userStruct;
            pool6userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 7){
            pool7users[newPoolMember] = userStruct;
            pool7userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 8){
            pool8users[newPoolMember] = userStruct;
            pool8userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 9){
            pool9users[newPoolMember] = userStruct;
            pool9userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 10){
            pool10users[newPoolMember] = userStruct;
            pool10userList[poolCurrentUserID]=newPoolMember;
        }
        else if (_poolNumber == 11){
            pool11users[newPoolMember] = userStruct;
            pool11userList[poolCurrentUserID]=newPoolMember;
        }
        emit userAssignedEvent(newPoolMember,_poolNumber,now);
    }
    
    // get price of different pools
    function getPoolPrice(uint _poolNumber) internal view returns (uint){
        if (_poolNumber == 1)
            return pool1_price;
        else if (_poolNumber == 2)
            return pool2_price;
        else if (_poolNumber == 3)
            return pool3_price;
        else if (_poolNumber == 4)
            return pool4_price;
        else if (_poolNumber == 5)
            return pool5_price;
        else if (_poolNumber == 6)
            return pool6_price;
        else if (_poolNumber == 7)
            return pool7_price;
        else if (_poolNumber == 8)
            return pool8_price;
        else if (_poolNumber == 9)
            return pool9_price;
        else if (_poolNumber == 10)
            return pool10_price;
        else if (_poolNumber == 11)
            return pool11_price;
        return 0;
    }
    
    //increase pool payment received by current user
    function increasePoolPaymentReceive(uint _poolNumber, address CurrentUser) internal {
        if (_poolNumber == 1)
            pool1users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 2)
            pool2users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 3)
            pool3users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 4)
            pool4users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 5)
            pool5users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 6)
            pool6users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 7)
            pool7users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 8)
            pool8users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 9)
            pool9users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 10)
            pool10users[CurrentUser].payment_received+=1;
        else if (_poolNumber == 11)
            pool11users[CurrentUser].payment_received+=1;
        
    }
    
    
    //increase pool active users when given pool number
    function increasePoolActiveUserID(uint _poolNumber) internal {
        if (_poolNumber == 2)
            vars2.pool2activeUserID+=1;
        else if (_poolNumber == 3)
            vars2.pool3activeUserID+=1;
        else if (_poolNumber == 4)
            vars2.pool4activeUserID+=1;
        else if (_poolNumber == 5)
            vars2.pool5activeUserID+=1;
        else if (_poolNumber == 6)
            vars2.pool6activeUserID+=1;
        else if (_poolNumber == 7)
            vars2.pool7activeUserID+=1;
        else if (_poolNumber == 8)
            vars2.pool8activeUserID+=1;
        else if (_poolNumber == 9)
            vars2.pool9activeUserID+=1;
        else if (_poolNumber == 10)
            vars2.pool10activeUserID+=1;
        else if (_poolNumber == 11)
            vars2.pool11activeUserID+=1;
    }
    
    //get balance of user stored in contract    
    function getEthBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function distributeGlobalAmount(uint _global) public {
        
    }
    
    //get number of referals
    function getNumberOfReferals(uint _id,uint _pool) internal view returns(uint){
        uint referalsCount;
        if(_pool==1)
            referalsCount = users[userList[_id]].referredUsers;
        else if(_pool==2)
            referalsCount = users[userList[_id]].pool2ReferredUsers;
        else if(_pool==3)
            referalsCount = users[userList[_id]].pool3ReferredUsers;
        return referalsCount;
    }
    
    //get number of referals
    function getNumberOfReferals(uint _id) internal view returns(uint){
        uint referalsCount = users[userList[_id]].referredUsers;
        return referalsCount;
    }
    
    //withdraw maintanance amount by owner
    function withdrawMoneyOwner(uint _maintanance) internal{
        require(msg.sender==ownerWallet,"only owner can withraw maintanance amount");
        bool sent=msg.sender.send(_maintanance);
        if(sent){
            
        }
    }
    
    //withdraw money from you balance and transfer to wallet
    function withdrawMoneyTo() public {
    //check if the person refered atleast 3 persons to claim money
    uint amount = users[msg.sender].balance;
    if(msg.sender==ownerWallet)
    msg.sender.transfer(amount);
    else
    {
    require(users[msg.sender].referredUsers>=3,"refer more people to claim your price");
    msg.sender.transfer(amount);
    }
    }
}
