//
//  C4WorkSpace.m
//  earthMoon
//
//  Created by moi on 12-09-30.
//  Copyright (c) 2012 moi. All rights reserved.
//

#import "C4WorkSpace.h"

#define MOON_PERIGREE 362570.0
#define MOON_APOGEE 405410.0
#define MOON_ALTITUDE (MOON_PERIGREE + MOON_APOGEE) / 2.0f
#define MOON_MEAN_RADIUS 1737.1
#define MOON_ORBITAL_PERIOD 27.321582
#define MOON_ROTATION_PERIOD MOON_ORBITAL_PERIOD

#define EARTH_MEAN_RADIUS 6371.0
#define EARTH_ROTATION_PERIOD 0.99726968

#define MOON_RELATIVE_DISTANCE MOON_ALTITUDE/(EARTH_MEAN_RADIUS*2)

@implementation C4WorkSpace {
    C4Image *earth;
    C4Image *moon;
    C4Shape *moonOrbitShape;
}

-(void)setup {
    C4Image *stars = [C4Image imageNamed:@"stars.png"];
    [self.canvas addImage:stars];

    earth = [C4Image imageNamed:@"earth.png"];
    earth.width = 42.0f;
    earth.center = self.canvas.center;
    [self.canvas addImage:earth];

    moon = [C4Image imageNamed:@"moon.png"];
    moon.width = (MOON_MEAN_RADIUS/EARTH_MEAN_RADIUS) * earth.width;
    
    CGFloat MOON_DIST_EARTH = MOON_RELATIVE_DISTANCE * moon.width;
    
    moonOrbitShape = [C4Shape rect:CGRectMake(0, 0, MOON_DIST_EARTH*2,  MOON_DIST_EARTH*2)];
    moonOrbitShape.fillColor = [UIColor clearColor];
    moonOrbitShape.strokeColor = [UIColor clearColor];
    [moonOrbitShape addImage:moon];
    moon.center = CGPointMake(0,  MOON_DIST_EARTH);
    moonOrbitShape.center = self.canvas.center;
    
    [self.canvas addShape:moonOrbitShape];
    
    [self runMethod:@"beginRotations" afterDelay:0.1f];
}

-(void)beginRotations {
    earth.animationDuration = 2.0f;
    moonOrbitShape.animationDuration = earth.animationDuration * MOON_ORBITAL_PERIOD;
    moon.animationDuration = earth.animationDuration * MOON_ROTATION_PERIOD;
    
    earth.animationOptions = REPEAT | LINEAR;
    moonOrbitShape.animationOptions = REPEAT | LINEAR;
    moon.animationOptions = REPEAT | LINEAR;
    
    earth.rotation = TWO_PI;
    moonOrbitShape.rotation = TWO_PI;
    moon.rotation = TWO_PI;
}
					
@end
