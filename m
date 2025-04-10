Return-Path: <linux-edac+bounces-3510-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFBA84A4C
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 18:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF7D19E0792
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30A91E9B29;
	Thu, 10 Apr 2025 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="VhrPxT/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kaeseGV1"
X-Original-To: linux-edac@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576311E8323;
	Thu, 10 Apr 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303335; cv=none; b=fODso+cxuJNgktGsAufakOCF66MWRN38o9ZAhK9L0Er70UwPqNL1LI5AE8LvmQJOTy2bLQQ3ePt63Ki6iLMHzbATQd1ySz//COxe+gQmpG9VDVQTtPvgH1MUEShKK0Nk79z+APRNCo7WRwYqjB56ffAX/t9fxkoSVct1/aTLV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303335; c=relaxed/simple;
	bh=0pec9tSTAyfGRrcsnc0vSe6OqB5VVBTdEeHYiFjZ7G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzURRcbVkYXqAs6MAZuWnI/FyAJK8lzDGxCEJqDMYxDsznEGj/SC0KZqhigInx7W49VJxgFVL86pfnL0TNa0sdolp5dday8PNjiC1mMTkwiD+h/0al8dhb6XKduvKRYEqmpJHbmRsgI9bx02R4aT2njaS+PhpXocljEHliAQTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=VhrPxT/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kaeseGV1; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 383991140296;
	Thu, 10 Apr 2025 12:42:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 10 Apr 2025 12:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744303332; x=1744389732; bh=CK1BZr0s7R
	Ll9/uVCGwj1ZHvD1hBab9SNzcYfgX31g4=; b=VhrPxT/6dng2dnGvhQnWjtj/Nt
	pnOb5YiamTyfcfFDM/wT1e92NHsIbR71M9loECpRPpjwpULDvOQZR9sDkr0xonzA
	CXIwAFdiBts/lDRxjOC0iuwlp3Xu8lHsPOCIiU6iK+YJSBeRso6I7AwmOqIrl0db
	MVJgvIIm9+ODhg0Bds0NgaJVHA4pRM9UdQbOKGEUrwIjI80eEuwvyqDNQAMXHf/q
	Z+ugNeuC5vCIlW/gvgYqZKXKaUxkapBWf4mIEvwuHTseOQyYUeYUYyLQ6WZHzqBw
	TR6rU8qWUe+dbGRY50WN4Cu8d1LyvN6OVP15rnKu437p03L1FPLUXgB56nJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744303332; x=1744389732; bh=CK1BZr0s7RLl9/uVCGwj1ZHvD1hBab9SNzc
	YfgX31g4=; b=kaeseGV1aUR/uV6ZrNgIkiqHhcMuXDi5kw9CAjkMH7AwiayfWCe
	N3/Iss3sGLmet/JX3P3/Uh1pMR2yPZthkb3Gd6Tkx23wnNdDLqeLu3XSlTLCD9pM
	2ODo2Cnk39wwpnH2QOJ35fK9OxL5MSFRIAm8/vmoJ/k0OT92dZoA3zFQQ9RnOd7f
	6wBzH5lsjlNlxW9brNTcOdNwi/gA5QHKOrxP1h8JpX4KmNs/+kBoW06SZ8EcKI2b
	vAa8CsSWvciQJowsXDKKt56zQjruCyACKa0rz6Jij33b5Y2s7M8u6Wxu9ozuCvBx
	AmExmFB6NOWa6ZtccueF9gct9bbeDxS50ng==
X-ME-Sender: <xms:4_T3ZxSdiEdfErNYgB6MQrMAeHuWy8brzV2IkZ8xWoMbcoRZgiXCcg>
    <xme:4_T3Z6z1sKCOuvt_gKYzU2yQRQ3i_JyBrZhaARZHRAwta_r6rpCrcpUIjwwHvg40V
    D2Fw1SFmyvkAQUXcIo>
