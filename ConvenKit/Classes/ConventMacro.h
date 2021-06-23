//
//  ConventMacro.h
//  RoboHome
//
//  Created by Enix Yu on 4/1/2017.
//  Copyright © 2017 RobotBros. All rights reserved.
//

#ifndef ConventMacro_h
#define ConventMacro_h

/**
 *@brief Get the UINib instance for specific class name
 */
#define CV_UINibForClass(Cls)    [UINib nibWithNibName:NSStringFromClass([Cls class]) bundle:nil]


#define CV_RegisterNibForTableView(nibClass, tableView)  \
    [tableView registerNib:CV_UINibForClass(nibClass) forCellReuseIdentifier:NSStringFromClass([nibClass class])];

#endif /* ConventMacro_h */
