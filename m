Return-Path: <linux-edac+bounces-1818-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4853696CE26
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 06:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9BE1C21DEA
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 04:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0B217625C;
	Thu,  5 Sep 2024 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ZVpO2amI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F117155C97;
	Thu,  5 Sep 2024 04:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510911; cv=none; b=Q72BdsDeS937k/D66Ei2Kc2i/AhH9cVmH6gWk+1hHquQZG2zEdJMsJ3MXjxGeW+DQ19ht2vUXf/oqeECtkLHPCKDoKymONy+B/c+Mr50/G6xkPE1hd+gj/mzMdB4EdA7eeH5NSMWTSLHqSEhRS4BpO/tbqetNNx172hr383udQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510911; c=relaxed/simple;
	bh=bzAAfW9uC/tvRRZ790ZCEhZ4HcgMfvl1YwKN71QDo9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uwNTfYU15O6kwJIhSCiIXJunVZgKrXsfPvj8b7BfJyyRvgKvwocK93ffZtoO55svJZ0Gn979iz0qA0LMTDoMSHSx5Xo8C2kfsnu0vl8ULdmJC7vW0lqvDV4Hzz1GsRnJasU3t6TsoZv2rS6Q07SLlQM/KrT/tMR3pQ7K0/Du6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ZVpO2amI; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725510904;
	bh=PAza8esivzUmC+xTajyoYS9UdSvfUo/ZMOuE4D2DFFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZVpO2amIxWK9qiNxgoWLMn8QtfIPJl6BX+8SiI6sc1Dm3cjMMTl973Os/Zi7Mp+fJ
	 x1Eq44DYfs/9hO74kPzrVJZm9PNIj4hgXPcZZA+84/3xrOAWGwsur6M+oWDKFo1RuV
	 svd1oFmwJ472MwrVoe2ryPHAYGz3vs5O+9G5/bSuJCgGRLHSZQn3k0TnJliog4SZy4
	 06Ip+YwudDyKPgkDrlMZquttdLusuiOR+I0vPjJrUCth/GmrmxrWmkMj5zlIPchJRV
	 xbtRuDSh0NFxGiLw6AlM52K7ko/bkruSmHzzIgTblEp7eGk0BR3j7ZihcaZdS4u1WV
	 DrsPtrRzAnQxg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wzmjz5Y3lz4w2N;
	Thu,  5 Sep 2024 14:35:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Borislav Petkov <bp@alien8.de>, Tony Luck
 <tony.luck@intel.com>, James Morse <james.morse@arm.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC: Drop obsolete PPC4xx driver
In-Reply-To: <20240904192224.3060307-2-robh@kernel.org>
References: <20240904192224.3060307-2-robh@kernel.org>
Date: Thu, 05 Sep 2024 14:35:02 +1000
Message-ID: <87mskm67m1.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rob Herring (Arm)" <robh@kernel.org> writes:
> Since commit 47d13a269bbd ("powerpc/40x: Remove 40x platforms.")
> support for PPC40x platforms has been removed. While the EDAC driver
> also mentions PPC440 and PPC460 processors, the driver refuses to
> probe on anything other than PPC405. It's unlikely support will ever be
> added at this point for these other old platforms, so the driver can be
> removed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/edac/Kconfig       |    9 -
>  drivers/edac/Makefile      |    1 -
>  drivers/edac/ppc4xx_edac.c | 1425 ------------------------------------
>  drivers/edac/ppc4xx_edac.h |  167 -----
>  4 files changed, 1602 deletions(-)
>  delete mode 100644 drivers/edac/ppc4xx_edac.c
>  delete mode 100644 drivers/edac/ppc4xx_edac.h

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

