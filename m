Return-Path: <linux-edac+bounces-4489-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F76B1843D
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 16:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46007A830D6
	for <lists+linux-edac@lfdr.de>; Fri,  1 Aug 2025 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47226CE2B;
	Fri,  1 Aug 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b="tG5AH+4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8sF0dVf"
X-Original-To: linux-edac@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3FE2F5B;
	Fri,  1 Aug 2025 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059959; cv=none; b=QK6yRY/PLtxmLoVr6U86FlhTjBtDQ52OCpPa0ARr//Y87Penwe00IXzZ7yz+egRfoqxyM4QFoENf4xmnxzA2WsSpUoryxGvgUBqhnEnSsSiX/HfCxciMHLkJLraJRj67H+5r7BLGPacT4M92VPF3sIbPMVSvvYqARhPnFEkz3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059959; c=relaxed/simple;
	bh=h/454LMXoyHTe0O4dGak/GV7rhXcx3iVZ2cXXOnZr7M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XvuyQ432zbsEGIVL0RcGpnkIL4MJ6a+AOLGcIwTjSqcUNASeJqHTaG4m3fVSV5XyWuh0PT0uXH6Pa6ELdXacpTKCKQNklWkD9bLeZBKnjpWRoZilB8O8jobVbT7GT0XVugNcQtA8NVAXotEpYrPuUL3EeWzwbvH9Ph2h/Zn0Wfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com; spf=pass smtp.mailfrom=kylemanna.com; dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b=tG5AH+4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8sF0dVf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylemanna.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D56B7A039D;
	Fri,  1 Aug 2025 10:52:36 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-08.internal (MEProxy); Fri, 01 Aug 2025 10:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylemanna.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1754059956; x=1754146356; bh=zcxQlemet7I/lQYfYuwv7tBj1Gz5J5a2
	8lPWux7Fnik=; b=tG5AH+4Ur9Mz+qXTEVxou7wjHKrYGYGM+12T0qsId9lq2oqy
	YrsD7uhQQ33zy/X2ccvLvRB+92VSGA8scUU0I0IkmVLovB2dyQEZ19PavQ7k8Qu2
	khSZxzbKQP1yvukB6vlsR/+F4U3LVFPYxbYD5IGeyMpIeDrZSWbdvAATG5xxqjDg
	l7EZL0Yhp2E/pEKQaY/+4tfF7p8KT/ulWqS7YeCAwv9N1CxI/kqLrTS5aeBUYmJq
	Xl4ZYqWwiCg5ZBlamGNt9tVvF0jXLDxVCBC2g6+troAKTaMnDlPXHw9cATFluHH7
	JShHvmQ9TwwlRXOMruoQ3mkaAVHOOERXsdRHqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754059956; x=
	1754146356; bh=zcxQlemet7I/lQYfYuwv7tBj1Gz5J5a28lPWux7Fnik=; b=Y
	8sF0dVfv7I62sKBV50bJdvuAzaLdphYc3VjsEyvpSPLGFxavJgnCJeMU8bDu8BO1
	C7vzjytdfE1cjATCzYwvKoexhhGUv3rG8tPC1xOAelgGK4Paf4YJNKm+HlpwUDDF
	bmyAC4DkopLZNzd85RLE3tWy4HSBy3gIDo3eE/x6f7O5skGmLx/yxNs9X6kN5y35
	pL6kKUy+P6GRxXNHG8vO0WEWxoOe5Eyg/BDbx4VkOPStgMxBdUN473UTC2xwKeBS
	X1OE6cTB88NID9TY8XJmn+dpch9grUuLAiic0IHXu5zs8PT+jPvV5c68th7Bjh/k
	ECgCeqBlRuOYtnK4+j4jA==
X-ME-Sender: <xms:s9SMaMvyZRDocnn8quaWZhRCW81a6EQgwfUmEWqPfsWNaI8WhOJhNQ>
    <xme:s9SMaJfepLihhX24SQUHMIjXehCBCkiFgDbrW-cVzl8UO93CoqucsW77-ebOj9TXx
    fpP0bhi6k_d3glF-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfihlhgv
    ucforghnnhgrfdcuoehkhihlvgeskhihlhgvmhgrnhhnrgdrtghomheqnecuggftrfgrth
    htvghrnhepveekgeejlefgueekgeduheehveffkeekffeuffetvefgieehffduffffgedu
    tdetnecuffhomhgrihhnpehsvghrvhgvthhhvghhohhmvgdrtghomhdpihhnthgvlhdrtg
    homhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepkhihlhgvsehkhihlvghmrghnnhgrrdgtohhmpdhnsggprhgtph
    htthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgsrghrohhnsegr
    khgrmhgrihdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtth
    hopehjrghmvghsrdhmohhrshgvsegrrhhmrdgtohhmpdhrtghpthhtohepjhgrmhgvshif
    vghsthhonhhjvghrnhhighgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehqihhugi
    hurdiihhhuohesihhnthgvlhdrtghomhdprhgtphhtthhopehtohhnhidrlhhutghksehi
    nhhtvghlrdgtohhmpdhrtghpthhtohephihiuddrlhgrihesihhnthgvlhdrtghomhdprh
    gtphhtthhopehmtghhvghhrggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrhhi
    tgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:s9SMaAGf3lapbRCaJHFa0OGMQ4-nuvif1L7FGf_qjvhm4Y6OaLZjOA>
    <xmx:s9SMaIi0W0IgBhwgPnCkneg0lQL2nl7jMrLnK3ebOBSCO0fYlSRTgA>
    <xmx:s9SMaM14z79z8ZB_kcoVLEOUGL5aeS-X_bizi_LKHbdi2EjM5QRvEA>
    <xmx:s9SMaLfWK_1fW9dG3hyr1dnASWKMPrihGjda1JvNM77R1DlRtSIaXA>
    <xmx:tNSMaFn1jQ6QNDxwE4a363m39cd-tGPogHKNEkxqTPBC-SpYJmWMpGqa>
