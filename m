Return-Path: <linux-edac+bounces-2364-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D949B6EBE
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 22:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4641F21A64
	for <lists+linux-edac@lfdr.de>; Wed, 30 Oct 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640D31E9064;
	Wed, 30 Oct 2024 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yt+6OvbF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DB1E00A7;
	Wed, 30 Oct 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323466; cv=none; b=HDDVT6Y4p5QSn9xuDTNL85Qtiih9vWEiK9SfknxvfCDWdM1UeprMO83yyjpLDbyutyaYm7fuPPOi4lbirRzEQUnr6I56XGnb0jO3h6ET0QLmSCxtk5OzffqA+xJYIvHVGT96sey5CEGKTFS58xFKemLE06p+0hteYN1+9IX+JL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323466; c=relaxed/simple;
	bh=acjOFjBOVMZZHj3bGLv6dB8gJMX3x2OJ3c8mHLp6OR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/peextvnLz7m82rkxVr/fxY2KaZSJ3Mx8HE4eMcZbNeV4H3VX7CJlB4x2opNccbkZQTaNGiN+yJsx7O4Ftlj47u4UYAMr/69UQtK+NbFh7UCJHGA90QAV5uLczpIXab8vKqYB129dfc+1DCNGN3dZZ4y3hZ7m0ZQg7WfiUNu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Yt+6OvbF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A8FF40E0208;
	Wed, 30 Oct 2024 21:24:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oNvYmtCrjerz; Wed, 30 Oct 2024 21:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730323454; bh=mYJgvheGLGEMM4Xdz1XlHN/OqJZZ0dMjOTA3ruL/C6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yt+6OvbFXnjV5arcEQUYehTog6xdT7AUVnowon9ZirlJUhVXIj6LUNp4LPjkApPu8
	 Nr4TP8BpgKgUROvF1/bXf7nfQfsPC2AwpPueiep8FEV6gyjQ6LWNxxO/5URjTDZNEF
	 vNx8GWsZ4NKRZ8GDUXCKAL7oOWWamCGSmqipomnCtzKrGuLWuuBRQLkkQGho/yKuNd
	 ZWe4CBpB0OVdrqnwm6BspVAwVX8M79MJXZVMa1Ia0mXuvJDD7lqu5w+6ai4Gs6ZB9T
	 RSlKvDTc2gVXPgJYUWVS/+IFhBf2wlsa+TiBtBjdPfDN0xY7tSxbQOTeWwSYRdi9wK
	 QUDJmz7XcHHCS1CLtoTjPTahUhuFFqdFh1tixmndkg3MA23HnVl3MR6Te348AfSpTk
	 YU2heXfZXo5dTv/NAmpWWE0BxVsP4kwt+SRUG1kFv74JoEJdVkQbyAnHpsBb6+ehb/
	 S3yHYC5vWAdfEtl/2WocmlhAR5uIetWfgLprX3I6Spp/uIVObLlJKcSgg4dvA2H3Qy
	 pU+VdfC+9oT2I47SH+21l3sfyXbGJw27lYH3okx/fo2PljLI7GNWdcACQkZHaxdpDu
	 vatJryse1acgaeX39fNsdcKCver5pmcGTanY5jr3CeHorzVVquH739WhUFLx3G8081
	 9/Y+ZRTB+lb/vGvkYPY1ceno=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4753D40E0191;
	Wed, 30 Oct 2024 21:24:00 +0000 (UTC)
Date: Wed, 30 Oct 2024 22:23:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com,
	qiuxu.zhuo@intel.com, tglx@linutronix.de, mingo@redhat.com,
	rostedt@goodmis.org, mchehab@kernel.org, john.allen@amd.com
Subject: Re: [PATCH v7 5/5] EDAC/mce_amd: Add support for FRU Text in MCA
Message-ID: <20241030212353.GHZyKj6Q5mcYZ-kSSn@fat_crate.local>
References: <20241022194158.110073-1-avadhut.naik@amd.com>
 <20241022194158.110073-6-avadhut.naik@amd.com>
 <20241030161550.GFZyJbthMO_2Wxe3bV@fat_crate.local>
 <20241030163147.GA1379143@yaz-khff2.amd.com>
 <20241030165002.GFZyJjuifxBLUDKyL6@fat_crate.local>
 <20241030180041.GGZyJ0SXfa73Q7NmwF@fat_crate.local>
 <5885d093-275d-4d29-ab13-2f118d61d62d@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5885d093-275d-4d29-ab13-2f118d61d62d@amd.com>

On Wed, Oct 30, 2024 at 02:57:33PM -0500, Naik, Avadhut wrote:
> So, for now, in the kernel, we log SYND1/2 registers only when they contain
> FRUText.  While in the userspace, since MCA_CONFIG is not in the picture, we
> always interpret SYND1/2 data as FRUText.  Rasdaemon might need to be
> tweaked accordingly. Will take care of it.  Overall, sounds good.

Thanks.

> Do you want me send out a revised version with these changes?

Nah, I will queue them soon as I have all the bits here already.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

