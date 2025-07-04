Return-Path: <linux-edac+bounces-4324-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98255AF9401
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FD6189F0A6
	for <lists+linux-edac@lfdr.de>; Fri,  4 Jul 2025 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C32FCE05;
	Fri,  4 Jul 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ktxANxFj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519A2FC3DA;
	Fri,  4 Jul 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635548; cv=none; b=T5/E+FYmxl+4/Kn9rESTu3Ud6eilzFVIanuK9qZH1Iyyndqln50PfhkyGVKNe72vlHasWu+0Wn7XgmvQxHh9c8+uBur7Xef9DfnBOUe0GtPv58o78WfF+2Jumt2o/tktQO6GuR/EfaFrGe/swXSepVk9UK9bREVM5EQctlUBir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635548; c=relaxed/simple;
	bh=WZ6R18pGSQgVZQ5nM4CDWt/kvcNBd2S5oeSCfDRieWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgGjpIVNR6/wfHONWNKoj1O8YCUKlN9r5COkKy9dO+Z4TNEwZ38b0AJK6nuOQ+m0D9Olg4xn6Zzvm20dKZQce7Xs6qEkqtF7RsI9H1vpRakg+YzVigE2yNvlXvDmlJRNp4wwl0e4eDanTaJcHc+5kG2kbgyzMziqcktMuasPAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ktxANxFj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D837D40E0220;
	Fri,  4 Jul 2025 13:25:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HAYByO302iK3; Fri,  4 Jul 2025 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751635539; bh=di8xIvp3Q2hISLCL6sb8IOiBmxTCpK0x0R93L5h+H68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktxANxFjMOrOjbk0N7U9BrItvwDX+HeVeOdeZlVBWlOKHK8+u2wfohPBNKS9u3vkL
	 Xs4R5kloxysIWvsCiHmo5zUC6YaO84gwEtHb7/d3XVVRtet7eT36HJ7HXtoP14Hl38
	 m6SJVdShOFceXHh/BNCIE3cpExW3TNu9H75s0s7lc71L7ZFb6eDckJwKOXqiN408Kc
	 xkDT4ZrUB9+gUr/woRYRvdpDyHBEQIeowPte9NG+So3NpOpdwuIRp1BfNY3u7wDrDH
	 N/isX5gitwMkvNrCyXWN6QHf574mi7JhX9AJCneMZFvBNURx3cs7NGBMxNq3gL3elU
	 9OisYTA/cJHjK4nNUaifqxPq3gtQeXrfOVtqxrcueSEGI75GBzIJPzj317IqeIumsT
	 cT+6u4Xhjl0XhQnMAnQlp1nJbwhQtm5X/bzrlk20B4xIJZbhSY4WPy+Wwyu9YH6krM
	 UwST0Yqj3vrcYReD9wn5SswFutdYug/mTwC5m+XNQUhjkh0NTN+mRgp9YKzau7JbGP
	 p5P2LaTgvlAQ3eJl402oE+bp8TyEmbBpGN76nytx7QjiuJxRFqgUwOTwr/9q8CJCJ8
	 JJLrlxwXAaWi/l0EnPVEtjutGvWJS9CXUZOlzozP2/VylvhCF+q2ghIu5vm9sD2RD2
	 2qTmYQzFVkDx0LDxGRMzenZY=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7505B40E00DE;
	Fri,  4 Jul 2025 13:25:23 +0000 (UTC)
Date: Fri, 4 Jul 2025 15:25:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, tony.luck@intel.com,
	rafael@kernel.org, Alexei Starovoitov <ast@kernel.org>,
	kbusch@kernel.org, rmikey@meta.com, kuba@kernel.org,
	linux-edac@vger.kernel.org, mchehab@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] panic: taint flag for recoverable hardware errors
Message-ID: <20250704132518.GDaGfWPnAZI2FY8EnM@fat_crate.local>
References: <20250704-taint_recovered-v1-0-7a817f2d228e@debian.org>
 <20250704111954.GBaGe42gY5_xADb17Z@fat_crate.local>
 <aGfFyktcuRV73Bl8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGfFyktcuRV73Bl8@gmail.com>

On Fri, Jul 04, 2025 at 01:15:06PM +0100, Breno Leitao wrote:
> The information is not there to show correlation of broken hardware,
> but,

I didn't say that.

I say that users will misunderstand this taint. Like all the other things we
have issued wrt RAS - people jump to conclusions without even reading english
text. Not to even talk about taint flags.

You having to explain it here basically proves my point.

> For instance, reading from `cat /proc/sys/kernel/tainted` might be
> *way easier* than parsing *thousands* different RAS tools logs for you
> to find what is going on. 

Thousands huh? I know of only two but maybe you will enlighten me.

And those I know can simply dump you an error log which you can check. It is
way easy already.

> Anyway, I am happy to add this information somewhere else if you think
> that taint is not the right place.

Documentation/admin-guide/kdump/vmcoreinfo.rst could be one place.

But again, this is redundant info which you can read out from logs which you
already *have* to collect anyway, in a large fleet.

IMO, you have everything already and this is not really needed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

