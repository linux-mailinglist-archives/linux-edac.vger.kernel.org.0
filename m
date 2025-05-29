Return-Path: <linux-edac+bounces-4039-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D887AAC7B76
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BAD4A17C4
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F39258CCE;
	Thu, 29 May 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ckKgXV2r"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05221B8F8;
	Thu, 29 May 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748512580; cv=none; b=Xw1HWpSQUt6Vs1DfsqTVyW5whEguFAz+8qCRk7heJhKo3IqL/FkySV5CsF6kcIx5dUBAm6WKFjQ1FrYuRZYcjC08WG1S22UJKGW75i80dHY8Y8kaxZ7FFOUuQ5VYlg6JBBU1LvN9jzA0xjRe6zXaJVZEdyydC7ZiaUgGQGhjk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748512580; c=relaxed/simple;
	bh=yqJ5DgY98E8B+lVlUMTdL98B493AuzUfG5+zVE+Ydz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEs5nyjirsIQaws/rTl6IzvYig7hrZL4eqYGWMpL1F0sFxr1Ss6eyAJPNewJExGmFnOwKMUL8VG4jDATA04U/SZlin3Uv6T8hNe4FZZb5x+clRQH02eZbG2YvN/hkY64dHb6qrmEES3wYNnnPgx1Xje1VPL6sDnbi6PvYtIQu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ckKgXV2r; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2596D40E01B2;
	Thu, 29 May 2025 09:56:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vOts0cI1yeCP; Thu, 29 May 2025 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748512570; bh=0p3zG1uflJ57VnzRzCyb15DyMSrlT6u+CZBmAvONpls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckKgXV2rA0QMco8nlB9vBcyGhRIwHnbStYPd0+wGGjrz9ioPwmbPtzNmyMkwcpybc
	 MgKi3moRDXQsgq+bHz4C+AH8+pUApqdw8j77mtced2xfEcakwQ31QwoElB6d3ON3dX
	 Tgb5VPzV9dWZdtE0cWMOb64gfaAh2gWkXsao6OAEpXD/JnEeYKYd7+kLzXt3xpp9OG
	 nD27DsJy4oMppsBJIylKe7bBqDY+Ya/a2lsy/PxQAjFu5u0MWOXEd3ajFBKwRoQO+u
	 1xmpemVym5MHnaVAsxVjBKAgSTBe7xwWnjOkWcwvm0pIERfA9XXysM7fhdbiEWsuUn
	 lInfRhrKT5ki8oZToamtuysSamu2qFFSOaCQpAk2EMnLPtwYojfKBdwD1OBL0MvFco
	 O7t9xpVC3TMOVMuCNtb4DTjqQtpSiKUmVx3IqQHfMIPzhhbSfbn+L2XiVMBJRalO2w
	 9FCwolrAELccRtKoRWDfY+PQMOBavmkdyb9eJQ0ial+vtc6EztndJYo5/nOw6/TT65
	 fwZIiwVgJfI+lhsYoH+b+HAfkxPeuSB0Ji+K/oZGJdsh7OMHMR95P8f2BESr90WvkM
	 /XQM7nOWeR3+HpYvPcntxidmTb4vmiPzJ39xu7mlvActJqTcEdygzxTqMjpr9A/TdG
	 2zD5AxdmnZp8vlj5p3nUFLVY=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DAA2C40E01A3;
	Thu, 29 May 2025 09:55:54 +0000 (UTC)
Date: Thu, 29 May 2025 11:55:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [v11 PATCH 0/2] Add L1 and L2 error detection for A72
Message-ID: <20250529095547.GBaDgvI0mCLSXsM0dR@fat_crate.local>
References: <1748487628-30123-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1748487628-30123-1-git-send-email-vijayb@linux.microsoft.com>

On Wed, May 28, 2025 at 08:00:26PM -0700, Vijay Balakrishna wrote:
> Changes since v10: 
> - edac_a72.c: copyright line add (Jonathan)
> - cpus.yaml: drop stale comment line (Krzysztof)
> - added "Reviewed-by" tags

It seems you're new to kernel development:

From: Documentation/process/submitting-patches.rst

"Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment,
but the development process works more smoothly than that now.  You should
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum of
one week before resubmitting or pinging reviewers - possibly longer during
busy times like merge windows."

And we have a merge window right now.

Instead of sending patches every day, you should spend some time perusing the
documentation about how this all works:

https://kernel.org/doc/html/latest/process/development-process.html

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

