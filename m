Return-Path: <linux-edac+bounces-3515-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96025A85080
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 02:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981F49A2492
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 00:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283862F2F;
	Fri, 11 Apr 2025 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crc.id.au header.i=@crc.id.au header.b="jVOJctsH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mailfilter.crc.id.au (mailfilter.crc.id.au [202.172.99.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199236D
	for <linux-edac@vger.kernel.org>; Fri, 11 Apr 2025 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.172.99.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744330994; cv=none; b=dz3mABd3V1k6eQD5MEHPdsajagz1+CsRX5BwpeieAYnCY1UwlgLWIrB9HQhytoDt6QST9Fbcmr6jUJIerfLjKa//Esscz6gxemr4ejGPNWfZrXPQF4HWFT7oijJKkDSN4Nj5XmB9ZWbtj/Cq5bHnDVTTYtTg3M5vZtL2wJCey6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744330994; c=relaxed/simple;
	bh=dd8ObEKw3qZqdDC3SqzcP1PalKmADUxIyDziNJqSn60=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VJRw8biagJp+LVPivi6aWLrDcUml63PHAWnWDnoq8v5U0WNo0T0Zb3HJscaUdbKLxKM5DmhCySf6agPvCUheHlBvldkqYJt6KdffGkbvPyT1tDE6EJO19TUMzDD+SiTSxSlHhToV+wR8Jh8ctt32mHTSiKHMlTq2cCb0jkl1rws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crc.id.au; spf=pass smtp.mailfrom=crc.id.au; dkim=pass (4096-bit key) header.d=crc.id.au header.i=@crc.id.au header.b=jVOJctsH; arc=none smtp.client-ip=202.172.99.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crc.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crc.id.au
Received: from mailfilter.crc.id.au (localhost.localdomain [127.0.0.1])
	by mailfilter.crc.id.au (Proxmox) with ESMTP id A98DB61A1C;
	Fri, 11 Apr 2025 10:23:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crc.id.au; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=default; bh=qdSL+kgVLT3Banbyo2dRo61Txo
	lzVk3wXadpPI0JyjE=; b=jVOJctsHWhM6bdyCa5PCeDPcWKtc8PZSGAQEXmk5zj
	ZdVddfSsYmnvJm5HeM8MAEtj47P8tHaoW2+L1aoBwo1oSOAli53kD5+S+ecYr2bl
	TBW8ne947q+kM/zepFdyagguJyWWIWGc155UacocZAgsu8nKphBzMApfAaLMQJ6j
	z5GHiUFb7WmF2akspOPsry1IyHa1iHakYwoT7SE1gUlJ+TkEFEehzK4ZDUw+hazk
	l2IAbppiRPDnvwXa3IDqPtEkxbQBN9KGZRB3ExUo4A8qMUDWt6/WFKPhiB6S30Bu
	g+l3K84yLijg1RGMuTJBrtKe/Wl8UBRkvA85NcSQdAGovAH4t+bZKgsfkuQrmtYg
	3ZgqA2ord4ZdIVJkd0IytaM1C2UNVSMWHO5xj9SlEoGIRym8d8ABa1hY74uQRNzB
	rEZ6qfbCRt0EHd6MCmXTSr1ol5MnPgw9ICLKMHTqHTzFDXC+YNOfUNP2J+nphAya
	da/acdseRGetDNvpbDYYv2fHBR2h/UZpof/7ZFJAdya5T61pufnbE0CLUynWGQQ4
	1V2qNw1sLbhLg8iNhp4vaMFxMLUH87+8USSvKOMuUpC3cqv5/NneomXTqIDDNxo5
	e/vGj69zFRVcdfFzrCfpzq5PbxfYO+NYboVr/D6sb3sPX+U+HqVwVZgvkadCt5Zi
	s=
Message-ID: <1a75da13-c073-48bd-a69b-7cc9543b6583@crc.id.au>
Date: Fri, 11 Apr 2025 10:23:01 +1000
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Constant EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR printed in
 dmesg
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <de007cb2-e64d-46b8-89d0-a064a7ab369b@crc.id.au>
 <CY8PR11MB7134FD1809BF82C3828B499789B72@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-AU
From: Steven Haigh <netwiz@crc.id.au>
In-Reply-To: <CY8PR11MB7134FD1809BF82C3828B499789B72@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/25 22:14, Zhuo, Qiuxu wrote:
> Hi Steven,
> 
>> From: Steven Haigh <netwiz@crc.id.au>
>> [...]
>> [   12.870378] EDAC MC0: Giving out device to module igen6_edac
>> controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (POLLED)
>> [   12.870433] EDAC igen6: v2.5.1
>> [   12.870449] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
>> [   12.870451] EDAC igen6 MC0: ADDR 0x807fbfffe0
>> ....
>> [   42.810794] EDAC igen6 MC0: ADDR 0x807fbfffe0
>> [   43.834707] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
>> [   43.834724] EDAC igen6 MC0: ADDR 0x807fbfffe0
>> ....
> 
> Thanks for reporting this.
> 
> Could you please build the kernel with "CONFIG_EDAC_DEBUG=y" enabled and
> provide a complete dmesg log (including the system boot log)?

Hi Qiuxu,

I don't have a way to do this currently. I'm pulling the latest test 
packages for Fedora 41 from:

https://koji.fedoraproject.org/koji/packageinfo?packageID=8

I noticed that 6.14.2 has been released which contains the patch:
	EDAC/igen6: Fix the flood of invalid error reports

I'll install this kernel package on the UP7000 board and report back if 
I see any further issues.

-- 
Steven Haigh

📧 netwiz@crc.id.au
💻 https://crc.id.au



