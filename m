Return-Path: <linux-edac+bounces-4549-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2DB21166
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8BB3E813D
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C292E3AEA;
	Mon, 11 Aug 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b="NWmDaOJV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VodR6MHm"
X-Original-To: linux-edac@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244B2E2846;
	Mon, 11 Aug 2025 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927457; cv=none; b=GOTJQGZjJ8uTBbTjb92EzpN97uXr4R7Gi4BTqdCEVwfr0xbQca4KZ3jrSwQbCRaOmotsa6KbXZvuPZtuwTrD8A2z/ZI5WzpzbgdkURUMcXZkjN5TCPrkBFChTNMMLiWV7eSNnlQyhQzZg8ttU7dpIYLY67aVVNSrJQGFuP+uAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927457; c=relaxed/simple;
	bh=o9R4/vr5/k219aZvmRaJpL5DkB6VIj3EXy4nFKRXg5I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lOhqxUZfGd/MecGCwC+OquC5MR49uLcgZ5zHfCfy4iyL1C0Y/jxz7K+CmpFRZp1BhfKG/ytWNuL5n1uxmTJzJDPEzJ9ONv1qyIiq2aZpHPc7io5VLfcII69fDgDVbooisRtmTCdAxgLJf5SYtRzu9/oRRLYSKBWc0fWbVjJ824k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com; spf=pass smtp.mailfrom=kylemanna.com; dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b=NWmDaOJV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VodR6MHm; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylemanna.com
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A42A7A0047;
	Mon, 11 Aug 2025 11:50:54 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-08.internal (MEProxy); Mon, 11 Aug 2025 11:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylemanna.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1754927454; x=1755013854; bh=l+xTtS8t6V054XL1cj8drWSr+lP1EqQh
	p0KIQIrldDA=; b=NWmDaOJVeCEI7mWfDrHHMkCq0r9QQIp5VxnqLeTnFWvsGKOW
	8zDC03BTxApW2pse7aGZ5JvyOVNeLr76VQq4WdTbhM3zd0kO3HzxuC5Ooixij4zc
	gpRtD1GADD/Gszm+LVU6Q/RSXl39JdAouEHQC7qvBV7pKNEc9lTuK/N9wlYvPSqP
	O0mXyTsnzsq7mfloDX9H+IZyhQ/WK/coiNbs9XJSyy7rl/6uGX7eo4GPQO45CSPG
	wQzSe9WdNETKesBmLIL7iSTHUSAAPe1w34rfkDpINBFcVFurGwu/leD4tSFkN/6Y
	2Em5/Zl6dBbhKAUkU/vPkDytnpn4SbK0g2xKdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754927454; x=
	1755013854; bh=l+xTtS8t6V054XL1cj8drWSr+lP1EqQhp0KIQIrldDA=; b=V
	odR6MHmKf0XBglpTXx7zlPLz7bcvBH/D+tEixVoFjwCEpAJeh6l0RhM6IMuj40sJ
	l7ZiTsPeSmcFHup1Qn6XaHu0utgVPQRO1rm7469pu4IVvR18/aoHSr/qc0S7tPAQ
	p6s1M0J/uUIXG0JWUhOH/AoiMVVvr6RA4Vr01LS9sWFZv1VnqfaAaCRi5pvC+eRc
	MeGxu8rbn1r4JT3gks9wxs9dQE31yaIn0KqVs5byuwKM0mJPtDAlj6pcTjxHroXf
	annwLszHBTQq9jGfzwGxghqw+CG4/4FBRIQlzMoWDA+kIRnXV5m/Yg4Jq/5Z5Lk7
	vPql/KTcr5ZOkd/IJxIFQ==