Feedback-ID: iac74403c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 187D32CC0083; Fri,  1 Aug 2025 10:52:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACyAlOQ1vLbo
Date: Fri, 01 Aug 2025 07:52:14 -0700
From: "Kyle Manna" <kyle@kylemanna.com>
To: "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>, "Tony Luck" <tony.luck@intel.com>,
 "Borislav Petkov" <bp@alien8.de>, "Jason Baron" <jbaron@akamai.com>
Cc: "James Jernigan" <jameswestonjernigan@gmail.com>,
 "James Morse" <james.morse@arm.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Robert Richter" <rric@kernel.org>, "Yi1 Lai" <yi1.lai@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <f9c0fd21-591e-4fd0-a13e-35cdc1aa063d@app.fastmail.com>
In-Reply-To: <e3bc0591-7ebf-4738-8848-599edd11c10d@app.fastmail.com>
References: <20250724064415.1134574-1-kyle@kylemanna.com>
 <CY8PR11MB7134484D663C31DA1544945B895EA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <e3bc0591-7ebf-4738-8848-599edd11c10d@app.fastmail.com>
Subject: Re: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC
 support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 24, 2025, at 19:23, Kyle Manna wrote:
> Hi Qiuxu,
>
> On Thu, Jul 24, 2025, at 07:31, Zhuo, Qiuxu wrote:
>> Do you have access to these machines to load the ie31200_edac
>> driver with your patch? If yes, would you take dmesg logs?
>
> I have access to a i5-12600K, here are the logs that I observed:
>
> $ dmesg | rg -i -e edac -e ecc -e ie31200 | rg -v systemd | rg edac
> [   14.379905] caller ie31200_init_one+0x1b5/0x480 [ie31200_edac] 
> mapping multiple BARs
> [   14.382709] EDAC MC0: Giving out device to module ie31200_edac 
> controller IE31200: DEV 0000:00:00.0 (INTERRUPT)
> [   14.383042] EDAC MC1: Giving out device to module ie31200_edac 
> controller IE31200_1: DEV 0000:00:00.0 (INTERRUPT)
>
> I posted additional logs from sysfs and "ras-mc-ctl" here[0] after I 
> learned that support was added for related processors as well as 
> discussion with other users trying to get W680 + ECC working.
>
> [0] 
> https://forums.servethehome.com/index.php?threads/intel-w680-ddr5-and-ecc-reporting.42559/#post-470425
>
>
>>> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c index
>>> a53612be4b2f..2078c12bbed2 100644
>>> --- a/drivers/edac/ie31200_edac.c
>>> +++ b/drivers/edac/ie31200_edac.c
>>> @@ -94,6 +94,8 @@
>>> 
>>>  /* Alder Lake-S */
>>>  #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
>>> +#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2	0x4668
>>> +#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_3	0x4648
>>> 
>>
>> I didn't find the place in your spec above that indicates these
>> two CPUs with these two DIDs have Out-Of-Band ECC capabilities.
>> Could you point it out to me?
>
> This Intel CPU page[1] lists ECC memory support and the same on the 
> Intel W680 chipset page[2]. The datasheet was used to confirm the 
> DIDs[3] were valid.
>
> [1] 
> https://www.intel.com/content/www/us/en/products/sku/134589/intel-core-i512600k-processor-20m-cache-up-to-4-90-ghz/specifications.html
> [2] 
> https://www.intel.com/content/www/us/en/products/sku/218834/intel-w680-chipset/specifications.html
> [3] 
> https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/011/device-ids/
>
> Given that you added the i9-12900k (0x4660) in 180f091224a00 and I've 
> personally verified the i5-12600k (0x4648) is working (see dmesg logs 
> above), I've added the i7-12700k (0x4668) to assist future users.

Hi Qiuxu and Borislav,

I saw a pull request[0] for a 14th gen version of the same chips and would love to get these 12th gen chips included as well.

Anything I can do to help this along?

[0] https://lore.kernel.org/lkml/20250728141521.GAaIeF-XYJVbfOQdT6@fat_crate.local/

Thanks!
 - Kyle

