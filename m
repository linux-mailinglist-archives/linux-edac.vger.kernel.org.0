Return-Path: <linux-edac+bounces-2203-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F6A9ACE58
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 17:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1957DB2510A
	for <lists+linux-edac@lfdr.de>; Wed, 23 Oct 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F381E1AC448;
	Wed, 23 Oct 2024 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="js3IozBh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630184037;
	Wed, 23 Oct 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696090; cv=none; b=AhUxgeOs/ThDGwjkGs5HtsnNg6004oPJbz2ooCH0C25uTij3RfVwPIpsfCCPaqN0ZGRdqAuBIyaA6bUJSYKX8ttedcl2uQfS7dY7YTwsRqrkQqz1J83UratbaIUhggfbTGlrK005recU9TOWSGJywXca+4DH02HZRAgFqauFalQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696090; c=relaxed/simple;
	bh=ZP+03tmAIbiGOIHJywpBTvq9FZUwuwgQsL5WI0KatxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SowDor972VCI1BcXthl6lqXEReRVLU9L+W8eGuHTT9Hytj+0CybS/+KK5hGljIgzsPf5r4AHsC7AgJDHUJawhwpsIegcGVmmT+wmAc8TQ2KV+dq91K9RP19F4WPT38khumClQ+EkUdThkVeCJuz6OoBTuWUkwqhKQEhkWoZ850w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=js3IozBh; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6AF5740E028A;
	Wed, 23 Oct 2024 15:08:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aB7gkiigdBbs; Wed, 23 Oct 2024 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729696082; bh=EJTgCTrCkb1GyKzUG2adEOYBOBSffMZ1KkRKxnhunKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=js3IozBhFrMQg+agM/fc877Updu8NsNIguPNHMZ7rds1USIWeHU7sI54e4hdtut+z
	 Jq2ifTJIas25MzdXThFZyS7+y4rcn0l4cUPPqIN6yAi6uWvpyQuHIEBf9b4A2kuSGF
	 MjV6uhpw9QrUBo8sfAXoNF0P9+XM4nUoCdGJpufhhI4RU4xGgPsU2rX58GQZHfxthu
	 A61KHu6hFJ0dBPviN34LjTha9GvnEbCKQagou/3gn5UYeuHg8JTZkER+e0ZOL7ZWo6
	 /oPSCh1H0JgMwbtjctWR3xghFt29K/WzGmBzOHbKNTybl51qhVq2AoXOQ6n3hfF2Ed
	 TIdj+A7O1HE4Y4lgwufjFCvGYjfUan9eBTwkyciU9NHllyRw6rSbemZ5Choh59p1Ac
	 mSgiVofDnLWPL1Am1O1lcP11t1Awsr8NISYRIaghhn48iceHya9Q+kdqRP7ECAdChk
	 cyK15Vg3PY5E364AR8V0g/sYRYAPPRC24CJNCPB8QucKNxv9cBL3re8+3NI20GycIJ
	 6hsFQ/f87glVFer17Ck1M+/wFTI0u4CDGUFvuA02XkBsP0NODj9A8tFrxq+Rta8dAk
	 bAVUOwIWlP/bh0ydV3cIJxy23al2/Txz2ZsxYzfkXPnQV1hvk88LK4Uqi4Gk5KCFYf
	 twrQkwkyHdFDXBe1l7W7mJ1M=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6AEA40E0198;
	Wed, 23 Oct 2024 15:07:36 +0000 (UTC)
Date: Wed, 23 Oct 2024 17:07:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: York Sun <york.sun@nxp.com>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Priyanka Singh <priyanka.singh@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 0/6] EDAC/fsl-ddr: Add imx9 support
Message-ID: <20241023150729.GBZxkRMZ2zqvt2hS0z@fat_crate.local>
References: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016-imx95_edac-v3-0-86ae6fc2756a@nxp.com>

On Wed, Oct 16, 2024 at 04:31:08PM -0400, Frank Li wrote:
> Add imx9 support for fsl-ddr.
> 
> Patch 1-2 is prepare patch, no function chagne
> Patch 3 is small fix for bit shift
> Patch 4 is dt binding patch.
> Patch 5 is driver change to support imx9

First 5 queued.

> Patch 6 is imx93 dts change

This one goes through the respective SoC tree.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

