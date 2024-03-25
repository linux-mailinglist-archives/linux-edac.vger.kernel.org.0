Return-Path: <linux-edac+bounces-798-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112FA88AD33
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 19:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435C31C3D8A9
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541F1E522;
	Mon, 25 Mar 2024 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NAxxMR0n"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AE18E25
	for <linux-edac@vger.kernel.org>; Mon, 25 Mar 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388346; cv=none; b=kH9OhAdln1ZOMPhRd/MTBVBHEHfxukHOPwfxm59ZZcEhnrXXpaC6rXmedpyxDewCPzIqcZ7KW5bJ1IhLHQZY1Zj3zt9UpVjUs85xlyNrGQ+7N1UD5UwJG/qW1VByzL3X6Lvn3epbxmy1mkWOcUMgUsXwOyxChFvu3WjRDsE6IDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388346; c=relaxed/simple;
	bh=3JvG4fr37Vhrrbb8kJmM7pqZEZBifYyOGImRVRkwprw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9LGO+Gh3GYcJY+txoKgbueshmJt2nDVq8b4gCaMg2xdE6Ttz7qyafp+DSOixnMBBpXUePXX1f9TB6nDskZzc4sjRWRXAQiue2SGUV2ggJ21V6Wf21TjVpeTcFE605CA4rTPP5EfWBXRjQukTxRn2VIRRgrJxyD9aaNR4D6YlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NAxxMR0n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5449640E0247;
	Mon, 25 Mar 2024 17:39:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xQey0RY9BRgP; Mon, 25 Mar 2024 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711388336; bh=eALaW0qDyBiyLJ8xuJ6Fpl12WV6i0h+J9Eikp46P79Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAxxMR0nFnDR86fR1QdwtkEd67Tx1drUrbaJLK4sIYB2Es+BmyeMM1jl9i2KA2+JD
	 p95KwTOXek+zF/UzrjyaM+vAka2pzhYo4i/xbn74WAnJLCChUgK6FfTrZlzroUvpVv
	 GevRBh0qCzcCfzZZfUdeeVAWR08X0U9SVLjswj1YtXJUMY6DEVlRNvqGQqRHMbAd1U
	 eV0/DdEg7YXRkl5SaIVrsk2GZ/Ckso1fyKvC2ClrqiQuuVfkV9z3CsOWD4xwZX4ONt
	 SJtHjUMKgKEvR3kU+tMQIPHb9wAcaSnI/qik6kiEK4itso1xA1vpkTh8Gtl+E9UNaq
	 vVN0hta/pbBsKqRNvEUalzkXXwOpnxMmzQRHfjSNSZxD30CUr4Q5jCsXCHZol0aWGF
	 5NJH3QQ1pfclJfkx87HZfj9IrkwPksBPpDMtYT+5N+d53cehWqRH4hzPNPe564R6PF
	 3EQe8SlQ4K8pcS3cyamt+ZkmWAw3taphPcQfQgzrPt+LDk404PlM/xMtbXq6za2/6T
	 vOXtR012D4KXBgLf7fSr66XYVhkJ2j8hroiG1OmwLE8+n1jO5IueEruUG+EukSGLeb
	 d/4JMO2JJ1q2KoQSN+qLul5N33USLI/w0tLf/QYMAbyW5LQHOReZ9559eOAsmhoqW1
	 51W7qbbRt2yNkf706JJpffOk=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E14340E016C;
	Mon, 25 Mar 2024 17:38:53 +0000 (UTC)
Date: Mon, 25 Mar 2024 18:38:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: A <akira.2020@protonmail.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: kernel 6.9-rc1 fails to compile if debugfs is disabled
Message-ID: <20240325173847.GFZgG2p9XT3OH0po5Y@fat_crate.local>
References: <N0Pv2Kh3nXKRyRNwwsJbgOoQ2_TE7fBqHtMUpI4-ijf4qosbq3o_HNCgL02-pr7hgQd6zLqXpJF_MmChCOrzABfX7s6D5lWI3KXk_B2iFB0=@protonmail.com>
 <20240325160818.GDZgGhcpLu3uks_K9z@fat_crate.local>
 <HCNla3hB7hRLtei6e9hDKTtNA8rpNlHjh6qeb6ysaiRniyNYBQFsbIqVPuHfIdOpkRAmL91XOFES7iumuKZcbUqZnOo59I6Sok1Irc3NcjU=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <HCNla3hB7hRLtei6e9hDKTtNA8rpNlHjh6qeb6ysaiRniyNYBQFsbIqVPuHfIdOpkRAmL91XOFES7iumuKZcbUqZnOo59I6Sok1Irc3NcjU=@protonmail.com>

On Mon, Mar 25, 2024 at 04:49:54PM +0000, A wrote:
> thanks, this works

Thanks for testing. Do you want me to add

Reported-by: akira.2020@protonmail.com

to the official fix?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

