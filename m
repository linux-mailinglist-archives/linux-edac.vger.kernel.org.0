Return-Path: <linux-edac+bounces-1469-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18792B864
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 13:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE3D281B48
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0F154C07;
	Tue,  9 Jul 2024 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b1mg5cSm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D055E4C;
	Tue,  9 Jul 2024 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524953; cv=none; b=vCvz1rpSr3CBVFxnYmP/ups0fFDPJPC3BSCK+IfR1XI5zgx9opiQ5XFTFFflQ1soZqGi7iV0jzPNU1yttRJPG+OHkR1XcAU2o59XSlLu3uqJKsohUtBouJ7ywv+g5m7Uz59PLpeTh1h5m/EwtsJVvcWqLMxbwF+dSMCDuZ8zM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524953; c=relaxed/simple;
	bh=ChnJFEMjclci+NOxf8NZiKN7AY7P4+7hFR/22Rs3Mh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hncaAJ0b8AgKOGZZlyzgjrwvVnyCCwU2MiU4l+lqEkWbt8A12YZQStEXSuwVGg8U8cjcZPoZvnWSiHVUsU/2O1K5QVQH0bqxjLdKpNoiV6PrVvNkdru1rR+1nSXHB8uXFRLIyw9Gbv4BPqzVF9UPe0zhDbiyL3IoQYLLCWuhJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b1mg5cSm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4028240E0192;
	Tue,  9 Jul 2024 11:35:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VQrDMEj5bBPf; Tue,  9 Jul 2024 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720524944; bh=jjf50ESvHnEK2z9lV8EITYgyBThg/spTlXOdeWwsvgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1mg5cSmDHgOzafwvedRIl52gqf+ZMalALTTzwCALau9QDX1Mzla6UQiLoM//w9b+
	 Dg0Y2Es1cko0pUOUoTV+GJUxYwjVjv/JVm83w6f1byyDUkJxFofiNbKxUH2nwrI4sR
	 ka5UANapE8wdXMb3wyHRLNHMd3TCOc0V4rroVcbWJvAj+C4L5KCO2H5iMFrFdFU6PG
	 xGcvhB5LIYzJ9s29oQneU3d1RQbRZKInL+xq0xj9AGrdMaZNwDeX57c+8vq4owiN2+
	 tSo+lUU2r3IysPvihkuQv0JFTskKoWvwkWIm8OVjmeFzmByKIeDAk35xAKQ8konMM6
	 ocmWELzzHI2ndIwftSI0+L1f61hHnAqCnsPSvMIGzqg6sWpV10wFSX+QQEOQxC1P77
	 b9xHoxeHnV7UcRXI4Rgj2b08yYtl7PMOImvzjHlqRW7SR22WVwGnhCxRuMOK6JOwBa
	 b3YaSenmHxdfWRyM4ImahrWDfNhxahVKHKNr0Ic6Bq6Ghjy40EV64bOGgY5SqXeI5+
	 vaHhxSpTka4fa+bzRZVsngXe8mObIX3PVQH/su/oxie4KmNBd4LMHbn4+5RGvxvbQL
	 1p1+j2/pXl50xhbYTdZvk4wvrVej3qRvZ4Ot5/lf7eL7idCbzxX5Ld4dZt+Sdr4sDk
	 ZDaEUmEKdb3IyAhOBWpWkOEM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7477440E0185;
	Tue,  9 Jul 2024 11:35:28 +0000 (UTC)
Date: Tue, 9 Jul 2024 13:35:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH RESEND v6 02/18] EDAC/synopsys: Fix mci->scrub_cap field
 setting
Message-ID: <20240709113522.GEZo0getHKGPD588S1@fat_crate.local>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
 <20240627173251.25718-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627173251.25718-3-fancer.lancer@gmail.com>

On Thu, Jun 27, 2024 at 08:32:09PM +0300, Serge Semin wrote:
> The mem_ctl_info.scrub_cap field is supposed to be set with the ECC
> scrub-related flags. Instead the driver erroneously initializes it with
> the SCRUB_HW_SRC flag ID. It's definitely wrong, but it hasn't caused any
> problem so far since the structure field isn't used by the EDAC core. Fix
> it anyway by using the SCRUB_FLAG_HW_SRC macro to initialize the field.

This hasn't been used at least since it got added by

commit da9bb1d27b21cb24cbb6a2efb5d3c464d357a01e
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Wed Jan 18 17:44:13 2006 -0800

    [PATCH] EDAC: core EDAC support code

AFAICT.

Please remove ->scrub_cap along with enum scrub_type instead.

We can always resurrect it if needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

