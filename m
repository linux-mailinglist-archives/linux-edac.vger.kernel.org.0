Return-Path: <linux-edac+bounces-3565-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9FFA8AC77
	for <lists+linux-edac@lfdr.de>; Wed, 16 Apr 2025 02:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE2E3A5C63
	for <lists+linux-edac@lfdr.de>; Wed, 16 Apr 2025 00:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D4137E;
	Wed, 16 Apr 2025 00:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g2VbcKjV"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B774819;
	Wed, 16 Apr 2025 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744761917; cv=none; b=FDyBtJoC01Dkf/2BO+8G6wAffo7q8o2SD+Dm4jl4FrW2WcggkXyeGjP2H/IATU0u8Rr9bIFAr26mAyrh3j9RT4BIrtlnfpn2KxgMeMe1BKq/U6tPVLxrYjEd8bDZCIqkABz3o5NSlalSraTD9284ECSDdH1Sgrz2oNfovlCGjHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744761917; c=relaxed/simple;
	bh=hZobG+FGhYW5bOUkfWEbXc5XYdYruXFuQNPQIJea+cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhhFlIH8Zr4kDsiOgJn9I9gUdXaHDluu/5eHdlf0M5ClGOnaM2H1d+vmU6c0sEZb94+7UQgNq4q0S+m1GsUaWqcQOqKhJjlHL+0wYNxiX5tfhRt5JH/vEQYOEqZhI+ko/+e/r8/aPmHiW+oGD5F8hrRZS4BeBe0BUaJXeBtECkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g2VbcKjV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.0.36] (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 26B4C210C44F;
	Tue, 15 Apr 2025 17:05:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26B4C210C44F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744761914;
	bh=Itt7QUONbx3ndLE+bRo+FLPm8asA/RVXkU2JleFvdCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g2VbcKjVinA0Iz5Xrkjq1PsZXRPSoW22m6WTIj3qsxNxxqQAfip2r/G6O2EX4VVEU
	 YRiRnZVydgQJmCUegZKAW5+XaC2jDkAjs1jt9x6VW/y8Wf5LRixdQ2s2/q6nOc4mc/
	 DdRTz0IFk86uW3qmyo/mUqvOGG23DzfgoE6RLy8I=
Message-ID: <3de64545-6247-4aaf-b1af-c9d5fe038eaa@linux.microsoft.com>
Date: Tue, 15 Apr 2025 17:05:11 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 PATCH 0/2] Add L1 and L2 error detection for A53, A57 and A72
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Marc Zyngier <maz@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org
References: <1744409319-24912-1-git-send-email-vijayb@linux.microsoft.com>
 <20250413203923.GAZ_wg-_lYFt5hkfbh@fat_crate.local>
Content-Language: en-US
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20250413203923.GAZ_wg-_lYFt5hkfbh@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/13/25 13:39, Borislav Petkov wrote:
> On Fri, Apr 11, 2025 at 03:08:37PM -0700, Vijay Balakrishna wrote:
>> Hello,
>>
>> This is an attempt to revive [v5] series. I have attempted to address comments
>> and suggestions from Marc Zyngier since [v5]. Additionally, I have extended
>> support for A72 processors. Testing on a problematic A72 SoC has led to the
>> detection of Correctable Errors (CEs). I am eager to hear your suggestions and
>> feedback on this series.
> 
> Did you not read Marc's note:
> 
> https://lore.kernel.org/all/86a58kl51r.wl-maz@kernel.org/
> 
> or
> 
> https://lore.kernel.org/all/86frigkmtd.wl-maz@kernel.org/
> 
> ?
> 

Hi Borislav,

I did see the second reply above, but not the first before posting v7. I 
opted to submit v7 after addressing the comments and issues identified 
in v6 for the benefit of those interested. Sascha's v5 series has helped 
us in confirming a problematic A72 indeed suffering from CEs.

Our primary focus is on A72. I can re-submit with modifications solely 
related to A72 and exclude A53 and A57. As Tyler mentioned, we have a 
significant number of A72-based systems in our fleet, and timely 
replacements via monitoring CEs will be instrumental in managing them 
effectively. Please share your thoughts.

Thanks,
Vijay



