Return-Path: <linux-edac+bounces-4304-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315D2AF11D6
	for <lists+linux-edac@lfdr.de>; Wed,  2 Jul 2025 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F163A7CE5
	for <lists+linux-edac@lfdr.de>; Wed,  2 Jul 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59424DCF6;
	Wed,  2 Jul 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fCivF7Sn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A6524BBFD;
	Wed,  2 Jul 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452079; cv=none; b=AEiUk1+x8xHJ9uqsVD2u7C5z9AMzBazL8E91bN9Fxg5oO6v29fjLQgqRE4FLCrxULt1orJ8g5VSkv0BMxjPDbZYVwrw3siT7GAF1/RfXy9ScD00/RpbFF0u5opqH7WerF360gYzJH85c9zdmF9E+LfW8JU04WQi7uj14/tXxy78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452079; c=relaxed/simple;
	bh=mKxFnJrFfq5yKXaS2svEXQwbcRkwD+z83At+PELKWzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S92geAgOxmgnQdRHEqViyGguR+4cJ1cUgzmBM7+CHP5TV37aav50GQBtJYaxGfIpKXA3ta2nAR7vBVg3ju56DW84yXvtT37dD/DwOiirUB507u+hp0osI4XlPiTwxXshEbn5Lc06q4hvXTSB83jcl/HMjl8exczBAD9l2Zcjkds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fCivF7Sn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 812A240E0217;
	Wed,  2 Jul 2025 10:27:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tG13KCk_QJPf; Wed,  2 Jul 2025 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751452063; bh=K6vtF+/FrP3SZLJ1xW3eTnYKlR656Bz2ybvMfEhgy7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCivF7SnbWweND0RenAM+SeXpWWhRNFm7diOBCTtNiFbTia1+A4ubAK+7EWc1Pczs
	 j55PbI1oOTPZZBUvsyk44Yh2sMO3q/PX3Tb6adz20ZmwpV0DNdgmOsPSE6MpsQy9Yl
	 8Yvcfttr4npkoc2LpcId+T6tMc6kcHy7yxHqRfOXnmbZN6HFlmdndo2mnCxQz2pZYA
	 yJUFDzw0DObeiAvLa3j84d+LcnLH2p2h3x74+2zZJhDJPLPOZgMZCil+Hh5Tq+OpZG
	 23ldmQjXzcBqPEBK1fN1pw3FCJY6w6J8JMMBQlaQMG2h/m20bMtJKVHsBymWiQr7p3
	 ggpm23yjDoQ6zc29jCsdHF+8wBbdT2+wyt/38eYnSnnqF1nLKarnjLxtdtjHpjBEj7
	 P3VS6rBs3+gJ8iNxjObUz+vriA9vt8OmihX9s3mfoMwDTQLqRSvVU29J4qpwitvvdN
	 xTmoRFASFgManLq+nefrBKUuD9CjavMVGNWdoeQVs5cHG4r0jYxnWMnxU88ZvTBIQw
	 5w/LbBxPwrJi3Qkvos6X+ek3gv1vt9O6lCy2qDNUIqyUjfWwMnVU26viP2y4rYo7qI
	 8ztdARHlWLtTxYzh1mBf3Cyl4kTDk+EsAjT0DfxYHb3VmVYcKZ1vT+kU2AbBYI7MVz
	 CMYxsyfYxSjc+ozQ42aLXP7M=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 662C140E01FE;
	Wed,  2 Jul 2025 10:27:28 +0000 (UTC)
Date: Wed, 2 Jul 2025 12:27:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"Gupta, Nipun" <Nipun.Gupta@amd.com>,
	"Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and
 Initialization
Message-ID: <20250702102721.GKaGUJiXLkOEC5kdpd@fat_crate.local>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
 <20250529070017.7288-3-shubhrajyoti.datta@amd.com>
 <20250613201034.GC171759@yaz-khff2.amd.com>
 <SA1PR12MB89474C0C76A66775B91A20C98170A@SA1PR12MB8947.namprd12.prod.outlook.com>
 <SA1PR12MB8947279143D868E39D30F616817CA@SA1PR12MB8947.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8947279143D868E39D30F616817CA@SA1PR12MB8947.namprd12.prod.outlook.com>

On Fri, Jun 20, 2025 at 11:03:02AM +0000, Datta, Shubhrajyoti wrote:
> I plan to have the current (in the cdx) mcdi.h to mcdid.h and move the common parts to
> Include/linux/cdx/mcdi.h
> 
> And for the bitfield.h will move to include/linux/cdx/bitfield.h as most of it is needed
> by others
> 
> 
> I plan to rename the existing mcdi.h under cdx/controller/ to mcdid.h.
> The common prototypes and definitions will be moved to the new global header at
> include/linux/cdx/mcdi.h.
> 
> I am using most of (close to 90/95 percent) the bitfield.h, I'll move it to include/linux/cdx/bitfield.h to
>  make it accessible for other subsystems.
> 
> Let me know if that sounds good.

Well, I'd expect the maintainers of that thing to move:

./scripts/get_maintainer.pl -f drivers/cdx/
Nipun Gupta <nipun.gupta@amd.com> (maintainer:AMD CDX BUS DRIVER)
Nikhil Agarwal <nikhil.agarwal@amd.com> (maintainer:AMD CDX BUS DRIVER)

and maintain.

Perhaps ping them on internal chat to catch their attention.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

