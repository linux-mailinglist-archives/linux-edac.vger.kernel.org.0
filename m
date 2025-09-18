Return-Path: <linux-edac+bounces-4829-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A9B83F7F
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 12:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7792D3B3C3F
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D722727EB;
	Thu, 18 Sep 2025 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JqBKrEmZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1116E863;
	Thu, 18 Sep 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190173; cv=none; b=uuiL4tMb29h1C1RFCCJDm3UPo9NEZ9Sa9E5YzWNrl/p3rZS57FIeJ562VCyKXcBovuJyWc0aj7KgUcaNAEFYVZmuOu1IwFGLHLQPKFcHmwrng2Ykr3k8tod6f4QHWADHg58U831t8Hh+rKVX48BUUdJFqAZTblT1mZaVN8RPDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190173; c=relaxed/simple;
	bh=hkbQSySAXFP2997FJQwvNSwyPQ29QZqlSQXVhENaPGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYi3i3YvNezF18hFVY3myS3Pm3YXvsgnNpJJdQtWg9LXicSu9LfNizFdTtSnIgc66o2YXuVIkwi8uchb5iufix3fnmakrYL4jv9gaJDZoL5VWMxzofYu9RbOf2Z275mK26XpZeN/Hpekx1+qm+NzcEuUD6ejuaTq3pSzGzPCAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JqBKrEmZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4365F40E01C9;
	Thu, 18 Sep 2025 10:09:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LxuQkn7pNEuR; Thu, 18 Sep 2025 10:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758190161; bh=0PONB7C6MWtb4ERdhUxXf/4yCGd/C0fliU4jgQN8y8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqBKrEmZJp7LHf3yjb2YABJBW+66fr3LEUX6vhu+9q/CK5lLBx5izuhN4mXWjr9+N
	 KCS5WUTc1k4TIZLy1w5MfhMziSNMrnPv3uUDHtiVJQpC76wYSdxWYlU78Ed5BvW+Ns
	 W6we/iOTTZb7jmVbHHEjV14JqHfMNAS4udwSYLLNHREleyr9LX7zVrhufZoktNmle5
	 xYi0o4oqT6b712kSxB5qsJWJcaj2hZrqc0I6KS2LsXOG30yRsObBQa/TaxgBrXYDEy
	 M/QFgQBJBYl0qai5iyPtJizWmMtwe7C7rmnLk1u8kwJwmUjY4t0MBq+Eb81rogYxmX
	 CG2UchmRHQWD/luPnVmQUPTLkA5r15ZnNxVXsQqiOH37JYBvrgzQfSH7OAXUDWADGr
	 srhXZPRvhOUEyXbX9qhXJxmdb31EGNT+Ac+u1qLbRuav3lCps27Inqa1PyMr74sti9
	 JsGbWgOo0GoskrVM1lSKUKDSYRyCzenDYarO8wNfFKuUFv5RTQ1A9WFiHsMBvqsUyR
	 QYD+wE6fPca3iq65EAf3I5eSz3kSkEaMweJRHd9ql4f8WeeTX+Eda2UyOm1HkoRCej
	 p/vuBGwAIFSoXG83fWXGhQuYFCKRjB8nca2bQgIXACvG6uvYBwuwp8+qHaKFUYCriB
	 pB7/+IpblJ1ktV4uN3lFOFko=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B2B2F40E01BB;
	Thu, 18 Sep 2025 10:09:17 +0000 (UTC)
Date: Thu, 18 Sep 2025 12:09:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	linux-edac@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] EDAC: Add a driver for the AMD Versal NET DDR
 controller
Message-ID: <20250918100855.GAaMvaN7wCauxpD9Uk@fat_crate.local>
References: <aMus-KpPMcCk2iJr@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMus-KpPMcCk2iJr@stanley.mountain>

On Thu, Sep 18, 2025 at 09:55:52AM +0300, Dan Carpenter wrote:
> Hello Shubhrajyoti Datta,
> 
> Commit d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR
> controller") from Sep 8, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	drivers/edac/versalnet_edac.c:849 init_versalnet()
> 	warn: '_res' from device_register() not released on lines: 849.

_res?

No _res there.

In any case, this mess is probably due to me trying to salvage a crap
situation already.

The proper fix is carving out the loop body into a __init_versalnet_mc() or so
function which does the allocation and everything along with goto labels for
error path for a *single* memory controller.

And then add another function which unwinds and frees everything, perhaps
__free_versalnet_mc().

Then this init_versalnet() function would only run the loop and call the
__init one. If the __init one returns an error, it would do the unwinding
using the __free one.

Sounds like a plan?

Would you like to give it a try and run your tool ontop to verify?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

