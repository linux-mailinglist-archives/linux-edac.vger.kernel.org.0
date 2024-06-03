Return-Path: <linux-edac+bounces-1169-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F228D85F8
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 17:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AE2283A07
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448FB12EBD3;
	Mon,  3 Jun 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XmDU5A6f"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681DC36127;
	Mon,  3 Jun 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428284; cv=none; b=AZZ9Qasy56Gha2P/EeDF299ORvXgrTrzW0+jSGNXIMi1/r1Dw6aP+Y7DSZac9x6AUGpqI7cpk0hCkyEQwSkgt8tMxst+aH82eVwm6ecbrJRuTszTTBrcmELOmyKDaJzmlVRkXcSM0Cz9JyS3P6p7a+j05VMnb3cJ4S1EOArlJx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428284; c=relaxed/simple;
	bh=pcUOL5LiR5J/CzdCNHXZbfLCkEHG/X+2CW9HB0Pml9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh0fTnwvxgee5EEMriRXF5mUdEAjxQKqZIVVntrimoZgRoH3GbG7qZayTZnxODBEozO6Xn7dRS4bNB3HXfiDcT053V0edfszsTaU6bZl5uhvwOkipfVro1sauSKVwPZG84fk2DbhtKUmSnPMGE5DGHK1n6qxzCwV1iVZzvQDdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XmDU5A6f; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2179340E00C9;
	Mon,  3 Jun 2024 15:24:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uXVwUpOPpISw; Mon,  3 Jun 2024 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717428275; bh=sxQevx+L0CskB61iTRhCSmaUNjmsrKe/AVv6Tub2IcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmDU5A6f8BqHwAmUT6bgJLLZr2vwOmpU1/ujS40Pr0Q5+GnBbPm4Htr2wxyz1SUe2
	 34RgyqdJSDtfFkxB+sjZn5xcPVfg3agebarXCi3ymUUBcHrPLY1GDZd9J5yjmMAWj3
	 jI4HaWAu66M7Ee5wSPbyq2YzkN8P5Qe64/zSQ/l/g+KRkYwB06vPqqeZfoOfdAZ0AJ
	 4hOUOgRZnRiByG4qBUjhpUHo2fJR1EwQGzkQ/gUgJQmjT+SHD5h+CRUgGVeZ2RaliF
	 F67NHM7RsxQf74m6YtzwbC5lo1sipBSVFJ6AQcUwL5KOlOXxgACcD1UXbsIQLZsEVf
	 JZ9AlJ/JNRol4hA+Jo1fZLEzvmkQcNSEsDntiDcsVXXoLTm3rJsbQHkA4E9vFf9kbQ
	 BfoYY8+iA/P9LzLsur0PEwPuzHAORPUUq8PWTNrZSkwfATfYHNMagxLUNTOC+aEoTb
	 71VRKvZ4NfPExHXMYWVHtUKnUsTxBrOyYjHwW0NZgiAg/0ZdskdVTCKRmexu6vEVx3
	 dVyx8kFb3Dp6YW9Sa/L3mnhx3K4PmLntUilS5AMF9gZi9JPENywVMWxaV9CFKr55a0
	 WHMvZZ2J1eR7tX1IizGhpx6uZ8NLFHWTbM+BbMraJjGfkVCTbyfk7gy03fhbL9jvMS
	 FJR2f5V9kJqdKkCSnuwkHVEs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C81240E0081;
	Mon,  3 Jun 2024 15:24:28 +0000 (UTC)
Date: Mon, 3 Jun 2024 17:24:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 3/9] x86/mce: Increment MCP count only for timer calls
Message-ID: <20240603152427.GEZl3gKy75YAwJaZZH@fat_crate.local>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-4-yazen.ghannam@amd.com>
 <20240524145335.GAZlCp7wAO22acrGyP@fat_crate.local>
 <3990ab6d-6217-4e10-bda9-6b5c7bd668c0@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3990ab6d-6217-4e10-bda9-6b5c7bd668c0@amd.com>

On Mon, Jun 03, 2024 at 10:22:22AM -0400, Yazen Ghannam wrote:
> In this case, should we also increment the count in __mc_scan_banks()?

Well, that's called only in do_machine_check() and latter's not polling
the banks but called as a result of a #MC exception raised.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

