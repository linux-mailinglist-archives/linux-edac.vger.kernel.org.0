Return-Path: <linux-edac+bounces-2287-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B209B0807
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 17:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9556E1C2130F
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC421A4AF;
	Fri, 25 Oct 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="m2JsUbw4"
X-Original-To: linux-edac@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225B21A4BD
	for <linux-edac@vger.kernel.org>; Fri, 25 Oct 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869631; cv=none; b=PAMLc4Ei23uSO5DzyOHv8Bzv63gez25FnjzMKx6iyqbEpuAYUcxeJycSYG/sMcslDD7FkRVY1MtxfckFXfZV5K2fpyVx5xq98Uc9gn6FQ2BarrkfFvT4tcGIDB2N23LkEetz9Tg2qu3j96KT7fJakaLyVIV2U7vHZahuebJy6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869631; c=relaxed/simple;
	bh=Cp9FSnTlH6bdvVMpEKMvRbQ5i2H60iAjX87XIB2uWE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=extsI6sPIFLLqA3tu/LXLcnXAC5HSc0W13yALTzCix446Y5tFFGy/AoD6wxsH6yaYy4q167GhxgL3u59nv0DJy656BliTyMTTuN//S8Q+2DOKr9HEJOpMBDeAjV8fDWbE4JMFGDBIT29fFi9VbPeVE94nlK7dCxIfD4tVZZW0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=m2JsUbw4; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49PFI2GF026443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 11:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729869491; bh=+3/YlMW+NiPuVTOTB6zPtTx6MGg/Ovh8Uq4NZbG/uyg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=m2JsUbw4V9BzTChzyhXxKEonx709PC2kGcGmxOyqq/Dj3J1OQmlaWKfLaXMPcQlWI
	 U1cD1pwfhERmeC1yoJG56VdEwJjIdfJXbbc9NxpD4mFr2EgBZO88LobYOF7KSMheAD
	 xunW+jK+TKd7G9GXDY3GTgrNXRVyn4XHUU6SwE5d1CAqUAXIbNAh+GPw9DFs+I2Rui
	 zcuKXf08A4qwIfnZF1P/9xNKQ0Yvwio7iAn8Ve3EPqzqdy0OHAe7vYUjTmCfpFEqiX
	 SnsQD60MMQgAoU2n8Afic9+mpasu+2+bjSavmaTe6RZYXijBNPFAAahQ4RcBOdQK0R
	 l5HWypBd+18tQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 28BF715C0329; Fri, 25 Oct 2024 11:18:02 -0400 (EDT)
Date: Fri, 25 Oct 2024 11:18:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Hantong Chen <cxwdyx620@gmail.com>, james.bottomley@hansenpartnership.com,
        ajhalaney@gmail.com, allenbh@gmail.com, andrew@lunn.ch,
        andriy.shevchenko@linux.intel.com, andy@kernel.org, arnd@arndb.de,
        bhelgaas@google.com, bp@alien8.de, broonie@kernel.org,
        cai.huoqing@linux.dev, dave.jiang@intel.com, davem@davemloft.net,
        dlemoal@kernel.org, dmaengine@vger.kernel.org, dushistov@mail.ru,
        fancer.lancer@gmail.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, ink@jurassic.park.msu.ru, jdmason@kudzu.us,
        jiaxun.yang@flygoat.com, keguang.zhang@gmail.com,
        kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org,
        linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux@armlinux.org.uk, linux@roeck-us.net,
        manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
        nikita.shubin@maquefel.me, nikita@trvn.ru, ntb@lists.linux.dev,
        olteanv@gmail.com, pabeni@redhat.com, paulburton@kernel.org,
        robh@kernel.org, s.shtylyov@omp.ru, sergio.paracuellos@gmail.com,
        shc_work@mail.ru, siyanteng@loongson.cn, tsbogend@alpha.franken.de,
        xeb@mail.ru, yoshihiro.shimoda.uh@renesas.com, phoronix@phoronix.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Message-ID: <20241025151802.GC3307207@mit.edu>
References: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <20241024165650.174-1-cxwdyx620@gmail.com>
 <20241024173504.GN3204734@mit.edu>
 <cc264780-0c16-4209-8736-ada156994eaa@metux.net>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc264780-0c16-4209-8736-ada156994eaa@metux.net>

On Fri, Oct 25, 2024 at 03:35:37PM +0200, Enrico Weigelt, metux IT consult wrote:
> 
> Okay, great. I'm fully on your side: let's sanction all countries that
> like to wage wars of aggressions against other countries and kick out
> all maintainers from there.

Sanctions are imposed by Governments --- for example, the US,
European, Japan, Switzerland, Norway, etc.  Not Linux developers, nor
Russian troll farms, nor Russia's useful idiots on the internet.  It's
not up to anyone on this mail thread.

I see from your country code in your signature that you apparently
live in Germany.  Please note that if you violate Germany's laws and
regulations, whether it's by supplying bomb-making technical
assistance to a terrorist group, or lending technical assistance to
sanctioned entities directly or indirectly controlled by the Russian
Military-Intelligence, you could be subject to civil or criminal
penalties.  And that's not up to me; it's up to your elected leaders
and Germany's judicial system.

If you don't like this, I cordially invite you to exercise your
democratic rights and make your opinions known to your fellow citizens
and to your elected politicians.

      	      		       	       - Ted

