/*
 * Copyright 2008-2011 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.techwin.common.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Aspect
@Service
public class LoggingAspect {

	@Pointcut("execution(* com.techwin..*Impl.*(..))")
	public void serviceMethod() {}

	@Before("serviceMethod()")
	public void beforeLogging(JoinPoint thisJoinPoint) {
		Class<? extends Object> clazz = thisJoinPoint.getTarget().getClass();
		String methodName = thisJoinPoint.getSignature().getName();
		Object[] arguments = thisJoinPoint.getArgs();

		StringBuilder argBuf = new StringBuilder();
		StringBuilder argValueBuf = new StringBuilder();
		int i = 0;
		for (Object argument : arguments) {
			String argClassName = argument.getClass().getSimpleName();
			if (i > 0) {
				argBuf.append(", ");
			}
			argBuf.append(argClassName + " arg" + ++i);
			argValueBuf.append(".arg" + i + " : " + argument.toString() + "\n");
		}

		if (i == 0) {
			argValueBuf.append("No arguments\n");
		}

		StringBuilder messageBuf = new StringBuilder();
		messageBuf.append("before executing " + methodName + "(" + argBuf.toString() + ") method");
		messageBuf.append("\n-------------------------------------------------------------------------------\n");
		messageBuf.append(argValueBuf.toString());
		messageBuf.append("-------------------------------------------------------------------------------");

		Logger logger = LoggerFactory.getLogger(clazz);
		
		logger.debug(messageBuf.toString());
	}
}
