Return-Path: <linux-edac+bounces-3348-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB93A5BDE7
	for <lists+linux-edac@lfdr.de>; Tue, 11 Mar 2025 11:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED883A57E5
	for <lists+linux-edac@lfdr.de>; Tue, 11 Mar 2025 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B11E98EF;
	Tue, 11 Mar 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VR9sCa7P"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADD314F6C;
	Tue, 11 Mar 2025 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689081; cv=none; b=r0mUfBtIVNcuUFWsrlMBXP/Dx9qMCcgTihWCn2TcSZ0sQx0utpss4OeM4pruSaUUhzrUatsPMa9TJQZ9rcSdjiOBerRMNfIk8MrvHHi9+CwlCmTV8H71Pc0lEUl5EwIfKYlKUle6aUROumJX4XUpwWsY03DdnyPdxzUE3U9JtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689081; c=relaxed/simple;
	bh=dramJQtT0992rCQho+PmGVYmluut1w3PRvtmR5s8/Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoXQp+63kGVZ2tjjGXunZ7dYq1H8aaxjyWbNGL1JG/zZGYS4iRTAm8/elR7WbBZF7xhOIgZ2BTecnAJ1H1/fF6eu68Zkc6O6outo6RpVYcSHdY5XVmUtNbBdScNrkAUWXX0SWcVxxO7pFawQk4PvVwwGcgz+pGcJYOWE9jtSoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VR9sCa7P; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1E6E640E0219;
	Tue, 11 Mar 2025 10:31:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ik8Z55RNbECl; Tue, 11 Mar 2025 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741689072; bh=2vhg/uPqpko2pkoZAAckZDRVAr0KlAyppwjV6jRfD/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VR9sCa7PSMwAI5zFVnsE/mwFuwymbZrvFGaOk9KTIpjb0luX5zkxrA0Gm8p15c3UJ
	 Y3aPp/W40FnD0Wu5j7AI/AQlzR52fke8usT9+tBhxgxsy+PNDqpFv0RXUuEFYl62lb
	 2+sqSFRFvJL4+65b0jVHvKrHmvYqu6nrkoqWyH5k/FI5V+DHhYed6rKLmIsJ/2xoP9
	 gn7KleUsFkoQveivxldrGYZch1g1OWPhPKu86792EO0wOi/mbDP2HoVSb9mVMog0PG
	 ggvMpgKV+DADszxxDyPeiOYQRMBfqPIlXXgp7g+qo+YmNFa72cDVMYBHeO3FmFCA8Q
	 DeqDa3Tdqq5MjzwOMV4rveCQGd20fLX4wJepRI1R864k/p8gIqMEcitmI3yPiqtflJ
	 vVjBgz3YXfsfskVnkUyxHVrdBKV+eMvQsOZdjfl6w6B1qu77fvE+uE9+4QnHtMKH3p
	 V8XP/QDSBW2ZXwlXd0eJrguFFIhTTyujK2EmuSiTzvbbdbvvCQLT0fVOpKwQ29PzY4
	 /pTnhTrmJNoT+6i3gbOEmVpzPniRVLlGWSEIYullBZpIS8eSYqNVA7XcjR6WDXJV4x
	 1wvp/JA/dP6Vy3li2ottEYVEWYZZnmf2FIPLF4a+HUDhqExY8ZK32qMmn9H7hkhO07
	 yqKJXG1b7wiPlFmsFcIIO+to=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B17D40E0218;
	Tue, 11 Mar 2025 10:31:07 +0000 (UTC)
Date: Tue, 11 Mar 2025 11:31:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Shravan Ramani <shravankr@nvidia.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Message-ID: <20250311103106.GBZ9AQ6u6B8bd6W0Ul@fat_crate.local>
References: <046bf689-9a2b-4993-b8ca-927d7d2a0cc5@stanley.mountain>
 <20250303145226.GCZ8XCKkC0YSLHXycB@fat_crate.local>
 <PH7PR12MB590225F9E7C1BA48B5EF538AC7D12@PH7PR12MB5902.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR12MB590225F9E7C1BA48B5EF538AC7D12@PH7PR12MB5902.namprd12.prod.outlook.com>

On Tue, Mar 11, 2025 at 02:22:20AM +0000, David Thompson wrote:
> Shravan and I will investigate solving this 'smatch' warning.

Thanks, sounds like you're still interested in this driver.

Which means, I'd need either of you to be responsive on the ML and review when
patches like that get sent. Otherwise, I'll simply orphan the thing and it'll
bitrot until it gets removed completely.

So, if interested, which email address should be in MAINTAINERS so that it
gets CCed? Shravan's or yours or both or some ML you guys want to be CCed?

> I setup a recent linux-next repo, installed the sparse package, and
> downloaded + built the smatch tool. 

Btw, you don't really need linux-next - you can follow EDAC development by
fetching the edac-for-next branch from this repo here:

https://web.git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git

That's what goes into linux-next too and EDAC patches should be based on that
branch.

Holler if there are questions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

