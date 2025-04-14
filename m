Return-Path: <linux-edac+bounces-3535-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45651A888A7
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044C83A7798
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9E827F736;
	Mon, 14 Apr 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hmd5x8yT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505A2DFA3D;
	Mon, 14 Apr 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648451; cv=none; b=T5OaUricdilW/Kyp9pxYBvXLs4go6GzdlibjizUQenBDcFK6WMuDi6+SJaA+uhcElnsrpo6kuVFFaTmrRTe+5l3eI6buaDcqC3JbqdD5chc4yVQcLVHXUCs+SBEMp2APYi4RiCDKMiyq6oCrTh4NHQ5PLnr9CzPfloPK4ze4Zjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648451; c=relaxed/simple;
	bh=H+8phVsMA2KFyA2CGK5w8E388kBsb7QiPb0AVzFAAuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQTvgw6iGsTiScjkGZsK1t2cZtMQ7Xim9mjPnzkHd7hNbHsjMkdrXY71Z3+K4ECpzjCLeJ0bd/w91sOA9SmVBqelpJl/zBzoxAyre7v6hX61xTzk5WT43UzJj2baPaya20i9aZuvwJnUxPYpK3kb9GheLSWLj4lW1Zjtrwotgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hmd5x8yT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F054040E0200;
	Mon, 14 Apr 2025 16:34:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2pPM1EfRjSs0; Mon, 14 Apr 2025 16:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744648441; bh=eVmLsIL8+zgjxJTn+4v2oA1H5L153iVSC3rDdOhs6yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hmd5x8yTSZY9As20dcJPFIn+aRWYOB+B7ukdwD++Fuc9cyjJbwtQF3wzf0KjZk51S
	 2ybIPQLH4dVeMR+BnQDnycnQUTxXGvl30WkgsF88ry0/griLK5mRMqqzJeEHAoPJdo
	 W9G0FsVRgfMdB3Rx9jySFaXr2umYtGBNP4f4FMlxPZXptNVw8pj04uUdxjBkU9x2JO
	 SxBUsqSdDwOLzE2+s2c43yOQR8oGRYwRUa+uzSRwAcESr7FL+bqj5CV8qBAM/DqJVL
	 TmU80kfnfDOftABaRZ74yzQFH2IjoA1FmahB8R5phREbUmrCxNSFeAKdGRqjuAnEZU
	 kCijf0QV8Kt80wFvsIwpuXHXUJX5kC/syxBR4rHIzzeQ+O5Yivx6wUQbPUKmTKKsfE
	 i/AoCPORFb5wd9o66XvrgrXkLfjKSzzmjDXqj+XuiVeSBto8NRH8bHcbx6RnGCB9Pn
	 baVUuGsTS4GwaV4xJVCnOuJni2zDoYXVCdC70zF9D6uGMy50hYaKuNPYimTH7hhgw8
	 ArHv5wxVvKQjxJtOAbGoc9Pjzn6t/2wx1Xvuw3Iw55kJ/ZzEJ7SPAxHgV6xNFP3MxP
	 HrTj3yIBo+p5e8NDZD0UZ4KIGF0c7k91AMZyg2MQ4ZXObcZzGUGpLat4HLYhKDgOd7
	 ypHXlwIIXwbvL0aP5CDjN+fw=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB03440E023A;
	Mon, 14 Apr 2025 16:33:54 +0000 (UTC)
Date: Mon, 14 Apr 2025 18:33:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sargun Dhillon <sargun@sargun.me>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2] trace, RAS: Use __print_symbolic helper for entry
 severity for aer_events
Message-ID: <20250414163347.GEZ_0461mT0OZGpOjl@fat_crate.local>
References: <20250414153835.947207-1-sargun@sargun.me>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414153835.947207-1-sargun@sargun.me>

+ Rostedt.

On Mon, Apr 14, 2025 at 08:38:34AM -0700, Sargun Dhillon wrote:
> The chained ternary conditional operator in the perf event format for
> ras:aer_event was causing a misrepresentation of the severity of the event
> when used with "perf script". Rather than building our own hand-rolled
> formatting, just use the __print_symbolic helper to format it.
> 
> Specifically, all corrected errors were being formatted as non-fatal,
> uncorrected errors, as shown below with the BAD_TLP errors, which is
> correctable. This is due to a bug in libtraceevent, where chained
> ternary conditions are not parsed correctly.

So because *some* libtraceevent has a bug, we're wagging the dog, not the
tail?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

