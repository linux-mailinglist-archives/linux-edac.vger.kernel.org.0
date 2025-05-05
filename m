Return-Path: <linux-edac+bounces-3827-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072ADAA8F05
	for <lists+linux-edac@lfdr.de>; Mon,  5 May 2025 11:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D68173735
	for <lists+linux-edac@lfdr.de>; Mon,  5 May 2025 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781041F463E;
	Mon,  5 May 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HiLtfZpO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5401EDA33;
	Mon,  5 May 2025 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436275; cv=none; b=cSrgKizDeGolGQ3GzFvc52dejXwX8iXAjBGjNSbj4wMR0fsOGZ9llAeanbO6KCHv4JBw1MIHxSQ9MJmJ6vZ5YbFLUiTyLS2iZsjDEBw7NCTyftV/IOs9QH9hGKW1399AjY5PQPAl9smXUeuJhvoa7SQH7DLm8wZsC5P3VnZZbG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436275; c=relaxed/simple;
	bh=Xo8XUrMn6xj4TqfQ3LqdOlexbgmagSfWnmLtxS//AnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFtpVYR3iYugPutbNommLP42kyGEl2BPDSkeSRd40Kaij3zC7JIU6QeXXAX8mUf9jw78sFM1wAMCKa6oFlFkHsxO926XHmnKswulQ+RR319ULDnpXo3OKn5fCeuPTJ55iD6zo9CGMlp3J5EtRyxsYmNMtBnTUc8LNxHKY7OOEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HiLtfZpO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5DE4940E0173;
	Mon,  5 May 2025 09:11:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n9tiTQf8rjA8; Mon,  5 May 2025 09:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1746436265; bh=01O7tqAno4eu+silbNQlnIVAZ0Q0+jh1x3ytSuxjZN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiLtfZpOdmjGqBsoYvwtK8QdYrhqZ/93rWN90SaS4C9YiyVRmH24RpiE07fWLKJDn
	 9gUfJtr4Z3Jn45HZd/tzqtCRalNMh4JmQavNEsBaL35JlHeiyvO+O9xUTNwUbWhlbf
	 UCcoz93TMl9DHH2IbGWWhWBOgfY2+mqQVQxTqBKjqfdLH7/kQj6RH//bAiYRN7Vbin
	 qvNTKbtOTrwc89emZwS7+UcCQV5+RiuXeA/+8g6JGM14ksohSj8AsWOoogQ3EgJwQf
	 dgUT3dX6RDNO21AvbCjb3+JSAd0Mf6SxFoi1hl4ETI4blOMI8EvfgYGIK8jHQlczKK
	 ySJKKzbhcGLZufRXug6/lhzW2gfiO1XyvTU/isQET5MsWac4MuPz2If8NEBQgPbPDD
	 qo72SpmSW3OALcKLL2bZ0U8wQfUZRypPnk3A9ugHj/Bha2gOzbnEbkMZNYuv+8t8QQ
	 PIW7zO7Ul1Jp6atS6yG0X/vWwd5gkXXWR3O1fOHpW/6VUpBLsL11BWNPDd049emPVz
	 hVXnUwQnBn/1OllDXj10875hQV1KIna3pYpAk+HXAM0aSnYQ15VuzVlstc6S+RbGIT
	 0Z8LQIrU3iM9HxF02dnXNjK4JsA8qz8t8cRcm9JD0T5JzTgGzbdLTDaxRAp0EegrWf
	 oQS/+dPvrWbr4dgMBn+rZ6M8=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E11E40E0222;
	Mon,  5 May 2025 09:10:50 +0000 (UTC)
Date: Mon, 5 May 2025 11:10:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [v8 PATCH 0/2] Add L1 and L2 error detection for A53, A57 and A72
Message-ID: <20250505091044.GCaBiAlCFqVgV7-3TJ@fat_crate.local>
References: <1746404860-27069-1-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1746404860-27069-1-git-send-email-vijayb@linux.microsoft.com>

On Sun, May 04, 2025 at 05:27:38PM -0700, Vijay Balakrishna wrote:
> Hello,
> 
> This is an attempt to revive [v5] series. I have attempted to address comments
> and suggestions from Marc Zyngier since [v5]. Additionally, I have extended

I'd like to hear from ARM folks here, whether this makes sense to have still.

> support for A72 processors. Testing the driver on a problematic A72 SoC
> has led to the detection of Correctable Errors (CEs). Below are logs captured
> from the problematic SoC during various boot instances.
> 
> [  876.896022] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
> 
> [ 3700.978086] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
> 
> [  976.956158] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
> 
> [ 1427.933606] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
> 
> [  192.959911] EDAC DEVICE0: CE: cortex-arm64-edac instance: cpu2 block: L1 count: 1 'L1-D Data RAM correctable error(s) on CPU 2'
> 
> Our primary focus is on A72. We have a significant number of A72-based systems

Then zap the support for the other CPUs as supporting those is futile.

cortex_arm64_l1_l2.c - I don't want an EDAC driver per RAS functional unit.
Call this edac_a72 or whatever, which will contain all A72 RAS functionality
support. ARM folks will give you a good idea here if you don't have.

Also, I'd need at least a reviewer entry to MAINTAINERS for patches to this
driver because you'll be the only ones testing this as you have vested
interest in this working.

The dt patch needs a reviewed-by too.

Once that is addressed, I'll take a look.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

