Return-Path: <linux-edac+bounces-418-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C942384477B
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 19:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BBB283C98
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7331EB37;
	Wed, 31 Jan 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fzxUv5s4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CAC21350
	for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727067; cv=none; b=qpFHzXSBjJvhhJz5lkcthfQQsRBuzdyeanI7d/YOlymMYo4eds6eDUK68kKn7vJYcWmKa9Mce3kjQ4BmIbdsYyi9A4suzrzWupKWjQ68mi0uI1xJuQzhsQTahgVfAfbs0nZPjyfdyVBcBr7d49Tzw453pP/xbl6z47gKDDUGGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727067; c=relaxed/simple;
	bh=KVhXoIS/ScsxmbKl2b/1j4x4nt3EN7JqWJCSRWqQTGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLYkrHbqgtQ1OLphFtT5Fj7ugwTm7Yp2qZVMoIEnOF614J/ebiCWZZDcpMu0RkDS+3chdjsJMwYBY7/kCElFn22895YYMNMy0I5K5yivb7M4PUNMv7bPdohylkvbH3XyWLO+wkj1gsNq9oPs6791VWy3wJ7gvzMuawKe6cSqE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fzxUv5s4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9C38440E01A2;
	Wed, 31 Jan 2024 18:51:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XBeKvo3ypU6o; Wed, 31 Jan 2024 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706727058; bh=x6KDBQggV2RQLvggsaGWPCZMZbOdaRtqMEySZWJgW1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzxUv5s4KMOxkQNQN1w6JymFy5DcgUUVgI2s1hQgB3CXning9EqT68QfAcEDwVH8w
	 qjEykmaRcMkxnvGfNSzoL/PmjBkJr1mZ8SWnB3eI2/Vt4QfRoIeCLZmsy+ra2wEdwq
	 8RiIiKfLKsUajDfWGRO82WVS88gysWoiPPakzlrugF05giFfzBs/tosDkVwvGr74V3
	 5Jg/aytDgaVPyTka9uSRp5bmPAtVurvJnkUrxK7qjwav389s/3x0jH5HJJPgjbosKc
	 09Xx1GPXt/ouTfSgFvt4O2KA7L7i3bTmWSaLHm7Kg+NXgE+dGpxEmgGSNoD2f5iK9K
	 OHUoQ/EPDkv5SzXcp0mTtdeXlo2Nszr05Usq9WNOWZaMVIXta2firiGUXF2ToS8RGY
	 N7NIhCJafF53FSKfwR24b4r0uT+mZUKKdZqkOK0vfBuLWHttmmRMUSZUx+J//lUUVb
	 XN6e+q1a0Iq2pK5etnYf1moN/SOw63gepNY7/Nl82tUcOAm1yynZpnRtPBaGiWfmiW
	 7RjFH87wh+9aJ45kIRiBaGNk6evXV9YcJNT3x4ze06dXqBq5e+GcDUbt+xQLmTjeeY
	 BJcfgZpS9X3/aQxhvl8CLAl9Qt9dU0A51bdpZjzIr1twfE/efB1gsSu5tn88uqsMGW
	 1yt7OfhlgsANwxUo/UDtH8J8=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3EAE340E016C;
	Wed, 31 Jan 2024 18:50:54 +0000 (UTC)
Date: Wed, 31 Jan 2024 19:50:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, muralidhara.mk@amd.com,
	linux-edac@vger.kernel.org
Subject: Re: [bug report] RAS/AMD/ATL: Add MI300 support
Message-ID: <20240131185049.GKZbqWiUVLWXI7-TQY@fat_crate.local>
References: <18bb00a0-5742-47a5-9dd6-c35c164114e2@moroto.mountain>
 <20240131085638.GBZboLRr6jsZhqwjfP@fat_crate.local>
 <1b3a758c-7928-4486-b63a-bee977d99913@amd.com>
 <3d20cb1e-e116-416a-ac1b-3e4226c85e74@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d20cb1e-e116-416a-ac1b-3e4226c85e74@moroto.mountain>

On Wed, Jan 31, 2024 at 09:33:13PM +0300, Dan Carpenter wrote:
> Oh, sorry, I hadn't seen that test_bit was also declared as bool.
> This is a bug in Smatch.  I will fix it.

We're glad that we were able to contribute to improving Smatch! :-)

> No, only bool can only be true/false (BIT(0)).

That is not specified by the standard. If a bool is true, it doesn't
necessarily mean that bit 0 of that bool storage area is 1b. I.e.,

0b0000_0001.

BUT, when it takes part in integer expressions, it will be
type-converted to 1 and thus work as expected.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

