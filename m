Return-Path: <linux-edac+bounces-5363-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5931C3AB11
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 12:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3852B561928
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1743090CD;
	Thu,  6 Nov 2025 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kHdyJ48e"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752302F5330;
	Thu,  6 Nov 2025 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428901; cv=none; b=sBZ3umZ9BpWBmuybdzqqrCtH6MDbwLio7MHrBjuF+80lnclqJwP3TJhiksOdLJbeU5wIL4gZyhzAO+6eisLqWabaq0J0C7Kj+qZ22ZXKbwJ9B2WEjcRVuzmb6cnlbw8x0TsPTOtxP85IXRyEFzIKhrHYqZuDIYDSsj1m4r3jaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428901; c=relaxed/simple;
	bh=FZ+xQhevs4W6MojfQXMJAFD8Dy6zfGeKkSvuojK3q0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLalTA8TU6NfBVHB7VBTIjJh60sZ7oZcG0TtNI9PjEgH2KvGnMKHuEonOmtInqFA9DmRPDKFVzMwbGbGU6bEsBAN7LGy+S6iK4jcaDL/eGrYridvEyUT7Ogl9ZROA3SIkwQt5ku5VNwg7jC1p9jAO0Qnz90GiPdpDEKPPF7VTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kHdyJ48e; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9189940E0191;
	Thu,  6 Nov 2025 11:34:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZrgZyW1OZZM8; Thu,  6 Nov 2025 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762428890; bh=BMtzBSnJBOm8d3+HVK2n5RalBifjQWJOzmJjLIuA8n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHdyJ48euVXrbvL5GmyvXxjubv1k7H/0LpvojnfbQ6Zu762M5u2vQVXjbisW051xA
	 DtOld8kil5i5xRNaQmbX83yrhf8HRaMcVJHGjkvlOnuh5v172JhV80hOPjulkK7d+A
	 mxZXnSJOTl37mqCwo3DhxvVI+92vtmcOB+G0yx1j9e4cfasxoU7vxzVsUiU6vgWt7J
	 az/rg2AsCGInvwhT8BClqoaaqifIBICHbniRPeFXVGNdztqXjjJdG5dRAjghXA5izH
	 T7+0jfndFGsANY4+2sNOsICqvBcoZrytCOnYSaO12QlM2swz609HLskCUx8mDhElh4
	 aPXPM2O+1H37CtyKcBYOBhtEpvtZZFa4n9BeryrTzsSVJDICuBVL4kX6T3Usn4GcpW
	 sV2NxVUnHBs0CSAzFl9QajDp05E4JEwRUzkS151vNxtMv/0L00n2TYfvMCJJvV2PDR
	 0QTmAQeH1Kz+a7StJ63IcomnAFWzatr8isiTw/mzQu4sL3H1VmVpaiKgPQ/vwcuqCo
	 k0GTXpjePq2X/lo2KG9zog5itUfwFdcQ/r+8dGN0ZdyFuNZA9Zlob7tMoEXsLfuRuJ
	 S0RVhLNHZdnVtEW51YUjO9bGxRjzWEGnydzwOM4DFPZduE7QpMY5wOepeAhqRevAG9
	 SBUgBbp5TSml+t1DH7ENTPi8=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 197E440E00DE;
	Thu,  6 Nov 2025 11:34:43 +0000 (UTC)
Date: Thu, 6 Nov 2025 12:34:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: tony.luck@intel.com
Cc: Ma Ke <make24@iscas.ac.cn>, jbaron@akamai.com, qiuxu.zhuo@intel.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3] EDAC/ie31200: Fix error handling in
 ie31200_register_mci
Message-ID: <20251106113436.GAaQyHzGJfszVtHNU0@fat_crate.local>
References: <20251106084735.35017-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106084735.35017-1-make24@iscas.ac.cn>

On Thu, Nov 06, 2025 at 04:47:35PM +0800, Ma Ke wrote:
> ie31200_register_mci() calls device_initialize() for priv->dev
> unconditionally. However, in the error path, put_device() is not
> called, leading to an imbalance. Similarly, in the unload path,
> put_device() is missing.
> 
> Although edac_mc_free() eventually frees the memory, it does not
> release the device initialized by device_initialize(). For code
> readability and proper pairing of device_initialize()/put_device(),
> add put_device() calls in both error and unload paths.
> 
> Found by code review.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - moved put_device() from fail_free to fail_unmap to avoid using uninitialized priv variable when window allocation fails.

Zapped v2 from the tree for the time being.

> Changes in v2:
> - modified the patch, thanks for developer's suggestions;
> - removed Fixes line.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