X-ME-Received: <xmr:4_T3Z216AQKazIPC7GYp7b6UhnkREcuTxNhMA2xVH43oyH_r_oxH8q5sTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepfdfvhihlvghrucfjihgtkhhsucdlofhitghrohhsohhfthdmfdcuoe
    gtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvghrnhepheeiieeuvefg
    teelhfejkeeluedttdduleevvefhkeeghffhhfettdffheeuvdetnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehthihhihgtkhhs
    rdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgriieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihksehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehvihhjrgihsgeslhhinhhugidrmhhitghrohhsohhfth
    drtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehtohhn
    hidrlhhutghksehinhhtvghlrdgtohhmpdhrtghpthhtohepjhgrmhgvshdrmhhorhhsvg
    esrghrmhdrtghomhdprhgtphhtthhopehmtghhvghhrggssehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqvggurggtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4_T3Z5B6_tXb9CJrY0tNA5mbrjpZvT1ipFJXj0zR2jU5btvxtS4cGQ>
    <xmx:4_T3Z6hTe9hmX5rytn67sQtiZq1lVGwN0UBHgtmjJxQsUH-6XBhfgg>
    <xmx:4_T3Z9oqckm_5AFRAUcEWPtOhIGKa60aDznQOqn9J3ogtM-PgIwZAw>
    <xmx:4_T3Z1issddJEYan6QRcVPWJ0hmrnzQIi6MSJCwo96A1yxEA-qmYKQ>
    <xmx:5PT3Z6ewBRhdsc-k5I2XLK1KbZWepFrwwv_nqHvzyCOca2cUP8nQqh-O>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 12:42:10 -0400 (EDT)
Date: Thu, 10 Apr 2025 11:42:09 -0500
From: "Tyler Hicks (Microsoft)" <code@tyhicks.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Vijay Balakrishna <vijayb@linux.microsoft.com>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Message-ID: <Z/f04bEJAUvMCzXC@redbud>
References: <1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com>
 <1744241785-20256-3-git-send-email-vijayb@linux.microsoft.com>
 <319b7c65-3e2f-456b-a845-45f7a57ba2c5@kernel.org>
 <86o6x4lcf9.wl-maz@kernel.org>
 <Z/fV+SP0z+slV9/1@redbud>
 <86frigkmtd.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86frigkmtd.wl-maz@kernel.org>

On 2025-04-10 17:23:26, Marc Zyngier wrote:
> On Thu, 10 Apr 2025 15:30:17 +0100,
> "Tyler Hicks (Microsoft)" <code@tyhicks.com> wrote:
> > 
> > On 2025-04-10 08:10:18, Marc Zyngier wrote:
> > > On Thu, 10 Apr 2025 07:00:55 +0100,
> > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > 
> > > > On 10/04/2025 01:36, Vijay Balakrishna wrote:
> > > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > 
> > > > > Some ARM Cortex CPUs like the A53, A57 and A72 have Error Detection And
> > > > > Correction (EDAC) support on their L1 and L2 caches. This is implemented
> > > > > in implementation defined registers, so usage of this functionality is
> > > > > not safe in virtualized environments or when EL3 already uses these
> > > > > registers. This patch adds a edac-enabled flag which can be explicitly
> > > > > set when EDAC can be used.
> > > > 
> > > > Can't hypervisor tell you that?
> > > 
> > > No, it can't. This is not an architecture feature, and KVM will gladly
> > > inject an UNDEF exception if the guest tries to use this.
> > > 
> > > Which is yet another reason why this whole exercise is futile.
> > 
> > Hi Marc - could you clarify why this is futile for baremetal or were you just
> > referring to virtualized environments?
> 
> This is futile in general. This sort of stuff only makes sense if you
> can take useful action upon detecting an error, such as cache
> scrubbing. Here, this is just telling you "bang, you're dead", without
> any other recourse. You are not even sure you'll be able to actually
> *run* this code. You cannot identify what the blast radius.

We want to use it for monitoring purposes to let us know when a system needs to
be replaced. Knowing the number of Correctable Errors that a specific system is
encountering will help prioritize the replacement of that faulty system.

Also, if we can find some breadcrumbs of an Uncorrectable Error (UE) occurring
just before an important process crashes or before the kernel crashing, then we
can avoid expensive manual debugging and simply replace the system. Automation
can be implemented to dig through the kernel core dump contents to look for a
UE log message from this driver and a kernel engineer will never have to look
at the dump.

> We have some other EDAC implementation for arm64 CPUs (XGene,
> ThunderX), and they are all perfectly useless (I have them in my
> collection of horrors). I know you are familiar enough with the RAS
> architecture to appreciate the difference with a contemporary
> implementation that would actually do the right thing.

Yes, those are nice luxuries to have in the newer implementations but there are
still a lot of older systems in use and making do with what capabilities the
older hardware provides is still useful.

Tyler

> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