X-ME-Sender: <xms:XRGaaBngvhII7Wx9aJFVQTQRxqwk7HWnpXc0VUGwHwjuDmLmWQfjag>
    <xme:XRGaaM38nQUCnIfLcC0mDpwTX6ps7Ib7gAlH9_wnI-vAhpfplt5ANozNYuWIZHUTl
    _nvmy1xYVCelOzyqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfihlhgv
    ucforghnnhgrfdcuoehkhihlvgeskhihlhgvmhgrnhhnrgdrtghomheqnecuggftrfgrth
    htvghrnhepheeigeejffekffegjeeghfetfedtgefhtdfhffeljefghedvueffieeguefg
    ffetnecuffhomhgrihhnpehinhhtvghlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhihlhgvsehkhihlvghmrghnnhgrrdgtohhm
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    gsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdgu
    vgdprhgtphhtthhopehjrghmvghsrdhmohhrshgvsegrrhhmrdgtohhmpdhrtghpthhtoh
    epjhgrmhgvshifvghsthhonhhjvghrnhhighgrnhesghhmrghilhdrtghomhdprhgtphht
    thhopehqihhugihurdiihhhuohesihhnthgvlhdrtghomhdprhgtphhtthhopehtohhnhi
    drlhhutghksehinhhtvghlrdgtohhmpdhrtghpthhtohephihiuddrlhgrihesihhnthgv
    lhdrtghomhdprhgtphhtthhopehmtghhvghhrggssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehrrhhitgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XRGaaA9mmd7csveRy4npn_IuM-ffpS4gY7e_w7ZKt5PScCxKsJ4pXw>
    <xmx:XRGaaH4JoYBp-A4tf84XEUYeA4UNXEkvhJFbLM3QoE3q0bSfUbhl7w>
    <xmx:XRGaaIupcTThLfPjsF5XHoMLfqYLSs8d8DhqMHLc3A0MPw7RNUzRRQ>
    <xmx:XRGaaJ1LLRGyVKHpW4IYb0WXiIfFPoroyqPYlfHp8ktTSA29TljAcA>
    <xmx:XhGaaFmdInmbSouAknS8QU68sxUJRirOKRFSXJBBftVz-XCN9TI7q9FP>
Feedback-ID: iac74403c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 69DFF2CC0083; Mon, 11 Aug 2025 11:50:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqtgtjpCkecB
Date: Mon, 11 Aug 2025 08:50:14 -0700
From: "Kyle Manna" <kyle@kylemanna.com>
To: "Tony Luck" <tony.luck@intel.com>, "Borislav Petkov" <bp@alien8.de>,
 "Jason Baron" <jbaron@akamai.com>, "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Cc: "James Jernigan" <jameswestonjernigan@gmail.com>,
 "James Morse" <james.morse@arm.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Robert Richter" <rric@kernel.org>, "Yi1 Lai" <yi1.lai@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <c2f98618-4197-41c3-9a2b-2c59841dd543@app.fastmail.com>
In-Reply-To: <20250802060112.363506-1-kyle@kylemanna.com>
References: <20250802060112.363506-1-kyle@kylemanna.com>
Subject: Re: [PATCH v2] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC
 support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025, at 23:01, Kyle Manna wrote:
> Host Device IDs (DID0) correspond to:
> * Intel Core i7-12700K
> * Intel Core i5-12600K
>
> See documentation:
> * 12th Generation Intel=C2=AE Core=E2=84=A2 Processors Datasheet
>     * Volume 1 of 2, Doc. No.: 655258, Rev.: 011
>     * https://edc.intel.com/output/DownloadPdfDocument?id=3D8297 (PDF)
>
> Signed-off-by: Kyle Manna <kyle@kylemanna.com>
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> Changes in v2:
> - Rebased on top of a6923c06a3b2e2c534ae28c53a7531e76cc95cfa
> - Added comments to Device ID definitions as requested
> - Added Reviewed-by tag from Qiuxu Zhuo
>
>  drivers/edac/ie31200_edac.c | 4 ++++
>  1 file changed, 4 insertions(+)

Hi Tony, Jason,

Gentle ping on this small EDAC/ie31200 change that adds two more Alder L=
ake-S device IDs for ECC-capable part.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Could you please pick this up for the EDAC tree (ras edac-for-next)?

Thanks,
- Kyle

