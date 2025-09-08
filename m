Return-Path: <linux-edac+bounces-4736-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85279B487FB
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 11:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A71A1665B7
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EE62F0C5E;
	Mon,  8 Sep 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UxtBKidM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55351188713;
	Mon,  8 Sep 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322693; cv=none; b=jviATK3bv9nqfb75Z52gnJkWQXU+LoVD+uQbDjO8xuEn5TmAj6cbT78kQjychXX3TU5xjAqeVuQYO9JGm9PQ5xRYTbUsPQbLIewibbw5LKkxZ2FNSBf1+tBPhOJlV/JTQUMcCm/h3UTW8EtaG5CsAVvs94rzWwRdQoiUOnFYJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322693; c=relaxed/simple;
	bh=evM/rvxGMjDmULbW0k7e2tz9gZ0s8QBMQMepaWK796g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH6C/5+nJHvsHzo0gAQseozeYqr0NaYKN1x8JnQ8/nVg+Ryx7rp9F1oufXZTuEi1AOnuWndOkyByrJdPguDILkPhMC6uBQUbfc1EL51A06tU4+Wrf/AscCXV0hvz6K7FWbTZJZJmtSkUmmy8repkjqpgKZloaZ2whb08VQO8tZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UxtBKidM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8FAF140E01A2;
	Mon,  8 Sep 2025 09:11:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0T8FJY5P_F1g; Mon,  8 Sep 2025 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757322675; bh=7XAfj3MYUgMXBT0TNh9lZ7tKmYbhfmf+pgp/Zi0Uqdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxtBKidMGLDtd0UkOGsNpak8DBmn4lehaxMdjKy8Ge5buIQ6XHX+Kr8JrHwQlxTtZ
	 cRbqBQ+Tg2l4iRNt/2FWoYcqxweGTga//xAPeT5pon+YZ++Lxr36I1/v+y0PZsl8L4
	 7IcM7XDjoQN5DIqSfZjRYY1naEAItG2+7xN2ejf11C7VHsHYUpbPbkDIPpySq25siM
	 6UCfnyH8gCRl+xZGmYoE3972M4pzx4Z27ZcKfqX0wgmX1qaivcGFNBUrXAQWVlaoO/
	 mPXzBjepuyqNcBqcFYdNiNH36kt+rNu8t8Z/LaigwoamgoJnjy3SzKXLksd6QiAgqf
	 AlVKfVMaiz+c21hfPQFbVUtldHXXIUtHZjemjoAQyVLy0RjiHjQ5RWMKAi1V0FlKcV
	 5MHz83b2zr5P4XKfh6M38mTfxJOJ2DgPxr8THlNxyajAi+cCCgmT37kDXgzml+OW+b
	 4GHiZihv6tPWpvLkt3b6oijySIoYIbLenEJeeBU6H77iokWZAJ7vrSZUWux7cCRuoz
	 ukAu73MbdEy6hQNyFNPM76Dd+yrP40WDMdwlBXxrxlRuaKQtLBr2qxbASQPLZuE6B7
	 neVhlUcot/tKgww+DjxKcI8mnPdbF9kVDX0NiJV0JJjBrKzVBGP8xU1ENhDQXZDsd2
	 ZD3vnxS+2k7fLr63icgb4oig=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8CF6940E01AC;
	Mon,  8 Sep 2025 09:10:58 +0000 (UTC)
Date: Mon, 8 Sep 2025 11:10:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"ptsm@linux.microsoft.com" <ptsm@linux.microsoft.com>,
	"srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
	"shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	"Gupta, Nipun" <Nipun.Gupta@amd.com>,
	"Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Subject: Re: [PATCH v8 5/5] EDAC/VersalNET: Add support for error notification
Message-ID: <20250908091050.GAaL6dmop_0kjZSYWg@fat_crate.local>
References: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
 <20250826052914.2066884-6-shubhrajyoti.datta@amd.com>
 <20250907111948.GAaL1qVA_jL9F5piRR@fat_crate.local>
 <SA1PR12MB8947C010FA7FF05F9980D983810CA@SA1PR12MB8947.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8947C010FA7FF05F9980D983810CA@SA1PR12MB8947.namprd12.prod.outlook.com>

On Mon, Sep 08, 2025 at 06:41:02AM +0000, Datta, Shubhrajyoti wrote:
> I have tested it on hardware it worked for me.

Thanks.

> Also there was a suggestion to replace log_non_standard_event by
> trace_non_standard_event directly.[1]

It is on the todo list.

While waiting, you could try to ping your colleagues on an Ack for your other CDX
patches.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

