Return-Path: <linux-edac+bounces-3969-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B393ABEB8B
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7520D1BA5231
	for <lists+linux-edac@lfdr.de>; Wed, 21 May 2025 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDC82309B5;
	Wed, 21 May 2025 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FdVGozbe"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA64B4430;
	Wed, 21 May 2025 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806989; cv=none; b=TaoM+9/DCuaY3CoIpWPBjMwI7MkRaORJHIdZfsnGQrbzbkMhYTGcv/tDUduQRunS8UFd1ZNUswofT8AJWInHNVAt9Xe4V1MHlpMBNv3ynVgh0ibLq7jsjWmZ+Xz1OX2aSQ9Kuk8WB0PyUKLQsaAxpl2YgijRtwlQwK/0prhIXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806989; c=relaxed/simple;
	bh=CPFCDaA/lcqIvz6K9DFQHewK6uAUu2NeTEsAovPkLTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GznzGrZhEC37JomLItfS18vXdkpqhp3RVEnVp05JF9N2DvpTMo2s+XGCftdp1WkGCgBn8sNpcQowAYBErjwLJbhn/DBV5qheZ5kfnsnjq/9Y5CrXSK7I1zWoyuy8kFcrNxgcD2iflcGJkawMCmdOjRqIpQGvIWsG/cNhlKGT0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FdVGozbe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.200.30] (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C4AC20277E4;
	Tue, 20 May 2025 22:56:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C4AC20277E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747806987;
	bh=JrahNYN1nFgLqUBmUeNiVpHK9mLr48HhRMyMudWE2KU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FdVGozbedOPB1110KM0NVzyPf+kgAQwutNFqwohpLsygI1YszWVY5/jta4IkALQoZ
	 jPdmqSZV4ZKnoaQL9V3PfeYdvo/EaS5rdTbVMeJF53MR5/7dPjQLRAuC8hXa3cAjOc
	 kKZqcz67I4rtMj4ajsnCb0kBKI2KN6cmJsUR1IJI=
Message-ID: <3d000c56-6cc9-4bf3-aa76-39becd05cfcd@linux.microsoft.com>
Date: Tue, 20 May 2025 22:56:33 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: arm: cpus: Add edac-enabled property
To: Rob Herring <robh@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Marc Zyngier <maz@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-3-git-send-email-vijayb@linux.microsoft.com>
 <20250519090253.GGaCrzvRFC75JnFN1S@fat_crate.local>
 <CAL_Jsq+T=ARcSe9NByMyiFDN9pns=0f2c=hFEK=o6668MARz8g@mail.gmail.com>
Content-Language: en-US
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <CAL_Jsq+T=ARcSe9NByMyiFDN9pns=0f2c=hFEK=o6668MARz8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/2025 5:07 PM, Rob Herring wrote:
> On Mon, May 19, 2025 at 4:03 AM Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Thu, May 15, 2025 at 05:06:12PM -0700, Vijay Balakrishna wrote:
>>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>>
>>> Some ARM Cortex CPUs including A72 have Error Detection And
>>> Correction (EDAC) support on their L1 and L2 caches. This is implemented
>>> in implementation defined registers, so usage of this functionality is
>>> not safe in virtualized environments or when EL3 already uses these
>>> registers. This patch adds a edac-enabled flag which can be explicitly
>>> set when EDAC can be used.
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> [vijayb: Limit A72 in the commit message]
>>> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>
>> This needs an Ack from DT maintainers.
> 
> That will happen when my review comments are implemented. Those were
> on v1. Not this v1, but the prior v1. Version your patches correctly
> please.

Sorry, I will include in my next patch series.

Vijay



