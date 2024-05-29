Return-Path: <linux-edac+bounces-1155-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AD78D3F31
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 21:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9817DB236B5
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD681C688E;
	Wed, 29 May 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NA7mxaH7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CjVC4ES6"
X-Original-To: linux-edac@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FCD1C2333;
	Wed, 29 May 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012534; cv=none; b=fv7r2RdUuQnZ7RUp7LqP9yzvyTjCqlAp7kn5Ww5sdf7PjPM4MLngNTm3MVPafd3mQ0gqCD4IhpO1Bied4NxhecQyb7LVWaR1NM5Jgf81+BQIlcbv4OJ6ZJJXM5/JjmymNHTRbQiGfZyFhPCrUdHeX2D01/r71Off0uB/KGKqxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012534; c=relaxed/simple;
	bh=N4jgiuvfYE8OrlkeRZ4JhuC/8gtM3lMrQG3gCv2wHJM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=fzQiWVOFBeCw1mQK7xFE/q95I7Des1pnKTNK8SFSIzZwmJxrN/L3rY34MVGESSYhK7/6rWeiNUOQTcEBVF6D9LsHWuF+TjLVGVK55c6Jd1fWDQmulBtQ7/7mR6E/hMH5AVZT646jhr7S/drJtBnAKcYDNPZCxor4gpMisZlRWs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NA7mxaH7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CjVC4ES6; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D66AF1C000D6;
	Wed, 29 May 2024 15:55:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 15:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717012529; x=1717098929; bh=wlwWXCsQ/e
	aeGKvYIW4tA7hpA+jryO2cZljm6EODNys=; b=NA7mxaH70FA0ZkbI5+HcFRWbXl
	k+3O0Zuf69j7tJKA2JVIYYYeKLRHiN+rIyoVTJwP94XOg3ghGKzZiECof+ztyyjf
	Vom/5OxGFXnYyKdyIjjxR4o+WCCIyyvDYgQl/sskPV8tglxy3owRvCb7h3GyvxpY
	b+pi1P3Wy/tueEtYdTchHuJarQP9koV6kJ1U6Xs70YXUh+9qDP+xPK2awE2GNxan
	beDe+ANMUfpmCUe617xsnTDzLODgdRgASTmrC4aonYktUntrP9RL2L5RlM25Ibrk
	KxORdOIQLo1db0MZoVrmfW4Zfvf5kQceWp91S8j8VQZrBRytjSXWnHpd0Eqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717012529; x=1717098929; bh=wlwWXCsQ/eaeGKvYIW4tA7hpA+jr
	yO2cZljm6EODNys=; b=CjVC4ES6lLFizXkfh5icN4FjEVT7OEmQCYlhuZt+Jso5
	vUziqusgyUKhvH4ri5jQqGPM+0JvxF+ZdRvgik+6VrCIwRw170RTNH9iXNTL11tE
	WIjGhyk9pTBMwY5+SGfKaBN5989ygrK4dga+GCG1sFyNh1RgiUlGLSp9U9znFJsV
	za1IATLveMFUPE6Vm3StJd6MUTOvfNXPkUEJrUUFcTzFG+vraYMIH7rPViXFBKV6
	GaIQwZzWuhuSEugl8pD23/IQlGXerET9dEmQwTx/WiuPRdI/C4ok0tJaxFZfIpK9
	JtiqPrd7fZZc1bf/btXl7b4dx9+k89uIoThLYbIpqQ==
X-ME-Sender: <xms:MYhXZlBRaGEyHI8jMxSgcPnD7i32tl64nB4ZiTwUjDbzyzofWTYHgA>
    <xme:MYhXZjibLtA5nkCWzT7C7dEXkasg6lMpGKXBp84883VS84RUZtEHc7lgBytJFoRjm
    GvtEyX6FQ_D3LxfGZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:MYhXZgm_TCLrdEqCMwa6Loq3XqtRN7RBMdvtgEa5ncaG2dIzrpNXBQ>
    <xmx:MYhXZvzYfr1q8iMI_R9RV2gdrR9FuYrCa6s5L87r1rUgpLyvMaUmUQ>
    <xmx:MYhXZqSPiHIcMO0DcG28BQRroPgoGoC4PeDkDXA_qU_Zr9N5vMjmNw>
    <xmx:MYhXZiYdSZmxukUwzG3lvHyGWxPmZjmcmP-NaQNnXoO-23KMZjeRHA>
    <xmx:MYhXZmbFmDEg7UsHb-3ZXz413myFZAbpQTGXLrbv49h9jn-BOWfuPTLF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 01EC6B6009B; Wed, 29 May 2024 15:55:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc7f2a95-2a61-4eea-a1b8-b764893eabe3@app.fastmail.com>
In-Reply-To: <20240529193127.GEZleCjwyUtnDv_Nc0@fat_crate.local>
References: <20240529095132.1929397-1-arnd@kernel.org>
 <20240529193127.GEZleCjwyUtnDv_Nc0@fat_crate.local>
Date: Wed, 29 May 2024 21:55:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Borislav Petkov" <bp@alien8.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Tony Luck" <tony.luck@intel.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "James Morse" <james.morse@arm.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Robert Richter" <rric@kernel.org>, "Marvin Lin" <milkfafa@gmail.com>,
 "Shubhrajyoti Datta" <shubhrajyoti.datta@amd.com>,
 "Sai Krishna Potthuri" <sai.krishna.potthuri@amd.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Content-Type: text/plain

On Wed, May 29, 2024, at 21:31, Borislav Petkov wrote:
> On Wed, May 29, 2024 at 11:51:11AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Linking an object file into multiple modules causes a warning:
>> 
>> scripts/Makefile.build:236: drivers/edac/Makefile: skx_common.o is added to multiple modules: i10nm_edac skx_edac
>
> What changed?
>
> This wasn't an issue until now-ish...

It has caused problems in enough other drivers that we now
have a warning for it, it was added in commit 598afa050403
("kbuild: warn objects shared among multiple modules").

Most modules are modified already, and we are now down to
the last handful. Since the bugs are fairly hard to understand
when they happen, it would be nice to enable the warning
by default.

     Arnd

