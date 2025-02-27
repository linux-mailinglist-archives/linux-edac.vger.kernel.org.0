Return-Path: <linux-edac+bounces-3217-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D81A482E0
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 16:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12F63AA6E0
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2025 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28A26B2B2;
	Thu, 27 Feb 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Py4kxBin"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCD26B0A1;
	Thu, 27 Feb 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669920; cv=none; b=sCyDeF6DonW+b3hUL3azfdQ4A9o8/7TcAjBqrHMSYqWbdYwyHUt5Rnzg5L95Q2jwN/Bp6laBFta0BL9ty93PDsuXdgDBWTwyVdeUICWCz03ITUiN0uuuF4rXwWZqskzN7DcWjoWflOEjPYhL2RlJQncExscLsDoPsdU8jlev9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669920; c=relaxed/simple;
	bh=ILhxlSPxDHvKqbkAdsFvnA5w0urddBfQcztKCtjLnNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn+jEiWeC7SKk+HmXLlso7KfS7W3sAo3/xX04+WpGHBYMVOrzwO0oznohC5NtcscsfYxWXmlaJFMOWpH5O4Huk2SxM+sqwR9OcwaP8MsTW5Mt+wSpOnARLnHHGYG2Ml99Vwp7B8+qU+cuRZbb5QNbEiD6wcQLcF8h57/Ogz6cW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Py4kxBin; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1CE5040E01A3;
	Thu, 27 Feb 2025 15:25:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Asb82YF14Yc2; Thu, 27 Feb 2025 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740669913; bh=Q92QBKq9jE7T7IU2lV/bRqcFLg5w8yrhy42mYugBxuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Py4kxBinmMsuPKY2ONATv4jqviqzQnMVIQnseeGKYbjsJ3qG4AGwxwtp5QtVSqz0W
	 iduuisOui7qJRfA8qXEAjG/4epC9st0hGJ2wBHl8OZ0knfNC6KuXqcMvZxFeh9y4QI
	 qxuYaU2vQiRz72PUaURy6MYjUV6xzHetYv3bvmjHi4L1LmplCRFxS7BMn+Qlgl2y+h
	 +DA609FJd6S0jGLpnVvX0nxTgV+XjJpsjagyEuuFH30X9qlAFHtXSAVAlhP8AqG4Zn
	 9BLK1rVXsbJY3CX08eSpiW/RP2CN74p9LXgU1bv9YmyopUTO68c9blXBuvCNGYlVyP
	 O2Z8OS1vioz7fYW3hrwZ/5oIUpmYsG5Siqp85Nk9CzRLwhXaCuRpV+ygYG+OMZsAS6
	 ZDdThNfh9ZYng78LkQ6BMUwtHBUcqDgK0t+MW3W4WXSZKWrNVeOK6ucqPThTDRHBMn
	 gSK6zUnMj/gx9m1SymeZt/2PTjlpLfL1WZ/asaKJTAv81WkS7tguZkSOHL+kql98xm
	 7m0Qs+vbUGSFZvMhpptYOxTnOvpfQzUe79AEzD7m81q6HSyoa3deuu4A4MpEJ8pt5E
	 ZnCMqzbyRJKp2pkg/tY482Y8VzfVCHs8sT7qMmeT3u8sFgeu7rMuJWeFr2xF3zUs+w
	 xlv/mYUY2e86bPpSNvhIvSMs=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 498D840E021F;
	Thu, 27 Feb 2025 15:25:07 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:25:00 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
Message-ID: <20250227152500.GAZ8CDzEBRWBUukmcl@fat_crate.local>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>

On Thu, Feb 13, 2025 at 04:45:55PM +0000, Yazen Ghannam wrote:
> Also, move __mcheck_cpu_init_generic() after
> __mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
> MCA polling event.

The reason being?

Precaution?

It was this way since forever, why are you moving it now? Any particular
reason?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

