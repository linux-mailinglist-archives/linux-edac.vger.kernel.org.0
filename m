Return-Path: <linux-edac+bounces-1707-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C25959538
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 09:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA7D1F2193C
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 07:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353D192D75;
	Wed, 21 Aug 2024 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="WYDxnEnU"
X-Original-To: linux-edac@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556AF192D66;
	Wed, 21 Aug 2024 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223681; cv=none; b=MpLiHIykK6wqz8hVkRDXmRl7VzoZ9o0tvHaRQWaSuDUMgZoZk5IbAY0uCpPKG5sp8a5W+cT5yqAs45ayjQgd6PeyuTFDNK9vQ/knOsRxu0x5L6w/Uf6ME5ok27LvyYassb26QEdM0WXdJen0NQRFLNkO6kvgWGJV6fcxgXdhk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223681; c=relaxed/simple;
	bh=Ye6VOm/SOYsSXUcP5wpTHe357J8s03jXZ7rW3RPw5oI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5D68KWGiOUj6oEXwmGw05emL0xeAFI6/5EkiJrNUtM1YZO5WW7mtuNY2hp/Nzc9hpW3EaIiGCtwTjU9O6wlPNjCUnzmz1P1G9VR5rNjFkbjF3M8dlRBFJ0Fpm0xZ0EZsgtK1S1OqPxwCwjXEOzn7Zz6j+x5QlpuE1aeSwQAgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=WYDxnEnU; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724223677;
	bh=Ye6VOm/SOYsSXUcP5wpTHe357J8s03jXZ7rW3RPw5oI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WYDxnEnUBQ6Wrhxsr2D7zO+kCrWCWWVx7f/R6uVDGUAjgfG3W+lfhtZ252Bvqlest
	 EfFPwJCyiBymz/+I8eNffRCBJ49yxeGH8ixoXyK43UMpIDe3XMI+0wt861pdruOkM8
	 OBPz3vJHzvF2YjZAC4jdKGkqqtCwyjwRbtsbhXZc=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A7F1266F26;
	Wed, 21 Aug 2024 03:01:14 -0400 (EDT)
Message-ID: <0c6da945b5539ddc4807c6efb7c25458382d44c1.camel@xry111.site>
Subject: Re: [PATCH v1 0/2] Add EDAC driver for loongson memory controller
From: Xi Ruoyao <xry111@xry111.site>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>, chenhuacai@kernel.org, 
	kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, 
	mchehab@kernel.org, rric@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 21 Aug 2024 15:01:13 +0800
In-Reply-To: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
References: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 14:47 +0800, Zhao Qunqin wrote:
> These patchs are based on 6.10.4. Add a simple EDAC driver which
> report
> single bit errors (CE) only on loongson platform.
>=20
> zhaoqunqin (2):
> =C2=A0 Loongarch: EDAC driver for loongson memory controller
> =C2=A0 dt-bindings: EDAC for loongson memory controller

Hmm so the EDAC driver only works on DT-based systems?  It feels strange
to me.  AFAIK the ECC memory is mostly used in servers where the
firmware passes ACPI system tables instead of DT.

And it makes the incorrect "select EDAC" (I've mentioned in another
reply) worse: all desktop/server users are now building some code
definitely useless on their systems.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

