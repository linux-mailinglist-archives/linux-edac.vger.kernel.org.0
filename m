Return-Path: <linux-edac+bounces-1193-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB08FD317
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 18:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AD4286BC4
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440F188CAD;
	Wed,  5 Jun 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D4+0UYha"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21C15666F;
	Wed,  5 Jun 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605926; cv=none; b=e5kjboji5YqRiW0GWqGIWtqcTg8Ha8yQD4RicjOzEnL3XRAUmn71fH5YxTEM5aQ4vejDEyHL35TJhs3CGZKxDiRSqhZt0XTQ5obJ2J2O1EzUYTXVBwH2hfSlgx83h+YQepMO2NHQe+JnLFxxUcppXI6ywwjzlc5/1X+il0neEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605926; c=relaxed/simple;
	bh=2AvSoawsFzTXh1CTPggnx/EJHpxRpbOoUivtACXyLtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWJ7hbuPIji6fW6eckfl2+Lr+blhSx/n7iNB7vDl6A6QoIFWKiHpvAVvcidweq33COMT7G1oKNa193PwQDkg5YH/YV1d3Q6r+zkXL+cFyaQ1FmWjmqITnKveA/e2Xig6UtQ2q7NGMc61epVKdlR2MGJKmANvT6JyLzVRf1fIDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D4+0UYha; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E0BBF40E016C;
	Wed,  5 Jun 2024 16:45:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HKwGLeMcO4GR; Wed,  5 Jun 2024 16:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717605919; bh=55FFsN3ftlp8CQPCKWhszPtPcA6LJBd4hfv2N4LBpfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4+0UYhaGFeq4Zc6tpJEsxCPSQaFqjMqnbtB8E7Hbx37v03uU46ocRwLF+zeDKnOw
	 846/UnTeB8Stu8aG8S6IegN3HxicT3falfAzU8UwR50gj2iKhblvJzLRcZaVD+kh4X
	 +IqWvFYCme5J2EOcHuuWKPM/DcUZPm7zUX5hsyRYX1vcl1U2cpyna4c2Q4+IWaiw+c
	 hMIDzk0L2p/JQ7pNnGZBuM9PnCCN5QGppvW44xfZff147rX1NmxUfyFAkHEYovWXyl
	 45m6t0SoxGsa6qYqQdI5+7CMFjfNyoUfVXCXDsTmWpMOZ5ubgaRxAq/fgMyEo5WEwK
	 V+fHenVe1KTsyhK3x1ykyydB7qkAkpcZ7s3U0uX5m2V2Xqb8Gd+e7lhV9uQL+aMiFt
	 kucwaBs4pYUXIr14ORiNUWj7fouVA+9DJsJeFSXtxZLpE4RGGU+3nwI7igqqFBwTIa
	 3jq/wc8TbFVl5X91FLPVDIbPoXaSVBGqah/ONUH0PEOQfpJ39lAQE2oPT4JVs/zg4R
	 B/liHLkOdYou2BogStRfeOzukxPhss/v7WRCxmbLsHTzBh0orx//5xYdF2JH0lu7wC
	 LUwwpLQW9znPTKnFlWqbwia6f/ZesHffovbLQ4o4H1sOZsCaJjBP4xFiKR2E6E6Oae
	 DUWvQ8fJY8eJW7KWgXn0C4hk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 412E240E016A;
	Wed,  5 Jun 2024 16:45:12 +0000 (UTC)
Date: Wed, 5 Jun 2024 18:45:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
Message-ID: <20240605164505.GKZmCWEROq9QByGDRn@fat_crate.local>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
 <20240605122012.GXZmBX_KFQArXB9Lar@fat_crate.local>
 <7a7c2f41-1608-4348-9183-d99aaa51398e@amd.com>
 <20240605161236.GIZmCOdP-CRPJ8-3sY@fat_crate.local>
 <e17b38fe-97cb-4559-be97-36af0ab14789@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e17b38fe-97cb-4559-be97-36af0ab14789@amd.com>

On Wed, Jun 05, 2024 at 12:30:35PM -0400, Yazen Ghannam wrote:
> "It fixes a problem like ... a hardware quirk ..."

I'm pretty sure that means a patch which sets a magic bit in some MSR or
does something else to make the hardware work again. Errata fix and some
other hackery we get to do from time to time. Or my favourite - fix
a BIOS f*ckup.

> Most systems will return 0 for SMN addresses that are not accessible.
> This is in line with AMD convention that unavailable registers are
> Read-as-Zero/Writes-Ignored.
> 
> However, some systems will return a "PCI Error Response" instead. This
> value, along with an error code of 0 from the PCI config access, will
> confuse callers of the amd_smn_read() function.

Yes, but it hasn't so far. It is all pretty-much, a hypothetical, "what
if" thing.

Sure, if that error would cause a serious issue on some system, by any
means. But just because it might potentially happen... Meh.

> But I think it's fine to drop the stable tag after reading through the
> rules again. I'll do option 2 or 3 if there's interest for specific
> branches. And the cherry-pick thing should be easy to do if all the
> prerequisites are already upstream.

Just wait until some real issue happens. Otherwise, you'll be pretty
much wasting time and energy.

And, btw, people should upgrade their kernels on a regular basis - not
run old, Frankenstein backported crap and think they've got the best of
both worlds.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

