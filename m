Return-Path: <linux-edac+bounces-1043-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77DA8C2AA3
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 21:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BFBB22755
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9C482ED;
	Fri, 10 May 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XQQMls6X"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230504642A;
	Fri, 10 May 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369188; cv=none; b=IhGusOWklxyi96ccrpOh8y8Qj0zjMdrzXKyg/VpELTdOIW2j6UGFguAdTmzvSUzJn/jI1TGseqerU26Z6PvjORns951F1lISCoKKMDpQiy8pYHgvADnQaFeK3g2NDt30huXajMj4RJh5LzRQHM/ISf9tjgv9e5yapUhc3iiRkbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369188; c=relaxed/simple;
	bh=inEDYaew+YEG01C4KAaMRl1VrUA889zVACJ2cNg8zpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoyiGfBThzmLmRqJhzvM9FWK3rNDUZg/78piEV0okY/llxhTUIGcartkp6xNsYczxxaC5Uce3xqNguqNMxsjbr7+Gf7G/5b9CQ2a5kACDi2uENaKPVxylF3adhHVjlMYGMAQYeZtCkigIIs72eVLx57D4A5YeupFFjL6wkUKB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XQQMls6X; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A853440E0187;
	Fri, 10 May 2024 19:26:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i9wnLk0-y1gd; Fri, 10 May 2024 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715369172; bh=uw/2ezevvELFhvp8bGePVRfu1FmVUU/OEjEIueZ/F+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQQMls6Xyzn1yeMNbYh08V7k/Vg7O9Ip+hyan2dPjyPcZukh3VomjMHwy+xXqcjaL
	 6pAAmHy55AquZQzroTpBQIHzjGpztGj4YG3WGtl3bTbmZw0IH2Y1H2b8GrctwtbmoG
	 9NTLM6RA9uoFFwXY22LJ2zmwIx/+AvvmYqJnompBPpLWxilqN+H/Uo6TTySJiawrj4
	 NNWGfryOhro0q+MKmdM/F9myxinMgOv2AhOMWICjq9BKtY8tgwjdjOygUurLtrxwSk
	 ClPr5QbC+buexMdoJNc+B4Uyj/XfpaSWPit6nPUoPd+STypzkkwumuuR0BZQnsXvZi
	 RKH8ieWbO0UIH2kSeGteypRGiTy6xYJL3+XUF1FD2ZYbcGv2zTizoLVHH0cWNk8NEe
	 UxmJ127/qyeMUGGiGJx4muG0oimNniqu+xAOMqMURtsRt5kJqyN/F2sEcXhBvxvHUP
	 teTZqOjsb9m6VpsHK4ciOnlSSgTviyNWrqSQCgb/pLygBSmiZrxsn1Ohu1Sckj6w7u
	 E5bGjxzgP+3aLPT3x03SnnRGtmfDtAkPaJkikSQ17dY16hGLbiJSe/Jdh/jYPL8D1t
	 FDk9FuuM5QNOA2sIbCxj/BkQgz7UHQuPQww8hBxsBNlKaMPC3iCu46vu51DHqIECSG
	 u+OzV5Qc6LASoKibrfAkwMP4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C6BC40E0249;
	Fri, 10 May 2024 19:26:04 +0000 (UTC)
Date: Fri, 10 May 2024 21:25:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <20240510192556.GDZj50xFIWSqK2gzQR@fat_crate.local>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <20240510112740.667445-4-fabio.m.de.francesco@linux.intel.com>
 <20240510125214.GCZj4YfluoP-mDz3_U@fat_crate.local>
 <7009544.jJDZkT8p0M@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7009544.jJDZkT8p0M@fdefranc-mobl3>

On Fri, May 10, 2024 at 09:00:34PM +0200, Fabio M. De Francesco wrote:
> I thought that ELOG and GHES should be modeled consistently. ghes_proc() 
> prints to the console while ghes_do_proc() also uses ftrace.

ghes_proc() calls ghes_do_proc(). I have no clue what you mean here.

> If we want to make ELOG and GHES act similarly, this patch is needed.

I still don't know what the problem is.

> Please note that I was introducing the "why" part of the message. I never 
> refer to this patch for the "what", and I always use an imperative tone only 
> in the "what" part.

No, this is not what I meant. I mean, don't say "This patch does" or "This
commit does" or "This change ... " or whatnot as that is not necessary.

IOW:

"Make extlog_print() (ELOG) log consistently with ghes_proc() (GHES)
because... " and this is where you come in.

So let's start with the problem: what is it and why do you think it is
a problem?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

