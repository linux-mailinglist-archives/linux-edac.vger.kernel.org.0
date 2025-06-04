Return-Path: <linux-edac+bounces-4097-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C2ACDB20
	for <lists+linux-edac@lfdr.de>; Wed,  4 Jun 2025 11:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04614177BD3
	for <lists+linux-edac@lfdr.de>; Wed,  4 Jun 2025 09:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41928D824;
	Wed,  4 Jun 2025 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UuPSaV13"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205C79F2;
	Wed,  4 Jun 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029891; cv=none; b=oYsEHhlS2wFUrJJXGtqkE3m+ebZe0AitxHcyQ7a3NUCUSs6ut/oR7oygYy8LlYpTQ6YBS1Z1yedDEvPU8mw51BhIPQSbFi2z7cO3LFmbdiWOZOao4vdfZYYoOESB6iG+3zZaZCXAygQ3VtyxCZeeMwi6YDT9ZEkYfXRfqKmlAz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029891; c=relaxed/simple;
	bh=94Ilj/KFzd5MdpkV/wY6nIqoNkGvZ1JWEOv+FrlbeOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJYE+V2ZpW66hQjwSeEo3E9hwjJs2RoiDwrionZAnEYPkC+ZLo8qZL97Kzhwf2uVp2cP4+PFtfJPKRt/hyjxo4qPLM3asb72TUKnwHgR5+EMPWkv6KzQUMTCCSxF8dhoFnBoTw7CaVnqfNiIBa9diOoaWL417sPhqTetbe1XzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UuPSaV13; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 551AB40E01B3;
	Wed,  4 Jun 2025 09:37:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1yGCJ7GcToE7; Wed,  4 Jun 2025 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1749029875; bh=6RjTJtVSzdWyzX7GyVuRGykl9/8zi8wuYS32cfMkJ60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuPSaV1330sC1HJkUzvB9+cYppDXRCAUCRvqQxeTFFcXc9dImU9MVI9tg/IXY05FO
	 ddDQOd+jzpg/sTEC+bRLuGrIeCOxa5jeL7mSU0qjr+O75qUXvCQgn3INVXED7PCjIh
	 KRIwrG53V5ZKig4WGXm4iyJkIQG7r64wq4p1rmxHl2sQVFJaZU/4DzUsHJRBhQCy42
	 WHERx0Sk2Erf7Xwm88Mxu9KSZJHaRMxbvS2ItVcFkM2sk3xmDmUHHwg8cWGQwjsQGr
	 YLsTVMqmLcXy3qjiUlOMCpsVALtvzeFdZyMGgM0MvhAySmsOaIlZ2B/gvbUDzDd1go
	 BQTlVBuSEZtLkuDbyUA4PFayk3JdV0AX6j45DHyO3K4930XZscx9wN6KoX11N5DBQC
	 oWlMXa1xdTJre76+PMrBzhaFu8ytNvLujqzC0H6EQ/pGhIGX/7GM1kYRBamB4TDndo
	 pgHdfokA/UgLEoDTL/g7Ti29zif43u+StFKFD030/ZyAc8VzcyMJCdIk6n4Zixc+01
	 FYbjdMDNjsQ1+7mzg/KPDCWFpWdyGW5r9VMD485WAiUr5c+LiH5chW0L/G2DdnhC1D
	 K7wai02uO35HS+W6OTMxODnDIxjnW7VOM+MQNSBvFdysZFdMw6pJEJnAMymWNnAggg
	 OkZHsfKcMTizLxyDJNcI8B/o=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD96B40E0163;
	Wed,  4 Jun 2025 09:37:45 +0000 (UTC)
Date: Wed, 4 Jun 2025 11:37:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Message-ID: <20250604093735.GAaEAT39KGW1KJDrjD@fat_crate.local>
References: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>
 <20250603090536.GCaD664IbJB5IoR06g@fat_crate.local>
 <SA1PR12MB894764756C6538EE985BDE24816CA@SA1PR12MB8947.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR12MB894764756C6538EE985BDE24816CA@SA1PR12MB8947.namprd12.prod.outlook.com>

On Wed, Jun 04, 2025 at 05:58:22AM +0000, Datta, Shubhrajyoti wrote:
> zynqmp_get_ecc_state is getting called from probe/init.
> I will update the commit message to reflect the same.

No need.

Next question: There's zynq_get_ecc_state() which is almost the same. Does
that need clearing too?

If so, the right thing to do is to unify both functions and get rid of the
silly function pointers calling them but simply do ECC state reading once in
mc_probe() and be done with it.

The duplication here is very much unnecessary.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

