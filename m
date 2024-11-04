Return-Path: <linux-edac+bounces-2428-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4929BBA91
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 17:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E453128232F
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8501C232B;
	Mon,  4 Nov 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VFCeAjLs"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380F1C07F1;
	Mon,  4 Nov 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738949; cv=none; b=Z2Au8ClgzSDYkdUYVOkvlFHR235/bUe0BbAVttjKVu0roPrX1a6K5ZPUd8wbgnwzLrEaBqG2vp7PfitXhSC8BeDtJONUTwQYGOXhWhy4mzi2EIOj9sW34zaxmsOG6YGuj3GOjjdGpg/E0StetffGQnWPFo1QhjozTUPTc58f+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738949; c=relaxed/simple;
	bh=7Pn8Oi0n7WRC7x0SqsrwXg9RE680+0oqFcWaW1t/kC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou8NDMuFG0+u8KdbMNXC2+Grz0yTQLODjh0C1xvlqw8RSLEW/a5rWJ7QJYHMQxLQVTiBp1ClmRn1CWZ/AHLYXF63GoUAAFYRYCtxPdf8UVEkTf+Qk5jhnW0ZAeXJfMWD8x8y9HN3THoOAaly0ymMrwK8JA5NtK2Zn0Hh9UXHDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VFCeAjLs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BDCEA40E0220;
	Mon,  4 Nov 2024 16:49:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zKoHjBiZQc7Y; Mon,  4 Nov 2024 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730738938; bh=BCYoC9IrOjIFECP/0oh9vzrE4nH5oG2SejugrTWJKKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFCeAjLsOo6yNluwXI8/C9pyCQMKfBCJaAZrq4SFcA5X1Lgz17htG3v5GHOFeYcI7
	 p+vGHW9ueYucylAOtRCnxMokHjGGfhAxwM9JS30ubh9h/tejJp8YLA+aX2evngNRJu
	 /WUTcIjYH0X+GgldsDTHA7aWmcNqitw312OZ1CwY+Btq3DFDFLI4uvif4492VT2Tsl
	 s9ez03OlYTjt5H3m/9yU35G5zhNsHfGt4dgaTEJSUifYxC7nx/CZWdtUBquCh4mWqP
	 KTt1XQjIRRnbmJnY6+4rdtbhAfD4cfc6cYGZ/Ru4RYsRFXbjRFiY1cdHBmiVmVyFuB
	 O+3BIkEcU6Jq9QteCquogOOQ0v0PQyamiS5VpRSNk/k3Vjr10WT8mjXCBFNgtp/Oh+
	 sUSOI6zJBGgBGvFpBuwqUBkmnWFbvPL4AzlRPqmtrWtXZQ1BLlO1cfCmF2E0XQxulQ
	 0vvOgMYoHiKDuHcMtSnQorCEBzIpQZmzQcnW6L9yuXahfS9TBJbeLAZ6TzYh8ug3Dg
	 6R16xuE632Zk1cC/pSEjEEiwdZ4nXXw0ODoxRjalESMJVPDQpjn2FtOsL3+TaLBco8
	 +/6Dq42DKeklm9wRhCTSNPo66SyFhwV8x1mk8CEdlhaLZ0nO7ZLNTRS8z6pt7Pw6ML
	 6BAn+pSPx1CCm7hcqmoRp2uw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41D2540E0263;
	Mon,  4 Nov 2024 16:48:54 +0000 (UTC)
Date: Mon, 4 Nov 2024 17:48:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jason Baron <jbaron@akamai.com>
Cc: James Ye <jye836@gmail.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/ie31200: Add Kaby Lake-S dual-core host bridge ID
Message-ID: <20241104164847.GFZyj670ngFSLWm6u9@fat_crate.local>
References: <20240824120622.46226-1-jye836@gmail.com>
 <20241104160425.GEZyjwiRx74PEqiZRl@fat_crate.local>
 <b990a1a9-97e5-469a-8469-0ea5bdc0fc03@akamai.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b990a1a9-97e5-469a-8469-0ea5bdc0fc03@akamai.com>

On Mon, Nov 04, 2024 at 11:15:49AM -0500, Jason Baron wrote:
> Sorry, seems fine...
> 
> Acked-by: Jason Baron <jbaron@akamai.com>

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

