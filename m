Return-Path: <linux-edac+bounces-4300-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE72AEF81D
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 14:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07743A5090
	for <lists+linux-edac@lfdr.de>; Tue,  1 Jul 2025 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E07199E9D;
	Tue,  1 Jul 2025 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YY9sc2uM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C9433C4;
	Tue,  1 Jul 2025 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372186; cv=none; b=GUn5zxOu6dfp7ci4Qc+W3WMPxVx/NnMaZnGjikIpLrFIsl6Qa6aymklY4jEZHH5on/nN+mwLRpRnXXEZxjNskGhaG+R1s2n9iy22vSqQMFAKGue0HC/VfsS0nlPZqOtS0yRd6j7T8GyqaPv/8DndYz64eeZbh21TyJDUd+d23Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372186; c=relaxed/simple;
	bh=8RTvthheWftb0PKThQnvoyTc85D/KFEGam022IXgHEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvGxJghNbgxV+eKVjZl75ajFrJONUx1dYkB+Fol8021E+LMQusXKxNrcoMGXyCyUpGchJRiuVWHBh4sr6asw220ybe8tCYjdsjR6pthPGCVJLvZwfcDw2NmW3hHqJs8yKrIkiD5y5bW7XS46fki8E5iU1/CrE3rvFCs4HWkgUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YY9sc2uM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A303540E0200;
	Tue,  1 Jul 2025 12:16:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M9cxXZzrn7sa; Tue,  1 Jul 2025 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751372179; bh=pLAQpJpx73Sd85ACs9Vy75P3EDa4RokGPwB1/GszqKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YY9sc2uM8qbv2hmQ/FmOQtv14X/DTyDfqY+auWSgh7QOmEod8dvTy2EJtdL0f8C7U
	 3fKwsGtZjxz3PjkqmRbwSAE9jTc2TWJiisztvJXC/E03zmZQebF5VfF1I12mkkcX24
	 xsZ+wDQm6vF8gXHG7NHzrWvJzMG9CMyc8B4cI02MBM0bLIhVtEHPMA9C53sWhTDh5y
	 AuYhtpT8T9aqhW/d6U27U3B8tE2G9bkwOzgFafst61lrWi+xkcfMGCkGZIomSkNEzj
	 wrT0ZCJKXTPcWLUIeJARggI93QV4jJUSY6+Xrrm3w472hTjVo9Do5zYFMvp7TKUNLm
	 mQnlQZDpew385PsWqK1YbIF47whoX+1pL2pbz7+p45BLyogj/dwdRSnlogMw23eOHX
	 HHFr76XXNriRqBWyotAGJhJvO0/BIQWksV1XY7mlJxFgF7q2jfbLPwepWcPUccTrfx
	 LbjuPaSGM2HyiIHPqXh9hQWeQyv1Q3HzNvIzrMFVCtI+C0rUg8mAY3CWlC+uuyqQm3
	 TUt8BXZ8f1ppIgOY9VADXyB0llGLGBOwcweJkwa1wRSGFHnC4NUl4n6kgZhCqKGk73
	 1fvge9rt1aVWanAYcrP8Epd0HBJD1M668tOxUF74Jtv7WrfzzH6ToER/plvrMDhZCw
	 7sm2M9RseRxu0U2ql50xTTfU=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6861340E01FC;
	Tue,  1 Jul 2025 12:16:09 +0000 (UTC)
Date: Tue, 1 Jul 2025 14:16:08 +0200
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
Message-ID: <20250701121608.GIaGPRiLn_pmIUvvUO@fat_crate.local>
References: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>
 <20250603090536.GCaD664IbJB5IoR06g@fat_crate.local>
 <SA1PR12MB894764756C6538EE985BDE24816CA@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250604093735.GAaEAT39KGW1KJDrjD@fat_crate.local>
 <SA1PR12MB89471067967E0A5F46CEE1DF8175A@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250611164018.GAaEmxctC+ESUCvBNT@fat_crate.local>
 <SA1PR12MB894766DFAD90E9DB15A3268F8174A@SA1PR12MB8947.namprd12.prod.outlook.com>
 <20250626141023.GBaF1UzwF9ITE8-LBQ@fat_crate.local>
 <SA1PR12MB894730DD2C29CB3492C734B38146A@SA1PR12MB8947.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR12MB894730DD2C29CB3492C734B38146A@SA1PR12MB8947.namprd12.prod.outlook.com>

On Mon, Jun 30, 2025 at 09:40:38AM +0000, Datta, Shubhrajyoti wrote:
> - Added a new `platform` enum field to `synps_platform_data` to identify the
>   target hardware platform

Better. Feel free to send a properly tested patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

