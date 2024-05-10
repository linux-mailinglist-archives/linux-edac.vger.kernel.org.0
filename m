Return-Path: <linux-edac+bounces-1039-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9938C251E
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3341F21910
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2024 12:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2D8127B66;
	Fri, 10 May 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OovjXAU7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD54D376;
	Fri, 10 May 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345557; cv=none; b=t+EbtiDWEXjjI349Rj+3H49tT4UUa2oTRuIQrDK4o8Z33HB6Yet6ywIyuO+8RR9mQQks4vUUNFMp9JZKXktp8WAP8pkTKJNNGT+8S6Vij2Vj1nQuSPLRCY8mdCrAtwLb3poLTx1hvOxy2SxrTbGFHMe7yW6bHB1maw5rGzXPMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345557; c=relaxed/simple;
	bh=pDwlZWiIXP/ed5ZKK47iOK1IxJybI7zmM6gq7+VyleA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2iAirbzvWVWeTWqUZqWGgfrvduogdEswF9MY5CKYzUmwAxjNwtH/qr+vooQeuPJg3YRgamZ7AWCJsqrz3cZA3HO+A4Mi5gx1BMWUynZVRc10A2qdSPlXLC+OQwEycJpxR7clzhbts47a4Fy4RkIXjRHX+0Dbmqgoq+MQnHp0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OovjXAU7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 53F7D40E024C;
	Fri, 10 May 2024 12:52:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2geoQ1AAp8Ho; Fri, 10 May 2024 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715345548; bh=vXXmcFqFduUzeShgTnzVQzbxh5p2i8qrDyrsMQmHWzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OovjXAU7Fg8DyDHu6YjJN7KRin/dtzIfRaoaKpuXQ/vPijUDDJkjaMa5xs9UTsnf7
	 +vHBIVa0kRqXkutRpOBjlNKq8shi9kLA1spCHWB9LQEyyF2fpWA9OoZ49sFq4j/e2A
	 c3j3dinA5cFSC3zTdnNHDErwZepu1iwWo4UpzqDpcyKBAsXaNsKexKSXPhC38MXcc7
	 uSRJtvoGLZLb+58Mnl3NLfu3VlHkLFA1xUh3uJ5xSPlXwHe1JBGQkjXgbb4Q6c5437
	 cRrIOH3dUItgtlv58Y0piJKXGEEdvh97LkqNGyC/JJPX40kDkDyeqqW7njICYwdccI
	 p8SBeti0ChQe1MRcjo8kJbjcOI5QhnY/1RWGyRJGtNQ8MHqxMs+B9DYFtFt4CJEvlx
	 XKK0/6KKCVQacpx3nvj/3NkKuj+mWsZ0NPQTxQb5qzWpLKZjSoSaSehqhgTFc9f72l
	 VZhLjFHAWnnwjMIXd51wuOR4SIUB0WPm7OWHfK8+IkmMpSFYzX376eV0BSMNuWKjrZ
	 Vp/n/I5TzLa7Mx78oFkhN2jJ1vtaA4arKEkymaL4b63DCzlgoX7sJzjMAndgwzKl4M
	 XHVzNKM1IIyMUNMQYqvOso4Hlw+1JaEpmgJ5QE9vUxIkSxT7FpZeY9ARiWjURsMkgc
	 QmsLuWeC4dc87PhPGOkmwq/8=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1ED5B40E0187;
	Fri, 10 May 2024 12:52:20 +0000 (UTC)
Date: Fri, 10 May 2024 14:52:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH v2 3/3] ACPI: extlog: Make print_extlog_rcd() log
 unconditionally
Message-ID: <20240510125214.GCZj4YfluoP-mDz3_U@fat_crate.local>
References: <20240510112740.667445-1-fabio.m.de.francesco@linux.intel.com>
 <20240510112740.667445-4-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240510112740.667445-4-fabio.m.de.francesco@linux.intel.com>

On Fri, May 10, 2024 at 01:21:47PM +0200, Fabio M. De Francesco wrote:
> Make extlog_print_rcd() log unconditionally to report errors even if
> userspace is not consuming trace events. Remove ras_userspace_consumers()
> because it is not anymore used.

Did you do any git archeology before that?

d6cae935ec5b ("trace, eMCA: Add a knob to adjust where to save event log")

I can't find in this commit message why this is needed... Do share pls.

> This change makes extlog_print() (ELOG) log consistently with ghes_proc()
> (GHES).

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Pls have a look at our documentation and check all your patches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

