Return-Path: <linux-edac+bounces-1425-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64C91B69A
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 08:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D31C22B24
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 06:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF437143;
	Fri, 28 Jun 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GUiKgoqN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1917F7;
	Fri, 28 Jun 2024 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554500; cv=none; b=L1Gws654QEN82LoZUTldiXtAwQ2eYVwaL+YMU35xIPyoYTOA+HXK3PbDea/a77Fi39H5OpfVdjyieJGotsk4iePjTodqq8OQb6DuePFvqpRzQzNGK2dyPyIEVH2TAqFzDBWJ1T0MtcD7YMFpafz24YWux+2ghSel76hLRpGWTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554500; c=relaxed/simple;
	bh=P6y1P3/wGDrObrg47XiQpw9OHprDZ9SYzqDl+eYONgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0I5Shp3MjT6TvzkHQlcqTMApk+MVmLmp7OKGJBG+9qtoJmR99ifiPLCK9/Z98MpF3BRlzVxYhjhhaisDj4q1DaNFkBBNWBdoI2Y0UH+D22WAMfNBkPX0jfZ6rkbxQWwHuUL4NJ1m1l21R3UzUusbfQ5qEH4O32VgKLFzRLz0+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GUiKgoqN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4036B40E0194;
	Fri, 28 Jun 2024 06:01:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cNAKaoYubs04; Fri, 28 Jun 2024 06:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719554491; bh=Mf9vyWFcLEnZ2ff2oQQwYlpqrKcC87z/wHFeRfd/kt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUiKgoqND0rQYtu3a6wlVTolrNJE0mGRmNEcUEZ8Y1D2mWYGl521jK3wl040PRUvo
	 OSEs3Su8VEWDjgnEn1dBldHjsFBBupe+S7Zkbs+oz44MgPCuUBZPmFCTi0B3YeuNoj
	 hok76XF6d4Las8lxnk42KQgJapVtDVjuD5sG3jvepcZFXnRRmQhiStv7fJmdJq8C+C
	 pIFHQYv68aRPx4yrPo3LhhMWUs3SLtnnM6GoocgesjE9PvRRUjB+hC3AkUuMegXk8A
	 LyR+r9wbI1uN040u54hdgpSmkBD86VEp/RIJnRZ53DjeJWgsDq4JHWLvnTMdE2/0rd
	 8UbON54YEnRVNB5WHv1rfDLBqyTgHNxU9MIj26TvTu+NFAIFuWhRNU7jzmTMVCBibB
	 wKw41LrL92OOceRdRQTI8LZ24mTlnIV4Z4THCZ6/hhcN4v7OLl4aF3YKlqzBP+9CPg
	 vXTVUMSQW9KoApd30in+Nf7hZA/HJQseiJzx9kV6OdoMtDM/ID1sJGfgTSU7xvidkj
	 WgtasDbqX987SUf5qw+ZVkkvi8NA4YAIFz54a4/VOngcYEF2FIiZZe/9XPlyTK3TOv
	 tRBhVFYl2rT/hy8+cEIhGaLxxMkSc0mDLQWx9R+y1yMXhLn9AfubFyD4VI3uZmhzvA
	 2Ystz8652en+JagBwYdoREZo=
Received: from nazgul.tnic (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7298240E0027;
	Fri, 28 Jun 2024 06:01:13 +0000 (UTC)
Date: Fri, 28 Jun 2024 08:01:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Manish Narani <manish.narani@xilinx.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH RESEND v6 01/18] EDAC/synopsys: Fix generic device type
 detection procedure
Message-ID: <20240628060126.GBZn5Rto4AYYm_qeqB@fat_crate.local>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
 <20240627173251.25718-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627173251.25718-2-fancer.lancer@gmail.com>

On Thu, Jun 27, 2024 at 08:32:08PM +0300, Serge Semin wrote:
> First of all the enum dev_type constants describe the memory DRAM chips
> used at the stick, not the entire DQ-bus width (see the enumeration kdoc
> for details).

Last time I said:

"Which kdoc?

The kernel doc above enum dev_type in include/linux/edac.h?

In any case, you need to be precise pls."

https://lore.kernel.org/all/20240604183803.GJZl9fC9R5M2NSQ01O@fat_crate.local

Ignoring this patch for now until you've incorporated all review
feedback.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

