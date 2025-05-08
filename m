Return-Path: <linux-edac+bounces-3867-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E41AAF204
	for <lists+linux-edac@lfdr.de>; Thu,  8 May 2025 06:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4C04E320A
	for <lists+linux-edac@lfdr.de>; Thu,  8 May 2025 04:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2FC20409A;
	Thu,  8 May 2025 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PzQsT6ED"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2932CA9;
	Thu,  8 May 2025 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677674; cv=none; b=OVuPaikaHcCv9s8w8R1GuBR9jJTeaGg78JPlpmZyDUu6V9GslAs5opg+RrdMb6/GaoVHiVZNox6uWIu3TdrrUnzfRbZKINy4znb3/DZQvh35Eu0QEQU4iwnxdqw0qXZc6TcftLfRHSuYJqgRZQbs/LVcr5Z941G+nzly3SeBZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677674; c=relaxed/simple;
	bh=kkFlGg5bNPTJPjCV1zeL3eKzkCAHsT7R0AsSJTUn46Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGemK9K9QT+WUyGP5IpdHonn1HtJZd72gPao9JijuqfM2YqI1twMzbKC0Z8bbZoAN2vVbfckTv+jqCco3y4d1dzmBZUGNqX1LcfFoUV+pIWOkpNctjy+nk9AsZvqHBylXqrzDkGEGYS+UBXktVZfKhVXu5xThjoSy4vUR1oEUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PzQsT6ED; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.0.18] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 042A121199E9;
	Wed,  7 May 2025 21:14:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 042A121199E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746677672;
	bh=qjjRDbgXc5t2xS79DeCctPMPk2aN4d/AA83/fxurBo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PzQsT6EDggx9vwP8aXC7LjcT1HCntXX6m7vqa+lTLGoggaeS1CMDAdPe3hRX0JtTX
	 ZkOXEd7L8XILk7eyA626yAvp8XrLuRSMN6WdF/R9Rg0HUFHPHigw9Eqkt8WthSibWf
	 8tXz5CW0LCJd+2KAr7oSf47/WJO+hD7RUPYZQfLM=
Message-ID: <013cab30-7314-46bb-afd6-156632835fcc@linux.microsoft.com>
Date: Wed, 7 May 2025 21:14:30 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8 PATCH 0/2] Add L1 and L2 error detection for A53, A57 and A72
To: Borislav Petkov <bp@alien8.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Marc Zyngier <maz@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org
References: <1746404860-27069-1-git-send-email-vijayb@linux.microsoft.com>
 <20250505091044.GCaBiAlCFqVgV7-3TJ@fat_crate.local>
Content-Language: en-US
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20250505091044.GCaBiAlCFqVgV7-3TJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/25 02:10, Borislav Petkov wrote:
> On Sun, May 04, 2025 at 05:27:38PM -0700, Vijay Balakrishna wrote:
>> Hello,
>>
>> This is an attempt to revive [v5] series. I have attempted to address comments
>> and suggestions from Marc Zyngier since [v5]. Additionally, I have extended
> 
> I'd like to hear from ARM folks here, whether this makes sense to have still.
> 
>> support for A72 processors. Testing the driver on a problematic A72 SoC
>> has led to the detection of Correctable Errors (CEs). Below are logs captured
>> from the problematic SoC during various boot instances.
>>
>> [  876.896022] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
>>
>> [ 3700.978086] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
>>
>> [  976.956158] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
>>
>> [ 1427.933606] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
>>
>> [  192.959911] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
>>
>> Our primary focus is on A72. We have a significant number of A72-based systems
> 
> Then zap the support for the other CPUs as supporting those is futile.
> 
> cortex_arm64_l1_l2.c - I don't want an EDAC driver per RAS functional unit.
> Call this edac_a72 or whatever, which will contain all A72 RAS functionality
> support. ARM folks will give you a good idea here if you don't have.
> 
> Also, I'd need at least a reviewer entry to MAINTAINERS for patches to this
> driver because you'll be the only ones testing this as you have vested
> interest in this working.
> 
> The dt patch needs a reviewed-by too.
> 
> Once that is addressed, I'll take a look.
> 
> Thx.
> 

Thank you, Boris.

I will soon be posting a new series featuring only A72 functionality. 
Could the ARM folks on Cc please comment on additional changes we can 
include for A72?

Tyler and I can serve as joint reviewers, and I'll update the 
MAINTAINERS file accordingly.

Krzysztof, I would appreciate your reviewed-by for the DT patch when I 
post the next version.

Thanks,
Vijay

