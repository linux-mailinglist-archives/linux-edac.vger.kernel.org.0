Return-Path: <linux-edac+bounces-1376-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5A2917D27
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 12:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D9D7B20D7B
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F7173342;
	Wed, 26 Jun 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="k+cJkItj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735616EBE5;
	Wed, 26 Jun 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396170; cv=none; b=Wx6VAkwT9RBNP8jKCarpuHdQRu0zQt1xOqeA+n+8rg6tHGmoj0HihEifXaEgN6FENYZRGgshekFa8C/bwnPwrUejfQ5URqXvv9xmnT/F2Zifg/akPPNLQ/dOthtolGL7g+XzuXL92wSIr29L4Z7WD/MdbAAR90xz5Wm7GwWnvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396170; c=relaxed/simple;
	bh=7vJCvp/7xnSt0k6s6hy/bZa2PYeD50NH6MW9l+0gHmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At1aEh794j81RAV8Xbi5Cy76Hd6oSrBfGNwna4idmRqXXy7YYKrbiQ52Eh8WFF5im8s9gC3HQoN6Ge6js54++/X+1XYDVtnGh4UoZEgYVSXwb/iL9ZmU+9XIwIXhvFkIuhCbQCaNgTwN3rph5TLNTx/lAO07ONy9R7AZC0p/IjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=k+cJkItj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B381740E021E;
	Wed, 26 Jun 2024 10:02:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jRMYJYaiDzF9; Wed, 26 Jun 2024 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719396161; bh=lD4TyeZu/NhhgQQlfGteNi+vykIB4ZpqnU53gHZBmtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+cJkItji6nli1P7LsZrysOq4r7ZPT0ZOKELzmfKPORSfJvoE2WeT625RSUn0fmCB
	 nbUXM5++2/fNukBgfO1dNVhLzGXyxEuyzak6YknsN19/pk3Rj6oGTvz+TAcgPdePB2
	 3HN6qYmjBwMfmiGuD8mHdVjLXGfdYE1g0qX+OdeAYVl3wwgjDGBG2DdgJs54z+JfuK
	 kNRwUiFZ/e5xkM0bAAiMx5F30vpMOQqRTbkiXDv+JDFidy8j5AYVhM33mQxG2yafQt
	 +x/+I9aIy7hysiFzYRuM/eAUzJ79rahjKU3V9ziAGM0boqq49UjA3E+bslOYmqch8W
	 VLyqis0HV6KYO7yHhunAcQ9ZvO2ZKzI5wD9fxuJioMyfgQr/b3y139mfF1SSAlyKM3
	 3bVo1ydiCgUuER2b2C640UvsUDXIFtjPOuSg/SPG4WbpyIi7/tGCPJS3b7A+qORerz
	 ENqmu5Ov/HR+drPyZysAdYpMY3xYG3gDw0m8eBEnlkV/57vj7+4sGDqxxCeVpLWzPe
	 1qpCAFeoWBD6Rjn66fN428cHZTFUR9ES5x+lA5gZj0o/hr7woIj56j6z5rkJ5nxNoe
	 ae0T0rqFJ1yl2cnEKaFBKQb9sR+VQvPsrPYEZbvhXSZ2YCRyRzaYbkMgyCOD1zWYKl
	 6F+RxQge14VHxtjAspcd/gDI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F74D40E0185;
	Wed, 26 Jun 2024 10:02:30 +0000 (UTC)
Date: Wed, 26 Jun 2024 12:02:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	EDAC Mailing List <linux-edac@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mauro Carvalho Chehab <m.chehab@huawei.com>,
	Shengwei Luo <luoshengwei@huawei.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Jose <shiju.jose@huawei.com>,
	Jason Tian <jason@os.amperecomputing.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [GIT PULL for v6.10-rc6] edac fixes for kernel 6.11
Message-ID: <20240626100223.GAZnvnL9xKNAwFrUFK@fat_crate.local>
References: <20240626113322.5e263aa0@coco.lan>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626113322.5e263aa0@coco.lan>

On Wed, Jun 26, 2024 at 11:33:41AM +0200, Mauro Carvalho Chehab wrote:
> Hi Borislav,
> 
> Please pull from:
>   git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac tags/edac/v6.10-1

Do:

git tag -l <edac tree>

to see how we're naming the EDAC tags and use the same scheme pls.

> For two patches that fix UEFI 2.6+ implementation of the ARM trace event, 
> as the original implementation was incomplete.
> 
> The patches on this series was sent at:
> 	https://lore.kernel.org/all/20240321-b4-arm-ras-error-vendor-info-v5-rc3-v5-0-850f9bfb97a8@os.amperecomputing.com/

ac3a74c73a6c (tag: refs/tags/edac/v6.10-1) RAS: Report all ARM processor CPER information to userspace
54481ee6de96 RAS: ACPI: APEI: add conditional compilation to ARM specific error reporting routines.

This is an ACPI patch so it needs Rafael.

Then it needs a Link tag. The ordering we use in the EDAC tree is just like in
tip:

Fixes:
Closes:
Reported-by:
Suggested-by:
SOB chain
Reviewed-by:
Acked-by:
Tested-by:
CC:
Link:

Then, the ifdeffery is ugly but ghes_handle_arm_hw_error() at least puts it
inside the function. log_arm_hw_error() should do the same and then you don't
need the ifdeffery around the prototype.

Patch 1 needs massaging too.

So please send them as a normal set so that I can take a proper look first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

