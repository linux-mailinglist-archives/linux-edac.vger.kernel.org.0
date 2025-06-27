Return-Path: <linux-edac+bounces-4269-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B28AEBA59
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jun 2025 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D9188DB55
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jun 2025 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3312E719E;
	Fri, 27 Jun 2025 14:50:18 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95493155A25;
	Fri, 27 Jun 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035818; cv=none; b=aKGkopaXmpwU+rL2Nr4Ovt2nVJCsXBnZceidmWTN2lXKqCc7289mK3EaRRBX9/FDpYZVMkx8ad9JBf+Je5kTrs1YVfiWPg0fpZovWCG03Z53eSfdiqfYqPXvyZpkaKh6rql5+ZHGP6oG0VgOELfcSPc0/I2OV79HaxT3yPAv0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035818; c=relaxed/simple;
	bh=OajsTmkJdLIEF5rm6k7dhQrH565xMLDPFI1F72yojdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kn0RmK8V56CLoVPIGjLxxJwcQ3mAcvNy57GUtLlultWheEwjOnCIeMqeOuJqW2fQOYcKnB6xNTwqqrjjsEAt2f4N57tFm7p9fhVtvyzeDOKS4hc3YwYNPAuHjlD9MGFTGYVS2aA6ZjVhsxoa7iX1z12V7Sj0dmgdFLfH9uPSRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B49101A00;
	Fri, 27 Jun 2025 07:49:58 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F2A53F58B;
	Fri, 27 Jun 2025 07:50:14 -0700 (PDT)
Message-ID: <2de8a66a-7537-4e05-bc4f-9fe73f4d8b6d@arm.com>
Date: Fri, 27 Jun 2025 15:50:10 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: EDAC: Drop inactive reviewers
To: Borislav Petkov <bp@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
References: <20250622161943.4700-1-bp@kernel.org>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250622161943.4700-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Boris,

On 22/06/2025 17:19, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> I know y'all busy with other stuff and don't have time for EDAC review.

Yeah, sorry about the radio-silence.

FWIW:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

