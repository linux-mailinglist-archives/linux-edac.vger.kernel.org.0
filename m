Return-Path: <linux-edac+bounces-3253-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B581CA4BC83
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 11:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEDD3ACE0C
	for <lists+linux-edac@lfdr.de>; Mon,  3 Mar 2025 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1871F1513;
	Mon,  3 Mar 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CIeizD2K"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547DA23F383;
	Mon,  3 Mar 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998189; cv=none; b=IhiOdTUStJHhVOW9/yf8BjdUXxKVgZpJYQoG17cY/JV5Myo6AjmmaGSuNIie94s23ld4KYAd0BcDuChqz7hO8xk4Sa+5otou2d57Vy8nPpA937TQZgyPx8R0EsVL2UlqHIEoVowDbPkpElqTmTt8jLVbP0VWcdmrREkq9cP60lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998189; c=relaxed/simple;
	bh=N3sPKcpbk+N345Z6QfXw1a68D9uC0IXP2GiFiY2vjV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8B+cx1QCludubWhoJ5eKe+mVfzOY6WGyR1tzRy3RFULimmx48v2WXc+3C9BY/fTpirJkv1SyAcDF0vng0CwoH5IOQcRFxYulqv0HMh80JkHjBEf5OlayxftQ8FKMIWarvFCdBMXPBlo+eGoO1ioARRdP7Mly4u5oFd7V9LcVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CIeizD2K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AE1BE40E0202;
	Mon,  3 Mar 2025 10:36:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bd2HeietVv99; Mon,  3 Mar 2025 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740998178; bh=XNI3SnVJolAxVhmPjt2JrEwot6jN/8zHjxYEktMG+4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIeizD2KFeTbtYEKdnNDnpUDBbCjZpqwAkO17eGwBzpecuIzivjikXY8+BLNqxtL2
	 TfnD+4lmhvBtg1RPiedflnah3OqDiwlBEBTHScYraeZze7/vUBJVWbqOtLh/XIEfjf
	 vn/H+X1OHwlS2JlD8EBWQMFyYz/AgvkAOLcqLSgOtfU4Szlas4X45SSXuDPsVsV4Do
	 Q7ZFUIHAXlbqcNetihj/DrGOUoaMkmc9qwyrh5qv72T88BBIbMpkWzY1kvcEiCVVWH
	 F+vMqJ1sz3KLAeG2gLiG+Q+iwVsztkq8WEwP8NTNzwMyDJSXxV3GowCo7DzwWVSuyS
	 rTwrDZtqJWLGIi3sq8VTlwCqmYP1JEhwzQMkNt+zboA+0kjJp/ufc0cVIsN9uWI5rT
	 KADNathwh6qa4OElEeBSQ+KHdgd5GosTf/1l4FXVgdfjUUW0j2W5RIklyg3XpjXNn9
	 8UoqEkzjBKx7RzqCx7/fG+/iIAANKeTrCYJv5O0dqlv8dcqZXFbR/QHjgYSuPpvGTV
	 zqweiOFcXs/A/sbIvjqzKFK/yw9U/5dTi1XPNk4jyk8uMBmgV8ICdpd0kzMELYqAmK
	 JdJnxk878YZy4HeTp+fgj+qZ/OFOXuPRXHUaXQS3+x4U6yPqmh0o+MOSmbIAM1magZ
	 KbUuiDvnDuZkQIiP7vXiu4eo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAC8940E01D1;
	Mon,  3 Mar 2025 10:35:34 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:35:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, rafael@kernel.org, tony.luck@intel.com,
	lenb@kernel.org, mchehab@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH linux-next 0/2] ACPI: Add support for ACPI RAS2 feature
 table
Message-ID: <20250303103529.GBZ8WF8flezRahE-1h@fat_crate.local>
References: <20250228122752.2062-1-shiju.jose@huawei.com>
 <20250303173538.000007cd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303173538.000007cd@huawei.com>

On Mon, Mar 03, 2025 at 05:35:38PM +0800, Jonathan Cameron wrote:
> Borislav via ras.git, or Rafael via acpi.git?  I don't really
> have any preference other than making sure it doesn't fall down
> the cracks!

It's probably easier if I take it.

However, just from a cursory look, it would need some scrubbing. There's stuff
like:

+               ps_sm->params.requested_address_range[0] = 0;
+               ps_sm->params.requested_address_range[1] = 0;
+               ps_sm->params.scrub_params_in &= ~RAS2_PATROL_SCRUB_SCHRS_IN_MASK;
+               ps_sm->params.scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_SCHRS_IN_MASK,
+                                                           ras2_ctx->scrub_cycle_hrs);
+               ps_sm->params.patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;


which definitely needs shortening. There's no need for a wholly written out
"requested_address_range". I know variables should have meaningfull names but
writing fiction shouldn't be either.

+static int ras2_acpi_parse_table(struct acpi_table_header *pAcpiTable)

Yuck, CamelCase?!

And I'm pretty sure if I start looking more, I'll find more funky stuff.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

