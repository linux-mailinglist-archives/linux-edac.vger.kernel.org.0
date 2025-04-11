Return-Path: <linux-edac+bounces-3517-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF314A866BF
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 22:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8793C18968F4
	for <lists+linux-edac@lfdr.de>; Fri, 11 Apr 2025 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA6235C1E;
	Fri, 11 Apr 2025 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="O2ohyfAb"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731323026C;
	Fri, 11 Apr 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744401694; cv=none; b=UlRYx3MKOq2sR48KIICjTqlGv624zlKBNASNlzoh196AwVAnOO8/oCyq2fPZdN6jk1eElIpPc4j5kPkFslFPpSVRBCct+Jj7Z7EG5p4vkZ4QW86Jt/ehjFGdSLPyJjXK35+YujnZJKmEvPGwq4Wwhq+L22sJ2pOaPbVOdXpqp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744401694; c=relaxed/simple;
	bh=2QhpccvsdGc8U6v2k8YHD/vVE7lypg2Vj/lFVArppZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlpW1aucQfj5F7BykFRhOmYAEKwU1bUMO/5j1cw0FmcZGbCyA89e9mQdQTu43hGFvVcDA/TdEls9vVxf5gSuxFvGPT0LGgp6JJfzLY1DMTsBM1M0ZJK/grDN8Osok6cNWaDXNJscEe9bFcGOwLSTlIRSPYpYhuOGABzzHU+H6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=O2ohyfAb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0F15740E0243;
	Fri, 11 Apr 2025 20:01:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9glBSqHv_OV9; Fri, 11 Apr 2025 20:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744401686; bh=2QhpccvsdGc8U6v2k8YHD/vVE7lypg2Vj/lFVArppZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2ohyfAbOFoYk/IS7F6pj+r7hxBWHGrFh1bpf0pJovk1nahEj3SAMEXKUupoyI+3t
	 jDX1o0HabmK0N9rrBwgcjNtCx5Iu+hzLFL4Bux+gBJ/Vor3Nu9pganZsrwk8PS7/he
	 cVEUFcyScw1fJZZNhXHVCW2R6Jcu1qYNOK5wgAAJOkA1j8M7rlV/bmXlO2Aa8o+iD6
	 5X9t5AyAtMzenDsWKkEc12THvdXiq3Zh8/MbkFgIaoUtirX1P1N1zmGYblm9GifAd4
	 HdS35xg2kLDN/7Uma4ZyQgW69IkHaC8PT940fC2erOMfWSCeVCcAe8d6BMvGfUex9s
	 B1wk3vPmNwPvrzo4mBsbncz7L4vJsLnM737NKQhufsjkVKSGqNgyTf7gFWWsT8WVEm
	 F+2RkiN9swlorig+qSC3CvJqwfKdNKUDerRTSh7+WzhPRk+2D/C+VAlyN2rN+qKDCG
	 aTHdxS36aHIms7V4D6KF4JDtdLiMZcT2oLBsxL9erkH5Neq0kDcxoeIysgsdUfZuB0
	 RFBGse1y6asNH4iBrF2CJZrbYC+GRam5YgqJCAzGOQY14M82XEVyz9ETO03daVrYJh
	 sCzSXyEbmt+dbQzSBx70ZwmtEieT5zumK6hkSOklkSy7RIUSLL1wJTCxvI3Tntetua
	 zjFI/GGGqItVTEjBnBE+uW9A=
Received: from rn.tnic (ip-185-104-138-50.ptr.icomera.net [185.104.138.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E2BB140E01FF;
	Fri, 11 Apr 2025 20:01:14 +0000 (UTC)
Date: Fri, 11 Apr 2025 22:02:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Marc Zyngier <maz@kernel.org>
Cc: "Tyler Hicks (Microsoft)" <code@tyhicks.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vijay Balakrishna <vijayb@linux.microsoft.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] dt-bindings: arm: cpus: Add edac-enabled property
Message-ID: <20250411200207.GAZ_l1P91QuMi_wecf@renoirsky.local>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86frigkmtd.wl-maz@kernel.org>

On Thu, Apr 10, 2025 at 05:23:26PM +0100, Marc Zyngier wrote:
> We have some other EDAC implementation for arm64 CPUs (XGene,
> ThunderX), and they are all perfectly useless (I have them in my
> collection of horrors).

Oh oh, can I remove, can I remove?

My trigger finger is itching to kill some more useless code...

Thx.

