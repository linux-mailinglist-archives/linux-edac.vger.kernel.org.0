Return-Path: <linux-edac+bounces-3103-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDFA37F63
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 11:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8BC164851
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EE2217654;
	Mon, 17 Feb 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BzctW2vf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BD217647
	for <linux-edac@vger.kernel.org>; Mon, 17 Feb 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786517; cv=none; b=GaqZFFvLCm5vXc77W7XjZrx+HZa2utF5UpDA1hGPsJZf7bAewey6dA7PbSH8kr4LeS2N2w2ekfzcItU7umEflKKNupskoMe+yTYBaD8TAD+QG7qrI57A9BsVu0+Icvv8FdMJxvCPwCF9xhhTwZNAsStFvh+l6tx4nwZ+qxjBOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786517; c=relaxed/simple;
	bh=0ik/x5gdQpwFxGRve4EoCIoEDYncm6E5QaBZIZs4S6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYvKakZ23Js/bZV31LIRmHJ8ftO3//6IFNV6RcdPgVE2mH5wJyHT6pvKh6T/61KulwW68XWYlQk147MbcHs91zfHwdcz8n/O1xv87p15JyQ4R30IQTdQLb0RX1Oqh5SEZ1s3KSPDtm2BJMJDU/IXKTENaF7k5YVogxyp53KtkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BzctW2vf; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab744d5e567so775776166b.1
        for <linux-edac@vger.kernel.org>; Mon, 17 Feb 2025 02:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739786514; x=1740391314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMV/tUWTTBpA4vW8CyRHWlBAGTTrRPmL8N3P3dHOplQ=;
        b=BzctW2vfgtn45ApKHXnWpJSM7Igcq76rrn+DHxiudaphAZCSp7ttjquyj8PPBZlQyx
         M9qYOfcumE2zVI7mEPVege2xKSeYbbqO/BOeMpZ6pgIh/yBTy/wQAf2LTREg8jBjiWoC
         4H1Mo0nrCIZoOTVVekYG2tKWH3JXBscDwCywKvuitjfDWbL+aM4oGqL+eyuAa/O7Py/s
         AUsvJVHCBYP8YsSv8HMAXk0XKqxjWhkkCDpw0baerQKEGByswhAiEiHq63129uD5Jzkd
         UdGGXIAALHZ/TbX0V3lh8W7+R9hBix4ipRmtq1wC7lkRcQ0afkJvgLRd8ZZaK+rBJPdH
         hq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786514; x=1740391314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMV/tUWTTBpA4vW8CyRHWlBAGTTrRPmL8N3P3dHOplQ=;
        b=LjteE8x1XFVcyCJms4Ejmop929O46SOEBVHBpDa/NQpB+f8v9dBZ7spNSkmbWGY2/n
         VPCK7IZj0Q1wBCvajU28SimLfVAOnqpMS+lk5JJuVPxNyRJ49MNdFRdzqzQ6cbwkTlqI
         gMQ8K/n2KBdWehGM9WmzZFBmTovi//yilL/Z09EPnTFeNq9PPsJs0wb7E7ToGbj6bJTP
         fLK7jdq159voJrYEXZACQofUfZcASLQ4CrlOk+zFh/Dzld5MkSPai7xMAdIcLl5pdKUp
         ESENxnipx0+iZyNLlAeg8LiTYQIufc+8vhBXUCQAMdoC++yZ9SONFG9+LmLddxqI4THJ
         sbIg==
X-Gm-Message-State: AOJu0Yxh7Ba9G8lPAYk5o+jDdnzW0xRoG3Q2s4uGIFTd3nD8U6xI2wgr
	h1nEs8msYRe679WvNg2IoWOBWDK00wzCTL3OzoTrYNNispxFubhqhMYSUAKUWyY=
X-Gm-Gg: ASbGncvh92DeSYHbz91iAHceb3hc+GpHbSgokJWp3wkdT+HuWkUGYQBMy1/8gwlAbmR
	fYmN06TxQMhzLeDQvJoD8vrcHbC1VnRueFdF+OwFRIpuTBDtbGYmCAf9Nx1+qFCOGqb0UP7JeyV
	fX+8ulG7aeO3Mh5/tKeBOlYQz//I1529CsMcMsFUXRIAXUpblKZWGJk932pJ1eLOV6MnSJNRmvD
	6OzdHeb8+rlA7kqoCUZEmUYeCLJw0xWZJwUJ64z1J2E3PVD0fPwSL4KInGMquokOzQs6XFabQw2
	vDKVfPpn4L/05lBTc6Pwbb2qypT55frnRa5cbf4KNbY=
X-Google-Smtp-Source: AGHT+IFVSN5gkXJhtCi/O+DcvMndotLeH1zglHLdeZ85L2r1nGGgQtQnfumGzJ0IxDgCKsF8Du92fQ==
X-Received: by 2002:a17:907:8e8c:b0:aba:e585:42fa with SMTP id a640c23a62f3a-abae5854477mr976618666b.5.1739786513881;
        Mon, 17 Feb 2025 02:01:53 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b187203sm175736766b.61.2025.02.17.02.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:01:53 -0800 (PST)
Message-ID: <8cce2725-9efe-44e8-b071-f921874d7649@suse.com>
Date: Mon, 17 Feb 2025 12:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 tony.luck@intel.com
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-2-nik.borisov@suse.com>
 <20250216161050.GBZ7IOCofLUUelomR4@fat_crate.local>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20250216161050.GBZ7IOCofLUUelomR4@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.02.25 г. 18:10 ч., Borislav Petkov wrote:
> On Mon, Feb 10, 2025 at 05:47:04PM +0200, Nikolay Borisov wrote:
>> The call is actually a noop because when the MCE is raised the early
>> notifier is the only call site that correctly calls mce_notify_irq()
>> because it also sets mce_need_notify. Remove this call and as a result
>> make mce_notify_irq() static
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   arch/x86/include/asm/mce.h       |  2 --
>>   arch/x86/kernel/cpu/mce/core.c   | 44 ++++++++++++++++----------------
>>   arch/x86/kernel/cpu/mce/inject.c |  1 -
>>   3 files changed, 22 insertions(+), 25 deletions(-)
> 
> So what you're looking at are the remnants of the old soft-inject of MCE
> errors. And it seems that we lost some of that functionality along the way and
> no one has noticed because, well, it seems no one uses it anymore.
> 
> In order to understand how this thing was supposed to work, checkout
> 
> ea149b36c7f5 ("x86, mce: add basic error injection infrastructure")


The original code in  ea149b36c7f5 was setting the notify_user bit via

raise_mce()->machine_check_poll()->mce_log(),
  mce_notify_user() - consumes notify_user set in mce_log above.


  subsequently in 011d82611172 ("RAS: Add a Corrected Errors Collector") 
you factored out the code from mce_log() mce_first_notifier, where the 
bit setting remains to this day, but since it's been removed from 
mce_log() it made the call in raise_local() defunct.


Considering that no one complained about this after all these years and 
that the dev-mcelog is deprecated I think it still makes sense to make 
mce_notify_irq() private

> 
> and follow what raise_mce() does and pay attention to notify_user which is
> what mce_need_notify was called back then.
> 
> Remember to have fun :-P
> 


