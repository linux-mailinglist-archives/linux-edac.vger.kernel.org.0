Return-Path: <linux-edac+bounces-415-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BE98443D2
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0EE1F21397
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70512A17A;
	Wed, 31 Jan 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B4/hKtzO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BD12A166
	for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717508; cv=none; b=uQyoPlGyCHL4l8DmddXnrMuh+f/ZptiX61pGOMSb8UgihEgMVLrzBCq/8shLVPb5k9FAhX1ZhqNjkCZKWdoeAvXNsUDVfWZM3scpg8UxqtEB/8wpBDSg5kl95Akb7KiipOazr8isJZNmoYykbvsWFFgKyGQCDmbHkbxQAIsf1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717508; c=relaxed/simple;
	bh=g2TcNYsfdMvnC5KVedS4bLVr/zjrS+zyQEj00SiHwjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ86ruCiU/YpzInfCHU70/w2yZi4YW00WSotOx7AJQPnxfC5fy/5Rllg23P7648q71PmraoyCOr9O/11M9CeFVmjr+DczhCZAItyPbqZRnWGCGITmiPBrASqjEVQXtPfyI6a6iUjWh8D6hFmoBq8mJr1xLreBQ7lCjg948+eudw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B4/hKtzO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2C8B640E01A2;
	Wed, 31 Jan 2024 16:11:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1w-588W2n2Sn; Wed, 31 Jan 2024 16:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706717499; bh=O7E7kwHx1Kr9225w43oFqd2UxOHvGdP9OedBlf53otU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4/hKtzOrZjIK9laqz5SqJ/gRFUTQlJjJ653+kAXHhs9Bd1AT59wFxHhMXjteFxFQ
	 CNcBin5fhL9OxXzqPwMFaqDRUp4HZlKxTJB8hQZWHHc+2bwYOAZmUKh6JCoYXS7v7r
	 /9nsTJN+xjCIDnzBOHWc1n4CYt9EI4Qgdu4cfJaqaXgc310c6n9y7DFezg6k8wf4YY
	 3Y5HxjA7yI/9MHJxobMEztavEcYy6k24IHkE++q4pUeiaHZ3t0FZmI7xz65O1IK380
	 mX49gKvzDOyN7dWnprm2oFQfguipa+1XcMnY4ytkwPGv+yB65K959gdVGWjKGNeluK
	 RgZ9Fe+fYipLe2SkkoIJ3q7772KqEy2FjKOeJHqrht0zY54fTGcviccW+/Czp0KS4h
	 A3ncSPyavBjrAiuax7CIy9e811JXSAJ7PycoCU89M8/xiN5q4h/ddSvp1mmNKWhfd7
	 pmyBlN6x8zj2NMLdUlSB5sbRvUPqItIocIyqfWixPFUMlUaZEZhBbsd2n5we4zAUE0
	 HqqS2088uphsiSM+Rr7D27NcIiGqtZ3YKjkkafGywCdzHC9rjPQje6IuaNxRqJhPbD
	 DT6/wqPoqCAHApIQXepOhhkQ7VTRN7j3A9uYrmcXSIFaV/i3TeLBgNXYF6n5ub10i4
	 CnFhnD5osiOKDHqIehSrjDzc=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A029D40E0177;
	Wed, 31 Jan 2024 16:11:35 +0000 (UTC)
Date: Wed, 31 Jan 2024 17:11:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, muralidhara.mk@amd.com,
	linux-edac@vger.kernel.org
Subject: Re: [bug report] RAS/AMD/ATL: Add MI300 support
Message-ID: <20240131161130.GEZbpxMqgOcxo_HW02@fat_crate.local>
References: <18bb00a0-5742-47a5-9dd6-c35c164114e2@moroto.mountain>
 <20240131085638.GBZboLRr6jsZhqwjfP@fat_crate.local>
 <1b3a758c-7928-4486-b63a-bee977d99913@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b3a758c-7928-4486-b63a-bee977d99913@amd.com>

On Wed, Jan 31, 2024 at 10:45:55AM -0500, Yazen Ghannam wrote:
> Since a bool is stored as a u8, is it possible that bits[7:1] can be set? And will bool
> operations only use bit[0]? This would break my assumptions regarding the bitmask uses.

The C standard says:

"When any scalar value is converted to _Bool, the result is 0 if the
value compares equal to 0; otherwise, the result is 1."

and

"An object declared as type _Bool is large enough to store the values
0 and 1."

Also,

"true which expands to the integer constant 1, false which expands to
the integer constant 0"

So I looks correct but lemme ask my compiler dude about the finer
details.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

