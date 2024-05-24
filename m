Return-Path: <linux-edac+bounces-1123-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6358CE75A
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 16:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1324DB20521
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D8312C522;
	Fri, 24 May 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b4T3ldzd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C12BAF3;
	Fri, 24 May 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562444; cv=none; b=tUOmqFq+QPeCQB2N0suVziIef+CZ8qSuz5nbFejqNbJfetXO0n6PyvLPUVv4LjQba/tYUqefKnX68+QuAkQFeslqXdZGZft/d5Srdfu8xDnMddQzZVYa0j0GduNWf9ETZv8nqpFyo74kBuzbcvfr5RyyFcOrma84XE5FQNaqhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562444; c=relaxed/simple;
	bh=6b5WaG8RwTRaSu4VPX/gk6NuU3QaXHGREcosZB+kWIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8FS9vzLw9WQWLSPr7obczPAg+TNfrcCfiw+zXiRNtrW98kHtv1GHBdYXVtZAVcV/gruQX/5JQIdhWAlIpV/iL98YrZeuVzxn7xAiSnvVNuWdBpiP7IDCKZaPyN+TWxGty9tFCnB7Yw+kFquC28NYffJzvRdLNKbuT7nr13cKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b4T3ldzd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 016CE40E02A8;
	Fri, 24 May 2024 14:53:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 66pLATH8wysw; Fri, 24 May 2024 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716562428; bh=6/WyMpeLD7PW3IYfJwxTvSgcRfBMp0+ADWk+WOzwZAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4T3ldzdx0/7BTYg2WMGtiO56rn3h/2g/5UaXTovqRMFl4RBK1+nKh4Y97djbSu8b
	 Vyi+g7ERRf+ftImqLW3b975Sq4RIax29yhp4I+UHvrK0mXXzD+9VE9KVU+wRlxje76
	 VxXWmkuipruLm0hmPcMaImddyDwMsTy9KdPPZyBv/e9mTqeUcJghrjiZAl0a35K7/E
	 yl80JUVVz3TdsgAk08XsZXBrf4T9z8hqsuW7Z/jC0dXZtCWiBUZiLbGDNhC5CZxfaN
	 vP6qDazPBemIABb607Zx+WqTigwsbxdO/B/paTuThtRfcE3U7krWR2ihNSBCp4hz1c
	 BAbua3KeVwysicYp8pcVMWVU/HvlHQmwH5tEcfzzXw7KOXZMIiTZwX2pT1wWo5TvDL
	 LnjqxcDWtNlsqykoUOqaO5dASoh0TuNAPcgVm2EbGCKmjmFL1qr9GoqZRayPAVJR8J
	 Kd8ZKXGtKjJoe4UxD36ioSAg0RzS6NvIbr7E1CQVzWXMLomVdxTp/Dz1/6P103VMW8
	 ncokZo7y3+fwhWDRy+sWqRmOSq6RnusrG6lQu3Z/850FgzHKWNjqZZjMr0Pzph+aMT
	 CX+r65EgjzlrBLU2HoMS6j2hl7MwYoBjlpw0eu1dFkvM6N1nl6IDbyRIkpXkMr+vBB
	 46GNV6Bxb9Qz4urWohzj9ZW8=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9920740E01F6;
	Fri, 24 May 2024 14:53:41 +0000 (UTC)
Date: Fri, 24 May 2024 16:53:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 3/9] x86/mce: Increment MCP count only for timer calls
Message-ID: <20240524145335.GAZlCp7wAO22acrGyP@fat_crate.local>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-4-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523155641.2805411-4-yazen.ghannam@amd.com>

On Thu, May 23, 2024 at 10:56:35AM -0500, Yazen Ghannam wrote:
> MCP count is currently incremented for any call to machine_check_poll().
> Therefore, the count includes calls from the timer, boot-time polling,
> and interrupt handlers.
> 
> Only increment the MCP count when called from the timer so as to avoid
> double counting the interrupt handlers.

Well, but, every time the function is called, we did poll the banks.
Sure, the count is part of /proc/interrupts but we did poll the banks in
those other cases too. So I think showing an accurate poll number is
actually representing the truth, no matter where it is shown...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

