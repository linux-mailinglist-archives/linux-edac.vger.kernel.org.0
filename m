Return-Path: <linux-edac+bounces-4724-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85A1B41A80
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 11:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BD57A2C3D
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3BF25F96D;
	Wed,  3 Sep 2025 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hwoI6QdG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CB1B3935;
	Wed,  3 Sep 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892965; cv=none; b=eXyCc+RaVjw9nSkc1u4omKPvc3EAqMzlTjGpMnLXfaQlijK3vp/Msw4PmBthMpqKoZ8KU6vOMlaRZPLWkRWmnZj+KrPvacB+yBDk8AcKnhZvb6feFIUrMOBa69jdT2N5YsnRoUE7Mdi+CCCtvQmhKFSVwM0sb60rFKkLQnFhskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892965; c=relaxed/simple;
	bh=QBA+9Q4DXlRNsL3uh2/WaBWI40Bn0edsboUJopMDhxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm76plqgDWJvv8+ZUxN8XDsjOa4l6d1EqiJtkGsF/OP8SpOY/5Ll9MnLHHQAgjQJW29hBQf2BLm4evHJTeE+WnHXHc8nx672kxexx6P68CIRBYwlFBTagQKCYVukYouEsDDW81cv8MmSYVfUy18jzh5hNOwEbuApHXi2g54QphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hwoI6QdG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9884040E0163;
	Wed,  3 Sep 2025 09:49:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n6MtSgtb6_z7; Wed,  3 Sep 2025 09:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756892956; bh=4e37DFL/MADhgiMTEbF7IvAM6sIa/QBG8ACggKqHIN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwoI6QdGF8OZlYUji2yJ5VEI963Eu/CApCpRCMASAWuEbLNnrJ0yBp/HLxXvo3KHt
	 RnZ3ZULyI/7RT5mvYLAjIbjmlHi1OO1QCJvNtGxDfeGXXn+r2Kf/8c/+vR3ZzVFa01
	 /cv3eMqXoeSRffT56LMs2Lh6zpANNtTAu5fJusArmHvrcRQMANCC7i4KJzEuRSfDl5
	 YmKe02dM6ijflrYLOnZRgy1fsXW5L3V6ImNVGC5tdfMmyu2ktfcSO65Jmp2XTlGFCi
	 97sh5k4vMPKVSsqhY3UD2+yvZaE5/mUtfo/ZrygarVczNVBOk8VvghJrN748AHsOR1
	 yWnN2ZPnK/Ciah9VKt7lJgJ8Ga72tqPsjLwrfCfjFP7c4DyyPh+gY30Q5E4/XdmC5q
	 GIya2g9r6yYDKINY2Tx27qT1OGCWJS7r2gOFB5suNswdaWV65p0lvfEpB3Tr5QyNJy
	 h/4AwR1hGLjmOBVZBoaqb9FN2BbE0DIpd4H+1FZC9ylU++pc5pAItRXsNuyFOmAMtm
	 FKLhHCzzLIKb6epnoX0FU8WgRw64iJoHdrwQpkt7a2E5BJVOiqIO8PdEsZE0Njwk/d
	 PvRyaYhpyYVxEu/uoDIhz2rfoqu334qfzEHrs6J3+ktklYTCB6QxECVzx8In2bzUt2
	 AdBB126YRiMZZ9C/0jHFx/2A=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7576C40E01AC;
	Wed,  3 Sep 2025 09:49:06 +0000 (UTC)
Date: Wed, 3 Sep 2025 11:48:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 13/20] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20250903094859.GGaLgPC_eWQgAqpHHb@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-13-865768a2eef8@amd.com>
 <20250902111052.GDaLbQvA2A0b8Ii26k@fat_crate.local>
 <20250902133712.GB18483@yaz-khff2.amd.com>
 <20250902170438.GGaLcjpoEhdfAGtBph@fat_crate.local>
 <20250902172543.GB273005@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902172543.GB273005@yaz-khff2.amd.com>

On Tue, Sep 02, 2025 at 01:25:43PM -0400, Yazen Ghannam wrote:
> Also, MCi_STATUS should be cleared as the last step. So it'd be more
> efficient to do any logging/clearing/resetting of an MCA bank all together.

Makes sense.

> I can go back to this idea and make it more abstracted like you suggest.

Yap, that would make the code flow more clear, at least, instead of spreading
all those different MSR clearing calls at the end of _poll().

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

