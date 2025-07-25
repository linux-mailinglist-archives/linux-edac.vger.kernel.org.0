Return-Path: <linux-edac+bounces-4435-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43FAB11658
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jul 2025 04:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64021C827E2
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jul 2025 02:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5376F22DA06;
	Fri, 25 Jul 2025 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b="jP4+ymPe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qd2VfQHz"
X-Original-To: linux-edac@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF354673;
	Fri, 25 Jul 2025 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410212; cv=none; b=B22K9PdHdkxQVxVfvxxmP6uhMkqHbq91RGHRAyW9RC1yaCB9RQasOhy5BG8yKlVk4FfPYwt/1fPJEz+f5al66a7YX3SOCCenpTZyK1UjdjfCG4G3MUDi6jtU3iS7TGyJTxFmuBlanO58tx8xNbLpyy3xH2WgE7OtaPDiWezqBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410212; c=relaxed/simple;
	bh=MgoIfixs4nmYkxvgEg68jeOrTXtKgkzDtOT/33t0RCw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZKt6Qkc7OE7syf3SW2Fi3LoKURZfiDJq+e+WSd86h0/CFULLnc7qupQgcT9wosqg7aC54BFHoyAwxEpnbOsqVFunLBAEslz2h74ykaHF4VTnXGe53T+9EvLeyVXVc3741uFkmsO7ETSYI6SwT/s8dX6gOePmS4fdef6H2sNt+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com; spf=pass smtp.mailfrom=kylemanna.com; dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b=jP4+ymPe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qd2VfQHz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylemanna.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 17270EC054F;
	Thu, 24 Jul 2025 22:23:29 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-08.internal (MEProxy); Thu, 24 Jul 2025 22:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylemanna.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1753410209; x=1753496609; bh=6eqGygpm+KL71M9AISS7z8e7DqChtpu4
	mFIFwIB6Ob0=; b=jP4+ymPeq4JWR7Mekx/ohUo4Xm6KaMQW7J49GE94f56nLMPi
	NQIcH3/D6OgVLC58bnlonPENk7b4gJvweyQcuGBzBYz5vJvNfm/Xt6xSzY9E4Dcd
	Y9JH5oKV47WW4sWjsU7DfTwid41M1RA5DmdeIGo4/a6tO7BJMtRQJs8JlqFL6z/M
	PV65s8xX/uFUaT8A9YDncnxKAxqZ/m2ddF+WOGehGM6KIzRjfIYTu56ka8Qc349k
	9TR3yuaC7/i+Vj5icp3RSmaz5g3NjtBVWqbRXxiaaq4s2sGLnLmYc1b+F8xtZGQs
	Xhr903o6hKmNN8yBxKIk6ckUlDyVBmmywjIVCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753410209; x=
	1753496609; bh=6eqGygpm+KL71M9AISS7z8e7DqChtpu4mFIFwIB6Ob0=; b=Q
	d2VfQHzwXq8W3JQLPE0Em706oBam14tNpRRsRGlFfzfKXVoOdw81x+xWyGxglD2W
	J/ItS875XuVcsb0eSLggxm4bg0nBaxKynZ1UBYwmKe77cWokpa5EcuimaxX8xLCy
	5rTnWuF1b2xMmm120IX9SKvuu3ZIORw3ltcZW+zth4WS6JjzPDPLisOd5hfeqAS/
	E4XtomblK8eQTmOg5Hc9xoYkHmZDal3FLqvgJYA69ASoymhIIFajlVGs/78+ukeZ
	OK05vzTfYl75zIc6znKcaRhv3MqDjsppB/8G9JKLFhff6NO1v5tqvSjggvO6G/L7
	lIFuz3RXNYiivCFjtcjiA==
