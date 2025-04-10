Return-Path: <linux-edac+bounces-3508-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F3A8466E
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26EE9C3D63
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD728540C;
	Thu, 10 Apr 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="TdQfd02s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW6claRV"
X-Original-To: linux-edac@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA8256C8A;
	Thu, 10 Apr 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295424; cv=none; b=htIN4kpWc02nSUitkMxNyQiBXDKP/vD+0lv37wr8OhxVgzX6l/+F51C+TW2LRzb5vjgBJCKbCR06gJDgu5lzgCH84Z/Nw0K9YKEFYFRCK7FoSdxeKrYdwOAVmDixZLIJWJwunll8ASzu/ciyeopTtezU08nNleQxBCsz0+lq99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295424; c=relaxed/simple;
	bh=YTlt8O+sE/9rtpzV+c+zIxYwrTJBxqj2yWXJ9DVefkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlEth0Sm+4ABpzP2lXCry1OcbA7CTbDTq4Y2LLhGFT8CrFIW9ZI40jIqhsCqcsf5maCYtN4IP6NWK9tHAFl5BdXtxv/fOPrTHH9gXrel34+ZbZw+4+AR7nAFP19Lyo8g0Q9JtX6+8WS7Fm7UlGYPu1DHuSQXcTOZ0l7K+2sNZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=TdQfd02s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW6claRV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3660D1140175;
	Thu, 10 Apr 2025 10:30:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 10 Apr 2025 10:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744295421; x=1744381821; bh=S1b/Do+0Ql
	mC0Izyp/1MjpcbjXO3labtAKsTkiwsvDg=; b=TdQfd02s0gUABxdWePX1JzTsFB
	BiosMDswsEm8HGoQIR5p994lQIQO3npTlfvgOHIr3F+TBp/i0LrKujU9Jzl6YW58
	KyrrPZf88/AIkhbCxzYIxQB5qF18AAZ+m4V5wA+2uatKIAye7Madc5azQQbwgLgG
	kvulKrH7r64JsqZa96M9O/fCvirEdcB9+olpo9BDy0dWnOP/bZi1Tmt/Ffr8ceKf
	JLzsoZmoFSf2Q/lQSICxaxKyUveF5dk6DO4PjmmFZsaePwu6WrSx+r4RTam+9zcY
	lT9JSzdf/nJ1DvMBhxxccHGAv9ZAdhW/ydhrnUuXE9hME/oeCgGbFb44yEUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744295421; x=1744381821; bh=S1b/Do+0QlmC0Izyp/1MjpcbjXO3labtAKs
	TkiwsvDg=; b=SW6claRVQdwiPYeMW6tV3DW8SkTRXSQRO0F6YsMAookt1Quqocm
	nFsFiYBnahMqqdEqBAovfLlkyV6WO9RGTQS3a2L/megMWUurvJvHSFxA6jC+XI68
	3w2NUhhIVasZxJh5VJ2MOo/qVKjgQPHsH+nW7WezwI4mz998eyfS9vv/MwyEVC24
	MGE0DM007DNMvhoVCIC3sSYPh61SSVTHgS1pmy8i4vSPdKeW+t2z3TL8Gjf1dbCl
	UR4JVnr1R/I+23yDSquHbiNrbvb+r50tC1/OrmCTRhawDDrKOaxfindf+aDSPLCJ
	UaVhihMtK1ge1Rwx3WUccJIl87nfI1k+HDA==
X-ME-Sender: <xms:_NX3Z4f1Kul2YuQB9f47R2ELs_D-4PV0JAnUqSXOL9gYwFA7p3H76Q>
    <xme:_NX3Z6PwS5IQCT2DnhmAg63lu7urbGJ-gk0xywlARnU7iPimvKMx8BjYIbIcN_9pw
    lvWdJtYPCj42qdvZnE>
X-ME-Received: <xmr:_NX3Z5g_LKzwLTriMbtd_8iXX2kdOIG54eHRx3EL2aHaiMRS1FDao6Arjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeludehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:_NX3Z98P_cTBUBPD1wPhFnla7Ne6Yy73W9VY9Kk6dL1aoANAde_WVw>
    <xmx:_NX3Z0vg2Xs65bbTZEopch73zy9Evaf7PbZ35vZe9janzXVREaVksg>
    <xmx:_NX3Z0F-UstAhZUJnIuV20TAfKuEFkUzXshX8Rj389Eyk3x_0gfsnA>
    <xmx:_NX3ZzO5F-TvQ8FdFCYqCqxVdWkEn41MZek96FmpcrzZQOkQIfvMuA>
    <xmx:_dX3Z64oI0QHwlorerHMZCra8RpsRPTP3aTp-5HInvvKYYm7NXCsttt6>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 10:30:19 -0400 (EDT)
Date: Thu, 10 Apr 2025 09:30:17 -0500
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
Message-ID: <Z/fV+SP0z+slV9/1@redbud>
References: <1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com>
 <1744241785-20256-3-git-send-email-vijayb@linux.microsoft.com>
 <319b7c65-3e2f-456b-a845-45f7a57ba2c5@kernel.org>
 <86o6x4lcf9.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o6x4lcf9.wl-maz@kernel.org>

On 2025-04-10 08:10:18, Marc Zyngier wrote:
> On Thu, 10 Apr 2025 07:00:55 +0100,
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > 
> > On 10/04/2025 01:36, Vijay Balakrishna wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > Some ARM Cortex CPUs like the A53, A57 and A72 have Error Detection And
> > > Correction (EDAC) support on their L1 and L2 caches. This is implemented
> > > in implementation defined registers, so usage of this functionality is
> > > not safe in virtualized environments or when EL3 already uses these
> > > registers. This patch adds a edac-enabled flag which can be explicitly
> > > set when EDAC can be used.
> > 
> > Can't hypervisor tell you that?
> 
> No, it can't. This is not an architecture feature, and KVM will gladly
> inject an UNDEF exception if the guest tries to use this.
> 
> Which is yet another reason why this whole exercise is futile.

Hi Marc - could you clarify why this is futile for baremetal or were you just
referring to virtualized environments?

Thanks!

Tyler

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

