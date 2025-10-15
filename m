Return-Path: <linux-edac+bounces-5056-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A4BDFD35
	for <lists+linux-edac@lfdr.de>; Wed, 15 Oct 2025 19:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4687919A4C6A
	for <lists+linux-edac@lfdr.de>; Wed, 15 Oct 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47922259D;
	Wed, 15 Oct 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="kt1r7eN2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4320296A
	for <linux-edac@vger.kernel.org>; Wed, 15 Oct 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548615; cv=none; b=ltEamPXYBcJqPd1EZT2SHJVq7h1hI1b9xGDaAZ38fYNuWFojRWamBDLKeZjMp18ksitgTiLlLRaBm32eFVLbpSLwevpzNHBt8D3eMS/EtTK+/P5oXPaQ0668NeGamU0/7GwiSDX06YjNbQWKZHlYDOcJqSDumw1wimgkCaR2jKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548615; c=relaxed/simple;
	bh=kC04YDuN0hhjIt4TueNY63Jt/eyZruzVh2BxHT4SP1o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Xy2UQkJR2Y1U6FzONlf4UxyK6es4i5W1JjZVjJjW+GrJYxFw/6YNpmLlI1olp2kd6V6uCBcGAaOzHT++ZBZqjabwwl1pM265Uak+3W7li6B4Ews3s66OMh2IFOP1kJKa94gp2Z0Zzrtw0fd6DPVBMEBz/1Aq6enM1kbQCuj3yHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io; spf=pass smtp.mailfrom=tuta.io; dkim=pass (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b=kt1r7eN2; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.io
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 34435D077361
	for <linux-edac@vger.kernel.org>; Wed, 15 Oct 2025 19:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760548605;
	s=s1; d=tuta.io;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=lzPlPEO6ulkSgP/TCPe0IC/cN44oTIypST9DC/v7+pU=;
	b=kt1r7eN2UtnJ+cgAIj9LSXGFF3EvC0j50rptYyL6fZ4hfim9e026FQDE1/Kdss8w
	tnQDZ3vxkc1osLLjKQ2E1UYxbWJUWdWyHRFAlbNFA+T4RxZiL4XZjnISqkJYu2ldcqi
	fFeA9Pl1GZHQSCvOxNKHmA5szTOayrQQ392PScwu3aQoO223mmCff5LDbBEKgIagYAz
	4YwahtR5TC++U9UZKxwC0On7qUAa9lPXB+CQjEQ7vwRwr4698Kgvw4PjAF9mfyJ3TaD
	Njb9zNn4u4UuCtphxiB7lHVZJD013bFCEvDpQAFgTXRGA4rxuyGN2VOvVicCj9pXH5X
	wgsixabTUQ==
Date: Wed, 15 Oct 2025 19:16:45 +0200 (GMT+02:00)
From: howtobserve1@tuta.io
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Matt Corallo <git@bluematt.me>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
Message-ID: <ObcrwdE--F-9@tuta.io>
In-Reply-To: <CY8PR11MB7134927522BE72D9772314D889E8A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <8ae4f35a-0cec-455f-8f2c-ce04fb99aa40@bluematt.me> <CY8PR11MB7134927522BE72D9772314D889E8A@CY8PR11MB7134.namprd11.prod.outlook.com>
Subject: RE: [PATCH] EDAC/ie31200: Add support for additional Alder Lake-S
 CPUs
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi everyone,

There are indeed still missing DIDs for Alder Lake:
0x4650 (6+0, e.g. i5 12500 or 12600)
0x4630 (4+0, e.g. i3 12100E)
0x4610 (2+0, e.g. Pentium Gold G7400E)

The entire Catlow range for low end servers are also not present (Xeon E-2400 and 6300P) 0xA711 to 0xA713

Not sure if there is interest adding in at least 0x4650 which is more commonly used

-- 


Oct 15, 2025, 09:42 by qiuxu.zhuo@intel.com:

> Hi Matt Corallo,
>
>> From: Matt Corallo <git@bluematt.me>
>> Sent: Tuesday, October 14, 2025 10:59 PM
>> To: linux-edac@vger.kernel.org
>> Subject: [PATCH] EDAC/ie31200: Add support for additional Alder Lake-S
>> CPUs
>>
>> 180f091224a002f8bd1629307c34619a5626841e added support for some but
>> not all Alder Lake-S SoCs. This adds support for, at least, the i5-12600K
>> which works with the existing Alder Lake-S config.
>>
>> Signed-off-by: Matt Corallo <git@bluematt.me>
>> ---
>>  drivers/edac/ie31200_edac.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
>> index 5c1fa1c0d12e..010317e33738 100644
>> --- a/drivers/edac/ie31200_edac.c
>> +++ b/drivers/edac/ie31200_edac.c
>> @@ -99,6 +99,7 @@
>>
>>  /* Alder Lake-S */
>>  #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
>> +#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2	0x4648 /* e.g. i5-
>> 12600K */
>>
>
> The commit [1] merged in v6.18-rc1 has already added Alder Lake 
> compute die ID for EDAC support.
>
> [1] 71b69f817e91 ("EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC support")
> https://lore.kernel.org/all/20250819161739.3241152-1-kyle@kylemanna.com/
>
> - Qiuxu
>