X-ME-Sender: <xms:oOqCaErfogP8RSEV-cZxkm5lu9OIrhtw6g1ZYrpzvv-5JedKiMOhXg>
    <xme:oOqCaKqqIy0-ewzi-VubjXwVgWdz47Y3695yL5n3akxIsQoED201nhWdkyLIrtrv6
    V3UplZCiQpNvYHT_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmhihlvgcu
    ofgrnhhnrgdfuceokhihlhgvsehkhihlvghmrghnnhgrrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehtddvjeehueehffffuedtieejieetleevgfdtffeuheekhfdvtdfggedtffeu
    hfenucffohhmrghinhepshgvrhhvvghthhgvhhhomhgvrdgtohhmpdhinhhtvghlrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhih
    lhgvsehkhihlvghmrghnnhgrrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgt
    phhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehjrghmvghsrdhmohhrsh
    gvsegrrhhmrdgtohhmpdhrtghpthhtohepjhgrmhgvshifvghsthhonhhjvghrnhhighgr
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehqihhugihurdiihhhuohesihhnthgvlh
    drtghomhdprhgtphhtthhopehtohhnhidrlhhutghksehinhhtvghlrdgtohhmpdhrtghp
    thhtohephihiuddrlhgrihesihhnthgvlhdrtghomhdprhgtphhtthhopehmtghhvghhrg
    gssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrhhitgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:oOqCaGDzBH9ZETa6nrRycQrLasYSs5IkyUYjyXJPwYKSvVROj3GEdw>
    <xmx:oOqCaPv6DvQYniz4t3rB7X0xLJehmVqw2fQJq_aSZFzLGuFiTvO1ig>
    <xmx:oOqCaMTJcyaDjI-bQCnXlGvJ0Ae61mIfVGmXjFr-AmS95RwLLSYQiA>
    <xmx:oOqCaOI5lCdxXD3sBVhyz2BDq7h3NvUnAH4JfnFeiNFPz3AIgVRkDQ>
    <xmx:oeqCaOoSivi8ALyw_D9tYr7RbYAhWIrLxiNCkTuTVQFIkb55J0pI4un6>
Feedback-ID: iac74403c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18A8B2CC0083; Thu, 24 Jul 2025 22:23:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T37e2f165b0bb5a7d
Date: Thu, 24 Jul 2025 19:23:07 -0700
From: "Kyle Manna" <kyle@kylemanna.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Borislav Petkov" <bp@alien8.de>, "Jason Baron" <jbaron@akamai.com>
Cc: "James Jernigan" <jameswestonjernigan@gmail.com>,
 "James Morse" <james.morse@arm.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Robert Richter" <rric@kernel.org>, "Lai, Yi1" <yi1.lai@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <e3bc0591-7ebf-4738-8848-599edd11c10d@app.fastmail.com>
In-Reply-To: 
 <CY8PR11MB7134484D663C31DA1544945B895EA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20250724064415.1134574-1-kyle@kylemanna.com>
 <CY8PR11MB7134484D663C31DA1544945B895EA@CY8PR11MB7134.namprd11.prod.outlook.com>
Subject: Re: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC
 support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Qiuxu,

On Thu, Jul 24, 2025, at 07:31, Zhuo, Qiuxu wrote:
> Do you have access to these machines to load the ie31200_edac
> driver with your patch? If yes, would you take dmesg logs?

I have access to a i5-12600K, here are the logs that I observed:

$ dmesg | rg -i -e edac -e ecc -e ie31200 | rg -v systemd | rg edac
[   14.379905] caller ie31200_init_one+0x1b5/0x480 [ie31200_edac] mapping multiple BARs
[   14.382709] EDAC MC0: Giving out device to module ie31200_edac controller IE31200: DEV 0000:00:00.0 (INTERRUPT)
[   14.383042] EDAC MC1: Giving out device to module ie31200_edac controller IE31200_1: DEV 0000:00:00.0 (INTERRUPT)

I posted additional logs from sysfs and "ras-mc-ctl" here[0] after I learned that support was added for related processors as well as discussion with other users trying to get W680 + ECC working.

[0] https://forums.servethehome.com/index.php?threads/intel-w680-ddr5-and-ecc-reporting.42559/#post-470425


>> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c index
>> a53612be4b2f..2078c12bbed2 100644
>> --- a/drivers/edac/ie31200_edac.c
>> +++ b/drivers/edac/ie31200_edac.c
>> @@ -94,6 +94,8 @@
>> 
>>  /* Alder Lake-S */
>>  #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
>> +#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2	0x4668
>> +#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_3	0x4648
>> 
>
> I didn't find the place in your spec above that indicates these
> two CPUs with these two DIDs have Out-Of-Band ECC capabilities.
> Could you point it out to me?

This Intel CPU page[1] lists ECC memory support and the same on the Intel W680 chipset page[2]. The datasheet was used to confirm the DIDs[3] were valid.

[1] https://www.intel.com/content/www/us/en/products/sku/134589/intel-core-i512600k-processor-20m-cache-up-to-4-90-ghz/specifications.html
[2] https://www.intel.com/content/www/us/en/products/sku/218834/intel-w680-chipset/specifications.html
[3] https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/011/device-ids/

Given that you added the i9-12900k (0x4660) in 180f091224a00 and I've personally verified the i5-12600k (0x4648) is working (see dmesg logs above), I've added the i7-12700k (0x4668) to assist future users.

Thanks!
- Kyle

