Return-Path: <linux-edac+bounces-5642-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C297DD1F3C0
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 14:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8214302E179
	for <lists+linux-edac@lfdr.de>; Wed, 14 Jan 2026 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243A273D66;
	Wed, 14 Jan 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GFd0txDt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267326ED3F;
	Wed, 14 Jan 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398673; cv=none; b=lF/K90oynMZgZHcIh90HvsnJMEsNuBCUJ55edPMl7lOuldi4PUGZ8YiRHgkk9Jm3/fWjarrdy1kwg2ZZSvfpsNOGQPqS8kEgka4vN4hyfrE6wxlbfEyWx1/44bJeMOGn6kXWePk18PiAhClTfVj+CmrrLwEsUQN4bJI09Ts6vlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398673; c=relaxed/simple;
	bh=dOgoOn90W11kGI4+6sAeZmfHKlTC64xN3u4WbyUw0h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJGg9xX/U7XjhIEKPkjrlXbpedQEHBJ1j4AYVjvWqusE5zGmWj6lZiN9nqcny93wD25AGYlzMB2hg3XIr/KMBTYkPxRse1v9XsvYCpRDNHFaKlpMaFvc0zyhxoWFAawng7iqxhqyackmz3bIE9VSjYLKmifGbJMQWnjGd0qhU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GFd0txDt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6477440E0280;
	Wed, 14 Jan 2026 13:50:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ARdy5Ft5JHVx; Wed, 14 Jan 2026 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768398656; bh=A2At7p3/uobm6hMvE3qTEDD3cG3t4QDVxmePKlGAJ0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFd0txDt0WC5O108wqxpckLKNeKdMqd66Y96POhSClrV/2vvGJJ5Slkw/wjmV86zt
	 LI5nh/9ILACexcwifQhLbMHbyBsstZsWiqOHCXzARI3+dr3cu+jAYhJZDk/7tEO0xO
	 bEuOczQxVmUxnMPkeo9qmKfEITI3FqsYinwL2xj7uVVHyWFSZ6l3Aqr4vxkjzNvp81
	 KqOk4ibznVP70R34Riee9iK4qE3jzpBzAyXcQS8yy53P0tq55cnnYZmo4WpeYFTNH/
	 SsadJtIykRU6aloR31Ox1u4Ml4aWoDPUsmDNKEelrrcCEPBWQE2vfjk/pheDhRRVNv
	 CZlNnyIPWDcLFTU6G17KtjKbtGD+C7JMH0vTdpVFd+9tVewuQ/sMS59DIzb4ieFrhJ
	 tVSX5OSX+E9TBtgDqwcyfyUY+L/GjtLJuTn2AFV0n8aHxpCzZqvfYiOmt4rAxPASuy
	 ZN4gf7dXadYkE2kgy0OmiQrAMozxzAp/+fC5pzLbVhbS4yTbbz5PvskBZnHSxRBrF2
	 NfXI1bs/WHoBeoNLUl7ToILNv86/UEDBrpnCUTg0fMgTG26jab29fzhaD2v2bY118i
	 bRGqlKhtg6tyQPKntIIhlsqoVYYTBgZ/SOEXjpXXDqbmnWV1dUgeQqKmcGv9QwZTB5
	 BfdV6V/15AfHf6YNi9cb+8rk=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C50A240E0028;
	Wed, 14 Jan 2026 13:50:42 +0000 (UTC)
Date: Wed, 14 Jan 2026 14:50:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Li, Rongqing" <lirongqing@baidu.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Fix timer interval adjustment after logging a
 MCE event
Message-ID: <20260114135034.GAaWefKm97-CkbEp4P@fat_crate.local>
References: <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113205654.GTaWaxllyfJLHsl0YX@fat_crate.local>
 <SJ1PR11MB6083A836550962AECED68500FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20260113213158.GUaWa5zunSfuAzra0n@fat_crate.local>
 <20260113224152.GVaWbKMMzManQ5WwlT@fat_crate.local>
 <aWbjkAPX9a9ZlJGN@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWbjkAPX9a9ZlJGN@agluck-desk3>

On Tue, Jan 13, 2026 at 04:30:08PM -0800, Luck, Tony wrote:
> Seems to work (though you've deleted all the places where mce_need_notify
> is used, so you can also delete the declaration.

Right.

> I see time delta between logs reducing while I'm injecting errors.
> 
> When I pause injection for several minutes, and then restart I see the
> interval went back up again.

Thanks Tony, I'll play with this too and ponder over what would be the proper
fix which to take to stable too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

